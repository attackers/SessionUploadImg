//
//  SguaiK1HttpService.swift
//  wk
//
//  Created by leaf on 2018/1/4.
//  Copyright © 2018年 leaf. All rights reserved.
//

import Foundation
import Moya

/// 请求类型与参数
enum HttpServiceType {
    /// 登录
    case login(name: String, pwd: String)
    /// 微信登录
    case wechatLogin(wID: String)
    /// 注册
    case regist(email: String,phone: String,password: String,code: String)
    /// 微信注册
    case wechatRegist(wID: String)
    /// 儿童列表
    case children(registID: String)
    /// 查询儿童信息
    case selectChildInfomation(childUserID: String)
    /// 修改关联水杯
    case updateRelevanceCup(userID: String,deviceSN: String,deviceReName: String)
    /// 关联水杯
    case relevanceCup(userID: String,deviceSN: String,deviceReName: String)
    /// 获取好友列表
    case friendlist(userID: String)
    /// 查找好友
    case searchFriendlist(userName: String)
    /// 上传图片
    case upImage(img: URL,lenght: NSInteger,id: String)
    /// 修改儿童信息
    case updataChildInfomation(age: String,classEndTime: String,classOnOff: String,classStartTime: String,registerID: String,restEndTime: String,restOnOff: String,restStartTime: String,sex: String,totalOnOff: String,username: String,weight: String,height:String)
    /// 添加儿童
    case addChildInUser(age: String,classEndTime: String,classOnOff: String,classStartTime: String,registerID: String,restEndTime: String,restOnOff: String,restStartTime: String,sex: String,totalOnOff: String,username: String,weight: String,height: String)
}

extension HttpServiceType: TargetType {
    var baseURL: URL {
        return URL(string: "http://112.74.79.95:8081/XsgAppService/")!
    }
    
    var path: String {
        switch self {
        case .addChildInUser(_, _, _, _, _, _, _, _, _, _, _, _,_):
            return "childUser/addChildUser"
        case .children(_):
            return "childUser/childUserList"
        case .friendlist(_):
            return "childUser/friendList"
        case .login(_, _):
            return "user/login"
        case .regist(_, _, _, _):
            return "user/register"
        case .relevanceCup(_, _, _):
            return "childUser/addRelationDevice"
        case .wechatLogin(_):
             return "user/loginWX"
        case .selectChildInfomation(_):
            return "childUser/selectChildUser"
        case .updateRelevanceCup(_, _, _):
            return "childUser/updateRelationDevice"
        case .searchFriendlist(_):
            return "childUser/findChildByUserName"
        case .updataChildInfomation(_, _, _, _, _, _, _, _, _, _, _, _,_):
            return "childUser/editChildUser"
        case .wechatRegist(_):
            return "user/registerForWX"
        case .upImage(_):
            return "file/uploadFile"

        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }
    
    var task: Task {
        switch self {
       
        case .login(let name, let pwd):
            
            let result = "^([\\w]+)@([\\w]+)\\.([\\w]{2,6})$"
            let predicate = NSPredicate(format: "SELF MATCHES %@", result)
            let isMail = predicate.evaluate(with: name)
            var phone = "",email = ""
            if isMail {
                email = name
            } else {
                phone = name
            }
            let info = ["email": email, "phone": phone, "password": pwd, "code": ""]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .wechatLogin(let wID):
            
            let info = ["unionid": wID]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .regist(let email, let phone, let password, _):
            
            let info = ["email": email, "phone": phone, "password": password, "code": ""]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .wechatRegist(let wID):
        
            let info = ["unionid": wID]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .children(let registID):
  
            let info = ["registerID": registID]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .selectChildInfomation(let childUserID):

            let info = ["childUserID": childUserID]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .updateRelevanceCup(let userID, let deviceSN, let deviceReName):

            let info = ["userID": userID,"deviceSN": deviceSN,"deviceReName": deviceReName]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .relevanceCup(let userID, let deviceSN, let deviceReName):

            let info = ["userID": userID,"deviceSN": deviceSN,"deviceReName": deviceReName]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .friendlist(let userID):

            let info = ["userID": userID]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .searchFriendlist(let userName):

            let info = ["userName": userName]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .updataChildInfomation(let age, let classEndTime, let classOnOff, let classStartTime,  let registerID, let restEndTime, let restOnOff, let restStartTime, let sex, let totalOnOff, let username, let weight, let height):

            let info = ["age": age,
                        "classEndTime": classEndTime,
                        "classOnOff": classOnOff,
                        "classStartTime": classStartTime,
                        "registerID": registerID,
                        "restEndTime": restEndTime,
                        "restOnOff": restOnOff,
                        "restStartTime": restStartTime,
                        "sex": sex,
                        "totalOnOff": totalOnOff,
                        "username": username,
                        "weight": weight,
                        "height": height,
                        ]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
            
        case .addChildInUser(let age, let classEndTime, let classOnOff, let classStartTime,  let registerID, let restEndTime, let restOnOff, let restStartTime, let sex, let totalOnOff, let username, let weight, let height):
            
            let info = ["age": age,
                        "classEndTime": classEndTime,
                        "classOnOff": classOnOff,
                        "classStartTime": classStartTime,
                        "registerID": registerID,
                        "restEndTime": restEndTime,
                        "restOnOff": restOnOff,
                        "restStartTime": restStartTime,
                        "sex": sex,
                        "totalOnOff": totalOnOff,
                        "username": username,
                        "weight": weight,
                        "height": height,
                        ]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .requestData(json!)
        case .upImage(let img, _, let id):
            let info = ["weewe": img]
            let json = try? JSONSerialization.data(withJSONObject: info, options: .prettyPrinted)
            return .uploadCompositeMultipart([MultipartFormData(provider: .file(img), name: id)], urlParameters: info)
        }
        
    }
    
    var headers: [String : String]? {
        switch self {
        case .upImage(_, _,let id):
            return ["Content-type": "application/x-www-form-urlencoded; boundary=\(id)"]
        default:
            return ["Content-type": "application/json"]
        }
    }
    
    
    
}
