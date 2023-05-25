//
//  HapticsManager.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit /* 49 */
import Foundation

/// Object to manage haptics
final class HapticsManager { /* 50 */
    
    ///Singleton
    static let shared = HapticsManager() /* 51 */
    
    ///Private constructor
    private init() {} /* 52 */
    
    //MARK: - Public
    
    ///Vibrate slightly for selection
    public func vibrateForSelection() { /* 53 */
        //Vibrate lightly for a selection tap integration
        let generator = UISelectionFeedbackGenerator() /* 882 */
        generator.prepare() /* 883 */
        generator.selectionChanged() /* 884 */
    }
    
    //vibrate for type
    /// Play haptic for given type interaction
    /// - Parameter type: Type to vibrate for
    public func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) { /* 885 */
        let generator = UINotificationFeedbackGenerator() /* 886 */
        generator.prepare() /* 887 */
        generator.notificationOccurred(type) /* 888 */
    }
}

