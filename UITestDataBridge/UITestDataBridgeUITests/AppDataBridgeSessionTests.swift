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
import XCTestDataBridge

@MainActor
final class AppDataBridgeSessionTests: XCTestCase {

    func test_givenDataBridgeSession_itAttachesSession() {
        let session = newSession()
        let app = appWithAttachedSession(session)

        app.launch()

        XCTAssertTrue(app.staticTexts["label_bridge_session_ID"].label == session.sessionID)
    }

    func test_givenPlublishingData_itReceivesDataInTheApp() async throws {
        let session = newSession()
        let app = appWithAttachedSession(session)

        try session.publishData(Data("Hello, World!".utf8), forKey: "test_data")

        app.launch()

        XCTAssertTrue(app.staticTexts["label_bridge_session_data"].label == "Hello, World!")
    }

    private func newSession() -> UITestDataBridgeSession {
        return UITestDataBridgeSession()
    }

    private func appWithAttachedSession(_ session: UITestDataBridgeSession) -> XCUIApplication {
        let app = XCUIApplication()
        app.attach(session)

        return app
    }
}
