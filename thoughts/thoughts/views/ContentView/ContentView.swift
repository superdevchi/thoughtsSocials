//
//  ContentView.swift
//  thoughts
//
//  Created by chibuike on 2024-01-26.
//

import SwiftUI
import SDWebImageSwiftUI



struct ContentView: View {
    @EnvironmentObject private var vm : UserCreationViewModel
    
    var body: some View {
        
        VStack {
            //                CustomNavHeader
            TabView{
                Group{
                    FeedView().onAppear(perform: {
                        vm.getdata()
                    }).onDisappear(perform: {
                        vm.Feed = []
                    })
                    .tabItem {
                        Image(systemName: "house.fill").font(.system(size: 20)).foregroundColor(Color(.label))
                    }
                    SearchView().onDisappear(perform: {
                        vm.Users = []
                    }).onAppear(perform: {
                        vm.getallusers()
                    })
                    .tabItem {
                        Image(systemName: "magnifyingglass").font(.system(size: 20)).foregroundColor(Color(.label))
                    }
                    CreateView()
                        .tabItem {
                            Image(systemName: "plus.app").font(.system(size: 20)).foregroundColor(Color(.label))
                        }
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle.fill").font(.system(size: 20)).foregroundColor(Color(.label))
                        }
                }
                
            }
            
            
        }
        .environmentObject(vm)
    }
    
    
}

#Preview {
    ContentView().environmentObject(UserCreationViewModel())
}
