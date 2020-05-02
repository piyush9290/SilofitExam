//
//  UIViewController.swift
//  SilofitExam
//
//  Created by Piyush Sharma on 2020-04-26.
//  Copyright © 2020 Piyush Sharma. All rights reserved.
//

import Foundation
import UIKit

protocol Routable {
    var viewController: UIViewController { get }
}

extension UIViewController: Routable {
    public var viewController: UIViewController {
        return self
    }
}
