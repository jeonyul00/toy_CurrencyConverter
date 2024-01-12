//
//  CurrencyCell.swift
//  CurrencyConverterApp
//
//  Created by 전율 on 2023/11/06.
//

import UIKit

class CurrencyCell: UITableViewCell {
    @IBOutlet private weak var leftLabel: UILabel!
    @IBOutlet private weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    func presentCurrency(rate: (String,Double), usdValue:Double) {
        self.leftLabel.text = rate.0
        let changedValue = (rate.1) * Double(usdValue)
        let resultValue = String(format: "%.2f", changedValue)
        self.rightLabel.text = resultValue.description
    }
    
    
}
