//
//  StockDetailsViewControllerViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import SafariServices /* 708 */
import UIKit

/// VC to show stock details
final class StockDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    //Symbol, Company Name, Any chart data we may have
    
    /// Stock symbol
    private let symbol: String /* 653  */
    
    ///Company name
    private let companyName: String /* 654 */
    
    ///Collection of data
    private var candleStickData: [CandleStick] /* 655 */
    
    /// Primary view
    private let tableView: UITableView = { /* 659 */
       let table = UITableView() /* 660 */
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier) /* 661 */
        table.register(NewsStoryTableViewCell.self,
                       forCellReuseIdentifier: NewsStoryTableViewCell.identifier) /* 662 */
        return table /* 663 */
    }()
    
    /// Collection of news Stories
    private var stories: [NewsStory] = [] /* 683 */
    
    /// Company metrcis
    private var metrics: Metrics? /* 824 */
    
    //MARK: Init
    
    init(
        symbol: String,
        companyName: String,
        candleStickData: [CandleStick] = []
    ) { /* 648 */
        self.symbol = symbol /* 652 */
        self.companyName = companyName /* 652 */
        self.candleStickData = candleStickData /* 652 */
        super.init(nibName: nil, bundle: nil) /* 649 */
    }
    
    required init?(coder: NSCoder) { /* 650 */
        fatalError() /* 651 */
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 167 */
        title = companyName /* 722 */
        setUpCloseButton() /* 724 */
        //Show view
        setUpTable() /* 665 */
        //Fetch Financial data
        fetchFinancialData() /* 667 */
        //Show chart/Graph
        //Show News
        fetchNews() /* 670 */ 
    }
    
    override func viewDidLayoutSubviews() { /* 675 */
        super.viewDidLayoutSubviews() /* 676 */
        tableView.frame = view.bounds /* 677 */
    }
    
    //MARK: - Privete
    
    /// Sets up close button
    private func setUpCloseButton() { /* 723 */
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        ) /* 725 */
    }
    
    /// Handle close button tap
    @objc private func didTapClose() { /* 726 */
        dismiss(animated: true, completion: nil) /* 727 */
    }
    
    /// Sets uptable
    func setUpTable() { /* 664 */
        view.addSubview(tableView) /* 672 */
        tableView.delegate = self /* 673 */
        tableView.dataSource = self /* 674 */
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: (view.width*0.7) + 100)
        ) /* 721 */
    }
    
    /// Fetch financial metrics
    private func fetchFinancialData() { /* 666 */
        let group = DispatchGroup() /* 740 */
        //Fetch candle sticks if needed
        if candleStickData.isEmpty { /* 741 */
            group.enter() /* 742 */
            APICaller.shared.marketData(for: symbol) { [weak self] result in /* 863 */
                defer { /* 864 */
                    group.leave() /* 865 */
                }
                
                switch result { /* 866 */
                case .success(let response): /* 867 */
                    self?.candleStickData = response.candleSticks /* 868 */
                case .failure(let error): /* 867 */
                    print(error) /* 868 */
                }
            }
        }
        //Fetch financial metrics
        group.enter() /* 743 */
        APICaller.shared.financialMetrics(for: symbol) { [weak self] result in /* 744 */ /* 781 add weak self */
            defer { /* 745 */
                group.leave() /* 746 */
            }
            switch result { /* 747 */
            case .success(let response): /* 748 */
                let metrics = response.metric /* 749 */
                self?.metrics = metrics /* 825 */
//                print(metrics) /* 780 */
            case .failure(let error): /* 748 */
                print(error) /* 749 */
            }
        }
        //Render chart
        group.notify(queue: .main) { [weak self] in /* 750 */
            self?.renderChart() /* 751 */
        }
        renderChart() /* 669 */
    }
    
    /// Fetch news for given type
    private func fetchNews() { /* 671 */
        APICaller.shared.news(for: .company(symbol: symbol)) { [weak self] result in /* 700 */
            switch result { /* 701 */
            case .success(let stories): /* 702 */
                DispatchQueue.main.async { /* 705 */
                    self?.stories = stories /* 703 */
                    self?.tableView.reloadData() /* 704 */
                }
            case .failure(let error): /* 702 */
                print(error) /* 703 */
            }
        }
    }
    
    /// Render chart and metrics
    private func renderChart() { /* 668 */
        //Chart VM | FinancialMetricViewModel(s)
        let headerView = StockDetailHeaderView(
            frame: CGRect(
                x: 0,
                y: 0,
                width: view.width,
                height: (view.width*0.7) + 100
            )
        ) /* 778 */
        
        headerView.backgroundColor = .systemBackground /* 782 */
        
        var viewModels = [MetricCollectionViewCell.ViewModel]() /* 827 */
        if let metrics = metrics { /* 828 */
            viewModels.append(.init(name: "52W High", value: "\(metrics.AnnualWeekHigh)")) /* 829 */
            viewModels.append(.init(name: "52L High", value: "\(metrics.AnnualWeekLow)")) /* 830 */
            viewModels.append(.init(name: "52W Return", value: "\(metrics.AnnualWeekPriceReturnDaily)")) /* 831 */
            viewModels.append(.init(name: "beta", value: "\(metrics.beta)")) /* 832 */
            viewModels.append(.init(name: "10D Vol.", value: "\(metrics.TenDayAverageTradingVolume)")) /* 833 */
        }
        
        //Configure
        let change = getChangePercentage(symbol: symbol, data: candleStickData) /* 880 */
        headerView.configure(
            chartViewModel: .init(
                data: candleStickData.reversed().map { $0.close }, /* 861 change [] */
                showLegend: true,
                showAxis: true,
                fillColor: change < 0 ? .systemRed : .systemGreen /* 881 add fillColor */
            ),
            metricViewModels: viewModels
        ) /* 826 */
        
        tableView.tableHeaderView = headerView /* 779 */
    }
    
    /// Get change percentage
    /// - Parameters:
    ///   - symbol: Symbol of a company
    ///   - data: Collection of data
    /// - Returns: Percent
    private func getChangePercentage(symbol: String, data: [CandleStick]) -> Double { /* 874 */
        let latestDate = data[0].date /* 875 */
        guard let latestClose = data.first?.close,
            let priorClose = data.first(where: {
                !Calendar.current.isDate($0.date, inSameDayAs: latestDate)
            })?.close else { /* 876 */
            return 0 /* 877 */
        }
        
        let diff = 1 - (priorClose/latestClose) /* 878 */
        return diff /* 879 */
    }
}

