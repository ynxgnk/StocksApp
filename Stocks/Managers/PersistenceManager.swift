//
//  ParsistenceManager.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation

///Object to manage saved caches
final class PersistenceManager  { /* 38 */
    ///Singleton
    static let shared = PersistenceManager() /* 39 */
    
    ///Reference to user defauts
    private let userDafaults: UserDefaults = .standard /* 47 */
    
    ///Constants
    private struct Constants { /* 48 */
        static let onboardedKey = "hasOnboarded" /* 420 */
        static let watchListKey = "watchlist" /* 421 */
    }
    
    ///Privatized constructor
    private init() {} /* 40 */
    
    //MARK: - Public
    
    ///Get user watchlist
    public var watchlist: [String] { /* 41 */
        if !hasOnboarded { /* 410 */
            userDafaults.set(true, forKey: Constants.onboardedKey) /* 411 */ /* 420 change hasOnboarded */
            setUpDefaults() /* 413 */
        }
        return userDafaults.stringArray(forKey: Constants.watchListKey) ?? [] /* 42 */ /* 414 change [] */ /* 422 change "watchlist" */
    }
    
    /// Check if watch ist contains item
    /// - Parameter symbol: Sybol to check
    /// - Returns: Boolean
    public func watchlistContains(symbol: String) -> Bool { /* 713 */
        return watchlist.contains(symbol) /* 714 */
    }
    
    /// Add a symbol to watchlist
    /// - Parameters:
    ///   - symbol: Symbol to add
    ///   - companyName: Company name for symbol being added
    public func addToWatchList(symbol: String, companyName: String) { /* 43 */
        var current = watchlist /* 631 */
        current.append(symbol) /* 632 */
        userDafaults.set(current, forKey: Constants.watchListKey) /* 633 */
        userDafaults.set(companyName, forKey: symbol) /* 634 */
        
        NotificationCenter.default.post(name: .didAddToWatchList, object: nil) /* 637 */
    }
    
    /// Remove item from watchlist
    /// - Parameter symbol: Symbol to remove
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
    
    /// Check if user has been onboarded
    private var hasOnboarded: Bool { /* 45 */
        return userDafaults.bool(forKey: Constants.onboardedKey) /* 46 */ /* 409 change false */ /* 420 change hasOnboarded */
    }
    
    /// Set up default watchlist items
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
