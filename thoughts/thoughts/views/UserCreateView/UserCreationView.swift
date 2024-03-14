//
//  UserCreationView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-27.
//

import SwiftUI
import PhotosUI

struct UserCreationView: View {
    @StateObject private var vm = UserCreationViewModel()
    @State var avatarImage: UIImage?
    @State var ImageData: Image?
    @State var isImageSelectionVerified = true
    @State var photopickeritem: PhotosPickerItem?
    @State var username = ""
    @State var email = ""
    @State var password = ""
   
    
    @State var isLoading = false
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .center, spacing: 5){
                    //wrap image in a picker selector
                    PhotosPicker(selection: $photopickeritem, label: {
                        Image(uiImage: ((avatarImage ?? UIImage(named: "Image")!))).resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 200, height: 200, alignment: .center)
                            .background(Color.white)
                            .clipShape(Circle())
                            .font(.system(size: 20))
                            .padding()
                            
                    })
                    
                    
                  
                    Group{
                        TextField("Username", text: $username).padding().foregroundColor(Color.black)
                        TextField("Email", text: $email).padding().foregroundColor(Color.black)
                        TextField("Password", text: $password).padding().foregroundColor(Color.black)
                    }.background(Color.white).padding(5)
               
                    
                }/*.background(Color.gray)*/
                .onChange(of: photopickeritem) { _, _ in
//                    this track when any image data has been added to photoitem. Task is due to async try
                    Task{
                        if let photopickeritem,
                           let data = try? await photopickeritem.loadTransferable(type: Data.self){
                            if let image = UIImage(data: data){
                                avatarImage = image
                            }
                            print(data)
                       
                        }
                        
                        photopickeritem = nil
                    }
                    
                }
                
                Button {
                    Task {
                    if (avatarImage == nil) {
                        print("Cannot Sign up")
                        isImageSelectionVerified = false
                    }else {
                        print("sending data")
                        
                        guard let imagedata = avatarImage?.jpegData(compressionQuality: 0.8) else {return}
                        
                        
                        await vm.userregistration(EMAIL: email, USERNAME: username, PASSWORD: password, IMAGE: imagedata)
                        
                        
                        isLoading.toggle()
                        
                        
                    }
                    }
                    
                    
                } label: {
                    ZStack {
                        
                        HStack{
                           Spacer()
                            Text("Register").foregroundColor(Color.white).padding(.vertical).font(.system(size: 16, weight: .semibold))
                            Spacer()
                            
                            
                            
                        }.background(Color.blue)
                        
                        if isLoading == true{
                            ProgressView()
                            .progressViewStyle(CircularProgressViewStyle()).tint(.black)
                            .scaleEffect(2)
                        }
                        
                    }
                    
                }.padding(5)

                if isImageSelectionVerified == false{
                    Text("cannot signup complete all fields").foregroundColor(.red)
                }
                
                Button {
                    vm.loginpage.toggle()
                } label: {
                    Text("Already a user? Login here")
                }
                
                
                
            }
            
            .background(Color(.init(white: 0,alpha:0.05))).ignoresSafeArea()
        }.padding().background(Color(.init(white: 0,alpha:0.05)))
        
            .fullScreenCover(isPresented: $vm.isRegistrationProcessComplete, content: {
            ContentView()
        })
            .fullScreenCover(isPresented: $vm.loginpage, onDismiss: {
            
        }, content: {
            LoginView()
        })
        
        .environmentObject(vm)
    }
}

#Preview {
    UserCreationView()
}
