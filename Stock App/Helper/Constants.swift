//
//  Constant.swift
//  Stock App
//
//  Created by Massive Infinity on 22/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import Foundation

struct Constants {
    struct Storyboard {
        static let main = "Main"
    }
    
    struct API {
        static var APIKEY = "O068DC2W9G7AYUG7"
        static let BaseURL = "https://www.alphavantage.co/query?function="
        static let IntradayURL = "TIME_SERIES_INTRADAY&symbol="
        static let DailyAdjusted = "TIME_SERIES_DAILY_ADJUSTED&symbol="
        static let SearchURL = "SYMBOL_SEARCH&keywords="
        
    }
    
    struct StringValue {
        static let APIKey = "APIKey"
    }
    
    struct SortedBy {
        static let date = "Date"
        static let open = "Open"
        static let high = "High"
        static let low = "Low"
    }
    
    struct Interval {
        static let min1 = "1 Minute"
        static let min5 = "5 Minutes"
        static let min15 = "15 Minutes"
        static let min30 = "30 Minutes"
        static let min60 = "60 Minutes"
    }
    
    struct Outputsize {
        static let compact = "Compact"
        static let full = "Full"
    }
    
    struct UIPickerText {
        static let sortedBy = [SortedBy.date, SortedBy.open, SortedBy.high, SortedBy.low]
        static let interval = [Interval.min1, Interval.min5, Interval.min15, Interval.min30, Interval.min60]
        static let outputsize = [Outputsize.compact, Outputsize.full]
        static let apiKey = [""]
    }
}

