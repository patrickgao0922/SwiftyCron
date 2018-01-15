//
//  CronParser.swift
//  graphql-client-demo
//
//  Created by Patrick Gao on 12/1/18.
//  Copyright © 2018 Patrick Gao. All rights reserved.
//

import Foundation

public class SwiftyCron {
    
    /// # Decomposing cron expression error
    /// [node-cron](https://github.com/kelektiv/node-cron)
    ///
    /// - invalidCronExpression: Cron expression's format is invalid for backend service
    /// - invalidMinute: minitue should be in the range of 1 - 59 or *
    /// - invalidHour: hour should be in the range of 1 - 23 or *
    /// - invalidDay: day should be in the range of 1 - 31 or *
    /// - invalidMonth: month should be in the range of 1 - 12 or *
    /// - invalidWeekday: weekday should be in the range of 1 - 7 or *
    /// - invalidYear: minitue should be in the range of 1900 - 3000 or *
    public enum DecomposingError:Error {
        case invalidCronExpression
        case invalidMinute
        case invalidHour
        case invalidDay
        case invalidMonth
        case invalidWeekday
        case invalidYear
    }
    
    fileprivate enum CronCompnent:Int {
        case minute = 0
        case hour
        case day
        case month
        case weekday
        case year
    }
    
    public enum Weekday:Int {
        public var fullString:String {
            switch self {
            case .monday: return "Monday"
            case .tuesday:return "Tuesday"
            case .wednesday: return "Wednesday"
            case .thursday: return "Thursday"
            case .friday: return "Friday"
            case .saturday: return "Saturday"
            case .sunday: return "Sunday"
            }
        }
        
        public var inittialString:Substring {
            return self.fullString.prefix(3)
        }
        
        case monday = 1
        case tuesday
        case wednesday
        case thursday
        case friday
        case saturday
        case sunday
    }
    
    public enum Month:Int {
        
        public var fullString:String {
            switch self {
            case .january: return "January"
            case .feburary:return "Feburary"
            case .march: return "March"
            case .april: return "April"
            case .may: return "May"
            case .june: return "June"
            case .july: return "July"
            case .august: return "August"
            case .september:return "September"
            case .october: return "October"
            case .november: return "November"
            case .december: return "December"
            }
        }
        
        public var inittialString:Substring {
            return self.fullString.prefix(3)
        }
        
        case january = 1
        case feburary
        case march
        case april
        case may
        case june
        case july
        case august
        case september
        case october
        case november
        case december
    }
    
    public var cronString:String?
    public var minute:Int?
    public var hour:Int?
    public var day:Int?
    public var month:Month?
    public var weekday:Weekday?
    public var year:Int?
    
    
    /// CronParser initializer with cronString
    ///
    /// - Parameter cronString: Cron expression String
    public init?(cronString:String) {
        do {
            try decompose(cronString: cronString)
        } catch {
            return nil
        }
    }
    
    public init?(minute:Int? = nil, hour:Int? = nil, day:Int? = nil, month:Month? = nil, weekday:Weekday? = nil, year:Int? = nil) {
        do {
            try validate(minute: minute, hour: hour, day: day, month: month, weekday: weekday, year: year)
            self.minute = minute
            self.hour = hour
            self.day = day
            self.month = month
            self.weekday = weekday
            self.year = year
        } catch {
            return nil
        }
        
    }
    
    /// Decompose cronString to each cron components and assign them into each properties
    ///
    /// - Parameter cronString: Cron expression string
    /// - Throws: An error of type `DecomposingError`
    fileprivate func decompose(cronString:String) throws {
        let cronExpressionArray = cronString.components(separatedBy: " ")
        try? validate(cronExpressionArray: cronExpressionArray)
        self.minute = Int(cronExpressionArray[CronCompnent.minute.rawValue])
        self.hour = Int(cronExpressionArray[CronCompnent.hour.rawValue])
        self.day = Int(cronExpressionArray[CronCompnent.day.rawValue])
        self.month = Int(cronExpressionArray[CronCompnent.month.rawValue]) == nil ? nil : Month(rawValue: Int(cronExpressionArray[CronCompnent.month.rawValue])!)
        self.weekday =  Int(cronExpressionArray[CronCompnent.weekday.rawValue]) == nil ? nil : Weekday(rawValue: Int(cronExpressionArray[CronCompnent.weekday.rawValue])!)
        
        self.year = cronExpressionArray.count == CronCompnent.year.rawValue + 1 ? Int(cronExpressionArray[CronCompnent.year.rawValue]) :  nil
        
    }
    
