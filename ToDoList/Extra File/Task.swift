//
//  Task.swift
//  ToDoList
//
//  Created by Yiğit Yavuz Tok on 16.07.2025.
//

import Foundation
import UIKit

struct Task : Codable , Equatable{
    var id : UUID = UUID()
    
    var title : String
    
    var description : String?
    
    var date : Date?
    
    var isCompleted : Bool
    
    var repeatOption : TaskRepeatOption
    
    var notificationTime : Date?
    
    enum CodingKeys : String, CodingKey {
        case title, description, date, isCompleted, repeatOption, notificationTime
    }
    
    enum TaskRepeatOption : String, Codable , CaseIterable {
        case none = "Tekrar yok"
        case daily = "Günlük"
        case weekly = "Haftalık"
        case yearly = "Yıllık"
    }
}


