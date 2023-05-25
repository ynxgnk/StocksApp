//
//  StockChartView.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import Charts /* 834 */
import UIKit

/// View to show a vhart
final class StockChartView: UIView {
    
    /// Chart View ViewModel
    struct ViewModel { /* 606 */
        let data: [Double] /* 607 */
        let showLegend: Bool /* 607 */
        let showAxis: Bool /* 607 */
        let fillColor: UIColor /* 871 */
    }
    
    /// Chart View
    private let chartView: LineChartView = { /* 835 */
       let chartView = LineChartView() /* 836 */
        chartView.pinchZoomEnabled = false /* 837 */
        chartView.setScaleEnabled(true) /* 838 */
        chartView.xAxis.enabled = false /* 839 */
        chartView.drawGridBackgroundEnabled = false /* 840 */
        chartView.legend.enabled = false /* 859 */
        chartView.leftAxis.enabled = false /* 841 */
        chartView.rightAxis.enabled = false /* 842 */
        return chartView /* 843 */
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) { /* 516 */
        super.init(frame: frame) /* 517 */
        addSubview(chartView) /* 844 */
    }
    
    required init?(coder: NSCoder) { /* 518 */
        fatalError() /* 519 */
    }
    
    override func layoutSubviews() { /* 520 */
        super.layoutSubviews() /* 521 */
        chartView.frame = bounds /* 845 */
    }
    
    ///Reset the chart view
    func reset() { /* 525 */
        chartView.data = nil /* 846 */
    }
    
    /// ConfigureView
    /// - Parameter viewModel: View ViewModel
    func configure(with viewModel: ViewModel) { /* 608 */
        var entries = [ChartDataEntry]() /* 847 */
        
        for (index, value) in viewModel.data.enumerated() { /* 848 */
            entries.append(
                .init(
                    x: Double(index),
                    y: value
                )
            ) /* 849 */
        }
        
        chartView.rightAxis.enabled = viewModel.showAxis /* 869 */
        chartView.legend.enabled = viewModel.showLegend /* 870 */
        
        let dataSet = LineChartDataSet(entries: entries, label: "7 Days") /* 850 */
        dataSet.fillColor = viewModel.fillColor /* 854 */ /* 872 change .systemBlue */
        dataSet.drawFilledEnabled = true /* 855 */
        dataSet.drawIconsEnabled = false /* 856 */
        dataSet.drawValuesEnabled = false /* 857 */
        dataSet.drawCirclesEnabled = false /* 858 */
        let data = LineChartData(dataSet: dataSet) /* 851 */
        chartView.data = data /* 852 */
    }
}