    /// validate pased cron expression array
    ///
    /// - Parameter cronExpressionArray: cron expression string array[minute, hour, day, month, weekday, year]
    /// - Throws: An error of type `DecomposingError`
    fileprivate func validate(cronExpressionArray:[String]) throws {
        guard cronExpressionArray.count < 5 || cronExpressionArray.count > 6 else {
            throw DecomposingError.invalidCronExpression
        }
        
        let minute = Int(cronExpressionArray[CronCompnent.minute.rawValue])
        let hour = Int(cronExpressionArray[CronCompnent.hour.rawValue])
        let day = Int(cronExpressionArray[CronCompnent.day.rawValue])
        let month = Int(cronExpressionArray[CronCompnent.month.rawValue])
        let weekday = Int(cronExpressionArray[CronCompnent.weekday.rawValue])
        let year = Int(cronExpressionArray[CronCompnent.year.rawValue])
        
        //        Validate minute
        if minute != nil {
            guard (minute! >= 0 && minute! <= 59) else {
                throw DecomposingError.invalidMinute
            }
        } else if cronExpressionArray[CronCompnent.minute.rawValue] != "*" {
            throw DecomposingError.invalidMinute
        }
        
        //        Validate hour
        if hour != nil {
            guard (hour! >= 0 && hour! <= 23)else {
                throw DecomposingError.invalidHour
            }
        }else if cronExpressionArray[CronCompnent.hour.rawValue] != "*" {
            throw DecomposingError.invalidHour
        }
        
        //        Validate day
        if day != nil {
            guard (day! >= 1 && day! <= 31) else {
                throw DecomposingError.invalidDay
            }
        }else if cronExpressionArray[CronCompnent.day.rawValue] != "*" {
            throw DecomposingError.invalidDay
        }
        
        //        Validate month
        if month != nil {
            guard (month! >= 1 && day! <= 12) else {
                throw DecomposingError.invalidMonth
            }
        } else if cronExpressionArray[CronCompnent.month.rawValue] != "*" {
            throw DecomposingError.invalidMonth
        }
        
        //        Validate weekday
        if weekday != nil {
            guard (weekday! >= 1 && weekday! <= 7) else {
                throw DecomposingError.invalidWeekday
            }
        } else if cronExpressionArray[CronCompnent.weekday.rawValue] != "*" {
            throw DecomposingError.invalidWeekday
        }
        
        if cronExpressionArray.count == 6 {
            if year != nil {
                guard (year! >= 1900 && year! <= 3000) else {
                    throw DecomposingError.invalidYear
                }
            } else if cronExpressionArray[CronCompnent.year.rawValue] != "*" {
                throw DecomposingError.invalidYear
            }
        }
    }
    
    fileprivate func validate(minute:Int? = nil, hour:Int? = nil, day:Int? = nil, month:Month? = nil, weekday:Weekday? = nil, year:Int? = nil) throws {
        //        Validate minute
        if minute != nil {
            guard (minute! >= 0 && minute! <= 59) else {
                throw DecomposingError.invalidMinute
            }
        }
        
        //        Validate hour
        if hour != nil {
            guard (hour! >= 0 && hour! <= 23)else {
                throw DecomposingError.invalidHour
            }
        }
        
        //        Validate day
        if day != nil {
            guard (day! >= 1 && day! <= 31) else {
                throw DecomposingError.invalidDay
            }
        }
        
        //        Validate month
//        if month != nil {
//            guard (month! >= 1 && month! <= 12) else {
//                throw DecomposingError.invalidMonth
//            }
//        }
//        
//        //        Validate weekday
//        if weekday != nil {
//            guard (weekday! >= 1 && weekday! <= 7) else {
//                throw DecomposingError.invalidWeekday
//            }
//        }
        
        //        Validate year
        if year != nil {
            guard (year! >= 1900 && year! <= 3000) else {
                throw DecomposingError.invalidYear
            }
        }
    }
}

