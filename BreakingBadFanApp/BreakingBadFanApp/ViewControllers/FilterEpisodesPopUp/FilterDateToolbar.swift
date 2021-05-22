//
//  FilterDateToolbar.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-05-22.
//

import UIKit

class FilterDateToolbar: UIToolbar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50)
        self.barStyle = .default
        self.setBackgroundImage(
            UIImage(),
            forToolbarPosition: .any,
            barMetrics: .default
        )
        self.setShadowImage(
            UIImage(),
            forToolbarPosition: .any
        )
    }
}
