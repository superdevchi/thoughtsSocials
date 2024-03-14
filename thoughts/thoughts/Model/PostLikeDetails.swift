// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? JSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct PostLikeDetails: Codable {
    let postLikeID: String
    let userThatLikedPost: User
    let postLiked: PostLiked

}

// MARK: - PostLiked
struct PostLiked: Codable {
    let userModel: User
    let postID: String
    let postHeaderImage: String
    let postContent: String
}

// MARK: - User
struct User: Codable {
    let userID, userName, email, firebaseID: String
    let profilePicture: String
}

