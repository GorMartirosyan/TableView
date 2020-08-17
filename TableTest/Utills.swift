//
//  Utills.swift
//  TableTest
//
//  Created by Gor on 3/22/20.
//  Copyright © 2020 user1. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var note: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
}
