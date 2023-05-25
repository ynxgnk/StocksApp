//
//  SearchResultTableViewCell.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

///Tableview cell for search result
final class SearchResultTableViewCell: UITableViewCell {
    ///Identifier for cell
    static let identifier = "SearchResultTableViewCell" /* 83 */
    
    //MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) { /* 84 */
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier) /* 85 */
    }
    
    required init?(coder: NSCoder) { /* 86 */
        fatalError() /* 87 */
    }
}
