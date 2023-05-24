//
//  MetricCollectionViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 24.05.2023.
//

import UIKit

class MetricCollectionViewCell: UICollectionViewCell {
    static let identifier = "MetricCollectionViewCell" /* 786 */
    
    struct ViewModel { /* 795 */
        let name: String /* 796 */
        let value: String /* 796 */
    }
    
    private let nameLabel: UILabel = { /* 797 */
       let label = UILabel() /* 798 */
        
        return label /* 799 */
    }()
    
    private let valueLabel: UILabel = { /* 800 */
       let label = UILabel() /* 801 */
        label.textColor = .secondaryLabel /* 802 */
        return label /* 803 */
    }()
    
    override init(frame: CGRect) { /* 787 */
        super.init(frame: frame) /* 788 */
        contentView.clipsToBounds = true /* 804 */
        addSubviews(nameLabel, valueLabel) /* 805 */
    }
    
    required init?(coder: NSCoder) { /* 789 */
        fatalError() /* 790 */
    }
    
    override func layoutSubviews() { /* 791 */
        super.layoutSubviews() /* 792 */
        valueLabel.sizeToFit() /* 806 */
        nameLabel.sizeToFit() /* 807 */
        nameLabel.frame = CGRect(x: 3, y: 0, width: nameLabel.width, height: contentView.height) /* 808 */
        valueLabel.frame = CGRect(x: nameLabel.right + 3, y: 0, width: valueLabel.width, height: contentView.height) /* 809 */
    }
    
    override func prepareForReuse() { /* 793 */
        super.prepareForReuse() /* 794 */
        nameLabel.text = nil /* 810 */
        valueLabel.text = nil /* 810 */
    }
    
    func configure(with viewModel: ViewModel) { /* 811 */
        nameLabel.text = viewModel.name+":" /* 812 */
        valueLabel.text = viewModel.value /* 813 */
    }
}
