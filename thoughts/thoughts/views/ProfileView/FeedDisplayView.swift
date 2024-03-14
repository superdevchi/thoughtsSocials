//
//  FeedDisplayView.swift
//  thoughts
//
//  Created by chibuike on 2024-03-09.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedDisplayView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var vm: UserCreationViewModel
    @State var comment = ""
    @State var likecount = 0
    @State var commentcount = 0
    @State var haveilikedpost = false
    var body: some View {
        VStack{
            HeaderView.padding(.bottom)
            FeedPreview
            AddCommentView
        }    }
    
    var FeedPreview: some View {
        ScrollView{
            
            if vm.PostInfo != nil {
                VStack{
                    HStack{
                        WebImage(url: URL(string: vm.PostInfo?.userModel.profilePicture ?? ""))
                            .resizable()
                            .frame(width: 30, height: 30)
                            .scaledToFit()
                            .background(Color(.red))
                            .clipShape(Circle()).padding(.leading, 4)
                        Text(vm.PostInfo?.userModel.userName ?? "").font(.system(size: 16, weight: .medium))
                        Spacer()
                    }
                }
                
                VStack{
                    WebImage(url: URL(string: vm.PostInfo?.postHeaderImage ?? ""))
                        .resizable()
                        .frame(width: 400, height: 450)
                        .scaledToFill()
                }

                VStack(alignment: .leading) {
                    
                    HStack {
                        Text(vm.PostInfo?.postContent ?? "").padding()
                        Spacer()
                    }
//                    Spacer()
                }
                Divider()
                
                HStack(spacing:10){
                    Spacer()
                    Button(action: {
                        if haveilikedpost != true {
                            vm.addlike(USERID: vm.UserInfo?.userID ?? "", POSTID: vm.PostInfo?.postID ?? "", completion: { bool in
                                
                                if bool == true {
                                    haveilikedpost.toggle()
                                    self.likecount = +1
                                    print("Add Liked")
                                }
                                
                            })
                        }else{
                            print("do nothing")
                        }
                      
                    }) {
                        VStack {
                            if haveilikedpost != true{
                                Image(systemName: "heart").font(.system(size: 20)).foregroundColor(Color(.label))
                            }else{
                                Image(systemName: "heart.fill").font(.system(size: 20)).foregroundColor(Color.red)
                            }
                            
                            Text("\(likecount) Likes").font(.system(size: 15)).foregroundColor(Color(.label))
                        }
                    }
                    Spacer()
                    Button(action: {
                    }) {
                        VStack {
                            Image(systemName: "message").font(.system(size: 20)).foregroundColor(Color(.label))
                            Text("\(commentcount) Comments").font(.system(size: 15)).foregroundColor(Color(.label))
                        }
                    }
                    Spacer()
                    Button(action: {}) {
                        VStack {
                            Image(systemName: "paperplane").font(.system(size: 20)).foregroundColor(Color(.label))
                            Text("Shared").font(.system(size: 15)).foregroundColor(Color(.label))
                        }
                    }
                    Spacer()
                    
                }.onAppear(perform: {
                    
                    vm.getAllPostLikeCount(POSTID: vm.PostInfo?.postID ?? "", completion: { count in
                        DispatchQueue.main.async {
                            likecount = count
                        }
                    })
                    vm.getAllPostCommentCount(POSTID: vm.PostInfo?.postID ?? "", completion: { count in
                        DispatchQueue.main.async {
                            commentcount = count
                        }
                    })
                    vm.didilikethispost(USERID: vm.UserInfo?.userID ?? "", POSTID: vm.PostInfo?.postID ?? "", completion: {
                        bool in
                        if bool == true {
                            haveilikedpost.toggle()
                        }
                    })
                })

                Divider()
               
                VStack{
                    if vm.Comment != nil{
                        ForEach(vm.Comment){
                            comment in
                            
                            let username = comment.userModel.userName
                            let comments = comment.comment
                            var url = comment.userModel.profilePicture
                            
                            
                            
            //                Divider()
                            HStack(spacing: 5){
                                
                                WebImage(url: URL(string:  url))
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .scaledToFit()
                                    .background(Color(.white))
                                    .clipShape(Circle())
                                VStack(alignment: .leading){
                                    Text(username)
                                    Text(comments)
                                }
                                Spacer()
                                
                            }.padding()
                        }
                    }else{
                        Text("No Comment")
                    }
                }
            }else{
                Text("No Post")
            }
            
        }
    }
    
    var HeaderView: some View {
        HStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
            }).font(.system(size: 25)).foregroundColor(.red).padding(.leading)
            Spacer()
        }
    }
    
    var AddCommentView: some View {
        
        var userid = vm.UserInfo?.userID ?? ""
        let userprofilepicture = vm.UserInfo?.profilePicture ?? ""
        
        return HStack(spacing: 5){
            Group{
                WebImage(url: URL(string:  userprofilepicture))
                    .resizable()
                    .frame(width: 40, height: 40)
                    .scaledToFit()
                    .background(Color(.white))
                    .clipShape(Circle())
                HStack{
                    TextField("Add a comment", text: $comment, axis: .vertical).foregroundColor(.black)
                    
                    Button(action: {
                        vm.addcomment(USERID: userid, COMMENT: comment)
                        comment = ""
                    }, label: {
                        Text("POST")
                    })
                }
                
            }
            
        }.padding()
        
    }
}

#Preview {
    FeedDisplayView().environmentObject(UserCreationViewModel())
}
