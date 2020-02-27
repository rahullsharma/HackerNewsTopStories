//
//  HackerNewsViewModel.swift
//  VroomCodingChallenge
//
//  Created by Rahul Sharma on 2/26/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

/*
 * To get the top stories for HN, we need to first get their respective ids, then make a request to get
 * the story information with the id
 */

class TopStoriesViewModel {
    
    // store the ids and Story object returned from the API
    var ids: [Int] = []
    var stories: [Story] = []
    
    func getStoryIDs(_ completion: @escaping ([Int]?, Error?) -> Void) {
        let baseURL = "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty"
        let decoder = JSONDecoder()
        guard let url = URL(string: baseURL) else {
            preconditionFailure("Failed to construct URL for top stories ids")
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
            }
            else {
                if let data = data {
                    switch Result(catching: {
                        try decoder.decode([Int].self, from: data)
                        }) {
                        case .success(let json):
                            DispatchQueue.main.async {
                                self?.ids = json
                                completion(self?.ids, nil)
                            }
                        case .failure(let error):
                            completion(nil, error)
                        }
                }
                else {
                    print("Service returning no data")
                    completion(nil, error)
                }
            }
        }.resume()
    }
    
    func getStoryData(story: Int, _ completion: @escaping ([Story]?, Error?) -> Void) {
        let baseURL = "https://hacker-news.firebaseio.com/v0/item/\(story).json?print=pretty"
        let decoder = JSONDecoder()
            guard let url = URL(string: baseURL) else {
                preconditionFailure("Failed to construct URL for top stories data")
            }
        URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
               if let error = error {
                   print(error.localizedDescription)
                   completion(nil, error)
               }
               else {
                   if let data = data {
                       switch Result(catching: {
                           try decoder.decode(Story.self, from: data)
                       }) {
                           case .success(let json):
                               DispatchQueue.main.async {
                                   self?.stories += [json]
                                   completion(self?.stories, nil)
                               }
                           case .failure(let error):
                               completion(nil, error)
                           }
                   }
                   else {
                       print("Service returning no data")
                       completion(nil, error)
                   }
               }
           }.resume()
    }
}
