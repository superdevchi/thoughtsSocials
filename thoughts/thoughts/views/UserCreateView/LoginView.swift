//
//  LoginView.swift
//  thoughts
//
//  Created by chibuike on 2024-03-06.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var vm: UserCreationViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var username = ""
    @State var password = ""
    
    @State var isbuttonclicked = false
    var body: some View {
        
        Header
        ScrollView{
            
            VStack(alignment: .center){
                TextField("Email", text: $username).padding().foregroundColor(Color.black)
                Divider()
                TextField("Password", text: $password).padding().foregroundColor(Color.black)
            }.background(Color.white).padding(5)
            
            ZStack {
                Button(action: {
                    vm.loginUser(email: username, password: password)
                    isbuttonclicked.toggle()
                }, label: {
                    Text("Login")
            }).frame(width: 200, height: 50).background(Color.blue).foregroundColor(.white).cornerRadius(5)
                
                if isbuttonclicked == true {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(2)
                }
               
            }
            
            Text(vm.ErrorMessage).foregroundColor(.red)
        }
        .offset(y: 250)
        .background(Color(.init(white: 0,alpha:0.05)))
        .fullScreenCover(isPresented: $vm.isLoginProcessCompleteLoginView) {
            ContentView()
        }
        
        .background(Color(.init(white: 0,alpha:0.05)))
    }
    
    
    
    var Header: some View {
        HStack{
            Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")
            }).font(.system(size: 25)).foregroundColor(.red).padding(.leading)
            
            Spacer()
        }
//        .background(Color(.init(white: 0,alpha:0.05)))
    }
}

#Preview {
    LoginView().environmentObject(UserCreationViewModel())
}
