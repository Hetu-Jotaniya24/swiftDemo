//
//  CodableResponseService.swift
//  MorningFeeds
//
//  Created by Hiral Jotaniya on 06/10/21.
//

import Foundation

class CodableService {
    
    //MARK: URLSession
    class func getResponseFromSession<C:Codable>(request: URLRequest, codableObj: C.Type, completion: @escaping  (_ status: Bool,_ modelObj: C?,_ dataDic: Any) -> ()){
        var responseDic : Any?
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let ERR = error{
                        completion(false, nil, ERR.localizedDescription)
                }else{
                    if let httpResponse = response as? HTTPURLResponse{
                        print("Status code of the request:=>",httpResponse.statusCode)
                        var statusCode : Bool = false
                        if (200 ..< 299) ~= httpResponse.statusCode{
                            if  let responseData = data {
                                responseDic = getResponseDicFromData(responseData:  responseData)
                                if let mainDic = responseDic as? [String: Any], let APIStatus = mainDic[UrlConstant.Status] as? Bool {
                                    statusCode = APIStatus
                                }
                                if let obj = getCodableObjectFromData(jsonData: responseData, codableObj: codableObj){
                                    completion(statusCode, obj, responseDic ?? "")
                                }else{
                                    completion(statusCode, nil, responseDic  ?? SessionErrors.failedToConvertJson.dictionary)
                                }
                            }else{
                                completion(statusCode, nil, SessionErrors.dataNotReceived.dictionary)
                            }
                        }else if httpResponse.statusCode == 403{
                            //Do Force Logout
                            completion(statusCode, nil, SessionErrors.serverAuthorization.dictionary)
                            
                        } else if httpResponse.statusCode == 429{
                                
                            completion(statusCode, nil, SessionErrors.tooManyRequest.dictionary)
                        }else{
                            completion(statusCode, nil, SessionErrors.somethingWentWrong.dictionary)
                        }
                    }
                }
            }
        }.resume()
    }
    
    //MARK: To convert response to model
    class func getCodableObjectFromData<C:Codable>(jsonData: Data, codableObj: C.Type) -> C?{
         let obj = try? JSONDecoder().decode(codableObj, from: jsonData)
        return obj
    }
    
    //MARK: Just for printing Response
    class func getResponseDicFromData(responseData: Data) -> Any{
        let json = try? JSONSerialization.jsonObject(with: responseData)
           
           if let jsonObj = json{
               print(" Response is ->  \n \(String(describing: json))")
               return jsonObj
           }else{
               return SessionErrors.serializationError.dictionary
           }
    }
}
