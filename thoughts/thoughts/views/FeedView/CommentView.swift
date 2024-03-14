//
//  CommentView.swift
//  thoughts
//
//  Created by chibuike on 2024-02-10.
//

import SwiftUI
import SDWebImageSwiftUI

struct CommentView: View {
    @EnvironmentObject var vm : UserCreationViewModel
    @State var comment: String = ""
    
    
    
    
    var body: some View {
        VStack{
            if vm.Comment == nil {

                CommentListView.redacted(reason: .placeholder)
            }else{
                CommentListView
            }
            Spacer()
//            Divider()
            AddCommentView
        }.onAppear(perform: {
//            vm.getcomments(POSTID: postid)
        })
        
    }
    
    var CommentNotLoaded: some View {
        Text("Getting Comment")
    }
    
    var CommentListView: some View {
        ScrollView{
            
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
        }
        
        
    }
    
    var AddCommentView: some View {
        
        var userid = vm.UserInfo?.userID ?? ""
        let userprofilepicture = vm.UserInfo?.profilePicture ?? ""
        
        return HStack(spacing: 5){
            Group{
                WebImage(url: URL(string:  userprofilepicture))
                    .resizable()
                    .frame(width: 30, height: 30)
                    .scaledToFit()
                    .background(Color(.white))
                    .clipShape(Circle())
                HStack{
                    TextField("Add a comment", text: $comment, axis: .vertical).foregroundColor(.black)
                    
                    Button(action: {
                        vm.addcomment(USERID: userid, COMMENT: comment)
                        comment = ""
                    }, label: {
                        Image(systemName: "paperplane.fill").font(.system(size: 20))
                    })
                }
                
            }
            
        }.padding()
        
    }
}

#Preview {
    CommentView().environmentObject(UserCreationViewModel())
    //    FeedView()
}
