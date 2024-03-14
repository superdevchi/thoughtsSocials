//
//  PostDetailStruct.swift
//  thoughts
//
//  Created by chibuike on 2024-02-07.
//

import Foundation

struct PostDetailsStruct: Identifiable, Codable {
    var id: String {postID}
    
    let userModel: User
    let postHeaderImage: String
    let postContent, postTimeStamp,postID: String
    
    init(data: [String:Any]) {
        self.postHeaderImage = data["postHeaderImage"] as? String ?? ""
        self.postContent = data["postContent"] as? String ?? ""
        self.postTimeStamp = data["postTimeStamp"] as? String ?? ""
        self.postID = data["postID"] as? String ?? ""
        self.userModel = data["userModel"] as! User
        
    }
}

struct UserModelStruct: Codable {
    let userName, email, firebaseID: String
    let profilePicture: String
    let userID: String
    
    init(data: [String:Any]) {
        self.userName = data["userName"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.firebaseID = data["firebaseID"] as? String ?? ""
        self.profilePicture = data["profilePicture"] as? String ?? ""
        self.userID = data["userID"] as? String ?? ""
    }
}
