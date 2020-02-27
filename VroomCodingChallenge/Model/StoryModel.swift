//
//  StoryModel.swift
//  VroomCodingChallenge
//
//  Created by Rahul Sharma on 2/26/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation

// The model of the story object returned from the API
struct Story: Codable {
    let by: String
    let score: Int
    let title: String
    let url: String
}
