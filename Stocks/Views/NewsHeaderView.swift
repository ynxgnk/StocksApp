//
//  NewsHeaderView.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

protocol NewsHeaderViewDelegate: AnyObject { /* 271 */
    func newsHeaderViewDidTapAddButton(_ headerView: NewsHeaderView) /* 272 */
}

class NewsHeaderView: UITableViewHeaderFooterView {
    static let identifier = "NewsHeaderView" /* 226 */
    static let preferredHeight: CGFloat = 70 /* 227 */
    
    weak var delegate: NewsHeaderViewDelegate? /* 273 */
    
    struct ViewModel { /* 228 */
        let title: String /* 229 */
        let shouldShowAddButton: Bool /* 229 */
    }
    
    private let label: UILabel = { /* 239 */
        let label = UILabel() /* 240 */
        label.font = .systemFont(ofSize: 32, weight: .semibold) /* 241 */
        return label /* 242 */
    }()
    
    private let button: UIButton = { /* 243 */
       let button = UIButton() /* 244 */
        button.setTitle("+ Watchlist", for: .normal) /* 245 */
        button.backgroundColor = .systemBlue /* 246 */
        button.setTitleColor(.white, for: .normal) /* 247 */
        button.layer.cornerRadius = 8 /* 248 */
        button.layer.masksToBounds = true /* 249 */
        return button /* 250 */
    }()
    
    //MARK: - Init
    
    override init(reuseIdentifier: String?) { /* 230 */
        super.init(reuseIdentifier: reuseIdentifier) /* 231 */
        contentView.backgroundColor = .secondarySystemBackground /* 269 */
        contentView.addSubview(label) /* 251 */
        contentView.addSubview(button) /* 252 */
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside) /* 260 */
    }
    
    required init?(coder: NSCoder) { /* 232 */
        fatalError() /* 233 */
    }
    
    @objc private func didTapButton() { /* 261 */
        //Call delegate
        delegate?.newsHeaderViewDidTapAddButton(self) /* 274 */
    }
    
    override func layoutSubviews() { /* 234 */
        super.layoutSubviews() /* 235 */
        label.frame = CGRect(x: 14, y: 0, width: contentView.width-28, height: contentView.height) /* 262 */
        
        button.sizeToFit()
        button.frame = CGRect(
            x: contentView.width-button.width-16,
            y: (contentView.height-button.height)/2,
            width: button.width+8,
            height: button.height
        ) /* 270 */
    }
    
    
    override func prepareForReuse() { /* 236 */
        super.prepareForReuse() /* 237 */
        label.text = nil /* 259 */
    }
    
    public func configure(with viewModel: ViewModel) { /* 238 */
        label.text = viewModel.title /* 257 */
        button.isHidden = !viewModel.shouldShowAddButton /* 258 */
    }
 
}
