//
//  GDLogSpec.swift
//  GDLog
//
//  Created by Gene De Lisa on 04/10/16.
//  Copyright © 2017 genedelisa. All rights reserved.
//

import Quick
import Nimble
@testable import GDLog

class GDLogSpec: QuickSpec {

    override func spec() {

        describe("GDLoggerSpec") {
            
            it("work by default") {
                let log = GDLog()
                log.debug("hello")
                expect(log.logger).toNot(beNil())
            }
            
            it("has a category") {
                let log = GDLog(category: "some category")
                log.debug("hello")
                expect(log.logger).toNot(beNil())
            }
            
            it("has a string subsystem and category") {
                let log = GDLog("foosubsystem", category: "foocategory")
                log.debug("hello")
                expect(log.logger).toNot(beNil())
            }
            
        }

    }

}
