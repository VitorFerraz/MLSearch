import SnapshotTesting
import SwiftUI
import Quick
import Nimble
import XCTest
@testable import MLSearch

class SearchSnapshotTests: QuickSpec {
    var repository: SearchRepositoryMock!
    var rootViewController: UIViewController!

    override func spec() {

        describe("Snapshot SearchViewController Test") {
            beforeEach {
                self.repository = SearchRepositoryMock()
                self.rootViewController = SearchRouter.buildStructure(repository: self.repository)
                //If the snapshot test failed you may enable record to take a new snapshot using your simulator
                //Try using the iPhone 12 simulator
                //isRecording = true
            }
            
            context("with multiple devices") {
                it("show a list of products") {
                    let devices: [(String, ViewImageConfig)] = [("iPhoneX", .iPhoneX),
                                                                ("iPhoneXr", .iPhoneXr),
                                                                ("iPhoneXsMax", .iPhoneXsMax)]
                    let result = SearchResponse.parse(jsonFile: "SearchResults")!
                    self.repository.result = .success(result)

                    devices.forEach { device in
                        self.rootViewController.loadViewIfNeeded()
                        let named = "Device-\(device.0)"
                        let expectation = XCTestExpectation(description: named)

                        putInViewHierarchy(self.rootViewController)
                        let nav = self.rootViewController as? UINavigationController
                        let searchViewController = nav?.viewControllers.first as? SearchViewController
                        searchViewController?.didTapSearch(text: "iPhone")
                        
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
                            expectation.fulfill()
                        })
                        self.wait(for: [expectation], timeout: .infinity)
                        let width = device.1.size?.width ?? 0.0
                        let height = device.1.size?.height ?? 0.0
                        assertSnapshot(matching: self.rootViewController, as: .image(size: CGSize(width: width, height: height)), named: named)
                    }
                }
            }
        }
    }
}

func putInViewHierarchy(_ vc: UIViewController) {
    let window = UIApplication.shared.windows.first!
    window.rootViewController = vc
}

