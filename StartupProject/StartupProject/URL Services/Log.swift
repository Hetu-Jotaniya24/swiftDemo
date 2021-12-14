//
//  Log.swift
//  SwiftUITemplate
//
//  Created by Hiral Jotaniya on 30/11/21.
//

import Foundation
import UIKit
import OSLog

enum LogEvent: String {
    case test
}

//https://www.avanderlee.com/workflow/oslog-unified-logging/
//https://developer.apple.com/videos/play/wwdc2020/10168/

@available(iOS 14.0, *)
extension Logger {
    
    private static var subsystem = Bundle.main.bundleIdentifier ?? ""

    static func logEvent(_ category: LogEvent, message: String, isPrivate: Bool = false) {
        let log = Logger(subsystem: Logger.subsystem, category: category.rawValue)
        if isPrivate {
            log.info("\(message, privacy: .private)")
        } else {
            log.info("\(message, privacy: .public)")
        }
    }
}
