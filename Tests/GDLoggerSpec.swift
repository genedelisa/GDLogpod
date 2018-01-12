//
//  GDLoggerSpec.swift
//  GDLogger
//
//  Created by Gene De Lisa on 04/10/16.
//  Copyright © 2017 genedelisa. All rights reserved.
//

import Quick
import Nimble
@testable import GDLogger

class GDLoggerSpec: QuickSpec {

    override func spec() {

        describe("GDLoggerSpec") {
            
            it("work by default") {
                let log = GDLogger()
                log.debug("hello")
                expect(log.logger).toNot(beNil())
            }
            
            it("has a category") {
                let log = GDLogger(category: "some category")
                log.debug("hello")
                expect(log.logger).toNot(beNil())
            }
            
            it("has a string subsystem and category") {
                let log = GDLogger("foosubsystem", category: "foocategory")
                log.debug("hello")
                expect(log.logger).toNot(beNil())
            }
            
        }

    }

}
