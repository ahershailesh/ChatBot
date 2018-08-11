//
//  UserListingInteractor.swift
//  MerPayAssignment
//
//  Created by Shailesh Aher on 8/10/18.
//  Copyright © 2018 Shailesh Aher. All rights reserved.
//

import Foundation

class User : Codable {
    var login           :   String?
    var id              :   Int?
    var nodeId          :   String?
    var avatarUrl       :   URL?
    var gravatarId      :   String?
    var url             :   URL?
    var htmlUrl         :   URL?
    var followersUrl    :   URL?
    var followingUrl    :   String?
    var gistsUrl        :   String?
    var starredUrl      :   String?
    var subscriptionsUrl:   URL?
    var organizationsUrl:   URL?
    var reposUrl        :   URL?
    var eventsUrl       :   String?
    var receivedEventsUrl:  URL?
    var type            :   String?
    var siteAdmin       :   Bool = false
    
    
}
