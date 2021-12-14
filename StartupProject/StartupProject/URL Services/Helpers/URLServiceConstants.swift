//
//  URLServiceConstants.swift
//  MorningFeeds
//
//  Created by Hiral Jotaniya on 06/10/21.
//

import Foundation

class UrlConstant{
    
    //MARK:- Keywords & Errors that are frequently exist in response
    
    static let ResponseMessage = "message"
    static let Success = "Success"
    static let Failed = "Failed"
    static let Status = "status"
    
}

enum SessionErrors :String {
    case somethingWentWrong = "There is some server side error, Please try again after some time!"
    case sessionExpired =  "Your session is expired! Please login again."
    case noInternetConnection = "The Internet connection appears to be offline, Please connect to the internet."
    case wrongURL = "Cannot create URL (Wrong URL in the session)."
    case failedToConvertJson = "Cannot convert JSON object to Model."
    case serializationError = "Failure in JSONSerialization - URLSession!"
    case dataNotReceived = "Did not receive data from URLSession."
    case serverAuthorization = "Something wrong with server authorisation."
    case urlIsMissing = "Failed to create url - URLSession"
    case mediaTypeError = "Something wrong with the media type."
    case tooManyRequest =  "Too many request."
    
    var dictionary: [String:String] {
        switch self {
        case .somethingWentWrong:
            return [UrlConstant.ResponseMessage : SessionErrors.somethingWentWrong.rawValue]
        case .sessionExpired:
            return [UrlConstant.ResponseMessage :  SessionErrors.sessionExpired.rawValue]
        case .noInternetConnection:
            return [UrlConstant.ResponseMessage :  SessionErrors.noInternetConnection.rawValue]
        case .wrongURL:
            return [UrlConstant.ResponseMessage :  SessionErrors.wrongURL.rawValue]
        case .failedToConvertJson:
            return [UrlConstant.ResponseMessage :  SessionErrors.failedToConvertJson.rawValue]
        case .dataNotReceived :
            return [UrlConstant.ResponseMessage : SessionErrors.dataNotReceived.rawValue]
        case .serverAuthorization:
            return [UrlConstant.ResponseMessage : SessionErrors.serverAuthorization.rawValue]
        case .serializationError :
            return [UrlConstant.ResponseMessage : SessionErrors.serializationError.rawValue]
        case .urlIsMissing :
            return [UrlConstant.ResponseMessage : SessionErrors.urlIsMissing.rawValue]
        case .mediaTypeError :
            return [UrlConstant.ResponseMessage : SessionErrors.mediaTypeError.rawValue]
        case .tooManyRequest :
            return [UrlConstant.ResponseMessage : SessionErrors.tooManyRequest.rawValue]
        }
    }
}
