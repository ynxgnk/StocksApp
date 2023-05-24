//
//  ViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import FloatingPanel /* 171 */
import UIKit

class WatchListViewController: UIViewController {
    
    private var searchTimer: Timer? /* 152 */
    
    private var panel: FloatingPanelController? /* 172 */
    
    static var maxChangeWidth: CGFloat = 0  /* 590 */
    
    ///Model
    private var watchlistMap: [String: [CandleStick]] = [:] /* 433 */ /* 484 change second String */
    
    ///ViewModels
    private var viewModels: [WatchListTableViewCell.ViewModel] = [] /* 446 */ /* 532 change String */
    
    private let tableView: UITableView = { /* 425 */
       let table = UITableView() /* 426 */
        table.register(WatchListTableViewCell.self,
                       forCellReuseIdentifier: WatchListTableViewCell.identifier) /* 570 */
        return table /* 427 */
    }()
    
    private var observer: NSObjectProtocol? /* 640 */
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 1 */
        setUpSearchController() /* 55 */
        setUpTableView() /* 424 */
        fetchWatchlistData() /* 435 */
        setUpFloatingPanel() /* 170 */
        setUpTitleView() /* 66 */
        setUpObserver() /* 639 */
    }
    
    override func viewDidLayoutSubviews() { /* 577 */
        super.viewDidLayoutSubviews() /* 578 */
        tableView.frame = view.bounds /* 579 */
    }
    
    //MARK:  - Private
    
    private func setUpObserver() { /* 638 */
        observer = NotificationCenter.default.addObserver(
            forName: .didAddToWatchList,
            object: nil,
            queue: .main
            ) { [weak self] _ in /* 641 */
                self?.viewModels.removeAll() /* 642 */
                self?.fetchWatchlistData() /* 643 */
            }
    }
    
    private func fetchWatchlistData() { /* 434 */
        let symbols = PersistenceManager.shared.watchlist /* 436 */
        
        let group = DispatchGroup() /* 473 */
        
        for symbol in symbols where watchlistMap[symbol] == nil { /* 437 */ /* 644 add where... */
            group.enter() /* 474 */
            //Fetch market data per symbol
            APICaller.shared.marketData(for: symbol) { [weak self] result in /* 477 */ /* 485 add weak self */
                defer { /* 478 */
                    group.leave() /* 479 */
                }
                
                switch result { /* 480 */
                case .success(let data): /* 481 */
                    let candleSticks = data.candleSticks /* 482 */
                    self?.watchlistMap[symbol] = candleSticks /* 486 */
                case .failure(let error): /* 481 */
                    print(error) /* 483 */
                }
            }
//            watchlistMap[symbol] = ["some string"] /* 438 */
        }
        
        group.notify(queue: .main) { [weak self] in /* 475 */
            self?.createViewModels() /* 529 */
            self?.tableView.reloadData() /* 439 */ /* 476 add self? */
        }
    }
    
    private func createViewModels() { /* 528 */
        var viewModels = [WatchListTableViewCell.ViewModel]() /* 530 */
        
        for (symbol, candleSticks) in watchlistMap { /* 531 */
            let changePercentage = getChangePercentage(symbol: symbol, data: candleSticks) /* 539 */
            viewModels.append(
                .init(
                    symbol: symbol,
                    companyName: UserDefaults.standard.string(forKey: symbol) ?? "Company",
                    price: getLatestClosingPrice(from: candleSticks),
                    changeColor: changePercentage < 0 ? .systemRed : .systemGreen,
                    changePercentage: .percentage(from: changePercentage),
                    chartViewModel: .init( /* 610 add chartViewModel */
                        data: candleSticks.reversed().map { $0.close },
                        showLegend: false,
                        showAxis: false,
                        fillColor: changePercentage < 0 ? .systemRed : .systemGreen /* 873 add fillColor */
                    ) /* 568 change "\(changePercentage" */
                )
            )
        }
//        print("\n\n\(viewModels)\n\n") /* 566 */
        self.viewModels = viewModels /* 533 */
    }
    
    private func getChangePercentage(symbol: String, data: [CandleStick]) -> Double { /* 538 */
        let latestDate = data[0].date /* 541 */
        guard let latestClose = data.first?.close,
            let priorClose = data.first(where: {
                !Calendar.current.isDate($0.date, inSameDayAs: latestDate)
            })?.close else { /* 540 */
            return 0 /* 542 */
        }
        
//        print("\(symbol): Current (\(latestDate): \(latestClose) | Prior: \(priorClose)") /* 543 */
        let diff = 1 - (priorClose/latestClose) /* 545 */
//        print("\(symbol): \(diff)%") /* 546 */
        return diff /* 544 */
    }
    
    private func getLatestClosingPrice(from data: [CandleStick]) -> String { /* 534 */
        guard let closingPrice = data.first?.close else { /* 535 */
            return "" /* 536 */
        }
        
        return .formatted(number: closingPrice) /* 537 */ /* 567 change "\(closingPrice)" */
    }
    
    private func setUpTableView() { /* 423 */
        view.addSubview(tableView) /* 428 */
        tableView.delegate = self /* 429 */
        tableView.dataSource = self /* 430 */
    }
    
    private func setUpFloatingPanel() { /* 169 */
        let vc = NewsViewController(type: .topStories) /* 180 */ /* 224 add type */
        let panel = FloatingPanelController(delegate: self) /* 173 */ /* 182 add delegate */
        panel.surfaceView.backgroundColor = .secondarySystemBackground /* 175 */
        panel.set(contentViewController: vc) /* 181 */
        panel.addPanel(toParent: self) /* 174 */
        panel.track(scrollView: vc.tableView) /* 186 */
    }

    private func setUpTitleView() { /* 65 */
        let titleView = UIView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: navigationController?.navigationBar.height ?? 100
            )
        ) /* 67 */
        
        let label = UILabel(frame: CGRect(x: 10, y: 0, width: titleView.width-20, height: titleView.height)) /* 72 */
        label.text = "Stocks" /* 74 */
        label.font  = .systemFont(ofSize: 40, weight: .medium) /* 75 */
        titleView.addSubview(label) /* 76 */
        navigationItem.titleView = titleView /* 73 */
    }
    
    private func setUpSearchController() { /* 54 */
        let resultVC = SearchResultsViewController() /* 56 */
        resultVC.delegate = self /* 107 */
        let searchVC = UISearchController(searchResultsController: resultVC) /* 57 */
        searchVC.searchResultsUpdater = self /* 59 */
        navigationItem.searchController = searchVC /* 58 */
    }

}



