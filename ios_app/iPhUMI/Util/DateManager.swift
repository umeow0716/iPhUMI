//
//  DateManager.swift
//  iPhUMI
//
//  Created by Austin Patel on 9/15/24.
//  Copyright © 2024 Apple. All rights reserved.
//

import Foundation

class DateManager {
    private static let isoFormatter: ISO8601DateFormatter = {
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter
    }()

    static func getISOFormatter() -> ISO8601DateFormatter {
        isoFormatter
    }
}
