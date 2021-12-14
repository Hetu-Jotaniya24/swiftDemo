//
//  SessionEnums.swift
//  UrlSessionDemo
//
//  Created by Hiral Jotaniya on 06/10/21.
//

import Foundation

enum GetRequestType: String{
    case GET
    case POST
    case PUT
}

enum RequestString : String{
    case boundry = "Boundary-"
    case multiplePartFormData = "multipart/form-data; boundary="
    case contentType = "Content-Type"
}

enum MediaType: String{
    case Image = "image"
    case Video = "video"
    case Audio = "audio"
    case File = "application"
}
