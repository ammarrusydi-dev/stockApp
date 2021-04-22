//
//  SearchModel.swift
//  Stock App
//
//  Created by Massive Infinity on 23/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import Foundation

// MARK: - SearchData
struct SearchResult: Codable {
    var bestMatches: [SearchData]?
}

// MARK: - BestMatch
struct SearchData: Codable {
    var symbol: String?

    enum CodingKeys: String, CodingKey {
        case symbol = "1. symbol"
    }
}

