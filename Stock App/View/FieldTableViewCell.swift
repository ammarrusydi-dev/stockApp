//
//  FieldTableViewCell.swift
//  Stock App
//
//  Created by Massive Infinity on 21/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell {

    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var openLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with data: IntradayData, date: String) {
        dateLbl.text = date
        openLbl.text = data.open
        highLbl.text = data.high
        lowLbl.text = data.low
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
