//
//  CountryCodeModel.swift
//  JFRxRequest
//
//  Created by fisker.zhang on 2019/3/25.
//  Copyright © 2019 fisker. All rights reserved.
//

import Foundation

struct Languages: Codable {
    
    var popular: [Language]?
    var all: [Language]?
}

struct Language: Codable {
    
    var urlParam: String?
    var name: String?
    
}

struct Channel : Codable {
    
    let abbrEn : String?
    let channelId : Int?
    let name : String?
    let nameEn : String?
    let seqId : Int?
}
