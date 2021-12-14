//
//  Enums.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 11/11/21.
//
import Foundation


enum UserDefaultsKey : String {
    case userProfile = "userProfile"
    case isUserLogin = "isUserLogin"
    case X_API_KEY = "X_API_KEY"
    case DeviceToken = "DeviceToken"
}

enum NoRecordsStrings : String{
    case Underdevelopment = "Hold on..! Great things takes time...UNDER DEVELOPMENT!!"
    case notification = "You have no notifications."
    case WalletHistory = "No transaction history."
    case Cards = "You have not added any cards yet."
}

enum DateFormatterString : String{
    case timeWithDate = "yyyy-MM-dd HH:mm:ss"
    case onlyDate = "yyyy-MM-dd"
}

enum HapticTypes {
    case error , success, warning
}


enum viewComponentsTags : Int{
    case ActivityIndicator = 1001
    case ToastView = 2002
    
}

enum webserviceResponse {
    case gotData , initial
}
