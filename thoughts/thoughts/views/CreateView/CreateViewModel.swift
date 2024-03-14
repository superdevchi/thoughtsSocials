//
//  CreateViewModel.swift
//  thoughts
//
//  Created by chibuike on 2024-02-03.
//

import Foundation
import Alamofire

class CreateViewModel: ObservableObject{
    
    
    
    @Published var userinfo:UserDetailStruct?
    
    
  

        
    func createPost(Content: String,Image: Data,UID:String, completion: @escaping (Bool) -> Void){
        print("Posting Thought")
        var URL = "http://localhost:2001/Post/"+UID+"/create"
        AF.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(Data(Content.utf8), withName: "postContent")
            multipartFormData.append(Image, withName:"ImageFile",fileName:"image.png")
        }, to: URL)
        .responseDecodable(of: PostDetails.self) { response in
            if response.response?.statusCode == 200{
               
                if let data = response.data {
                    // Convert This in JSON
                    do {
                        let UserDetails = try JSONDecoder().decode(PostDetails.self, from: data)
                        
                        print("Data saved to \(UserDetails)")
                        completion(true)
                    }catch let error as NSError{
                        print(error)
                        completion(false)
                    }
                }

            }else{
                
                print(response.error)
                completion(false)
            }
            
        }
       
    }
    
}
