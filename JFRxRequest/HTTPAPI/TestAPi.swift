//
//  TestAPi.swift
//  JFRxRequest
//
//  Created by fisker.zhang on 2019/3/25.
//  Copyright © 2019 fisker. All rights reserved.
//

import Foundation
import Moya

enum TestAPI {
    case language
}

extension TestAPI: TargetType{
    var baseURL: URL {
        switch self {
        case .language:
            return URL.init(string: "https://github-trending-api.now.sh")!
        }
    }
    
    var path: String {
        switch self {
        case .language:
            return "/languages"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "{}".data(using: .utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return ["Content-type" : "application/json"]

    }
    
}
