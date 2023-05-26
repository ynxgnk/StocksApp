//
//  StocksTests.swift
//  StocksTests
//
//  Created by Nazar Kopeika on 26.05.2023.
//

@testable import Stocks /* 897 */

import XCTest

final class StocksTests: XCTestCase { /* 895 */

    func testSomething() { /* 896 test */
        let number = 1 /* 896 */
        let string = "1" /* 896 */
        XCTAssertEqual(number, Int(string), "Numbers do not match") /* 896 */
    }
    
    func testCandlesStickDataConversation() { /* 898 */
        let doubles: [Double] = Array(repeating: 12.2, count: 10) /* 899 */
        var timestampts: [TimeInterval] = [] /* 901 */
        for x in 0..<12 { /* 903 */
            let interval = Date().addingTimeInterval(3600*TimeInterval(x)).timeIntervalSince1970 /* 904 */
            timestampts.append(interval) /* 905 */
        }
        
        let marketData = MarketDataResponse(
            open: doubles,
            close: doubles,
            high: doubles,
            low: doubles,
            status: "success",
            timestamps: timestampts
        ) /* 900 */
        
        timestampts.shuffle() /* 910 */
        
        let candleSticks = marketData.candleSticks /* 902 */
        
        XCTAssertEqual(candleSticks.count, marketData.open.count) /* 906 */
        XCTAssertEqual(candleSticks.count, marketData.close.count) /* 907 */
        XCTAssertEqual(candleSticks.count, marketData.high.count) /* 908 */
        XCTAssertEqual(candleSticks.count, marketData.low.count) /* 909 */
//        XCTAssertEqual(candleSticks.count, marketData.timestamps.count) /* 916 */
        
        //Verify sort
        let dates = candleSticks.map { $0.date } /* 911 */
        for x in 0..<dates.count-1 { /* 912 */
            let current = dates[x] /* 913 */
            let next = dates[x+1] /* 914 */
            XCTAssertTrue(current > next, "\(current) date should be greater than \(next) date") /* 915 */
        }
        
    }
}
/*
 target 'StocksTests' do
   # Comment the next line if you don't want to use dynamic frameworks
   use_frameworks!

 pod 'FloatingPanel'
 pod 'SDWebImage'
 pod 'Charts'
 end
 */
