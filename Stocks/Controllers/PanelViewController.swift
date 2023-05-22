//
//  PanelViewController.swift
//  Stocks
//
//  Created by Nazar Kopeika on 22.05.2023.
//

import UIKit

class PanelViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let grabberView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 10)) /* 176 */
        grabberView.backgroundColor = .label /* 177 */
        view.addSubview(grabberView) /* 178 */
        grabberView.center = CGPoint(x: view.center.x, y: 5) /* 179 */
        view.backgroundColor = .secondarySystemBackground /* 170 */
    }

}
