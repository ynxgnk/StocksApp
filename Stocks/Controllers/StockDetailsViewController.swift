//
//  StockDetailsViewControllerViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class StockDetailsViewController: UIViewController {
    
    //MARK: - Properties
    
    //Symbol, Company Name, Any chart data we may have
    private let symbol: String /* 653  */
    private let companyName: String /* 654 */
    private var candleStickData: [CandleStick] /* 655 */
    
    //MARK: Init
    
    init(
        symbol: String,
        companyName: String,
        candleStickData: [CandleStick] = []
    ) { /* 648 */
        self.symbol = symbol /* 652 */
        self.companyName = companyName /* 652 */
        self.candleStickData = candleStickData /* 652 */
        super.init(nibName: nil, bundle: nil) /* 649 */
    }
    
    required init?(coder: NSCoder) { /* 650 */
        fatalError() /* 651 */
    }
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground /* 167 */
    }

}
