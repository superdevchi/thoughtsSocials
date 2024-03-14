//
//  ChatUserListView.swift
//  thoughts
//
//  Created by chibuike on 2024-03-03.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatUserListView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var Search: String = ""
    
    @EnvironmentObject var vm : UserCreationViewModel
    var body: some View {
        NavigationView {
            VStack{
//                MessageListView
                FriendsList
            }
            .searchable(text: $Search, prompt: "Looking For Someone?").foregroundColor(.black).background(.white)
            
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        Image(systemName: "chevron.backward")
                    }).font(.system(size: 20)).foregroundColor(.red)
                    
                }
                
            }
        }
    }
    
    var FriendsList: some View {
        List{
            ForEach(vm.Followers){ followers in
                    NavigationLink {
                        ChatArea(username: followers.follower.userName, uid: followers.follower.userID )
                    } label: {
                        
                            HStack{
                                WebImage(url:URL( string: followers.follower.profilePicture )).frame(width: 50, height: 50).background(Color(.red)).clipShape(Circle())
                                Text(followers.follower.userName).padding(.bottom).font(.system(size: 20))
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
                    ChatArea(username: followers.follower.userName, uid: followers.follower.userID )
                } label: {
                    
                        HStack{
                            WebImage(url:URL( string: followers.follower.profilePicture )).frame(width: 50, height: 50).background(Color(.red)).clipShape(Circle())
                            Text(followers.follower.userName).padding(.bottom).font(.system(size: 20))
                            Spacer()
                        }.padding(.leading, 5)

                    }
                }

               
            }
        }
    }
}

#Preview {
    ChatUserListView().environmentObject(UserCreationViewModel())
}
