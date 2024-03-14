//
//  FeedView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-27.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedView: View {
    @EnvironmentObject private var vm : UserCreationViewModel
    @State var ShowCommentArea = false
    @State var ShowAllCommentArea = false
    
    @State var StateTrackingLikeClick = 0
    @State var ShowChatArea = false
    @State private var likesCount: Int = 0
    
    @State var HaveiLikedThisPost = false
    @State var comment = ""
    
    @State var QuickComment = false
    
    var body: some View {
        
        if vm.Feed == nil {
            VStack{
                CustomNavHeader.redacted(reason: .placeholder)
                FeedView.redacted(reason: .placeholder)
            }
            
        }else{
            VStack(alignment: .center, spacing: 10) {
                CustomNavHeader.padding(.bottom, -20)
                FeedView
            }
        }
        
    }
    
    var FeedView: some View {
        ScrollView {
            
            ForEach(vm.Feed){
                info in
                VStack{
                    
                    VStack{
                        HStack{
                            WebImage(url: URL(string:  info.userModel.profilePicture))
                                .resizable()
                                .frame(width: 30, height: 30)
                                .scaledToFit()
                                .background(Color(.white))
                                .clipShape(Circle())
                            
                            Text(info.userModel.userName)
                            Spacer()
                        }.padding(.leading)
                        VStack{
                            
                            WebImage(url: URL(string: info.postHeaderImage))
                                .resizable()
                                .frame(width: 385, height: 400)
                                .scaledToFit()
                                .background(Color(.white))
                                .padding(.init(top: 5, leading: 5, bottom: 5, trailing: 5))
                                .cornerRadius(20)
                            
                            HStack {
                                Text(info.userModel.userName).font(.system(size: 16, weight: .semibold))
                                Text(info.postContent)
                                Spacer()
                            }.padding(.leading)
                        }.padding(.bottom)
                        
                        HStack(spacing:10){

                            //
                            Button(action: {
                                ShowCommentArea.toggle()
                                print(info.postID)
                                vm.PostUID = info.postID
                                print(vm.PostUID)
                                vm.getcomments(POSTID: info.postID)
                                
                            }) {
                                Image(systemName: "message").font(.system(size: 25)).foregroundColor(Color(.label))
                            }
                            .sheet(isPresented: $ShowCommentArea) {
                                vm.Comment = []
                                vm.PostUID = ""
                            } content: {
                                CommentView( )
                                    .presentationDetents([.large, .fraction(0.75)])
                            }
                            
                            Button(action: {}) {
                                Image(systemName: "paperplane").font(.system(size: 25)).foregroundColor(Color(.label))
                            }
                            Spacer()
                            
                        }.padding(.leading)

                        HStack {
                            if vm.UserInfo?.profilePicture != nil {
                                WebImage(url: URL(string:  vm.UserInfo?.profilePicture ?? ""))
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .scaledToFit()
                                    .background(Color(.white))
                                    .clipShape(Circle())
                                TextField("Add a comment", text: $comment, axis: .vertical).foregroundColor(.black)
                                    .onTapGesture(perform: {
                                        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
                                        
                                        QuickComment.toggle()
                                    })
                                Spacer()
                                
                                if QuickComment == true{
                                    Button {
                                        var postid = info.postID
                                        vm.PostUID = postid
                                        print("comment to this post \(postid)")
                                        vm.addcomment(USERID: vm.UserInfo?.userID ?? "", COMMENT: comment)
                                        comment = ""
                                        QuickComment = false
                                    } label: {
                                        Image(systemName: "paperplane.fill").foregroundColor(.blue).font(.system(size: 20)).padding(.trailing)
                                    }
                                }
                                
                                
                            }else{
                                
                            }
                        }.padding()
                    }
                    
                }.padding(.bottom)
            }
        }
        .refreshable {
            vm.Feed = []
            vm.getdata()
        }
        
    }
    var CustomNavHeader: some View {
        
        HStack(spacing: 15){
            Text("Thoughts 💭").font(.system(size: 24, weight: .semibold)).foregroundColor(.blue)
            Spacer()
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Image(systemName: "heart").font(.system(size: 24)).foregroundColor(Color(.label))
            })
            Button(action: {
                self.ShowChatArea.toggle()
            }
                   , label: {
                Image(systemName: "message").font(.system(size: 24)).foregroundColor(Color(.label))
            })
            
            .fullScreenCover(isPresented: $ShowChatArea, content: {
                ChatView().onAppear {
                    vm.getAllFollowers(USERID: vm.UserInfo?.userID ?? "0")
                }
                
                .onDisappear(perform: {
                    vm.Followers = []
                })
            })
            
        }.padding()
    }
    
    
}

#Preview {
    FeedView().environmentObject(UserCreationViewModel())
}
