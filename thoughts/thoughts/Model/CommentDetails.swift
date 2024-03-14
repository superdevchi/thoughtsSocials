

import Foundation

// MARK: - Welcome
struct CommentDetails: Identifiable, Codable {
    var id: String {commentID}
    
    let userModel: CommentUserModel
    let postModels: CommentPostModels
    let comment, postTimeStamp,commentID: String
    
    init(data: [String:Any]) {
       
        self.comment = data["comment"] as? String ?? ""
        self.commentID = data["commentID"] as? String ?? ""
        self.postTimeStamp = data["postTimeStamp"] as? String ?? ""
        self.postModels = data["postHeaderImage"] as! CommentPostModels
        self.userModel = data["userModel"] as! CommentUserModel
        
    }
}

// MARK: - PostModels
struct CommentPostModels: Codable {
    let userModel: CommentUserModel
    let postID: String
    let postHeaderImage: String
    let postContent,postTimeStamp: String
    
    init(data: [String:Any]) {
        
        self.postHeaderImage = data["postHeaderImage"] as? String ?? ""
        self.postContent = data["postContent"] as? String ?? ""
        self.postID = data["postID"] as? String ?? ""
        self.postTimeStamp = data["postTimeStamp"] as? String ?? ""
        self.userModel = data["userModel"] as! CommentUserModel
        
    }
}

// MARK: - UserModel
struct CommentUserModel: Codable {
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

