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

        XCTAssertTrue(sessionID(of: app) == session.sessionID)
    }

    func test_givenPublishingData_itReceivesDataInTheApp() async throws {
        let session = newSession()
        let app = appWithAttachedSession(session)
        let dataContent = "Hello, App!"

        try session.publishData(dataContent.data(using: .utf8)!, forKey: "test_data")

        app.launch()

        XCTAssertTrue(dataReceivedInApp(app) == dataContent)
    }

    func test_whenAppPublishedData_itReceivesDataInTheTest() async throws {
        let session = newSession()
        let app = appWithAttachedSession(session)
        app.launch()

        sendDataFromApp(app)

        XCTAssertTrue(dataSendFromApp(app) == dataReceivedFromApp(in: session))
    }

    private func newSession() -> UITestDataBridgeSession {
        return UITestDataBridgeSession()
    }

    private func appWithAttachedSession(_ session: UITestDataBridgeSession) -> XCUIApplication {
        let app = XCUIApplication()
        app.attach(session)

        return app
    }

    private func sessionID(of app: XCUIApplication) -> String {
        return app.staticTexts["label_bridge_session_ID"].label
    }

    private func dataReceivedInApp(_ app: XCUIApplication) -> String? {
        return app.staticTexts["label_bridge_session_data"].label
    }

    private func dataSendFromApp(_ app: XCUIApplication) -> String? {
        app.staticTexts["label_bridge_session_sending_data"].label
    }

    private func sendDataFromApp(_ app: XCUIApplication) {
        app.buttons["button_bridge_session_send_data"].tap()
    }

    private func dataReceivedFromApp(in session: UITestDataBridgeSession) -> String? {
        guard let receivedData = try? XCTUnwrap(session.retrieveData(forKey: "app_test_data")) else {
            return nil
        }
        return String(data: receivedData, encoding: .utf8)
    }
}
