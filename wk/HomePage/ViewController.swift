//
//  ViewController.swift
//  wk
//
//  Created by leaf on 2017/12/25.
//  Copyright © 2017年 leaf. All rights reserved.
//

import UIKit
import WebKit
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON
class ViewController: UIViewController {
    
    var wk: WKWebView!
    let pool = WKProcessPool()
    let config = WKWebViewConfiguration()
    let preferences = WKPreferences()
    let userController = WKUserContentController()
    let websiteDataStore = WKWebsiteDataStore.default()
    let disposeBag = DisposeBag()
    let provider = MoyaProvider<HttpServiceType>()
    var session:URLSession!
    var upDataTask:URLSessionUploadTask!
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = Bundle.main.path(forResource: "Ratio_177_1@3x", ofType: "png")
        let fileURL = URL.init(fileURLWithPath: url!)
//        request(fileURL)
//        upImg(filePath: fileURL)
        requestImg(fileURL)

    }
    func request(_ filePath: URL){
        
        let _params = ["weewe": filePath.absoluteString]
        let imgData = try? Data(contentsOf: filePath)

        let BoundaryConstant = "----------V2ymHFg03ehbqgZCaKO6jy"
        let FileParamConstant = "file"
        var request = URLRequest.init(url: URL(string: "http://112.74.79.95:8081/XsgAppService/file/uploadFile")!)
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.httpShouldHandleCookies = false
        request.timeoutInterval = 20
        request.httpMethod = "POST"
        
        let contentType = "multipart/form-data; boundary=\(BoundaryConstant)"
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        body.append("--\(BoundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=weewe\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imgData!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        
        body.append("--\(BoundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Disposition: form-data; name=\(FileParamConstant)\"; filename=\"image.jpg\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: image/png\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imgData!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        body.append("--\(BoundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)

        request.httpBody = body
        request.setValue("\(String(describing: body.count))", forHTTPHeaderField: "Content-Length")
        
         session = URLSession.init(configuration: .default)
         upDataTask = session.uploadTask(with: request, from: imgData) { (data, response, error) in
            
            let jsonData = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
            print("...")
        }
        upDataTask.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func upImg(filePath: URL)  {
        
        let url = Bundle.main.path(forResource: "Ratio_177_1@3x", ofType: "png")
        var params = [String:String]()
        let imgData = try? Data(contentsOf: filePath)

        let boundaryConstant  = "----------V2y2HFg03eptjbaKO0j1"
        
        let file1ParamConstant = "file1"
        params["weewe"] =  "Ratio_177_1@3x"
        
        let requestUrl = NSURL(string: url!)
        
        var request = URLRequest(url: filePath)
        
//        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData
        request.httpShouldHandleCookies=false
        request.timeoutInterval = 30
        request.httpMethod = "POST"
        
        let contentType = "multipart/form-data; boundary=\(boundaryConstant)"
        
        request.setValue(contentType, forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        // parameters
        
        for param in params {
            
            body.append("--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)! )
            body.append("Content-Disposition: form-data; name=\"\(param)\"\r\n\r\n" .data(using: String.Encoding.utf8)!)
            body.append("\(param.value)\r\n" .data(using: String.Encoding.utf8)!)
            
        }
        // images
        
        // image begin
        body.append("--\(boundaryConstant)\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("Content-Disposition: form-data; name=\"\(file1ParamConstant)\"; filename=\"image.jpg\"\r\n".data(using: String.Encoding.utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
        
        body.append(imgData!)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        // image end
        
        
        
        body.append("--\(boundaryConstant)--\r\n".data(using: String.Encoding.utf8)!)
        
        request.httpBody  = body as Data
        let postLength = "\(body.length)"
        request.setValue(postLength, forHTTPHeaderField: "Content-Length")
        request.url = filePath
        
        var serverResponse = NSString()
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            
            print("response = \(response)")
            
            
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("responseString = \(responseString!)")
            serverResponse = responseString!
            
            
        }
        
        task.resume()
    }
    
    func requestImg(_ fileURL: URL) {
        
        let TWITTERFON_FORM_BOUNDARY = "AaB03x"
        var request = URLRequest(url: URL(string: "http://112.74.79.95:8081/XsgAppService/file/uploadFile")!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 30)
        let MPboundary = "--\(TWITTERFON_FORM_BOUNDARY)"
        let endMPboundary = "\(MPboundary)--"
        let sourceData = try? Data(contentsOf: fileURL)
        
        let image = UIImage(data: sourceData!)
        
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        
        var body = "\(MPboundary)\r\n"
        body.append("Content-Disposition: form-data; name=weewe\r\n\r\n")
        body.append("Ratio_177_1\r\n")
        body.append("\(MPboundary)\r\n")
        
        body.append("Content-Disposition: form-data; name=\"headPortrait\"; filename=\"headPortrait.png\"\r\n")
        body.append("Content-Type: image/png\r\n\r\n")
        
        let end = "\r\n\(endMPboundary)"
        
        var myRequestData = Data()
        myRequestData.append(body.data(using: String.Encoding.utf8)!)
        myRequestData.append(imageData!)
        myRequestData.append(end.data(using: String.Encoding.utf8)!)
        
        let content = "multipart/form-data; boundary=\(TWITTERFON_FORM_BOUNDARY)"
        
        request.setValue(content, forHTTPHeaderField: "Content-Type")
        request.setValue("\(String(describing: imageData?.count))", forHTTPHeaderField: "Content-Length")
        request.httpBody = myRequestData
        request.httpMethod = "POST"
        
        
        session = URLSession(configuration: .default)
        upDataTask =  session.uploadTask(with: request, from: myRequestData) { (data, response, error) in
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("needNewBodyStream")

        }
        upDataTask.resume()
    }
}
extension ViewController: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, didSendBodyData bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) {
        print("\(bytesSent) \(totalBytesSent)")
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, needNewBodyStream completionHandler: @escaping (InputStream?) -> Void) {
        print("needNewBodyStream")

    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        
        print("session")
        
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        print("response")
    }
    
}
extension ViewController:WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
    
    }
}

extension ViewController: WKNavigationDelegate {
    
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("")
        let store = WKWebsiteDataStore.allWebsiteDataTypes()
        store.map { print($0)}
    
        let webStore = webView.configuration.websiteDataStore
        webStore.fetchDataRecords(ofTypes: ["WKWebsiteDataTypeCookies"]) { records in
            records.map {
                if $0.displayName  ==  "mifengs.com" {
                    print($0)
                }
            }
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {

    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
    }
    
//    /// 认证证书
//    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//
//        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, URLCredential())
//    }
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
      let name =  webView.configuration.applicationNameForUserAgent
        print("request.url: \(String(describing: navigationAction.request.url?.absoluteURL))")
        let data = navigationAction.request.httpBody
        if data != nil {
            do {
                
                let  dataJson  =   try  JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
            } catch  {
                
            }
        }
     
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        print("response.url: \(String(describing: navigationResponse.response.url?.absoluteURL))")
        decisionHandler(.allow)
    }
}

