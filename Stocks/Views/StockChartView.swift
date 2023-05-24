//
//  StockChartView.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import UIKit

class StockChartView: UIView {
    
    struct ViewModel { /* 606 */
        let data: [Double] /* 607 */
        let showLegend: Bool /* 607 */
        let showAxis: Bool /* 607 */
    }
    
    override init(frame: CGRect) { /* 516 */
        super.init(frame: frame) /* 517 */
    }
    
    required init?(coder: NSCoder) { /* 518 */
        fatalError() /* 519 */
    }
    
    override func layoutSubviews() { /* 520 */
        super.layoutSubviews() /* 521 */
    }
    
    ///Reset the chart view
    func reset() { /* 525 */
        
    }
    
    func configure(with viewModel: ViewModel) { /* 608 */
        
    }
}
