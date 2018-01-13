//
//  RxMoyaMapper.swift
//  wk
//
//  Created by leaf on 2017/12/28.
//  Copyright © 2017年 leaf. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import ObjectMapper

enum DCUError : Swift.Error  {
    case ParseJsonError
    case RequestFailed
    case NoResponse
    case UnexPectedResult(resultCode: Int?,resultMsg: String?)
}

enum RequestStatus: Int {
    case requestSuccess = 200
    case requestError
}

fileprivate let RESULT_CODE = "code"
fileprivate let RESULT_MSG = "message"
fileprivate let RESULT_DATA = "data"

public extension Observable {
    func mapResponseToObject<T: BaseMappable>(type: T.Type) -> Observable<T> {
        return map{ response in
            guard let response = response as? Moya.Response else {
                throw DCUError.NoResponse
            }
            guard ((200...209) ~= response.statusCode) else {
                throw DCUError.RequestFailed
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any] else {
                throw DCUError.NoResponse
            }
            
            if let code = json[RESULT_CODE] as? Int {
               if code == RequestStatus.requestSuccess.rawValue {
                    let data = json[RESULT_DATA]
                    if let data = data as? [String: Any] {
                        let object = Mapper<T>().map(JSON: data)!
                        return object
                    } else {
                        throw DCUError.ParseJsonError
                    }
               }else {
                throw DCUError.UnexPectedResult(resultCode: json[RESULT_CODE] as? Int, resultMsg: json[RESULT_MSG] as? String)
                }
            } else {
                throw DCUError.ParseJsonError
            }
        }
    }
    
    func mapResponseToObjectArray<T:BaseMappable>(type: T.Type) -> Observable<[T]> {
        return map { response in
            guard let response = response as? Moya.Response else {
                throw DCUError.NoResponse
            }
            guard ((200...209) ~= response.statusCode) else {
                throw DCUError.RequestFailed
            }
            
            guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String: Any] else {
                throw DCUError.NoResponse
            }
            
            if  let code = json[RESULT_CODE] as? Int {
                if code == RequestStatus.requestSuccess.rawValue {
                    var objects = [T]()
                    guard let objectsArrays = json[RESULT_DATA] as? [Any] else {
                        throw DCUError.ParseJsonError
                    }
                    
                    for object in objectsArrays {
                        if let data = object as? [String: Any] {
                            let object = Mapper<T>().map(JSON: data)
                            objects.append(object!)
                        }
                    }
                    return objects
                } else {
                    throw DCUError.UnexPectedResult(resultCode: json[RESULT_CODE] as? Int , resultMsg: json[RESULT_MSG] as? String)
                }
            } else {
                throw DCUError.ParseJsonError
            }
        }
    }
}
