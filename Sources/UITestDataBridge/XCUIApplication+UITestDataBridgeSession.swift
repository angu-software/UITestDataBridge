//
//  XCUIApplication+UITestDataBridgeSession.swift
//  Pandocs
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation
import XCTest

extension XCUIApplication {

    func attach(_ session: UITestDataBridgeSession) {
        let envValue = [UITestDataBridgeSession.sessionIDEnvKey: session.sessionID]
        launchEnvironment.merge(envValue, uniquingKeysWith: { $1 })
    }

    func hasUITestBridgeSessionAttached() -> Bool {
        return launchEnvironment.keys.contains(UITestDataBridgeSession.sessionIDEnvKey)
    }
}
