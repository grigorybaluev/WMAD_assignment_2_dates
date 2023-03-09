//
//  Date.swift
//  Assignment2
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

//enum Month: String {
//    case "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
//}

struct Date {
    
    let months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    
    var month: String
    var day: Int
    var year: Int
    var maxDay: Int
    
    init(month: Int = 1 , day: Int = 1, year: Int = 2000) {
        if 1 <= month && month <= 12 {
            self.month = months[month-1]
            self.day = day
            self.year = year
            
            if ["January", "March", "May", "July", "August", "October", "December"].contains(self.month) {
                self.maxDay = 31
            } else if ["April", "June", "September", "November"].contains(self.month) {
                self.maxDay = 30
            } else if self.year % 4 == 0 {
                self.maxDay = 29
            } else {
                self.maxDay = 28
            }
        } else {
            self.month = months[0]
            self.day = 1
            self.year = 2000
            self.maxDay = 31
        }
    }
}

enum DateFormat {
    case standard, long, two
}

