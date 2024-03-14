//
//  Follower.swift
//  thoughts
//
//  Created by chibuike on 2024-03-04.
//

import Foundation

struct Follower: Codable, Identifiable {
    
    var id: String {followerID}
    let user, follower: UserFollower
    let followerID: String


}


struct UserFollower: Codable {
    let userID: String
    let profilePicture: String
    let userName, email, firebaseID: String
}
