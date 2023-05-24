//
//  ParsistenceManager.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation



final class PersistenceManager  { /* 38 */
    static let shared = PersistenceManager() /* 39 */
    
    private let userDafaults: UserDefaults = .standard /* 47 */
    
    private struct Constants { /* 48 */
        static let onboardedKey = "hasOnboarded" /* 420 */
        static let watchListKey = "watchlist" /* 421 */
    }
    
    private init() {} /* 40 */
    
    //MARK: - Public
    
    public var watchlist: [String] { /* 41 */
        if !hasOnboarded { /* 410 */
            userDafaults.set(true, forKey: Constants.onboardedKey) /* 411 */ /* 420 change hasOnboarded */
            setUpDefaults() /* 413 */
        }
        return userDafaults.stringArray(forKey: Constants.watchListKey) ?? [] /* 42 */ /* 414 change [] */ /* 422 change "watchlist" */
    }
    
    public func watchlistContains(symbol: String) -> Bool { /* 713 */
        return watchlist.contains(symbol) /* 714 */
    }
    
    public func addToWatchList(symbol: String, companyName: String) { /* 43 */
        var current = watchlist /* 631 */
        current.append(symbol) /* 632 */
        userDafaults.set(current, forKey: Constants.watchListKey) /* 633 */
        userDafaults.set(companyName, forKey: symbol) /* 634 */
        
        NotificationCenter.default.post(name: .didAddToWatchList, object: nil) /* 637 */
    }
    
    public func removeFromWatchList(symbol: String) { /* 44 */
        var newList = [String]() /* 625 */
        
        print("Deleting: \(symbol)") /* 630 */
        
        userDafaults.set(nil, forKey: symbol) /* 629 */
        for item in watchlist where item != symbol { /* 626 */
            newList.append(item) /* 627 */
        }
        
        userDafaults.set(newList, forKey: Constants.watchListKey) /* 628 */
    }
    
    //MARK: - Private
    
    private var hasOnboarded: Bool { /* 45 */
        return userDafaults.bool(forKey: Constants.onboardedKey) /* 46 */ /* 409 change false */ /* 420 change hasOnboarded */
    }
    
    private func setUpDefaults() { /* 412 */
        let map: [String: String] = [ /* 415 */
            "AAPL": "Apple Inc",
            "MSFT": "Microsoft Corporation",
            "SNAP": "Snap Inc.",
            "GOOG": "Alphabet",
            "AMZN": "Amazon.com, Inc.",
            "WORK": "Slack Technologies",
            "FB": "Facebook Inc.",
            "NVDA": "Nvidia Inc.",
            "NKE": "Nike",
            "PINS": "Pinterest Inc."
        ]
        
        let symbols = map.keys.map { $0 } /* 416 */
        userDafaults.set(symbols, forKey: Constants.watchListKey) /* 417 */ /* 422 change "watchlist" */
        
        for (symbol, name) in map { /* 418 */
            userDafaults.set(name, forKey: symbol) /* 419 */
        }
    }
}
