//
//  Date.swift
//  lyie
//
//  Created by Sevcan Eşim on 18.11.2020.
//  Copyright © 2020 Sevcan Esim. All rights reserved.

import Foundation

extension Date {
    
    func isSameMonth(as date: Date) -> Bool {
        let calendar = Calendar.current
        return
            calendar.component(.year, from: self) == calendar.component(.year, from: date) &&
            calendar.component(.month, from: self) == calendar.component(.month, from: date)
    }
    
    func isSameDay(as date: Date) -> Bool {
        let calendar = Calendar.current
        return
            calendar.component(.year, from: self) == calendar.component(.year, from: date) &&
            calendar.component(.month, from: self) == calendar.component(.month, from: date) && calendar.component(.day, from: self) == calendar.component(.day, from: date)
    }
    
    /*var startOfMonth: Date {
     var components = Calendar.current.dateComponents(in: TimeZone(secondsFromGMT: 0)!, from: self)
     components.day = 1
     components.hour = 0
     components.minute = 0
     components.second = 0
     components.nanosecond = 0
     return Calendar.current.date(from: components)!
     }*/
    
    func component(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    func components(_ components: Set<Calendar.Component>) -> DateComponents {
        return Calendar.current.dateComponents(components, from: self)
    }
    
    func startOfMonth() -> Date {
        return Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: Calendar.current.startOfDay(for: self)))!
    }
    
    func endOfMonth() -> Date {
        return Calendar.current.date(byAdding: DateComponents(month: 1, day: -1), to: self.startOfMonth())!
    }
    
    func readableFormat() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .short
        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter.string(from: self)
    }
    
    /// Returns an integer from 1 - 7, with 1 being Sunday and 7 being Saturday
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
    ///Age Calculator
    func ageCalculator() -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: Date()).year!
    }
    static func from(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date {
        let gregorianCalendar = NSCalendar(calendarIdentifier: .gregorian)!
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        dateComponents.hour = hour
        dateComponents.minute = minute
        dateComponents.second = second
        let date = gregorianCalendar.date(from: dateComponents)!
        return date
    }
    
    static func from(_ string: String, format: String = "yyyyMMddHHmmss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone.default
        dateFormatter.dateFormat = format
        
        let date = dateFormatter.date(from: string)!
        return date
    }}

