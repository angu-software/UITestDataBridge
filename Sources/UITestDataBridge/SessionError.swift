//
//  SessionError.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 04.02.26.
//  Copyright © 2026 Pandocs. All rights reserved.
//

import Foundation

public enum SessionError: Error {
    case noActiveSessionOnCurrentProcess
    case sharedSimulatorResourcesDirectoryNotFound
    case writingDataToSharedResourcesFailed
    case encodingOfDataFailed
    case decodingOfDataFailed
}
