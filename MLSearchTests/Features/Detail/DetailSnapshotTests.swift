//
//  DetailSnapshotTests.swift
//  MLSearchTests
//
//  Created by Vitor Ferraz Varela on 15/02/21.
//

import SnapshotTesting
import SwiftUI
import Quick
import Nimble
import XCTest
@testable import MLSearch

class DetailSnapshotTests: QuickSpec {
    var repository: DetailRepositoryMock!
    var rootViewController: UIViewController!

    override func spec() {

        describe("Snapshot SearchViewController Test") {
            beforeEach {
                self.repository = DetailRepositoryMock()
                self.rootViewController = DetailRouter.buildStructure(productId: "teste", repository: self.repository)
                //If the snapshot test failed you may enable record to take a new snapshot using your simulator
                //Try using the iPhone 12 simulator
                //isRecording = true
            }
            
            context("with multiple devices") {
                it("show a list of products") {
                    let devices: [(String, ViewImageConfig)] = [("iPhoneX", .iPhoneX),
                                                                ("iPhoneXr", .iPhoneXr),
                                                                ("iPhoneXsMax", .iPhoneXsMax)]
                    let result = [ProductDetailResponse].parse(jsonFile: "DetailResult")!
                    self.repository.result = .success(result)

                    devices.forEach { device in
                        self.rootViewController.loadViewIfNeeded()
                        let named = "Device-\(device.0)"
                        let expectation = XCTestExpectation(description: named)

                        putInViewHierarchy(self.rootViewController)
                        let detailViewController = self.rootViewController as? DetailViewController
                        detailViewController?.loadViewIfNeeded()
                        
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
