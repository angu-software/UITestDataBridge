//
//  UITestDataBridgeSession.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 04.02.26.
//

import Foundation

public struct UITestDataBridgeSession {

    public let sessionID: SessionID

    private var sharedResourceDirPath: String? {
        return ProcessInfo.processInfo.environment["SIMULATOR_SHARED_RESOURCES_DIRECTORY"]
    }

    public init() {
        self.init(sessionID: .new())
    }

    init(sessionID: SessionID) {
        self.sessionID = sessionID
    }

    /// Publishes data for a specific session and key.
    /// - Parameters:
    ///   - data: The data to publish.
    ///   - key: The key to associate with the data.
    ///   - sessionID: The unique session identifier.
    public func publishData(_ data: Data, forKey key: String) throws(SessionError) {
        guard let simulatorSharedDirectoryPath = sharedResourceDirPath else {
            throw .sharedSimulatorResourcesDirectoryNotFound
        }

        let dataFileURL = makeDataFileURL(sharedResourceDirPath: simulatorSharedDirectoryPath,
                                          fileName: makeFileName(key: key))

        do {
            try data.write(to: dataFileURL)
        } catch {
            throw .writingDataToSharedResourcesFailed
        }
    }

    /// Retrieves data for a specific session and key.
    /// - Parameters:
    ///   - key: The key to retrieve data for.
    ///   - sessionID: The unique session identifier.
    /// - Returns: The retrieved data, or `nil` if not found.
    public func retrieveData(forKey key: String) throws(SessionError) -> Data? {
        guard let simulatorSharedDirectoryPath = sharedResourceDirPath else {
            throw .sharedSimulatorResourcesDirectoryNotFound
        }

        let dataFileURL = makeDataFileURL(sharedResourceDirPath: simulatorSharedDirectoryPath,
                                          fileName: makeFileName(key: key))

        return try? Data(contentsOf: dataFileURL)
    }

    private func makeDataFileURL(sharedResourceDirPath: String, fileName: String) -> URL {
        let resourcesDirectoryURL = URL(filePath: sharedResourceDirPath,
                                        directoryHint: .isDirectory)
        return resourcesDirectoryURL
            .appending(path: fileName)
    }

    private func makeFileName(key: String) -> String {
        return "\(sessionID)-\(key)"
    }
}
