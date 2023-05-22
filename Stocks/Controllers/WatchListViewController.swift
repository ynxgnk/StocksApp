//
//  ViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class WatchListViewController: UIViewController {
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 1 */
        setUpSearchController() /* 55 */
        setUpTitleView() /* 66 */
    }
    
    //MARK:  - Private
    
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
        
        //Optimize to reduce number of searches for when user stops typing
        
        //Call API to search
        
        //Update results controller
        resultsVC.update(with: ["GOOG"]) /* 114 */
//        print(query) /* 64 */
    }
}

extension WatchListViewController: SearchResultsViewControllerDelegate { /* 108 */
    func searchResultsViewControllerDidSelect(searchResult: String) { /* 109 */
        //Present stock details for given selection
    }
}
