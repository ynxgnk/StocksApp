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
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 1 */
        setUpSearchController() /* 55 */
        setUpFloatingPanel() /* 170 */
        setUpTitleView() /* 66 */
    } 
    
    //MARK:  - Private
    
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
        
        let vc = StockDetailsViewController() /* 162 */
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
