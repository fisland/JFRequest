//
//  LWHTTPService.swift
//  MK-LWallet
//
//  Created by fisker.zhang on 2019/3/9.
//  Copyright © 2019 mtop.one. All rights reserved.
//

import UIKit
import Moya
import SwiftyJSON
import RxSwift
import RxCocoa
import CleanJSON

//MARK: 错误处理
enum HTTPServiceError : Error{
    case logic(err:ErrorResponse) //逻辑错误 例如已经注册，返回带code码
}

//网路错误异常处理
/* 例子
 return self.provider.rx.request(api)
 .asObservable()
 .take(1)
 .filterSuccess()
 .map(type, using: decoder)
 .observeOn(MainScheduler.instance)
 .asSingle()
 */
extension ObservableType where E == Response {
    
    public func filterSuccess() -> Observable<E> {
        return flatMap { (response) -> Observable<E> in
            
            let json = try JSON(response.mapJSON())
            //这里的情况是，只有code为0的时候，数据data才有东西
            if json.dictionaryValue["code"]?.intValue == 0{
                //code为0，表示成功
                return Observable.just(response)
            }
            //抛出错误
            if let errormodel = try? JSONDecoder().decode(ErrorResponse.self, from: json.rawData()){
                return Observable.error(HTTPServiceError.logic(err: errormodel))
            }
            return  Observable.error(MoyaError.jsonMapping(response))

        }
    }
}

//MARK: 主要内容
struct JFHTTPService {
    /// 单例
    static let provider = MoyaProvider<MultiTarget>()
}

extension JFHTTPService{

    
    /// 默认rx请求
    ///
    /// - Parameters:
    ///   - api: api
    ///   - type: 解析类型
    /// - Returns: 返回数据或错误
    public static func rxRequest<T:Codable>(_ api :MultiTarget, type:T.Type) -> Single<T>{

        let decoder = CleanJSONDecoder()
        return self.provider.rx.request(api)
            .asObservable()
            .take(1)
            .map(type, using: decoder)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }

    
    /// rx请求
    ///
    /// - Parameters:
    ///   - keypath: 更深路径 默认data
    ///   - api: api
    ///   - type: 传入的解析类型
    /// - Returns: 单信号（返回的数据，或错误信息）
    public static func rxRequestData<T:Codable>(_ api: MultiTarget,with keypath: String, type: T.Type) -> Single<T>{
        
        let decoder = CleanJSONDecoder()
        
        return self.provider.rx.request(api)
            .asObservable()
            .take(1)
            .map(type, atKeyPath: keypath, using: decoder)
            .observeOn(MainScheduler.instance)
            .asSingle()
    }
    
}
