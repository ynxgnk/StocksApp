//
//  SearchResultsViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject { /* 101 */
    func searchResultsViewControllerDidSelect(searchResult: String) /* 102 */
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate? /* 103 */
    
    private var results: [String] = [] /* 113 */
    
    private let tableView: UITableView = { /* 80 */
        let table = UITableView() /* 81 */
        table.register(SearchResultTableViewCell.self,
                       forCellReuseIdentifier: SearchResultTableViewCell.identifier) /* 88 */
        return table /* 82 */
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 77 */
        setUpTable() /* 93 */
    }
    
    override func viewDidLayoutSubviews() { /* 78 */
        super.viewDidLayoutSubviews() /* 79 */
        tableView.frame = view.bounds /* 100 */
    }
    
    private func setUpTable() { /* 89 */
        view.addSubview(tableView) /* 90 */
        tableView.delegate = self /* 91 */
        tableView.dataSource = self /* 92 */
    }
    
    public func update(with results: [String]) { /* 110 */
        self.results = results /* 111 */
        tableView.reloadData() /* 112 */
    }
    
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource { /* 93 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 94 */
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 95 */
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) /* 96 */
        cell.textLabel?.text = "AAPL" /* 98 */
        cell.detailTextLabel?.text = "Apple INC" /* 99 */
        return cell /* 97 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 104 */
        tableView.deselectRow(at: indexPath, animated: true) /* 105 */
        delegate?.searchResultsViewControllerDidSelect(searchResult: "AAPL") /* 106 */
    }
}
