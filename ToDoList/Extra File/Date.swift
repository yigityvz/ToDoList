//
//  Date.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 17.07.2025.
//

import Foundation


extension Date {
    func isSameDay(as otherDate: Date) -> Bool {
        let calendar = Calendar.current
        return calendar.isDate(self, inSameDayAs: otherDate)
    }
}