extension WatchListViewController: UISearchResultsUpdating { /* 60 */
    func updateSearchResults(for searchController: UISearchController) { /* 61 */
        guard let query = searchController.searchBar.text,
              let resultsVC = searchController.searchResultsController as? SearchResultsViewController,
              !query.trimmingCharacters(in: .whitespaces).isEmpty else { /* 62 */
            return /* 63 */
        }
        
        //Reset timer
        searchTimer?.invalidate() /* 154 */
        
        //Kick off new timer
        //Optimize to reduce number of searches for when user stops typing
        searchTimer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: false, block: { _ in /* 153 */
            //Call API to search
            APICaller.shared.search(query: query) { result in /* 136 */
                switch result { /* 137 */
                case .success(let response): /* 138 */
                    DispatchQueue.main.async { /* 139 */
                        resultsVC.update(with: response.result) /* 140 */
                    }
                case .failure(let error): /* 138 */
                    DispatchQueue.main.async { /* 160 */
                        resultsVC.update(with: []) /* 161 */
                    }
                    print(error) /* 138 */
                }
            }
        })
        
        //Update results controller
//        resultsVC.update(with: ["GOOG"]) /* 114 */
//        print(query) /* 64 */
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate { /* 108 */
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) { /* 109 */ /* 150 change String */
        //Present stock details for given selection
        navigationItem.searchController?.searchBar.resignFirstResponder() /* 166 */
        
        let vc = StockDetailsViewController(
            symbol: searchResult.displaySymbol,
            companyName: searchResult.description
        ) /* 162 */ /* 658 add 3 parameters */
        let navVC = UINavigationController(rootViewController: vc) /* 163 */
        vc.title = searchResult.description /* 164 */
        present(navVC, animated: true) /* 165 */
//        print("Did select \(searchResult.displaySymbol)") /* 151 */
    }
}

extension WatchListViewController: FloatingPanelControllerDelegate { /* 183 */
    func floatingPanelDidChangeState(_ fpc: FloatingPanelController) { /* 184 */
        navigationItem.titleView?.isHidden = fpc.state == .full /* 185 */
    }
}

extension WatchListViewController: UITableViewDelegate, UITableViewDataSource { /* 431 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 432 */
        return viewModels.count /* 441 */  /* 569 change watchlistMap */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 442 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier, for: indexPath) as? WatchListTableViewCell else { /* 571 */
            fatalError() /* 572 */
        }
        cell.delegate = self /* 598 */
        cell.configure(with: viewModels[indexPath.row]) /* 574 */
        return cell /* 443 */ /* 573 change UITableViewCell */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 575 */
        return WatchListTableViewCell.preferredHeight /* 576 */
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool { /* 614 */
        return true /* 615 */
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle { /* 616 */
        return .delete /* 617 */
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) { /* 618 */
        if editingStyle == .delete { /* 619 */
            tableView.beginUpdates() /* 620 */
            //Update persistence
            PersistenceManager.shared.removeFromWatchList(symbol: viewModels[indexPath.row].symbol) /* 622 */
            
            //Update viewModels
            viewModels.remove(at: indexPath.row) /* 621 */
            
            //delete row
            tableView.deleteRows(at: [indexPath], with: .automatic) /* 623 */
            
            tableView.endUpdates() /* 624 */
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 444 */
        tableView.deselectRow(at: indexPath, animated: true) /* 445 */
        //Open Details for selection
        let viewModel = viewModels[indexPath.row] /* 656 */
        let vc = StockDetailsViewController(
            symbol: viewModel.symbol,
            companyName: viewModel.companyName,
            candleStickData: watchlistMap[viewModel.symbol] ?? []
        ) /* 645 */ /* 657 add 3 parameters */
        let navVC = UINavigationController(rootViewController: vc) /* 646 */
        present(navVC, animated: true) /* 647 */
    }
}

extension WatchListViewController: WatchListTableViewCellDelegate { /* 599 */
    func didUpdateMaxWidth() { /* 600 */
        //Optimize: Only refresh wors prior to the current row that changes the max width
        tableView.reloadData() /* 601 */
    }
}
