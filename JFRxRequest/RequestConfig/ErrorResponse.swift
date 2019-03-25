//
//  ErrorResponse.swift
//  MChainWallet
//
//  Created by fisker.zhang on 2019/2/26.
//  Copyright © 2019 Miku. All rights reserved.
//

import UIKit
import Foundation

struct ErrorResponse : Codable {

    //逻辑错误
    var code : String?
    var msg : String?
}
