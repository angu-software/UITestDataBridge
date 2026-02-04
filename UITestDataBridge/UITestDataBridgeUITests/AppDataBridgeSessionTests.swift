//
//  AppDataBridgeSessionTests.swift
//  UITestDataBridgeTests
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation
import XCTest

import UITestDataBridge

@MainActor
final class AppDataBridgeSessionTests: XCTestCase {

    func test_givenDataBridgeSession_itAttachesSession() {
        let session = UITestDataBridgeSession()

        let app = XCUIApplication()
        app.attach(session)

        app.launch()

        XCTAssertTrue(app.staticTexts["bridge_session_ID_label"].label == session.sessionID)
    }
}
