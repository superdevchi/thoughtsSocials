

import Foundation

// MARK: - Welcome
struct PostLikeDetailsStruct: Identifiable, Codable {
    var id: String {postLikeID}
    let postLikeID: String
    let userThatLikedPost: UserStruct
    let postLiked: PostLikedStruct

    init(data: [String:Any]) {
        self.postLikeID = data["postLikeID"] as? String ?? ""
        self.postLiked = data["postLiked"] as! PostLikedStruct
        self.userThatLikedPost = data["userThatLikedPost"] as! UserStruct
        
    }
}

// MARK: - PostLiked
struct PostLikedStruct: Codable {
    let userModel: UserStruct
    let postID: String
    let postHeaderImage: String
    let postContent,postTimeStamp: String
    
    init(data: [String:Any]) {
        self.postHeaderImage = data["postHeaderImage"] as? String ?? ""
        self.postContent = data["postContent"] as? String ?? ""
        self.postTimeStamp = data["postTimeStamp"] as? String ?? ""
        self.postID = data["postID"] as? String ?? ""
        self.userModel = data["userModel"] as! UserStruct
        
    }

}

// MARK: - User
struct UserStruct: Codable {
    let userID, userName, email, firebaseID: String
    let profilePicture: String
    
    init(data: [String:Any]) {
        self.userName = data["userName"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.firebaseID = data["firebaseID"] as? String ?? ""
        self.profilePicture = data["profilePicture"] as? String ?? ""
        self.userID = data["userID"] as? String ?? ""
    }
}


