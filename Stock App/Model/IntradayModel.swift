//
//  IntradayModel.swift
//  Stock App
//
//  Created by Massive Infinity on 21/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import Foundation

// MARK: - APIData
struct APIData: Codable {
    var metaData: MetaData?
    var timeSeries1Min: [String: IntradayData]?
    var timeSeries5Min: [String: IntradayData]?
    var timeSeries15Min: [String: IntradayData]?
    var timeSeries30Min: [String: IntradayData]?
    var timeSeries60Min: [String: IntradayData]?
    var timeSeriesDaily: [String: IntradayData]?

    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeries1Min = "Time Series (1min)"
        case timeSeries5Min = "Time Series (5min)"
        case timeSeries15Min = "Time Series (15min)"
        case timeSeries30Min = "Time Series (30min)"
        case timeSeries60Min = "Time Series (60min)"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

// MARK: - MetaData
struct MetaData: Codable {
    var information, symbol, lastRefreshed, interval, outputSize, timeZone: String?

    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case interval = "4. Interval"
        case outputSize = "5. Output Size"
        case timeZone = "6. Time Zone"
    }
}

// MARK: - TimeSeries5Min
struct IntradayData: Codable {
    var open, high, low, volume, close: String?
    var date, symbol: String?

    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
//        case date
    }
}
