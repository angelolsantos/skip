//
//  DateFormatterExtension.swift
//  SkipMobile
//
//  Created by Angelo Lara dos Santos on 17/03/2018.
//  Copyright © 2018 angelo. All rights reserved.
//

import Foundation

extension DateFormatter {
    func date(fromSwapiString dateString: String) -> Date? {
        // SWAPI dates look like: "2014-12-10T16:44:31.486000Z"
        self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
        self.timeZone = TimeZone(abbreviation: "UTC")
        self.locale = Locale(identifier: "en_US_POSIX")
        return self.dateFromString(dateString)
    }
}
