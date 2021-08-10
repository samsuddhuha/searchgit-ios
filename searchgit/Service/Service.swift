//
//  Service.swift
//  searchgit
//
//  Created by Samsud Dhuha on 09/08/21.
//

import Foundation
import Moya
import SwiftyJSON

enum Common: Equatable {
    case search(key: String)
}

let commonClosure = { (target: Common) -> Endpoint in
    let defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
    switch target {
    case .search:
        return defaultEndpoint
    }
}

let commonService = MoyaProvider<Common>(endpointClosure: commonClosure)

extension Common: TargetType {
    var baseURL: URL {
        return URL(string: BASE_URL)!
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search/repositories"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        var data = [String:Any]()
        
        switch self {
        case .search(let key):
            data["q"] = key
            
            return .requestParameters(parameters: data, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
    
}
