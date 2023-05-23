//
//  TopStoriesNewsViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import SafariServices /* 401 */
import UIKit

class NewsViewController: UIViewController {
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
    
    //MARK: - Properties
    
    private var stories = [NewsStory]() /* 275 */ /* 302 change [String]() */ /* 350 add [NewStory] and remove ["first"] */ /* 389 replace [] to () */
//        NewsStory(category: "tech", datetime: 123, headline: "Some headline should go here!", image: "", related: "RElated", source: "CNBC", summary: "", url: "") /* 351 test */
    
    
    private let type: Type /* 205 */
    
    let tableView: UITableView = { /* 187 */
        let table = UITableView() /* 188 */
        table.register(NewsStoryTableViewCell.self,
                       forCellReuseIdentifier: NewsStoryTableViewCell.identifier) /* 346 */
        table.register(NewsHeaderView.self,
                       forHeaderFooterViewReuseIdentifier: NewsHeaderView.identifier) /* 263 */
        table.backgroundColor = .clear /* 225 */
        return table /* 189 */
    }()
    
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
        APICaller.shared.news(for: type) { [weak self] result in /* 390 */
            switch result { /* 391 */
            case .success(let stories): /* 392 */
                DispatchQueue.main.async { /* 396 */
                    self?.stories = stories /* 393 */
                    self?.tableView.reloadData() /* 394 */
                }
            case .failure(let error): /* 392 */
                print(error) /* 395 */
            }
        }
    }
    
    private func open(url: URL) { /* 197 */
        let vc = SFSafariViewController(url: url) /* 402 */
        present(vc, animated: true) /* 403 */
    }

}


extension NewsViewController: UITableViewDelegate, UITableViewDataSource { /* 214 */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { /* 215 */
        return stories.count /* 303 */
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell { /* 216 */
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsStoryTableViewCell.identifier,
            for: indexPath
        ) as? NewsStoryTableViewCell else { /* 347 */
            fatalError() /* 352 */
        }
        cell.configure(with: .init(model: stories[indexPath.row])) /* 349 */
        return cell /* 348 */
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? { /* 222 */
        guard let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: NewsHeaderView.identifier
        ) as? NewsHeaderView else { /* 265 */
            return nil /* 266 */
        }
        header.configure(with: .init(title: self.type.title, shouldShowAddButton: false)) /* 267 .init is the same as NewsHeaderView.ViewModel */
        return header /* 268 */
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat { /* 217 */
        return NewsStoryTableViewCell.preferredHeight /* 223 */ /* 345 change 140 */
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { /* 220 */
        return NewsHeaderView.preferredHeight /* 221 */ /* 264 change 70 */
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { /* 218 */
        tableView.deselectRow(at: indexPath, animated: true) /* 219 */
        //Open news storage
        let story = stories[indexPath.row] /* 397 */
        guard let url = URL(string: story.url) else { /* 398 */
            presentFailedToOpenAlert() /* 405 */
            return /* 399 */
        }
        open(url: url) /* 400 */
    }
    
    private func presentFailedToOpenAlert() { /* 404 */
        let alert = UIAlertController(
            title: "Unable to Open",
            message: "We were unable to open the article.",
            preferredStyle: .alert
        ) /* 406 */
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)) /* 408 */
        present(alert, animated: true) /* 407 */
    }
}
