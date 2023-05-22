//
//  TopStoriesNewsViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    let tableView: UITableView = { /* 187 */
     let table = UITableView() /* 188 */
        table.backgroundColor = .clear /* 225 */
        
        return table /* 189 */
    }()
    
    private let type: Type /* 205 */
    
    enum `Type` { /* 198 */
        case topStories /* 199 */
        case company(symbol: String) /* 200 */
        
        var title: String { /* 201 */
            switch self { /* 202 */
            case .topStories: /* 203 */
                return "Top Stories" /* 204 */
            case .company(let symbol): /* 203 */
                return symbol.uppercased() /* 204 */
            }
        }
    }
    
    //MARK: - Init
    
    init(type: Type) { /* 206 */
        self.type = type /* 207 */
        super.init(nibName: nil, bundle: nil) /* 208 */
    }
    
    required init?(coder: NSCoder) { /* 209 */
        fatalError() /* 210 */
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable() /* 195 */
        fetchNews() /* 196 */
    }
    
    override func viewDidLayoutSubviews() { /* 190 */
        super.viewDidLayoutSubviews() /* 191 */
        tableView.frame = view.bounds /* 192 */
    }
    
    //MARK: - Private
    
    private func setUpTable() { /* 193 */
        view.addSubview(tableView) /* 211 */
        tableView.delegate = self /* 212 */
        tableView.dataSource = self /* 213 */
    }
    
    private func fetchNews() { /* 194 */
        
    }
    
    private func open(url: URL) { /* 197 */
        
    }

}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource { /* 214 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 215 */
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 216 */
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { /* 222 */
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 217 */
        140 /* 223 */
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { /* 220 */
        70 /* 221 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 218 */
        tableView.deselectRow(at: indexPath, animated: true) /* 219 */
    }
}
