//
//  SeasonTableViewCell.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-01.
//

import UIKit

class SeasonTableViewCell: UITableViewCell {

    @IBOutlet weak var seasonNumberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(seasonNumber: Int) {
        seasonNumberLabel.text = "Season: \(seasonNumber)"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.accessoryType = selected ? .checkmark : .none
    }
}
