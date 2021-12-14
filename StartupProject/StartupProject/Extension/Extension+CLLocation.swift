//
//  Extension+CLLocation.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 02/12/21.
//

import Foundation
import CoreLocation
//import GoogleMaps

//extension CLLocation {
//    func fetchCityAndCountry(completion: @escaping (_ address:  String?, _ error: Error?) -> ()) {
//
//        GMSGeocoder().reverseGeocodeCoordinate(coordinate) { (response, error) in
//            if let address = response?.results() {
//
//                guard error == nil else {
//                    completion("",error)
//                    return
//                }
//                if let addressNew = address.first?.lines {
//
//                    completion(self.makeAddressString(inArr: addressNew), nil)
//                }
//            }
//        }
//    }
//
//    func makeAddressString(inArr:[String]) -> String {
//
//        var fVal:String = ""
//        for val in inArr {
//
//            fVal =  fVal + val + " "
//
//        }
//        return fVal
//
//    }
//}
