//
//  ChatView.swift
//  thoughts
//
//  Created by chibuike on 2024-02-24.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatView: View {
    
    @EnvironmentObject var vm: UserCreationViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var chatnewuser = false
    var body: some View {
        NavigationView {
            VStack{
                HeaderView
    //            StoryView
//                MessageListView.padding()
                FriendList
            }
        }
    }
    
    
    var HeaderView: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
            }).font(.system(size: 25)).foregroundColor(.red).padding(.leading)
            
            Text(vm.UserInfo?.userName ?? "Username").font(.system(size: 24, weight: .semibold))
            Spacer()
//            Button(action: {
//                self.chatnewuser.toggle()
//            }, label: {
//                Image(systemName: "square.and.pencil")
//            }).frame(width: 50, height: 50).font(.system(size: 25)).foregroundColor(.red)
        }
        .fullScreenCover(isPresented: $chatnewuser, content: {
            ChatUserListView().onAppear(perform: {
                
            }).onDisappear(perform: {
                vm.Followers = []
            })
        })
    }
    
    var StoryView: some View{
        LazyVStack(alignment: .leading) {
            ScrollView(.horizontal){
                HStack {
                    
                    
                    Button(action: {}, label: {
                        WebImage(url: URL(string: vm.UserInfo?.profilePicture ?? "")).frame(width: 80, height: 80).background(Color(.white)).clipShape(Circle())
                    })
                    LazyHStack {
                        ForEach(1..<2){_ in
                            Image(systemName: "person.fill").frame(width: 80, height: 80).background(Color(.white)).clipShape(Circle())
                        }
                    }
                }
            }
        }
    }
    
    var FriendList: some View {
        List{
            ForEach(vm.Followers){ followers in
                    NavigationLink {
                        ChatArea(username: followers.follower.userName, uid: followers.follower.userID ).onDisappear(perform: {
                            vm.chatMessages = []
                        })
                    } label: {
                        
                            HStack{
                                WebImage(url:URL( string: followers.follower.profilePicture ))
                                    .resizable()
                                    .frame(width: 50, height: 50).background(Color(.white)).clipShape(Circle())
                                Text(followers.follower.userName).font(.system(size: 20)).foregroundColor(.black)
                                Spacer()
                            }.padding(.leading, 5)

                        }
                    }

        }
    }
    
    var MessageListView: some View {
        
        
        ScrollView{
            VStack(alignment: .leading){
        ForEach(vm.Followers){ followers in
                NavigationLink {
                    ChatArea(username: followers.follower.userName, uid: followers.follower.userID ).onDisappear(perform: {
                        vm.chatMessages = []
                    })
                } label: {
                    
                        HStack{
                            WebImage(url:URL( string: followers.follower.profilePicture ))
                                .resizable()
                                .frame(width: 50, height: 50).background(Color(.white)).clipShape(Circle())
                            Text(followers.follower.userName).font(.system(size: 20)).foregroundColor(.black)
                            Spacer()
                        }.padding(.leading, 5)

                    }
                }

               
            }
        }
    }

}

#Preview {
    ChatView().environmentObject(UserCreationViewModel())
}
