//
//  HttpMoyaManager.swift
//  wk
//
//  Created by leaf on 2017/12/26.
//  Copyright © 2017年 leaf. All rights reserved.
//

import UIKit
import Moya
enum HttpService {
    case regist(name: String,pwd: String,mobile: String, randNum: String,mobileCode: String)
    case home
    case isPhone(phone: String)
}
extension HttpService: TargetType {
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var baseURL: URL {
        return URL(string: "http://www.zhuligo.com/legendshop_mobile/")!
    }
    
    var path: String {
        switch self {
        case .home:
            return "mIndex"
        case .isPhone(_):
            return "isPhoneExist"
        case .regist(_, _,_, _,_):
            return "userReg"
        }
    }
    
    var method: Moya.Method {
        switch self {
        default:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .home:
            return .requestPlain
        case let .isPhone(phone):
            return .requestParameters(parameters: ["phone": phone], encoding: URLEncoding.queryString)
        case let .regist(name, pwd, mobile, randNum, mobileCode):
            return .requestParameters(parameters: ["nickname": name,
                                                   "mobile": mobile,
                                                   "password": pwd,
                                                   "randNum": randNum,
                                                   "mobileCode": mobileCode],
                                      encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }

}
class HttpMoyaManager: NSObject {
    let provider = MoyaProvider<HttpService>()
    
    override init() {
        super.init()
        provider.request(.home) { result in
            switch result {
            case let .success(moyaResponse):
                do {
                    let json =  try JSONSerialization.jsonObject(with: moyaResponse.data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    
                    print("xxxx")
                } catch {
                    print("xxxx")
                    
                }
            case let .failure(error):
                print("error")
            }
            
        }
        
    }
    
}
