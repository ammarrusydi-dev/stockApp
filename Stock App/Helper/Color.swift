//
//  Color.swift
//  Stock App
//
//  Created by Massive Infinity on 21/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    @nonobjc class var black8: UIColor {
        return UIColor(white: 0.0, alpha: 0.08)
    }
    
    static let RTBYellow = UIColor(hexString: "#fab92b")
    static let RTBYellow2 = UIColor(hexString: "#d69828")
    static let RTBBlack = UIColor(hexString: "#191919")
    static let RTBBlack2 = UIColor(hexString: "#292929")
    static let RTBGrey = UIColor(hexString: "#242424")
    static let RTBTextGrey = UIColor(hexString: "#CCCCCC")
    static let RTBGrey2 = UIColor(hexString: "#A09FA1")
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
