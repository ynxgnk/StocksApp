//
//  Extensions.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import Foundation
import UIKit /* 68 */


extension UIImageView { /* 375 */
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
    static func string(from timeInterval: TimeInterval) -> String { /* 370 */
        let date = Date(timeIntervalSince1970: timeInterval) /* 371 */
        return DateFormatter.prettyDateFormatter.string(from: date) /* 372 */
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
    func addSubviews(_ views: UIView...) { /* 254 */
        views.forEach { /* 255 */
            addSubview($0) /* 256 */
        }
    }
}

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
