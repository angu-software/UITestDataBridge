//
//  UITestDataBridgeSessionTests.swift
//  UITestDataBridgeTests
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation
import XCTest

@testable import UITestDataBridge

final class UITestDataBridgeSessionTests: XCTestCase {

    func test_givenDataPublished_whenReceivingData_itReturnsWrittenData() async throws {
        let publishedData = Data.dummy
        let session = UITestDataBridgeSession()
        try session.publishData(publishedData, forKey: "hello")

        let receivedData = try session.retrieveData(forKey: "hello")

        XCTAssertEqual(receivedData, publishedData)
    }

    func test_givenDataWrittenInDifferentSession_whenReceivingData_itCantReadOtherSessionsData() async throws {
        let publishedData = Data.dummy
        try UITestDataBridgeSession().publishData(publishedData, forKey: "hello")

        let session = UITestDataBridgeSession()

        let receivedData = try session.retrieveData(forKey: "hello")

        XCTAssertNil(receivedData)
    }
}

extension Data {

    static var dummy: Self {
        return "Hello".data(using: .utf8)!
    }
}
