//
//  MetricCollectionViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 24.05.2023.
//

import UIKit

/// Metric table cell
final class MetricCollectionViewCell: UICollectionViewCell {
    /// Ccell identifier
    static let identifier = "MetricCollectionViewCell" /* 786 */
    
    /// Metric table cell viewModel
    struct ViewModel { /* 795 */
        let name: String /* 796 */
        let value: String /* 796 */
    }
    
    /// Name Label
    private let nameLabel: UILabel = { /* 797 */
       let label = UILabel() /* 798 */
        
        return label /* 799 */
    }()
    
    /// Value Label
    private let valueLabel: UILabel = { /* 800 */
       let label = UILabel() /* 801 */
        label.textColor = .secondaryLabel /* 802 */
        return label /* 803 */
    }()
    
    //MARK: - Init
    
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
    
    /// Configure view
    /// - Parameter viewModel: Views ViewModel
    func configure(with viewModel: ViewModel) { /* 811 */
        nameLabel.text = viewModel.name+":" /* 812 */
        valueLabel.text = viewModel.value /* 813 */
    }
}
