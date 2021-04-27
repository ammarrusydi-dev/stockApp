//
//  Extension.swift
//  Stock App
//
//  Created by Massive Infinity on 22/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import Foundation

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

extension UserDefaults {
    
    public func optionalInt(forKey defaultName: String) -> Int? {
        let defaults = self
        if let value = defaults.value(forKey: defaultName) {
            return value as? Int
        }
        return nil
    }
}
