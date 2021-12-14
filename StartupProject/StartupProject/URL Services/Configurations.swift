//
//  Configurations.swift
//  MorningFeeds
//
//  Created by Hiral Jotaniya on 30/11/21.
//


import Foundation

enum Environment {
    case dev
    case stage
    case release

    var baseURL: String {
        switch self {
        case .dev: return "https://newsapi.org/v2/"
        case .stage: return "https://www.stage.com/api/v1"
        case .release: return "https://www.release.com/api/v1"
        }
    }
    
    var googleToken: String {
        switch self {
        case .dev: return "dev-token"
        case .stage: return "stage-token"
        case .release: return "release-token"
        }
    }
    
    var newsAPIKey: String {
        switch self {
        case .dev, .stage, .release: return "4f748987c39f457ea0b6e357f7420f99"
        }
    }
}

struct Configuration {
    static var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Dev") != nil {
                return Environment.dev
            } else if configuration.range(of: "Stage") != nil {
                return Environment.stage
            }
        }
        return Environment.release
    }()
}
