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
        
    }
    
    private init() {} /* 40 */
    
    //MARK: - Public
    
    public var watchlist: [String] { /* 41 */
        return [] /* 42 */
    }
    
    public func addToWatchList() { /* 43 */
        
    }
    
    public func removeFromWatchList() { /* 44 */
        
    }
    
    //MARK: - Private
    
    private var hasOnboarded: Bool { /* 45 */
        return false /* 46 */
    }
}
