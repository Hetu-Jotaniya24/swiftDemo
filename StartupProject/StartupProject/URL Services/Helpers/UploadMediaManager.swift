//
//  UploadMediaManager.swift
//  UrlSessionDemo
//
//  Created by Hiral Jotaniya on 06/10/21.
//

import Foundation
import UIKit

//MARK: To manage the different types of requests in URLSession

class UploadMediaModel: Codable {
    let key: String
    let fileName: String
    let data: Data
    let mimeType: String

    init?(mediaType: MediaType, forKey key: String, withImage image: UIImage? = nil, fileUrl url: URL? = nil) {
        self.key = key
        let ext = mediaType.rawValue == MediaType.Audio.rawValue ? "m4a" : (url?.pathExtension ?? "")
        self.mimeType = mediaType.rawValue == MediaType.Image.rawValue ? "image/jpg" : "\(mediaType.rawValue)/\(ext)"
        self.fileName = mediaType.rawValue == MediaType.Image.rawValue ? "image.jpeg" : "\(key).\(ext.lowercased())"
        
        var mediaData : Data?
        if mediaType.rawValue == MediaType.Image.rawValue{
           if let img = image{
                guard let data = img.jpegData(compressionQuality: 0.5) else { return nil }
                mediaData = data
           }
        }else{
            if let mediaUrl = url{
                guard let data = try? Data(contentsOf: mediaUrl)else { return nil }
                mediaData = data
            }
        }
        
        guard let dt = mediaData else { return nil}
        self.data = dt
    }
}


class RequestBodyClass{
    
    class func createDataBodyForMediaRequest(withParameters params: [String: Any]?, media: [UploadMediaModel]?, boundary: String) -> Data {

        let lineBreak = "\r\n"
        var body = Data()

        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                let valueStr = value as? String ?? ""
                body.append("\(valueStr + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")

        return body
    }
}


