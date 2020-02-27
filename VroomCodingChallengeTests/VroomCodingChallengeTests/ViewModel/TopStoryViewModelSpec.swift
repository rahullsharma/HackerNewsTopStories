//
//  TopStoryViewModelSpec.swift
//  VroomCodingChallengeTests
//
//  Created by Rahul Sharma on 2/26/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import Foundation
import Quick
import Nimble
@testable import VroomCodingChallenge


class TopStoryViewModelSpec: QuickSpec {
    
    override func spec() {
        describe("#TopStoriesViewModel") {
            
            it("expects the ids array to be greater than zero when the getStoryIDs function called") {
                let vm = TopStoriesViewModel()
                vm.getStoryIDs() { _, _ in }
                expect(vm.ids.count).toEventually(beGreaterThan(0))
            }
            
            it("expects the story array to be  zero when the getStoryData function called for an invalid id") {
                let vm = TopStoriesViewModel()
                vm.getStoryData(story: 2) { _, _ in}
                expect(vm.stories.count).toEventually(equal(0))
                
            }
            
        }
        
    }
    
}
