//
//  WatchListTableViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import UIKit

protocol WatchListTableViewCellDelegate: AnyObject { /* 594 */
    func didUpdateMaxWidth() /* 595 */
}

class WatchListTableViewCell: UITableViewCell {
   static let identifier = "WatchListTableViewCell" /* 487 */
    
    weak var delegate: WatchListTableViewCellDelegate? /* 596 */
    
    static let preferredHeight: CGFloat = 60 /* 488 */
    
    struct ViewModel { /* 489 */
        let symbol: String /* 526 */
        let companyName: String /* 526 */
        let price: String //formatted /* 526 */
        let changeColor: UIColor //red of green /* 526 */
        let changePercentage: String // formatted /* 526 */
        let chartViewModel: StockChartView.ViewModel /* 609 */ 
        
    }
    
    //Symbol Label
    private let symbolLabel: UILabel = { /* 499 */
       let label = UILabel() /* 500 */
        label.font = .systemFont(ofSize: 16, weight: .medium) /* 501 */
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
        label.textAlignment = .right /* 605 */
        return label /* 510 */
    }()
    
    //Change Label
    private let changeLabel: UILabel = { /* 511 */
       let label = UILabel() /* 512 */
        label.textAlignment = .right /* 604 */
        label.textColor = .white /* 513 */
        label.font = .systemFont(ofSize: 15, weight: .regular) /* 514 */
        label.layer.masksToBounds = true /* 602 */
        label.layer.cornerRadius = 6 /* 603 */
        return label /* 515 */
    }()
    
    //MiniChart View
    private let miniChartView: StockChartView = { /* 522 */
       let chart = StockChartView() /* 587 */
//        chart.backgroundColor = .link /* 588 */
        chart.isUserInteractionEnabled = false /* 860 */
        chart.clipsToBounds = true /* 611 */
        return chart /* 589 */
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 490 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 491 */
        contentView.clipsToBounds = true /* 612 */
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
        symbolLabel.sizeToFit() /* 580 */
        nameLabel.sizeToFit() /* 580 */
        priceLabel.sizeToFit() /* 580 */
        changeLabel.sizeToFit() /* 580 */
        
        let yStart: CGFloat = (contentView.height - symbolLabel.height - nameLabel.height)/2 /* 581 */
        symbolLabel.frame = CGRect(
            x: separatorInset.left,
            y: yStart,
            width: symbolLabel.width,
            height: symbolLabel.height
        ) /* 582 */
        
        nameLabel.frame = CGRect(
            x: separatorInset.left,
            y: symbolLabel.bottom,
            width: nameLabel.width,
            height: nameLabel.height
        ) /* 583 */
        
        let currentWidth = max(
            max(priceLabel.width, changeLabel.width),
            WatchListViewController.maxChangeWidth
        ) /* 591 */
        
        if currentWidth > WatchListViewController.maxChangeWidth { /* 592 */
            WatchListViewController.maxChangeWidth = currentWidth /* 593 */
            delegate?.didUpdateMaxWidth() /* 597 */
        }
        
        priceLabel.frame = CGRect( 
            x: contentView.width-10-currentWidth,
            y: (contentView.height - priceLabel.height - changeLabel.height)/2, /* 613 change 0 */
            width: currentWidth,
            height: priceLabel.height
        ) /* 584 */
        
        changeLabel.frame = CGRect(
            x: contentView.width-10-currentWidth,
            y: priceLabel.bottom,
            width: currentWidth,
            height: changeLabel.height
        ) /* 585 */
        
        miniChartView.frame = CGRect(
            x: priceLabel.left - (contentView.width/3) - 5,
            y: 6,
            width: contentView.width/3,
            height: contentView.height-12
        ) /* 586 */
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
        nameLabel.text = viewModel.companyName /* 527 */
        priceLabel.text = viewModel.price /* 527 */
        changeLabel.text = viewModel.changePercentage /* 527 */
        changeLabel.backgroundColor = viewModel.changeColor /* 527 */
        //Configure Chart
        miniChartView.configure(with: viewModel.chartViewModel) /* 853 */
    }
    
}
