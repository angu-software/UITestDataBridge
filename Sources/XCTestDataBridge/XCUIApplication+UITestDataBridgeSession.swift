//
//  XCUIApplication+UITestDataBridgeSession.swift
//  Pandocs
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation
import XCTest

import UITestDataBridge

extension XCUIApplication {

    public func attach(_ session: UITestDataBridgeSession) {
        let envValue = [UITestDataBridgeSession.sessionIDEnvKey: session.sessionID]
        launchEnvironment.merge(envValue, uniquingKeysWith: { $1 })
    }

    public func hasUITestBridgeSessionAttached() -> Bool {
        return launchEnvironment.keys.contains(UITestDataBridgeSession.sessionIDEnvKey)
    }
}
