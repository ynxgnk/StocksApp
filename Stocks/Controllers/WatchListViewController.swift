//
//  ViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class WatchListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 1 */
        setUpSearchController() /* 55 */
    }

    private func setUpSearchController() { /* 54 */
        let resultVC = SearchResultsViewController() /* 56 */
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
        
        print(query) /* 64 */
    }
}
