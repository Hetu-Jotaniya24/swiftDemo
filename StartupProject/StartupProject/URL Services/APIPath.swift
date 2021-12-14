//
//  APIPath.swift
//  MorningFeeds
//
//  Created by Hiral Jotaniya on 05/10/21.
//

import Foundation


struct APIEnvironment  {
 
    
    static var headers : [String:String] {
        return ["Content-Type":"application/json"]
    }
    
    static var baseURL: String {
        return Configuration.environment.baseURL
    }
}

enum apiEndPoints: String {
    case topHeadLines = "top-headlines/sources"
}