//MARK: - TableView

extension StockDetailsViewController: UITableViewDelegate, UITableViewDataSource { /* 678 */
    //681
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 682 */
        return stories.count /* 684 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 685 */
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsStoryTableViewCell.identifier, for: indexPath) as? NewsStoryTableViewCell else { /* 686 */
            fatalError() /* 687 */
        }
        cell.configure(with: .init(model: stories[indexPath.row])) /* 688 */
        return cell /* 689 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 690 */
        return NewsStoryTableViewCell.preferredHeight /* 691 */
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { /* 681 */
        guard let header = tableView.dequeueReusableHeaderFooterView( /* 692 */
            withIdentifier: NewsHeaderView.identifier
        ) as? NewsHeaderView else { /* 693 */
            return nil /* 694 */
        }
        header.delegate = self /* 695 */
        header.configure(
            with: .init(
                title: symbol.uppercased(),
                shouldShowAddButton: !PersistenceManager.shared.watchlistContains(symbol: symbol) /* 715 change true */
            )
        ) /* 696 */
        return header /* 697 */
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { /* 698 */
        return NewsHeaderView.preferredHeight /* 699 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 706 */
        tableView.deselectRow(at: indexPath, animated: true) /* 707 */
        guard let url = URL(string: stories[indexPath.row].url) else { /* 709 */
            return /* 710 */
        }
        let vc = SFSafariViewController(url: url) /* 711 */
        present(vc, animated: true) /* 712 */
    }
}

//MARK: - NewsHeaderViewDelegate

extension StockDetailsViewController: NewsHeaderViewDelegate { /* 679 */
    func newsHeaderViewDidTapAddButton(_ headerView: NewsHeaderView) { /* 680 */
        //Add to watchlist
        headerView.button.isHidden = true /* 716 */
        PersistenceManager.shared.addToWatchList(
            symbol: symbol,
            companyName: companyName
        ) /* 717 */
        
        let alert = UIAlertController(
            title: "Added to Watchlist",
            message: "We have added \(companyName) to your watchlist",
            preferredStyle: .alert
        ) /* 718 */
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)) /* 719 */
        present(alert, animated: true) /* 720 */
    }
}
