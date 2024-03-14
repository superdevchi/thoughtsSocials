//
//  ProfileView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-27.
//

import SwiftUI
import SlidingTabView
import SDWebImageSwiftUI



struct ProfileView: View {
    @State var userpostcount = 0;
    @State var followercount = 0;
    @State private var selectedTabIndex = 0
    @EnvironmentObject var vm: UserCreationViewModel
    var body: some View {
        if vm.UserInfo == nil {
//            dataloading
            ProfileView.redacted(reason: .placeholder)
//            ProgressView()
        }else{
            ProfileView
        }
        
        
    }
    
    var ProfileView: some View {
        ScrollView{
            VStack{
                
                VStack(alignment: .center, spacing: 3) {
                    VStack{
                        if vm.UserInfo?.profilePicture == nil {
                            Image(systemName: "person").frame(width: 150, height: 150).background(Color.white).clipShape(Circle())
                        }else{
                            WebImage(url: URL(string: vm.UserInfo?.profilePicture ?? ""))
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 150)
                                .clipShape(Circle())
                        }
                        Text(vm.UserInfo?.userName ?? "no name yet")
//                        Text("bio")
                        
//                        Spacer()
                        
                        HStack(spacing: 20){
                            VStack{
                                Text("\(userpostcount)")
                                Text("Posts")
                            }
                            VStack{
                                Text("\(followercount)")
                                Text("Friends")
                            }
                            
//                            Spacer()
                        }.padding()
                        
                    }.padding()
                }
    
                Divider()
            }
            //           --------------------------------------
            //            Text("hello World")
            TabView
        }
        .onAppear(perform: {
            vm.getAllUserPostCount(USERID: vm.UserInfo?.userID ?? "0") { Int in
                DispatchQueue.main.async {
                    self.userpostcount = Int
                }
            }
            
            vm.getAllUserFollowersCount(USERID: vm.UserInfo?.userID ?? "0") { Int in
                DispatchQueue.main.async {
                    self.followercount = Int
                }
            }
        })
    }
    
    //loading
    var dataloading: some View {
        HStack{
            Text("Data loading..")
            Text("Error Screen Coming Soon ..")
        }
       
    }

    
    
    
    var TabView: some View{
        VStack{
            SlidingTabView(selection: $selectedTabIndex, tabs: ["Post","Tagged"])
            Spacer()
            if selectedTabIndex == 0{
                UserPostView().onAppear(perform: {
                    vm.getAllUserPost(USERID: vm.UserInfo?.userID ?? "")
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
    ProfileView().environmentObject(UserCreationViewModel())
}
