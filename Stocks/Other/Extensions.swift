//
//  Extensions.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation
import UIKit /* 68 */

//MARK: - Framing

extension UIView { /* 69 */
    var width: CGFloat { /* 70 */
        frame.size.width /* 71 */
    }
    var height: CGFloat { /* 70 */
        frame.size.height /* 71 */
    }
    var left: CGFloat { /* 70 */
        frame.origin.x /* 71 */
    }
    var right: CGFloat { /* 70 */
        left + width /* 71 */
    }
    var top: CGFloat { /* 70 */
        frame.origin.y/* 71 */
    }
    var bottom: CGFloat { /* 70 */
        top + height /* 71 */
    }
}
