//
//  SearchTableViewCell.swift
//  Stock App
//
//  Created by Massive Infinity on 23/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var symbolLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with symbol: String) {
        symbolLbl.text = symbol
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
