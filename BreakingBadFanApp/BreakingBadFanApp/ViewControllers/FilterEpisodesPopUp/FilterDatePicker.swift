//
//  FilterDatePicker.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-05-22.
//

import UIKit

class FilterDatePicker: UIDatePicker {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        self.datePickerMode = .date
        self.preferredDatePickerStyle = .wheels
        self.backgroundColor = .white
        self.layer.borderWidth = 0.5
        self.backgroundColor = .appLightGreen
        self.setValue(UIColor.white, forKey: "textColor")
        self.autoresizingMask = .flexibleWidth
        self.contentMode = .center
        self.frame = CGRect(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.calendar = .current
        self.date = Date()
    }
}
