//
//  FinanzialMetricsResponse.swift
//  Stocks
//
//  Created by Nazar Kopeika on 24.05.2023.
//

import Foundation

struct FinancialMetricsResponse: Codable { /* 732 */
    let metric: Metrics /* 733 */
}

struct Metrics: Codable { /* 734 */
    let TenDayAverageTradingVolume: Float /* 735 */
    let AnnualWeekHigh: Double /* 735 */
    let AnnualWeekLow: Double /* 735 */
    let AnnualWeekLowDate: String /* 735 */
    let AnnualWeekPriceReturnDaily: Float /* 735 */
    let beta: Float /* 735 */
    
    enum CodingKeys: String, CodingKey { /* 736 */
        case TenDayAverageTradingVolume = "10DayAverageTradingVolume" /* 737 */
        case AnnualWeekHigh = "52WeekHigh" /* 737 */
        case AnnualWeekLow = "52WeekLow" /* 737 */
        case AnnualWeekLowDate = "52WeekLowDate" /* 737 */
        case AnnualWeekPriceReturnDaily = "52WeekPriceReturnDaily" /* 737 */
        case beta = "beta" /* 737 */
    }
}

