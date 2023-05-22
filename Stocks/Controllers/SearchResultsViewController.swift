//
//  SearchResultsViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject { /* 101 */
    func searchResultsViewControllerDidSelect(searchResult: SearchResult) /* 102 */ /* 147 change String */
}

class SearchResultsViewController: UIViewController {
    
    weak var delegate: SearchResultsViewControllerDelegate? /* 103 */
    
    private var results: [SearchResult] = [] /* 113 */ /* 142 change String */
    
    private let tableView: UITableView = { /* 80 */
        let table = UITableView() /* 81 */
        table.register(SearchResultTableViewCell.self,
                       forCellReuseIdentifier: SearchResultTableViewCell.identifier) /* 88 */
        table.isHidden = true /* 158 */
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
    
    public func update(with results: [SearchResult]) { /* 110 */ /* 141 change String */
        self.results = results /* 111 */
        tableView.isHidden = results.isEmpty /* 159 if empty - is hidden */
        tableView.reloadData() /* 112 */
    }
    
}

extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource { /* 93 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 94 */
        return results.count /* 143 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 95 */
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.identifier, for: indexPath) /* 96 */
        let model = results[indexPath.row] /* 144 */
        
        cell.textLabel?.text = model.displaySymbol /* 98 */ /* 145 change "AAPL" */
        cell.detailTextLabel?.text = model.description /* 99 */ /* 146 change "Apple" */
        return cell /* 97 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 104 */
        tableView.deselectRow(at: indexPath, animated: true) /* 105 */
        let model = results[indexPath.row] /* 148 */
        delegate?.searchResultsViewControllerDidSelect(searchResult: model) /* 106 */ /* 149 change "AAPL" */
    }
}
