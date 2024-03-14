//
//  UserCreationViewModel.swift
//  thoughts
//
//  Created by chibuike on 2024-02-02.
//

import Foundation
import Alamofire
import FirebaseFirestore
import FirebaseAuth

class UserCreationViewModel: ObservableObject {
    
    
    @Published var UserInfo: UserDetailStruct?
    @Published var SearchedUserInfo: UserDetailStruct?
    @Published var Feed = [PostDetailsStruct]()
    @Published var user:UserDetail?
    @Published var URL = "http://localhost:2001/User/create"
    @Published var Comment = [CommentDetails]()
    @Published var Like = [PostLikeDetails]()
    @Published var UserPostList = [PostDetailsStruct]()
    @Published var PostUID = ""
    @Published var PostCount = 0
    @Published var FullPostDisplayID = ""
    @Published var PostInfo: PostDetailsStruct?
    @Published var Users = [UserDetailStruct]()
    @Published var Followers = [Follower]()
    @Published var chatMessages = [ChatMessage]()
    @Published var ErrorMessage = ""
    
    
    
    @Published var isRegistrationProcessComplete = false
    
    @Published var isLoginProcessCompleteLoginView = false
    
    @Published var loginpage =  false
    
    
    
    
    func getcomments(POSTID:String){
        AF.request("http://localhost:2001/Post/"+POSTID).response { response in
            print("getting comment from this \(POSTID)")
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode([CommentDetails].self, from: data)
                    self.Comment.append(contentsOf: UserDetails)
                    print(self.Comment)
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
        
    }
    
    func getAllUserPost(USERID:String){
        AF.request("http://localhost:2001/User/"+USERID).response { response in
            //            debugPrint(response)
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode([PostDetailsStruct].self, from: data)
                    self.UserPostList.append(contentsOf: UserDetails)
                    print("All User Post")
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
        
    }
    
    func getAllUserPostCount(USERID: String, completion: @escaping (Int) -> Void) {
        AF.request("http://localhost:2001/User/"+USERID).response { response in
            if let data = response.data {
                do {
                    let UserDetails = try JSONDecoder().decode([PostDetailsStruct].self, from: data)
                    let postCount = UserDetails.count
                    completion(postCount)
                } catch let error as NSError {
                    print(error)
                    completion(0) // Return 0 in case of an error
                }
            } else {
                completion(0) // Return 0 if there is no data
            }
        }
    }
    
    func getAllUserFollowersCount(USERID: String, completion: @escaping (Int) -> Void) {
        AF.request("http://localhost:2001/Follow/"+USERID).response { response in
            if let data = response.data {
                do {
                    let UserDetails = try JSONDecoder().decode([Follower].self, from: data)
                    let postCount = UserDetails.count
                    completion(postCount)
                } catch let error as NSError {
                    print("error getting count: \(error)")
                    completion(0) // Return 0 in case of an error
                }
            } else {
                completion(0) // Return 0 if there is no data
            }
        }
    }
    
    func getAllPostLikeCount(POSTID: String, completion: @escaping (Int) -> Void) {
        AF.request("http://localhost:2001/Likes/"+POSTID).response { response in
            print("getting like count from this \(POSTID)")
            if let data = response.data {
                do {
                    let UserDetails = try JSONDecoder().decode([PostLikeDetailsStruct].self, from: data)
                    let postCount = UserDetails.count
                    completion(postCount)
                } catch let error as NSError {
                    print("error Post count: \(error)")
                    completion(0) // Return 0 in case of an error
                }
            } else {
                completion(0) // Return 0 if there is no data
            }
        }
    }
    
    func getAllPostCommentCount(POSTID: String, completion: @escaping (Int) -> Void) {
        
        AF.request("http://localhost:2001/Post/"+POSTID).response { response in
            print("getting comment count from this \(POSTID)")
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode([CommentDetails].self, from: data)
                    let postCount = UserDetails.count
                    completion(postCount)
                    
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
        
    }
    
    func didilikethispost(USERID: String, POSTID: String,completion: @escaping (Bool) -> Void) {
        AF.request("http://localhost:2001/Likes/"+POSTID).response { response in
            if let data = response.data {
                do {
                    let UserDetails = try JSONDecoder().decode([PostLikeDetails].self, from: data)
                    
                    var check = UserDetails.map { PostDetailsStruct in
                        return PostDetailsStruct.userThatLikedPost.userID
                    }
                    
                    if check.contains(USERID){
                        completion(true)
                        print("i liked this post")
                    }else{
                        completion(false)
                        print("i do not liks this post")
                    }
                    
                    
                } catch let error as NSError {
                    print(error)
                    //                    completion(0) // Return 0 in case of an error
                }
            } else {
                //                completion(0) // Return 0 if there is no data
            }
        }
    }
    
    func doifollowthisuser(USERID: String, FOLLOWERID: String,completion: @escaping (Bool) -> Void) {
        AF.request("http://localhost:2001/Follow/"+USERID).response { response in
            if let data = response.data {
                do {
                    let UserDetails = try JSONDecoder().decode([Follower].self, from: data)
                    
                    var check = UserDetails.map { PostDetailsStruct in
                        return PostDetailsStruct.follower.userID
                    }
                    
                    if check.contains(FOLLOWERID){
                        completion(true)
                        print("i am following this user")
                    }else{
                        completion(false)
                        print("i do not follow this user")
                    }
                    
                    
                } catch let error as NSError {
                    print(error)
                    //                    completion(0) // Return 0 in case of an error
                }
            } else {
                //                completion(0) // Return 0 if there is no data
            }
        }
    }
    
    
    
    func getsearcheduser(USERID:String){
        AF.request("http://localhost:2001/User/Profile/"+USERID).response { response in
            //            debugPrint(response)
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode(UserDetailStruct.self, from: data)
                    var userinformation = [
                        "userName" : UserDetails.userName,
                        "Email": UserDetails.email,
                        "firebaseID": UserDetails.firebaseID,
                        "profilePicture":UserDetails.profilePicture,
                        "userID":UserDetails.userID
                    ]
                    self.SearchedUserInfo = .init(data: userinformation)
                    //                    self.UserPostList.append(contentsOf: UserDetails)
                    print("Searched User Info \(self.SearchedUserInfo)")
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
        
    }
    
    
    
    func sendmessage(FROMID: String, TOID: String, MESSAGE: String ){
        var Link = "http://localhost:2001/FirebaseMessaging/\(FROMID)/\(TOID)/\(MESSAGE)/send"
        AF.request(Link, method: .post).response{
            response in
            print(response)
        }
        
    }
    
    
    func addlike(USERID: String, POSTID: String, completion: @escaping (Bool) -> Void){
        var POSTURL = "http://localhost:2001/Likes/\(USERID)/\(POSTID)/like"
        AF.request(POSTURL, method: .post).response{
            response in
            print(response)
            completion(true)
        }
    }
    
    func addcomment(USERID: String,COMMENT:String){
        var POSTURL = "http://localhost:2001/Comment/\(USERID)/\(PostUID)/create"
        AF.upload(multipartFormData: { MultipartFormData in
            MultipartFormData.append(Data(COMMENT.utf8), withName: "Comment")
        }, to: POSTURL).response{ response in
            
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode(CommentDetails.self, from: data)
                    print("comment added +===\(UserDetails)")
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
    }
    
    func addFollower(USERID: String, FOLLOWERID: String){
        var POSTURL = "http://localhost:2001/Follow/\(USERID)/\(FOLLOWERID)"
        AF.request(POSTURL, method: .post).response{
            response in
            //            print(response)
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode(Follower.self, from: data)
                    print("friend added +===\(UserDetails)")
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
    }
    
    func getAllFollowers(USERID: String) {
        AF.request("http://localhost:2001/Follow/"+USERID).response { response in
            if let data = response.data {
                do {
                    let UserDetails = try JSONDecoder().decode([Follower].self, from: data)
                    //                    let postCount = UserDetails.count
                    self.Followers.append(contentsOf: UserDetails)
                    //                    completion(postCount)
                } catch let error as NSError {
                    print(error)
                    //                    completion(0) // Return 0 in case of an error
                }
            } else {
                //                completion(0) // Return 0 if there is no data
            }
        }
    }
    
    
    func getallusers(){
        
        AF.request("http://localhost:2001/User/users").response { response in
            //            debugPrint(response)
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode([UserDetailStruct].self, from: data)
                    //                    print("USER: ", UserDetails, "Etc...")
                    self.Users.append(contentsOf: UserDetails)
                    //                    print(self.Users)
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
    }
    
    
    
    func getdata(){
        AF.request("http://localhost:2001/Post/posts").response { response in
            //            debugPrint(response)
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode([PostDetailsStruct].self, from: data)
                    //                    print("USER: ", UserDetails, "Etc...")
                    var check = UserDetails.map { PostDetailsStruct in
                        return PostDetailsStruct.postID
                    }
                    
                    var sorteddata = UserDetails.sorted {
                        $0.postTimeStamp.compare($1.postTimeStamp) == .orderedDescending
                    }
                    
                    print("check \(check)")
                    
                    
                    
                    self.Feed.append(contentsOf: sorteddata)
                    
                    
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
    }
    
    
    
    func userregistration(EMAIL:String, USERNAME:String,PASSWORD:String,IMAGE: Data) async
    {
        do{
            
            Auth.auth().createUser(withEmail: EMAIL, password: PASSWORD) { Result, Error in
                if let Error = Error{
                    print(Error)
                }
                
                let UID = Result?.user.uid ?? ""
                let userData = ["email":EMAIL, "firebaseUID":UID]
                
                //Save User to FireStore
                let savefirestore = Firestore.firestore()
                savefirestore.collection("users").document(UID).setData(userData){ Error in
                    if let Error =  Error {
                        print("Error Saving")
                    }
                    
                    print("Saved now, saving to spring boot")
                    
                    //                    Save to db
                    AF.upload(multipartFormData: { multipartFormData in
                        multipartFormData.append(Data(USERNAME.utf8), withName: "UserName")
                        multipartFormData.append(Data(EMAIL.utf8), withName: "Email")
                        multipartFormData.append(Data(UID.utf8), withName: "FirebaseID")
                        
                        multipartFormData.append(IMAGE, withName:"ImageFile",fileName:"image.png")
                    }, to: self.URL)
                    
                    .response { response in
                        if response.response?.statusCode == 200{
                            //                            self.loginpage.toggle()
                            self.getfirebaseuser(USERID: UID, completion: {bool in
                                
                                if  bool == true {
                                    self.isRegistrationProcessComplete.toggle()
                                }
                            })
                            
                        }else{
                            
                            print("Some Error type shii")
                        }
                        
                    }
                    
                }
                
                
            }
            
        }catch{
            print("Failed")
        }
    }
    
    
    
    
    func getfirebaseuser(USERID:String, completion: @escaping (Bool) -> Void){
        AF.request("http://localhost:2001/User/Firebase/"+USERID).response { response in
            //            debugPrint(response)
            if let data = response.data {
                // Convert This in JSON
                do {
                    let UserDetails = try JSONDecoder().decode(UserDetailStruct.self, from: data)
                    var userinformation = [
                        "userName" : UserDetails.userName,
                        "email": UserDetails.email,
                        "firebaseID": UserDetails.firebaseID,
                        "profilePicture":UserDetails.profilePicture,
                        "userID":UserDetails.userID
                    ]
                    self.UserInfo = .init(data: userinformation)
                    print("Firebase User Info \(self.UserInfo)")
                    completion(true)
                }catch let error as NSError{
                    print(error)
                    completion(false)
                }
            }
            
        }
        
    }
    
    func getPostInformation(USERID:String){
        AF.request("http://localhost:2001/Post/"+USERID+"/search").response { response in
            if let data = response.data {
                // Convert This in JSON
                do {
                    let PostDetails = try JSONDecoder().decode(PostDetailsStruct.self, from: data)
                    var userinformation = [
                        "userModel" : User(userID: PostDetails.userModel.userID, userName: PostDetails.userModel.userName, email: PostDetails.userModel.email, firebaseID: PostDetails.userModel.firebaseID, profilePicture: PostDetails.userModel.profilePicture),
                        "postHeaderImage": PostDetails.postHeaderImage,
                        "postContent": PostDetails.postContent,
                        "postID":PostDetails.postID
                    ]
                    self.PostInfo = .init(data: userinformation)
                    print("Post Info \(self.PostInfo)")
                }catch let error as NSError{
                    print(error)
                }
            }
            
        }
        
    }
    
    
    func loginUser(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { Result, err in
            if let err = err {
                print("Wrong Login Infomation \(err)")
            }
            print("User Logged in \(Result?.user.uid ?? "" )")
            let LOGGEDUID = Result?.user.uid ?? ""
            self.getfirebaseuser(USERID: LOGGEDUID, completion: {
                bool in
                if bool == true {
                    self.isLoginProcessCompleteLoginView.toggle()
                }else{
                    self.ErrorMessage = "User does not exist"
                    print("User no exist")
                }
            })
            
        }
    }
    
    
    func getchatMessages(FROMID: String, TOID: String){
        let db = Firestore.firestore()
        db.collection("messages").document(FROMID).collection(TOID).order(by: "TIMESTAMP").addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("error getting chat: \(error)")
                return
            }
            print(querySnapshot?.documents)
            print("chatmessages")
            querySnapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    self.chatMessages.append(.init(documentId: change.document.documentID, data: data))
                }
            })
        }
    }
    
    
    
    
}


