//
//  StockDetailHeaderView.swift
//  Stocks
//
//  Created by Nazar Kopeika on 24.05.2023.
//

import UIKit

class StockDetailHeaderView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout { /* 765 add 3 protocols */

    //ChartView
    private let chartView = StockChartView() /* 752 */
    
    //CollectionView
    private let collectionView: UICollectionView = { /* 753 */
        let layout = UICollectionViewFlowLayout() /* 754 */
        layout.scrollDirection = .horizontal /* 755 */
        layout.minimumInteritemSpacing = 0 /* 756 */
        layout.minimumLineSpacing = 0 /* 757 */
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) /* 758 */
        collectionView.backgroundColor = .red /* 774 */
        //Register cells
        return collectionView /* 759 */
    }()
    
    override init(frame: CGRect) { /* 760 */
        super.init(frame: frame) /* 761 */
        clipsToBounds = true /* 785 */
        addSubviews(chartView, collectionView) /* 762 */
        collectionView.delegate = self /* 763 */
        collectionView.dataSource = self /* 764 */
    }
    
    required init?(coder: NSCoder) { /* 766 */
        fatalError() /* 767 */
    }
    
    override func layoutSubviews() { /* 775 */
        super.layoutSubviews() /* 776 */
        chartView.frame = CGRect(x: 0, y: 0, width: width, height: height-100) /* 784 */
        collectionView.frame = CGRect(x: 0, y: height-100, width: width, height: 100) /* 783 */
    }
    
    func configure(chartViewModel: StockChartView.ViewModel) { /* 777 */
        
    }
    
    //MARK: - CollectionView
    
    func numberOfSections(in collectionView: UICollectionView) -> Int { /* 768 */
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { /* 769 */
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell { /* 770 */
        return UICollectionViewCell() /* 771 */
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)  -> CGSize { /* 772 */
        return CGSize(width: width/2, height: height/3) /* 773 */
    }
}
