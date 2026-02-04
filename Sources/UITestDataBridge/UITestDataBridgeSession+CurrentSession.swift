//
//  UITestDataBridgeSession+CurrentSession.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 04.02.26.
//

import Foundation

extension UITestDataBridgeSession {

    public static func currentSession() -> Self? {
        guard let currentSession = ProcessInfo.processInfo.environment[Self.sessionIDEnvKey] else {
            return nil
        }

        return Self(sessionID: currentSession)
    }
}
