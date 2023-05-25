//
//  NewsStory.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import Foundation

/// Represent news story
struct NewsStory: Codable { /* 279 */
    let category: String /* 280 */
    let datetime: TimeInterval /* 280 */
    let headline: String/* 280 */
    let image: String /* 280 */
    let related: String /* 280 */
    let source: String /* 280 */
    let summary: String /* 280 */
    let url: String /* 280 */
}
