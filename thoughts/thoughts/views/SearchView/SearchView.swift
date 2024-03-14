//
//  SearchView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-27.
//

import SwiftUI
import SDWebImageSwiftUI

struct SearchView: View {
    @EnvironmentObject var vm : UserCreationViewModel
    @State var Users = [UserDetailStruct]()
    @State var Search = ""
    var body: some View {
        
        var filteredResorts: [UserDetailStruct] {
            if Search.isEmpty {
                return []
            } else {
                return vm.Users.filter { $0.userName.localizedCaseInsensitiveContains(Search) }
            }
        }
        
        
        NavigationView {
            
            ScrollView{
                
                VStack{
                    ForEach(filteredResorts){
                        info in
                        
                        HStack{
                            //                            Text(info.userID)
                            NavigationLink(destination: DiscoverView().onAppear(perform: {
                                vm.getsearcheduser(USERID: info.userID)
                            }).onDisappear(perform: {
                                vm.SearchedUserInfo = nil
                            })) {
//                                AsyncImage(url: URL(string: info.profilePicture)).frame(width: 50, height: 50).background(Color.white).clipShape(.circle).padding(.leading, 5)
//                                
                                WebImage(url: URL(string: info.profilePicture))
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .scaledToFit()
                                    .background(Color(.white))
                                    .clipShape(Circle())
                                    .padding(.leading, 5)
                                
                                VStack(alignment: .leading){
                                    Text(info.userName).foregroundColor(.black)
//                                    Text("following or not").foregroundColor(.black)
                                }.padding(.vertical)
                            }

                            Spacer()
                        }
                        
                        
                    }
                    
                }
                
            }
            .searchable(text: $Search, prompt: "Looking For Someone?").foregroundColor(.black).background(.white)
            .navigationBarTitleDisplayMode(.inline)
        }
        
        
    }
}

#Preview {
    SearchView().environmentObject(UserCreationViewModel())
}
