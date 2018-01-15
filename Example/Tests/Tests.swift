// https://github.com/Quick/Quick

import Quick
import Nimble
import SwiftyCron

class TableOfContentsSpec: QuickSpec {
    override func spec() {
        describe("these will fail") {
            
            let cronString = "39 11 02 08 4"
            let swiftyCron = SwiftyCron(cronString:cronString)
            
            it ("Get weekday initials") {
                expect(swiftyCron?.weekday?.inittialString) == "Thu"
            }
            it ("Get weekday full string") {
                expect(swiftyCron?.weekday?.fullString) == "Thursday"
            }
            
            it ("Get month initials") {
                expect(swiftyCron?.month?.inittialString) == "Aug"
            }
            
            it ("Get month full string") {
                expect(swiftyCron?.month?.fullString) == "August"
            }
            
//            it("can do maths") {
//                expect(1) == 2
//            }
//
//            it("can read") {
//                expect("number") == "string"
//            }
//
//            it("will eventually fail") {
//                expect("time").toEventually( equal("done") )
//            }
//
//            context("these will pass") {
//
//                it("can do maths") {
//                    expect(23) == 23
//                }
//
//                it("can read") {
//                    expect("🐮") == "🐮"
//                }
//
//                it("will eventually pass") {
//                    var time = "passing"
//
//                    DispatchQueue.main.async {
//                        time = "done"
//                    }
//
//                    waitUntil { done in
//                        Thread.sleep(forTimeInterval: 0.5)
//                        expect(time) == "done"
//
//                        done()
//                    }
//                }
//            }
        }
    }
}
