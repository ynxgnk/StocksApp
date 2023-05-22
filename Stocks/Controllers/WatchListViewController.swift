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
    }

}
