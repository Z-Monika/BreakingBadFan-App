//
//  QuotesTableViewCell.swift
//  BreakingBadFanApp
//
//  Created by Monika Zdaneviciute on 2021-03-02.
//

import UIKit

protocol QuoteSelectionDelegate {
    func didSelectQuote()
}

class QuotesTableViewCell: UITableViewCell {

    var quoteSelectionDelegate: QuoteSelectionDelegate?

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var quoteFavoriteCountLabel: UILabel!
    
    var isFavoriteQuote: Bool = false {
        didSet {
            favoriteImageView.isHighlighted = isFavoriteQuote
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteImageView.image = UIImage(named: "clearHeart")?.withTintColor(.red)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        markAsFavorite(selected: selected)
        quoteSelectionDelegate?.didSelectQuote()
    }
}

//MARK: - Configure cell view -

extension QuotesTableViewCell {
    
    func configureCell(quote: String, favoriteCount: Int?) {
        quoteLabel.text = "\"\(quote)\""
        if let favoriteCount = favoriteCount {
            quoteFavoriteCountLabel.text = String(favoriteCount)
        }
    }
    
    private func markAsFavorite(selected: Bool) {
        favoriteImageView.image = selected ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
    }
}

