//
//  SearchResultTableViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {
    static let identifier = "SearchResultTableViewCell" /* 83 */
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 84 */
        super.init(style: style, reuseIdentifier: reuseIdentifier) /* 85 */
    }
    
    required init?(coder: NSCoder) { /* 86 */
        fatalError() /* 87 */
    }
}
