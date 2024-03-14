//
//  SearchChat.swift
//  thoughts
//
//  Created by chibuike on 2024-03-03.
//

import SwiftUI

struct SearchChat: View {
    @EnvironmentObject var vm: UserCreationViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var chatText: String = ""
    @State var username: String = ""
    @State var toid: String = ""
    var body: some View {
        VStack{
            SearchHeaderView
            SearchmessagesView
            sendTextField
        }
        
        .onDisappear(perform: {
            vm.chatMessages = []
        })

    }
    
    var SearchHeaderView: some View {
        HStack {
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
            }).font(.system(size: 25)).foregroundColor(.red).padding(.leading)
            
            Text(username)
            Spacer()
        
        }
    }
    
    private var sendTextField: some View{
        
        HStack(spacing: 16){
            Image(systemName: "photo.on.rectangle").font(.system(size: 24)).foregroundColor(Color(uiColor: .label))
            TextField("Description", text: $chatText)
            Button(action: {
                vm.sendmessage(FROMID: vm.UserInfo?.userID ?? "0", TOID: toid, MESSAGE: chatText)
                
                self.chatText = ""
            }, label: {
                Text("send")
            }).background().padding(.trailing).font(.system(size: 20))
            
        }.padding(.top)
            .padding(.horizontal)
    }
    
    
    private var SearchmessagesView: some View {
        ScrollView {
            
            ForEach(vm.chatMessages){
                chat in
                VStack{
                    if chat.FROMID == vm.UserInfo?.userID{
                        HStack {
                            Spacer()
                            HStack {
                                Text(chat.MESSAGE)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(8)
                        }
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
                        }
                    }
                    
//                    HStack{Spacer()}
//                        .id("Empty")
                }
            }
        }

    }

}

#Preview {
    SearchChat().environmentObject(UserCreationViewModel())
}
