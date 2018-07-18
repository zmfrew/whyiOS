//
//  PostController.swift
//  whyiOS
//
//  Created by Zachary Frew on 7/18/18.
//  Copyright © 2018 Zachary Frew. All rights reserved.
//

import Foundation

class PostController {
    
    // MARK: - Singleton
    static let shared = PostController()
    var posts: [Post] = []
    
    // MARK: - Properties
     static let baseURL = URL(string: "https://whydidyouchooseios.firebaseio.com")
// /reasons
    
    // MARK: - Methods
    func fetchPosts(completion: @escaping ((Bool) -> Void)) {
        guard let url = PostController.baseURL?.appendingPathComponent("reasons").appendingPathExtension("json") else { completion(false); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            guard let data = data else { completion(false); return}
            
            do {
                let decoder = JSONDecoder()
                let postsDict = try decoder.decode([String : Post].self, from: data)
                var posts: [Post] = []
                for (_, value) in postsDict {
                    posts.append(value)
                }
                self.posts = posts
                completion(true)
                
            } catch {
                print("Error decoding JSON: \(error.localizedDescription)")
                completion(false)
                return
            }
        }.resume()
    }
    
    func postReason(name: String, reason: String, cohort: String, completion: @escaping ((Bool) -> Void)) {
        guard let url = PostController.baseURL?.appendingPathComponent("reasons").appendingPathExtension("json") else { completion(false); return }
        
        let newPost = Post(name: name, reason: reason, cohort: cohort)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(newPost)
            request.httpBody = data
        } catch {
            print("Error occurred encoding JSON: \(error.localizedDescription)")
            completion(false)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                print("Error occurred sending the data: \(error.localizedDescription)")
                completion(false)
                return
            }
            self.posts.append(newPost)
            completion(true)
        }.resume()
    }
    
}
