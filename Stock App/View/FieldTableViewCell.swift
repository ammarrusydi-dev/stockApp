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
        
        var dateConverted: Date = Date()
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateConverted = formatter4.date(from: date) ?? Date()
        
        var dateStringConverted = ""
        let formatter2 = DateFormatter()
        formatter2.timeStyle = .medium
        dateStringConverted = formatter2.string(from: dateConverted)

        let openDouble: Double = data.open?.toDouble() ?? 0.0
        let highDouble: Double = data.high?.toDouble() ?? 0.0
        let lowDouble: Double = data.low?.toDouble() ?? 0.0
        
        openLbl.textColor = UIColor.systemGray
        highLbl.textColor = UIColor.systemGray
        lowLbl.textColor = UIColor.systemGray
        
        if highDouble > openDouble {
            highLbl.textColor = UIColor.green
        }
        
        if lowDouble < openDouble {
            lowLbl.textColor = UIColor.red
        }
        
        if highDouble > openDouble && lowDouble >= openDouble {
            openLbl.textColor = UIColor.green
        }
        
        if highDouble <= openDouble && lowDouble < openDouble {
            openLbl.textColor = UIColor.red
        }
        
        dateLbl.text = dateStringConverted
        openLbl.text = String(format: "%.2f", openDouble)
        highLbl.text = String(format: "%.2f", highDouble)
        lowLbl.text = String(format: "%.2f", lowDouble)
     }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
