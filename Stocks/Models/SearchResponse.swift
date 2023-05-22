//
//  SearchResponse.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation

struct SearchResponse: Codable { /* 127 */
    let count: Int /* 128 */
    let result: [SearchResult] /* 129 */
}

struct SearchResult: Codable { /* 130 */
    let description: String /* 131 */
    let displaySymbol: String /* 131 */
    let symbol: String /* 131 */
    let type: String /* 131 */
}
