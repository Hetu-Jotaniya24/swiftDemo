//
//  UserDefaults+Extension.swift
//  StartupProject
//
//  Created by Hiral Jotaniya on 10/11/21.
//


import Foundation
extension UserDefaults{
    func set<T: Codable>(object: T, forKey: String) throws {
        
        let jsonData = try JSONEncoder().encode(object)
        
        set(jsonData, forKey: forKey)
    }
    
    
    func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(objectType, from: result)
    }
    
  
    func setUserData() {
//        try? UserDefaults.standard.set(object: Singleton.shared.userProfileData, forKey: UserDefaultsKey.userProfile.rawValue)
    }
//    func getUserData() -> RegisterData? {
//        let objResponse = try? UserDefaults.standard.get(objectType: RegisterData.self, forKey:  UserDefaultsKey.userProfile.rawValue)
//        return objResponse ?? nil
//    }

}
