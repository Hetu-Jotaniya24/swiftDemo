//
//  NetworkReachability.swift
//  MorningFeeds
//
//  Created by Hiral Jotaniya on 06/10/21.
//

import Foundation
import SystemConfiguration

enum ReachabilityStatus {
       case notReachable
       case reachableViaWWAN
       case reachableViaWiFi
   }

 class Reachability {
    class func isConnectedToNetwork() -> Bool {
//        var zeroAddress = sockaddr_in()
//        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
//        zeroAddress.sin_family = sa_family_t(AF_INET)
//
//        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
//            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
//                SCNetworkReachabilityCreateWithAddress(nil, $0)
//            }
//        }) else {
//            return false
//        }
//
//        var flags: SCNetworkReachabilityFlags = []
//        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
//            return false
//        }
//        if flags.isEmpty {
//            return false
//        }
//
//        let isReachable = flags.contains(.reachable)
//        let needsConnection = flags.contains(.connectionRequired)
//
//        return (isReachable && !needsConnection)
        
//        var currentReachabilityStatus: ReachabilityStatus {

                var zeroAddress = sockaddr_in()
                zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
                zeroAddress.sin_family = sa_family_t(AF_INET)

                guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
                    $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                        SCNetworkReachabilityCreateWithAddress(nil, $0)
                    }
                }) else {
                    return false//.notReachable
                }

                var flags: SCNetworkReachabilityFlags = []
                if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
                    return false//.notReachable
                }

                if flags.contains(.reachable) == false {
                    // The target host is not reachable.
                    return false//.notReachable
                }
                else if flags.contains(.isWWAN) == true {
                    // WWAN connections are OK if the calling application is using the CFNetwork APIs.
                    return true//.reachableViaWWAN
                }
                else if flags.contains(.connectionRequired) == false {
                    // If the target host is reachable and no connection is required then we'll assume that you're on Wi-Fi...
                    return true//.reachableViaWiFi
                }
                else if (flags.contains(.connectionOnDemand) == true || flags.contains(.connectionOnTraffic) == true) && flags.contains(.interventionRequired) == false {
                    // The connection is on-demand (or on-traffic) if the calling application is using the CFSocketStream or higher APIs and no [user] intervention is needed
                    return true//.reachableViaWiFi
                }
                else {
                    return false//.notReachable
                }
//            }

    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""//"\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .millisecondsSince1970
        let data = try encoder.encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}


