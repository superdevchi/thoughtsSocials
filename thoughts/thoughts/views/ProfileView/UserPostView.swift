//
//  UserPostView.swift
//  thoughts
//
//  Created by chibuike on 2024-02-18.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserPostView: View {
    @EnvironmentObject var vm : UserCreationViewModel
    @State var DisplayPost = false
    
    private var data: [Int] = Array(1...5)
    private let adaptiveColumn = [GridItem(.flexible()),GridItem(.flexible())
    ]
    var body: some View {
        ScrollView{
            LazyVGrid(columns: adaptiveColumn){
                ForEach(vm.UserPostList){ info in

                    Button(action: {
                        vm.getPostInformation(USERID: info.postID)
                        vm.PostUID = info.postID
                        vm.getcomments(POSTID: info.postID)
                        self.DisplayPost.toggle()
                    }, label: {
                        WebImage(url: URL(string: info.postHeaderImage))
                            .resizable()
                            .scaledToFill()
//                            .frame(width: 100, height: 100)
                    }).frame(maxWidth: .infinity).background(Color.white)
                    .fullScreenCover(isPresented: $DisplayPost, onDismiss: {
                        vm.Comment = []
                        vm.PostInfo = nil
                    }, content: {
                        FeedDisplayView()
                    })
                }
            }
        }
        
    }
}

#Preview {
    UserPostView().environmentObject(UserCreationViewModel())
}
