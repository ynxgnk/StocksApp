//
//  WatchListTableViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import UIKit

class WatchListTableViewCell: UITableViewCell {
   static let identifier = "WatchListTableViewCell" /* 487 */
    
    static let preferredHeight: CGFloat = 60 /* 488 */
    
    struct ViewModel { /* 489 */
        let symbol: String /* 526 */
        let companyName: String /* 526 */
        let price: String //formatted /* 526 */
        let changeColor: UIColor //red of green /* 526 */
        let changePercentage: String // formatted /* 526 */
        // let chartViewModel: StockChartView.ViewModel
        
    }
    
    //Symbol Label
    private let symbolLabel: UILabel = { /* 499 */
       let label = UILabel() /* 500 */
        label.font = .systemFont(ofSize: 15, weight: .medium) /* 501 */
        return label /* 502 */
    }()
    
    //Company Label
    private let nameLabel: UILabel = { /* 503 */
       let label = UILabel() /* 504 */
        label.font = .systemFont(ofSize: 15, weight: .regular) /* 505 */
        return label /* 506 */
    }()
        
    //Price Label
    private let priceLabel: UILabel = { /* 507 */
       let label = UILabel() /* 508 */
        label.font = .systemFont(ofSize: 15, weight: .regular) /* 509 */
        return label /* 510 */
    }()
    
    //Change Label
    private let changeLabel: UILabel = { /* 511 */
       let label = UILabel() /* 512 */
        label.textColor = .white /* 513 */
        label.font = .systemFont(ofSize: 15, weight: .regular) /* 514 */
        return label /* 515 */
    }()
    
    //MiniChart View
    private let miniChartView = StockChartView() /* 522 */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 490 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 491 */
        addSubviews(
            symbolLabel,
            nameLabel,
            miniChartView,
            priceLabel,
            changeLabel
        ) /* 523 */
    }
    
    required init?(coder: NSCoder) { /* 492 */
        fatalError() /* 493 */
    }
    
    override func layoutSubviews() { /* 494 */
        super.layoutSubviews() /* 495 */
        
    }
    
    override func prepareForReuse() { /* 496 */
        super.prepareForReuse() /* 497 */
        symbolLabel.text = nil /* 524 */
        nameLabel.text = nil /* 524 */
        priceLabel.text = nil /* 524 */
        changeLabel.text = nil /* 524 */
        miniChartView.reset() /* 524 */
    }
    
    public func configure(with viewModel: ViewModel) { /* 498 */
        symbolLabel.text = viewModel.symbol /* 527 */
        nameLabel.text = viewModel.price /* 527 */
        priceLabel.text = viewModel.price /* 527 */
        changeLabel.text = viewModel.changePercentage /* 527 */
        changeLabel.backgroundColor = viewModel.changeColor /* 527 */
    }
    
}
