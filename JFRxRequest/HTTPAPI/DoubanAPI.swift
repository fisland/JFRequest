//
//  DoubanAPI.swift
//  JFRxRequest
//
//  Created by fisker.zhang on 2019/3/25.
//  Copyright © 2019 fisker. All rights reserved.
// 引用 航哥  http://www.hangge.com/blog/cache/detail_2012.html

import Foundation
import Moya

//请求分类
public enum DouBanAPI {
    case channels  //获取频道列表
    case playlist(String) //获取歌曲
}

//请求配置
extension DouBanAPI: TargetType {
    //服务器地址
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL(string: "https://www.douban.com")!
        case .playlist(_):
            return URL(string: "https://douban.fm")!
        }
    }
    
    //各个请求的具体路径
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playlist(_):
            return "/j/mine/playlist"
        }
    }
    
    //请求类型
    public var method: Moya.Method {
        return .get
    }
    
    //请求任务事件（这里附带上参数）
    public var task: Task {
        switch self {
        case .playlist(let channel):
            var params: [String: Any] = [:]
            params["channel"] = channel
            params["type"] = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params,
                                      encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    //这个就是做单元测试模拟的数据，只会在单元测试文件中有作用
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    //请求头
    public var headers: [String: String]? {
        return ["Content-type" : "application/json"]
    }
}
