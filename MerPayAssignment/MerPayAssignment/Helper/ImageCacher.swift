//
//  ImageCacher.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/11/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import UIKit
import CoreData

/// This class will save images in the core data to retrieve it afterwords
class ImageCacher : NetworkManager {
    
    let queue = DispatchQueue.global(qos: .background)
    static let shared = ImageCacher(session: URLSession.shared)
    
    private override init(session: NetworkSessionProtocol = URLSession.shared) {
        super.init(session: session)
    }
    
    
    /// Fetch either from url or from username
    /// If url given and data not found in cache. it will retrieve data from url and store it in cache for later use.
    /// For user it will only try to find data in the cache, if not found it will return nil.
    ///
    /// - Parameters:
    ///   - url: link from where profile pic is to be fetched.
    ///   - userName: user name of the person.
    ///   - callBack: call back on retrieval.
    func get(from url: URL?, userName: String, callBack: ResponseCallBack?) {
        guard let url = url else {
            getImage(for: userName, callBack: callBack)
            return
        }
        
        //First fetch cache
        self.getImageFromCache(for: url) { [weak self] success, response in
            if !success {
                //If not found in cache, fetch from server
                self?.getImageFromAPI(for: url, userName: userName, callBack: callBack)
            } else if let profileData = response as? ProfileData {
                //If found in cache, check for validity.
                self?.checkValidity(of: profileData) { success, response in
                    if !success {
                        //if not valid, fetch image from server.
                        self?.getImageFromAPI(for: url, userName: userName, callBack: callBack)
                    } else {
                        //if valid return fetched image.
                        callBack?(success, response)
                    }
                }
            } else {
                //Immposible condition.
                callBack?(success, response)
            }
        }
    }
    
    //MARK:- Private
    private func getImage(for userName: String, callBack: ResponseCallBack?) {
        let context = CoreDataStack.shared.context
        let request = NSFetchRequest<ProfileData>(entityName: "ProfileData")
        //get object with the same url.
        request.predicate = NSPredicate(format: "userName = %@", argumentArray: [userName])
        var profileData : ProfileData?
        var success = false
        do {
            let objects = try context.fetch(request)
            if !objects.isEmpty {
                profileData = objects.first
                success = true
            }
        } catch {
            print(error.localizedDescription)
        }
        callBack?(success, profileData?.data)
    }
    
    private func getImageFromCache(for url: URL, callBack: ResponseCallBack?) {
        let context = CoreDataStack.shared.context
        let request = NSFetchRequest<ProfileData>(entityName: "ProfileData")
        //get object with the same url.
        request.predicate = NSPredicate(format: "url = %@", argumentArray: [url])
        var profileData : ProfileData?
        var success = false
        do {
            let objects = try context.fetch(request)
            if !objects.isEmpty {
                profileData = objects.first
                success = true
            }
        } catch {
            print(error.localizedDescription)
        }
        callBack?(success, profileData?.data)
    }
    
    private func getImageFromAPI(for url: URL, userName: String, callBack: ResponseCallBack?) {
        getData(from: url) { [weak self] data, response, error in
            let success = error == nil
            callBack?(success, data)
            self?.saveProfile(data: data, userName: userName, response: response as? HTTPURLResponse)
        }
    }
    
    private func checkValidity(of profileData: ProfileData, callBack: ResponseCallBack?) {
        if let url = URL(string: profileData.url!) {
            getHeaders(from: url) { _, response, _ in
                var success = false
                if let headers = response as? HTTPURLResponse,
                    let lastModified = headers.allHeaderFields["Last-Modified"] as? String,
                    profileData.lastModified == lastModified {
                    success = true
                }
                callBack?(success, profileData)
            }
        }
    }
    
    private func saveProfile(data: Data?, userName: String, response: HTTPURLResponse?) {
        queue.sync {
            let context = CoreDataStack.shared.context
            let profile = ProfileData(context: context)
            profile.data = data as NSData?
            profile.lastModified = response?.allHeaderFields["Last-Modified"] as? String
            profile.url = response?.url?.absoluteString
            profile.userName = userName
        }
    }
}
