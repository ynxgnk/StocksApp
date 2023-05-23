//
//  MarketDataResponse.swift
//  Stocks
//
//  Created by Nazar Kopeika on 23.05.2023.
//

import Foundation

struct MarketDataResponse: Codable { /* 453 */
    let open: [Double] /* 454 */
    let close: [Double] /* 454 */
    let high: [Double] /* 454 */
    let low: [Double] /* 454 */
    let status: String /* 454 */
    let timestamps: [TimeInterval] /* 454 */
    
    enum CodingKeys: String, CodingKey { /* 455 */
        case open = "o" /* 456 */
        case low = "l" /* 456 */
        case close = "c" /* 456 */
        case high = "h" /* 456 */
        case status = "s" /* 456 */
        case timestamps = "t" /* 456 */
    }
    
    var candleSticks: [CandleStick] { /* 463 */
        var result = [CandleStick]() /* 464 */
        
        for index in 0..<open.count { /* 465 */
            result.append(
                .init(
                    date: Date(timeIntervalSince1970: timestamps[index]),
                    high: high[index],
                    low: low[index],
                    open: open[index],
                    close: close[index]
                )
            ) /* 466 */
        }
        
        let sortedData = result.sorted(by: { $0.date > $1.date }) /* 468 */
//        print(sortedData[0]) /* 469 */
        return sortedData /* 467 */
    }
}

struct CandleStick { /* 461 */
    let date: Date /* 462 */
    let high: Double /* 462 */
    let low: Double /* 462 */
    let open: Double /* 462 */
    let close: Double /* 462 */
}
