//
//  AppDelegate.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //        APICaller.shared.search(query: "Apple") { result in /* 126 */
        //            switch result { /* 134 */
        //            case .success(let response): /* 135 */
        //                print(response.result)
        //            case .failure(let error): /* 135 */
        //                print(error)
        //            }
        //        }
        
        debug() /* 286 */
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }
    
    private func debug() { /* 283 testing function */
        APICaller.shared.marketData(for: "AAPL", numberOfDays: 1) { result in /* 459 */
            switch result { /* 470 */
            case .success(let data): /* 471 */
                let candleSticks = data.candleSticks /* 472 */
            case .failure(let error): /* 471 */
                print(error) /* 460 */
            }
        }
        
    }
}
    // was in func debug
    //        APICaller.shared.news(for: .company(symbol: "MSFT")) { result in /* 284 */ /* 298 change .topStories to company with MSFT */
    //            switch result { /* 299 */
    //            case .success(let news): /* 300 */
    //                print(news.count) /* 285 */
    //            case .failure(let error): /* 300 */
    //                break
    //            }
    //        }
    //    }
