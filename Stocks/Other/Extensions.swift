//
//  Extensions.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation
import UIKit /* 68 */

//MARK: - Notification

extension Notification.Name { /* 635 */
    ///Notification for when symbol gets added to watchlist
    static let didAddToWatchList = Notification.Name("didAddToWatchList") /* 636 */
}

//NumberFormatter

extension NumberFormatter { /* 547 */
    ///Formatter for percent style
    static let percentFormatter: NumberFormatter = { /* 548 */
       let formatter = NumberFormatter() /* 549 */
        formatter.locale = .current /* 550 */
        formatter.numberStyle = .percent /* 551 */
        formatter.maximumFractionDigits = 2 /* 552 */
        return formatter /* 553 */
    }()
    
    ///Formatter for decimal style
    static let numberFormatter: NumberFormatter = { /* 554 */
       let formatter = NumberFormatter() /* 555 */
        formatter.locale = .current /* 556 */
        formatter.numberStyle = .decimal /* 557 */
        formatter.maximumFractionDigits = 2 /* 558 */
        return formatter /* 559 */
    }()
}

//ImageView

extension UIImageView { /* 375 */
    
    /// Sets image from remote url
    /// - Parameter url: URL to fetch from
    func setImage(with url: URL?) { /* 376 */
        guard let url = url else { /* 377 */
            return /* 378 */
        }
        DispatchQueue.global(qos: .userInteractive).async { /* 385 global - not to impact main thread as much */
            let task = URLSession.shared.dataTask(with: url) { [weak self] data , _, error in /* 379 */
                guard let data = data, error == nil else { /* 380 */
                    return /* 381 */
                }
                DispatchQueue.main.async { /* 382 */
                    self?.image = UIImage(data: data) /* 383 */
                }
            }
            task.resume() /* 384 */
        }
    }
}


//MARK: - String

extension String { /* 369 */
    /// Create string from time interval
    /// - Parameter timeInterval: Timeinterval since 1970
    /// - Returns: Formatted string
    static func string(from timeInterval: TimeInterval) -> String { /* 370 */
        let date = Date(timeIntervalSince1970: timeInterval) /* 371 */
        return DateFormatter.prettyDateFormatter.string(from: date) /* 372 */
    }
    
    /// Percentage formatted string
    /// - Parameter double: Double to format
    /// - Returns: String in percent format
    static func percentage(from double: Double) -> String { /* 560 */
        let formatter = NumberFormatter.percentFormatter /* 561 */
        return formatter.string(from: NSNumber(value: double)) ?? "\(double)" /* 562 */
    }
    
    /// Format number to string
    /// - Parameter number: Number to form
    /// - Returns: formatted string
    static func formatted(number: Double) -> String { /* 563 */
        let formatter = NumberFormatter.numberFormatter /* 564 */
        return formatter.string(from: NSNumber(value: number)) ?? "\(number)" /* 565 */
    }
}

//MARK: - DateFormatter

extension DateFormatter { /* 290 */
    static let newsDateFormatter: DateFormatter = { /* 291 */
        let formatter = DateFormatter() /* 292 */
        formatter.dateFormat = "YYYY-MM-dd" /* 293 */
        return formatter /* 294 */
    }()
    
    static let prettyDateFormatter: DateFormatter = { /* 365 */
        let formatter = DateFormatter() /* 366 */
        formatter.dateStyle = .medium /* 367 */
        return formatter /* 368 */
    }()
}

//MARK: - Add Subview

extension UIView { /* 253 */
    /// Adds multiple subviews
    /// - Parameter views: Collection of subviews
    func addSubviews(_ views: UIView...) { /* 254 */
        views.forEach { /* 255 */
            addSubview($0) /* 256 */
        }
    }
}

//MARK: - Framing

extension UIView { /* 69 */
    /// Width for view
    var width: CGFloat { /* 70 */
        frame.size.width /* 71 */
    }
    /// Height for view
    var height: CGFloat { /* 70 */
        frame.size.height /* 71 */
    }
    /// Left edge of view
    var left: CGFloat { /* 70 */
        frame.origin.x /* 71 */
    }
    /// Right edge of view
    var right: CGFloat { /* 70 */
        left + width /* 71 */
    }
    /// Top edge of view
    var top: CGFloat { /* 70 */
        frame.origin.y/* 71 */
    }
    /// bottom edge of view
    var bottom: CGFloat { /* 70 */
        top + height /* 71 */
    }
}

