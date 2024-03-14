//
//  ProfileView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-27.
//

import SwiftUI
import SlidingTabView
import SDWebImageSwiftUI



struct DiscoverView: View {
    @State var userpostcount = 0;
    @State var followercount = 0;
    @State var amifollowing = false;
    @State private var selectedTabIndex = 0
    @EnvironmentObject var vm: UserCreationViewModel
    
    @State var follow: String = "FOLLOW"
    @State var messageview = false
    var body: some View {
        if vm.SearchedUserInfo == nil {
            //            dataloading
            DiscoverView.redacted(reason: .placeholder)
            ProgressView()
        }else{
            DiscoverView
        }
        
        
        
        
    }
    
    var DiscoverView: some View {
        
        ScrollView{
            VStack{
                VStack(alignment: .center, spacing: 3) {
                    VStack{
                        Text(vm.SearchedUserInfo?.userName ?? "None")
                        
                        VStack {
                            if vm.SearchedUserInfo?.profilePicture == nil {
                                Image(systemName: "person").frame(width: 150, height: 150).background(Color.white).clipShape(Circle())
                            }else{
                                WebImage(url: URL(string: vm.SearchedUserInfo?.profilePicture ?? ""))
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 150, height: 150)
                                    .clipped()
                                    .clipShape(Circle())
                            }
                            
                        }
                        
                        
                        HStack(spacing: 10){
                            VStack{
                                Text("\(self.userpostcount)")
                                Text("Posts")
                            }
                            
                            VStack{
                                Text("\(self.followercount)")
                                Text("Friends")
                            }
                        }
                        
                    }
                    
                    
                }
                
                HStack{
                    Spacer()
                    Button(action: {
                        if amifollowing == true{
                            
                        }else{
                            vm.addFollower(USERID: vm.UserInfo?.userID ?? "0", FOLLOWERID: vm.SearchedUserInfo?.userID ?? "0")
                            
                            self.follow = "FOLLOWING"
                        }
                        
                    }, label: {
                        if amifollowing == true{
                            Text("FOLLOWING").font(.system(size: 16)).padding().foregroundColor(.white)
                        }else{
                            Text(follow).font(.system(size: 16)).padding().foregroundColor(.white)
                        }
                    }).frame(width: 150).background(Color.blue).cornerRadius(5).padding(.leading)
                    Spacer()
                    
                    
                    
                }
                
            }
            .onAppear(perform: {
                vm.getAllUserPostCount(USERID: vm.SearchedUserInfo?.userID ?? "0") { Int in
                    
                    DispatchQueue.main.async {
                        self.userpostcount = Int
                    }
                    
                }
                
                vm.getAllUserFollowersCount(USERID: vm.SearchedUserInfo?.userID ?? "0") { Int in
                    DispatchQueue.main.async {
                        self.followercount = Int
                    }
                }
                
                vm.doifollowthisuser(USERID: vm.UserInfo?.userID ?? "0", FOLLOWERID: vm.SearchedUserInfo?.userID ?? "0") { Bool in
                    DispatchQueue.main.async {
                        self.amifollowing = Bool
                    }
                }
            })
            
            
            //           --------------------------------------
            //            Text("hello World")
            TabView.padding(.top)
        }
    }
    
    
    var TabView: some View{
        VStack{
            SlidingTabView(selection: $selectedTabIndex, tabs: ["Post","Tagged"])
            Spacer()
            if selectedTabIndex == 0{
                UserPostView().onAppear(perform: {
                    vm.getAllUserPost(USERID: vm.SearchedUserInfo?.userID ?? "")
                }).onDisappear(perform: {
                    vm.UserPostList = []
                })
            }else if selectedTabIndex == 1 {
                Text("No Tagged Post")
            }
            Spacer()
        }
    }
    
}

#Preview {
    DiscoverView().environmentObject(UserCreationViewModel())
}

