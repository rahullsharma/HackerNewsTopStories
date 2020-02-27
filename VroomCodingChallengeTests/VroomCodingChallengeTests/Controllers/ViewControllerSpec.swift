//
//  ViewControllerSpec.swift
//  VroomCodingChallengeTests
//
//  Created by Rahul Sharma on 2/26/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import VroomCodingChallenge


class ViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("#ViewController") {
            
            it("expects the tableView to have one row of mock data") {
                let vc = ViewController()
                let mockStory = Story(by: "Rahul", score: 100, title: "This is my mock story", url: "www.google.ca")
                vc.StoriesViewModel.stories.append(mockStory)
                vc.setupTableView()
                expect(vc.tableView.numberOfRows(inSection: 0)).toEventually(equal(1))

            }
            
            it("expects the tableView cell to have the mock data in its textLabel and detailTextLabel") {
                var cell: UITableViewCell!
                let vc = ViewController()
                let mockStory = Story(by: "Rahul", score: 100, title: "This is my mock story", url: "www.google.ca")
                vc.StoriesViewModel.stories.append(mockStory)
                cell = vc.tableView(vc.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
                vc.setupTableView()
                
                expect(cell.textLabel?.text).to(equal("This is my mock story"))
                expect(cell.detailTextLabel?.text).to(equal("100 points, by: Rahul"))
            }
            
        }
        
    }
    
}
