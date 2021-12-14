//
//  Singleton.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 16/11/21.
//
import Foundation
import CoreLocation

class Singleton: NSObject
{
    
    static let shared = Singleton()
    
    var UserId : String = ""
    var Api_Key = String()
    
    
    var arrFutureYears:[String] {
        get {
            let calendar = Calendar.current
            let currentYear = calendar.component(.year, from: Date())
            return (currentYear...(currentYear + 11)).map { String($0)}
        }
    }
    
    func clearSingletonClass() {
        Singleton.shared.UserId = ""
        Singleton.shared.Api_Key = ""
    }
}

