//
//  WebViewControllerSpec.swift
//  VroomCodingChallengeTests
//
//  Created by Rahul Sharma on 2/26/20.
//  Copyright © 2020 Rahul Sharma. All rights reserved.
//

import Foundation
import Quick
import Nimble
@testable import VroomCodingChallenge


class WebViewControllerSpec: QuickSpec {
    
    override func spec() {
        describe("#WebViewController") {
            it("expects to not be nil since the controller is initialized properly") {
                let baseURL = "https://www.google.com/"
                let wc = WebViewController(urlString: baseURL)
                expect(wc).toNot(beNil())
            }
                        
        }
        
    }
    
}
