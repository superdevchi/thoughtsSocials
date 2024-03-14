//
//  ChatArea.swift
//  thoughts
//
//  Created by chibuike on 2024-03-03.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatArea: View {
    @State var chatText: String = ""
    @State var username: String = ""
    @State var uid: String = ""
    @EnvironmentObject var vm: UserCreationViewModel
    var body: some View {
        
        VStack{
            messagesView.safeAreaInset(edge: .bottom) {
                sendTextField
            }
            
        }
       
       
        .navigationTitle("\(username)")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear(perform: {
            vm.getchatMessages(FROMID: vm.UserInfo?.userID ?? "0", TOID: uid)
        })
        .onDisappear(perform: {
            vm.chatMessages = []
        })
    }
    
    private var sendTextField: some View{
        
        HStack(spacing: 16){
            WebImage(url: URL(string:  vm.UserInfo?.profilePicture ?? "" ))
                .resizable()
                .frame(width: 30, height: 30)
                .scaledToFit()
                .background(Color(.white))
                .clipShape(Circle())
            
            TextField("✍🏻", text: $chatText, axis: .vertical).font(.system(size: 15, weight: .semibold))
            Button(action: {
                vm.sendmessage(FROMID: vm.UserInfo?.userID ?? "0" , TOID: uid, MESSAGE: chatText)
                
                self.chatText = ""
            }, label: {
                Text("send")
            }).background().padding(.trailing).font(.system(size: 20))
            
        }.padding(.top)
            .padding(.horizontal)
    }
    
    
    private var messagesView: some View {
        ScrollView {
            
            ForEach(vm.chatMessages){
                chat in
                VStack{
                    if chat.FROMID == vm.UserInfo?.userID{
                        HStack {
                            Spacer()
                            HStack {
                                Text(chat.MESSAGE)
                                    .foregroundColor(.white)
                                    
                            }
                            .padding(.trailing)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                        }.padding(.horizontal).padding()
                    }else{
                        HStack {
                            HStack {
                                Text(chat.MESSAGE)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            Spacer()
                        }.padding(.horizontal).padding()
                    }
                    
//                    HStack{Spacer()}
//                        .id("Empty")
                }
            }
        }
        
    }
    
    
    
}

#Preview {
    ChatArea().environmentObject(UserCreationViewModel())
}
