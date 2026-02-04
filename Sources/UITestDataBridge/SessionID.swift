//
//  SessionID.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation

typealias SessionID = String

extension SessionID {

    static func new() -> Self {
        return UUID().uuidString
    }
}
