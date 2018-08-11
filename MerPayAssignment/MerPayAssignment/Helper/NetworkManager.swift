//
//  NetworkManager.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit

@objc protocol NetworkProtocol {
    @objc optional func getUrl() -> String
    @objc optional func compulsoryPathParam() -> [String]
    @objc optional func compulsoryQueryParam() -> [String : String]
    @objc optional func compulsoryHeaders() -> [String : String]
}

typealias NetworkCallBack = ((_ success: Bool, _ response: Any?, _ error: Error?) -> Void)

protocol NetworkSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Swift.Void) -> URLSessionDataTask
    
}

extension URLSession : NetworkSessionProtocol {
    
}

class NetworkManager {
    
    var delegate : NetworkProtocol?
    private let session : NetworkSessionProtocol
    
    init(session: NetworkSessionProtocol =  URLSession.shared) {
        self.session = session
    }
    
    func get(url: String? = nil, pathParam: [String]? = nil, queryParam: [String: String]? = nil, headers: [String: String]? = nil, callBack: NetworkCallBack?) {
        
        var url = url ?? delegate?.getUrl?() ?? ""
        
        if let compulsoryPathParam = delegate?.compulsoryPathParam?(), !compulsoryPathParam.isEmpty {
            url = url + "/" + compulsoryPathParam.joined(separator: "/")
        }
        
        if let pathParameter = pathParam, !pathParameter.isEmpty  {
            url = url + "/" + pathParameter.joined(separator: "/")
        }
        
        var separator = "?"
        if let compulsoryQueryParam = delegate?.compulsoryQueryParam?(), !compulsoryQueryParam.isEmpty {
            separator = "&"
            url = url + "?" + compulsoryQueryParam.map { (key, value) -> String in
                return key + "=" + value
                }.joined(separator: "&")
        }
        
        if let queryParameter = queryParam, !queryParameter.isEmpty {
            url = url + separator + queryParameter.map { (key, value) -> String in
                return key + "=" + value
                }.joined(separator: "&")
        }
        
        if let thisUrl = URL(string: url) {
            var request = URLRequest(url: thisUrl)
            request.httpMethod = "GET"
            addHeaders(request: &request, headers: headers)
            let task = session.dataTask(with: request, completionHandler: { [weak self]  (data, response, error) in
                if let data = data { print(url + (String(data: data, encoding: .utf8) ?? "")) }
                let success =  error == nil
                if !success {
                    self?.showError(error: error)
                    print(error as Any)
                }
                callBack?(success, data, error)
            })
            task.resume()
        } else {
            callBack?(false, nil, nil)
        }
    }
    
    func getData(from url: URL, callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        let task = session.dataTask(with: url, completionHandler: callBack)
        task.resume()
    }
    
    func getHeaders(from url: URL, callBack: @escaping ((Data?, URLResponse?, Error?) -> Void)) {
        var request = URLRequest(url: url)
        request.httpMethod = "HEAD"
        let task = session.dataTask(with: request, completionHandler: callBack)
        task.resume()
    }
    
    private func addHeaders(request : inout URLRequest, headers: [String: String]?) {
        if let compulsoryHeaders = delegate?.compulsoryHeaders?() {
            compulsoryHeaders.forEach({ (key, value) in
                request.setValue(value, forHTTPHeaderField: key)
            })
        }
        
        headers?.forEach({ (key, value) in
            request.setValue(value, forHTTPHeaderField: key)
        })
        
    }
    
    func post(url: String? = nil, pathParam: [String]? = nil, queryParam: [String: String]? = nil, headers: [String: String]? = nil, bodyString : String? = nil, callBack: NetworkCallBack?) {
        
        var url = url ?? delegate?.getUrl?() ?? ""
        
        if let compulsoryPathParam = delegate?.compulsoryPathParam?(), !compulsoryPathParam.isEmpty {
            url = url + "/" + compulsoryPathParam.joined(separator: "/")
        }
        
        if let pathParameter = pathParam, !pathParameter.isEmpty  {
            url = url + "/" + pathParameter.joined(separator: "/")
        }
        
        var separator = "?"
        if let compulsoryQueryParam = delegate?.compulsoryQueryParam?(), !compulsoryQueryParam.isEmpty {
            separator = "&"
            url = url + "?" + compulsoryQueryParam.map { (key, value) -> String in
                return key + "=" + value
                }.joined(separator: "&")
        }
        
        if let queryParameter = queryParam, !queryParameter.isEmpty {
            url = url + separator + queryParameter.map { (key, value) -> String in
                return key + "=" + value
                }.joined(separator: "&")
        }
        
        if let thisUrl = URL(string: url) {
            var request = URLRequest(url: thisUrl)
            request.httpMethod = "POST"
            if let body = bodyString {
                request.httpBody = body.data(using: .utf8)
            }
            addHeaders(request: &request, headers: headers)
            let task = session.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
                let success =  error == nil
                var json : [String: Any]?
                if success {
                    do {
                        json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String: Any]
                    } catch {
                        print("got error while parsing json from url = " + url)
                    }
                } else {
                    self?.showError(error: error)
                    print(error as Any)
                }
                if let json = json {
                    print(json)
                    callBack?(success, json, error)
                } else if let data = data {
                    let stringData = String(bytes: data, encoding: .utf8)
                    print(stringData as Any)
                    callBack?(success, stringData, error)
                } else {
                    callBack?(false, nil, error)
                }
            })
            print("\(request.httpMethod!) - \(request.url!)")
            task.resume()
        }
    }
    
    private func showError(error : Error?) {
//        appDelegate.window?.rootViewController?.show(error: error)
    }
    
}
