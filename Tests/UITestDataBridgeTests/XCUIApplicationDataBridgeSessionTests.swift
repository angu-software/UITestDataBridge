//
//  XCUIApplicationDataBridgeSessionTests.swift
//  UITestDataBridgeTests
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation
import XCTest

@testable import UITestDataBridge

final class XCUIApplicationDataBridgeSessionTests: XCTestCase {

    @MainActor
    func test_givenDataBridgeSession_itAttachesSession() {
        let session = UITestDataBridgeSession()

        let app = XCUIApplication(bundleIdentifier: "com.apple.notes")
        app.attach(session)

        XCTAssertTrue(app.hasUITestBridgeSessionAttached())
    }
}
