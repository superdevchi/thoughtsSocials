//
//  CreateView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-27.
//

import SwiftUI
import PhotosUI
import SDWebImageSwiftUI

struct CreateView: View {
    
    @State var thoughts = ""
    @State var avatarImage: UIImage?
    @State var isImageSelected = false
    @State var isposting = false
    
    private var maxHeight : CGFloat = 300
    @State private var textEditorHeight : CGFloat = 50
    
    @FocusState var isInputActive: Bool
    
    @State var photopickeritem: PhotosPickerItem?
    @State var isPickerDisplayed = false
    
    @EnvironmentObject var vm : UserCreationViewModel
    
    @StateObject var mainvm = CreateViewModel()
    
    var body: some View {
        
        if vm.UserInfo == nil {
            CreatePostView
                .redacted(reason: .placeholder)
        }else{
            CreatePostView
        }
    }
    
    var CreatePostView: some View {
        
        ScrollView{
            
            ZStack {
                VStack(alignment: .center){
                    
                    
                    HStack(spacing: 5){
                        //
                        let imageurl = vm.UserInfo?.profilePicture ?? ""
                        WebImage(url: URL(string: imageurl))
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipped()
                            .cornerRadius(40)
                            .overlay(RoundedRectangle(cornerRadius: 44)
                                .stroke(Color(.label), lineWidth: 0.2)
                            )
                            .shadow(radius: 2.5).foregroundColor(Color(uiColor: .label))
                        Spacer()
                        
                        PhotosPicker(selection: $photopickeritem) {
                            Image(systemName: "plus").font(.system(size: 20)).padding(.leading, 30) 
                        }
                        
                        
                        //                    .frame(height: 100, alignment: .center)
                    }.onChange(of: photopickeritem) { _, _ in
                        //                    this track when any image data has been added to photoitem. Task is due to async try
                        Task{
                            if let photopickeritem,
                               let data = try? await photopickeritem.loadTransferable(type: Data.self){
                                if let image = UIImage(data: data){
                                    
                                    avatarImage = image
                                    isImageSelected = true
                                    
                                }
                                
                            }
                            photopickeritem = nil
                        }
                        
                    }
                    .padding(.trailing)
                    
                    VStack {
                        TextField("What's Up! \(vm.UserInfo?.userName ?? "Sir")", text: $thoughts, axis: .vertical)
                            .font(.system(size: 20))
                    }.padding(.trailing).padding(.top)
                    
                    if isImageSelected == true {
                        VStack{
                            Image(uiImage: avatarImage ?? UIImage(systemName: "person.fill")! ).resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 350, height: 350, alignment: .center)
                                .cornerRadius(3)
                        }.padding(.top)
                    }
                    
                    if isposting == true {
                        ProgressView()
                        .progressViewStyle(CircularProgressViewStyle()).tint(.black)
                        .scaleEffect(2)
                    }
                    
                }
            }
        
        }.padding()
            .overlay(alignment: .bottom) {
                if avatarImage == nil {
                    
                }else{
                    Button(action: {
                        if thoughts.isEmpty{
                            print("Must Add A Thought")
                        }else{
                            guard let imagedata = avatarImage?.jpegData(compressionQuality: 0.8) else {return}
                            guard let UID = vm.UserInfo?.userID  else {return}
                            mainvm.createPost(Content: self.thoughts, Image: imagedata, UID: UID, completion: {
                                done in
                                
                                if done == true {
                                    self.isposting = false
                                }
                            })
                            
                            
                            
                            self.isposting.toggle()
                            self.thoughts = ""
                            self.avatarImage = nil
                            self.isImageSelected = false
                        }
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Share").foregroundColor(.white).padding(.vertical).cornerRadius(5)
                            Spacer()
                        }.background(Color.blue).padding()
                        
                    })
                }
          
            }
    }
    
    var dataloading: some View {
        HStack{
            Text("Data loading..")
            Text("Error Screen Coming Soon ..")
        }
        
    }
}



#Preview {
    CreateView().environmentObject(UserCreationViewModel())
}
