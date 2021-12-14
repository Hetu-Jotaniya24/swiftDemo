//
//  URLSessionRequestManager.swift
//  MorningFeeds
//
//  Created by Hiral Jotaniya on 06/10/21.
//

import Foundation
import UIKit

class URLSessionRequestManager {
    
    static func BEARER_HEADER() -> [String:String]{
        return  APIEnvironment.headers
    }
    //MARK: Get
    class func makeGetRequest<C:Codable>(endPoint: String, responseModel: C.Type, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        let strURL = APIEnvironment.baseURL + endPoint
       
        guard let url = URL(string: strURL)  else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.GET.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        print("the url is \(url) and the headers are \(BEARER_HEADER())")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            DispatchQueue.main.async {
                completion(status,obj,dic)
            }
        }
    }
    
    class func makeParamsGetRequest<C:Codable, P:Encodable>(endPoint: String, requestModel: P, responseModel: C.Type, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }

        let strURL = APIEnvironment.baseURL + endPoint
        var components = URLComponents(string: strURL)
        
        if let queryReqParams = try? requestModel.asDictionary() {
            components?.queryItems = [URLQueryItem]()
            for (key, value) in queryReqParams {
                let queryItem = URLQueryItem(name: key, value: "\(value)")
                components?.queryItems?.append(queryItem)
            }
        }
        
        guard let url = components?.url  else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.GET.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            DispatchQueue.main.async {
                completion(status,obj,dic)
            }
        }
    }
    
    //MARK: Post
   /*Description : Request model : to pass as parameter
                    Response model to get the blueprint of the data so that we can return the object with same type when we get the response
    */
    class func makePostRequest<C:Codable, P:Encodable>(endPoint: String, requestModel: P, responseModel: C.Type, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        let strURL = APIEnvironment.baseURL + endPoint
       
        guard let url = URL(string: strURL)  else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
            
            print("the url is \(url) and the parameters are \n \(bodyDic) and the headers are \(BEARER_HEADER())")
        }
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    //MARK: Put
    class func makePutRequest<C:Codable, P:Encodable>(endPoint: String, requestModel: P, responseModel: C.Type, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()) {
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        let strURL = APIEnvironment.baseURL + endPoint
       
        guard let url = URL(string: strURL)  else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.PUT.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
            
            print("the url is \(url) and the parameters are \n \(bodyDic) and the headers are \(BEARER_HEADER())")
        }
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    //MARK: Multipart
    class func makeImageUploadRequest<C:Codable, P:Codable>(endPoint: String, requestModel: P, responseModel: C.Type, image: UIImage, imageKey: String, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + endPoint) else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        guard let mediaImage = UploadMediaModel(mediaType: .Image, forKey: imageKey, withImage: image) else {
            completion(false, nil, SessionErrors.mediaTypeError.dictionary)
            return
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
        
    }
    
    //MARK: Multiple Image upload
    class func makeMultipleImageRequest<C:Codable, P:Encodable>(urlString: String, requestModel: P, responseModel: C.Type, imageKey: String ,arrImageData : [UIImage]?, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        var mediaArr = [UploadMediaModel]()
        if let dataDic = arrImageData{
            for each in dataDic{
                guard let mediaImage = UploadMediaModel(mediaType: .Image, forKey: imageKey, withImage: each) else {
                    completion(false, nil, SessionErrors.mediaTypeError.dictionary)
                    return
                }
                mediaArr.append(mediaImage)
            }
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: mediaArr, boundary: boundary)
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    //MARK: Media upload
    class func makeMediaUploadRequest<C:Codable, P:Codable>(urlString: String, requestModel: P, responseModel: C.Type, mediaType: MediaType,file_url: String, fileKey: String, completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        guard let mediaUrl = URL(string: file_url) else {
            completion(false, nil, SessionErrors.mediaTypeError.dictionary)
            return
        }
        
        guard let mediaImage = UploadMediaModel(mediaType: mediaType, forKey: fileKey, fileUrl: mediaUrl) else {
            completion(false, nil, SessionErrors.mediaTypeError.dictionary)
            return
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: [mediaImage], boundary: boundary)
        print("BODY DIC: \(paramaterDic)")
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        print("REQUEST: \(request)")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
    
    class func makeMultipleMediaUploadRequest<C:Codable, P:Codable>(urlString: String, requestModel: P, responseModel: C.Type, mediaArr: [UploadMediaModel], completion: @escaping (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var paramaterDic = [String: Any]()
        
        if !Reachability.isConnectedToNetwork() {
            completion(false, nil, SessionErrors.noInternetConnection.dictionary)
            return
        }
        
        guard let url = URL(string: APIEnvironment.baseURL + urlString) else {
            completion(false, nil, SessionErrors.urlIsMissing.dictionary)
            return
        }
        
        let boundary = RequestString.boundry.rawValue + "\(NSUUID().uuidString)"
        
        var request = URLRequest(url: url)
        request.httpMethod = GetRequestType.POST.rawValue
        request.allHTTPHeaderFields = BEARER_HEADER()
        
        if let bodyDic = try? requestModel.asDictionary(){
            paramaterDic = bodyDic
            let dicData = bodyDic.percentEncoded()
            request.httpBody = dicData
        }
        
        request.setValue(RequestString.multiplePartFormData.rawValue + boundary, forHTTPHeaderField: RequestString.contentType.rawValue)
        
        let dataBody = RequestBodyClass.createDataBodyForMediaRequest(withParameters: paramaterDic, media: mediaArr, boundary: boundary)
        
        print("BODY DIC: \(paramaterDic)")
        request.httpBody = dataBody
            
        print("the url is \(url) and the parameters are \n \(paramaterDic) and the headers are \(BEARER_HEADER())")
        
        print("REQUEST: \(request)")
        
        CodableService.getResponseFromSession(request: request, codableObj: responseModel) { (status, obj, dic) in
            completion(status,obj,dic)
        }
    }
}
