//
//  PostDetails.swift
//  thoughts
//
//  Created by chibuike on 2024-02-03.
//


import Foundation

// MARK: - Welcome
struct PostDetails: Codable {
    
    let userModel: UserModel
    let postHeaderImage: String
    let postContent, postID: String
}

// MARK: - UserModel
struct UserModel: Codable {
    let userName, email, firebaseID: String
    let profilePicture: String
    let userID: String
}
