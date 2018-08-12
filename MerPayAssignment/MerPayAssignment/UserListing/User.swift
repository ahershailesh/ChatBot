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
    
    var name            :   String?
    var company         :   String?
    var blog            :   String?
    var location        :   String?
    var email           :   String?
    var hireable        :   String?
    var bio             :   String?
    var publicRepos     :   Int?
    var publicGists     :   Int?
    var followers       :   Int?
    var following       :   Int?
    var createdAt       :   String?
    var updatedAt       :   String?
}
