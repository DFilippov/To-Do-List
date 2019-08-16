//
//  Date+Extension.swift
//  To Do List
//
//  Created by Ayu Filippova on 12/08/2019.
//  Copyright © 2019 Dmitry Filippov. All rights reserved.
//

import Foundation

extension Date {
    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter.string(from: self)
    }
    
}
