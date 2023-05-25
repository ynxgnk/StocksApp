//
//  SceneDelegate.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    /// Our main app window
    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return } /* 2 change _ */
        
        let window = UIWindow(windowScene: windowScene) /* 3 */
        
        let vc = WatchListViewController() /* 4 */
        let navVC = UINavigationController(rootViewController: vc) /* 5 */
        window.rootViewController = navVC /* 6 */
        window.makeKeyAndVisible() /* 7 */
        
        self.window = window /* 8 */
    }

    func sceneDidDisconnect(_ scene: UIScene) {
     
    }

    func sceneDidBecomeActive(_ scene: UIScene) {

    }

    func sceneWillResignActive(_ scene: UIScene) {

    }

    func sceneWillEnterForeground(_ scene: UIScene) {

    }

    func sceneDidEnterBackground(_ scene: UIScene) {

    }


}
