//
//  Rxswiftstudy.swift
//  wk
//
//  Created by leaf on 2018/1/3.
//  Copyright © 2018年 leaf. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
enum DataError : Swift.Error  {
    case ParseJsonError
    case RequestFailed
    case NoResponse
    case UnexPectedResult(resultCode: Int?,resultMsg: String?)
}
class Rxswiftstudy: NSObject {
    var json: Observable<Any>!
    override init() {
        super.init()
        setupObservable()
        
    }
    func  setupObservable() {
        json = Observable.create({ (observer) -> Disposable in
            let session = URLSession.shared
            let task = session.dataTask(with: URL(string: "https://www.mifengs.com/mifengs_m/mIndex")!, completionHandler: { (data, response, error) in
                guard error == nil else {
                    observer.onError(error!)
                    return
                }
                
                guard let data = data,let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
                    observer.onError(error!)
                    return
                }
                
                observer.onNext(jsonObject)
                observer.onCompleted()
                
            })
            task.resume()
            return Disposables.create { task.cancel() }
        })
    }
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: { single   -> Disposable in
            let url = URL(string: "https://www.mifengs.com/mifengs_m/\(repo)")!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),let result = json as? [String: Any] else {
                    single(.error(DataError.ParseJsonError))
                    return
                }
                single(.success(result))
            })
            task.resume()
            return Disposables.create {
                task.cancel()
            }
        })
    }
//    func cachelocally() -> Completable {
//        return Completable.create(subscribe: { completable in
//            guard success else {
//                completable(.error(CacheError.failedCaching))
//            }
//        })
//    }
}
enum CacheError: Swift.Error {
    case failedCaching
}
