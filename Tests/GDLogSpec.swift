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

        describe("GDLogSpec") {
            it("works") {
                expect(GDLog.name) == "GDLog"
            }
        }

    }

}
