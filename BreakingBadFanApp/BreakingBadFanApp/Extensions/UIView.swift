//
//  UIView.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-02-28.
//

import UIKit

extension UIView {
    static var nib: UINib {
        return UINib(nibName: String(describing: Self.self), bundle: nil)
    }
    
    static func loadFromNib() -> Self {
        let nibName = String(describing: Self.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
