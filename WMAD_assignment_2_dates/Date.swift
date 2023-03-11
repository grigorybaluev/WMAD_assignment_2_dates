//
//  Date.swift
//  Assignment2
//
//  Created by Derrick Park on 2023-03-03.
//

import Foundation

struct Date: CustomStringConvertible, Comparable {
    private let months: [(String, Int)] = [("Jan", 31), ("Feb", 28), ("Mar", 31), ("Apr", 30), ("May", 31), ("Jun", 30), ("Jul", 31), ("Aug", 31), ("Sep", 30), ("Oct", 31), ("Nov", 30), ("Dec", 31)]
    
    private (set) var monthInt: Int
    private (set) var month: String
    private (set) var day: Int
    private (set) var year: Int
    private (set) var maxDay: Int
    private (set) var format: DateFormat
    
    func validateDate(_ monthInt: Int, _ day: Int, _ year: Int) -> (String, Int, Int, Int, Int) {
        var valMonth: String
        var valMonthInt: Int
        var valDay: Int
        var valYear: Int
        var valMaxDay: Int
        
        if year > 0 {
            valYear = year
        } else {
            valMonthInt = 1
            valMonth = self.months[0].0
            valDay = 1
            valYear = 2000
            valMaxDay = 31
        }
        
        valMonthInt = monthInt
        valMonth = self.months[monthInt-1].0
        valMaxDay = self.months[monthInt-1].1

        if monthInt == 2 && valYear % 4 == 0 && valYear % 100 != 0 {
            valMaxDay = 29
        }
        
        if day > 0 && day <= valMaxDay {
            valDay = day
        } else {
            valMonthInt = 1
            valMonth = self.months[0].0
            valDay = 1
            valYear = 2000
            valMaxDay = 31
        }
        return (valMonth, valDay, valYear, valMonthInt, valMaxDay)
    }
    
    init(monthInt: Int = 1 , day: Int = 1, year: Int = 2000) {
        self.monthInt = 1
        self.month = months[0].0
        self.day = 1
        self.year = 2000
        self.maxDay = 31
        self.format = .standard
        
        let valiDate = validateDate(monthInt, day, year)
        
        self.monthInt = valiDate.3
        self.month = valiDate.0
        self.day = valiDate.1
        self.year = valiDate.2
        self.maxDay = valiDate.4
    }
    
    mutating func input() -> Void {
        print("Enter a date (month/day/year): ", terminator: "")
        var inputArray = readLine()!.split(separator: "/").map {Int($0)!}
        while inputArray.count != 3 {
            print("Invalid date. Try again: ", terminator: "")
            inputArray = readLine()!.split(separator: "/").map {Int($0)!}
            if inputArray == [] {
                return
            }
        }
        let valiDate = validateDate(inputArray[0], inputArray[1], inputArray[2])
        
        self.monthInt = valiDate.3
        self.month = valiDate.0
        self.day = valiDate.1
        self.year = valiDate.2
        self.maxDay = valiDate.4
    }
    
    var description: String {
        return "\(self.month) \(self.day) \(self.year)"
    }
    
    mutating func setFormat(_ format: DateFormat) {
        self.format = format
    }
    
    func show() {
        switch self.format {
        case .standard:
            print("\(self.monthInt)/\(self.day)/\(self.year)")
        case .long:
            print("\(self.month) \(self.day), \(self.year)")
        case .two:
            print("\(String(format: "%02d", self.monthInt))/\(String(format: "%02d", self.monthInt))/\(String(format: "%02d", self.year % 100))")
        }
    }
    
    mutating func increment(_ numDays: Int = 1) {
        var currentDay = self.day
        var currentMonthInt = self.monthInt
        var currentYear = self.year
        var currentMaxDay = self.maxDay
        
        for _ in 0..<numDays {
            if currentDay < currentMaxDay {
                currentDay += 1
                continue
            } else if currentDay == currentMaxDay {
                if currentMonthInt < 12 {
                    currentMonthInt += 1
                    currentMaxDay = self.months[currentMonthInt-1].1
                    currentDay = 1
                    continue
                } else if currentMonthInt == 12 {
                    currentYear += 1
                    currentMonthInt = 1
                    currentMaxDay = self.months[0].1
                    currentDay = 1
                    continue
                }
            }
        }
        
        self.month = self.months[currentMonthInt-1].0
        self.day = currentDay
        self.year = currentYear
        self.maxDay = currentMaxDay
        self.monthInt = currentMonthInt
    }
    
    static func == (lhs: Date, rhs: Date) -> Bool { lhs.year == rhs.year && lhs.monthInt == rhs.monthInt && lhs.day == rhs.day }
    static func < (lhs: Date, rhs: Date) -> Bool {
        if lhs.year == rhs.year {
            if lhs.monthInt == rhs.monthInt {
                return lhs.day < rhs.day
            } else {
                return lhs.monthInt < rhs.monthInt
            }
        } else {
            return lhs.year < rhs.year
        }
    }
}

enum DateFormat {
    case standard, long, two
}

