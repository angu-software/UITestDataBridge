//
//  ContentView.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 04.02.26.
//

import SwiftUI

import UITestDataBridge

struct ContentView: View {
    var body: some View {
        VStack {
            Text("UI data bridge session")
                .fontWeight(.semibold)
            Text(sessionID())
                .accessibilityIdentifier("label_bridge_session_ID")
            Text("Received data")
                .fontWeight(.semibold)
                .italic()
            Text(sessionData())
                .accessibilityIdentifier("label_bridge_session_data")
        }
        .padding()
    }

    private func sessionID() -> String {
        guard let currentAttachedSessionID = UITestDataBridgeSession.currentSession()?.sessionID else {
            return "--"
        }

        return currentAttachedSessionID
    }

    private func sessionData() -> String {
        guard let session = currentBridgeSession(),
              let data = try? session.retrieveData(forKey: "test_data"),
              let stringValue = String(data: data, encoding: .utf8)else {
            return "--"
        }

        return stringValue
    }

    private func currentBridgeSession() -> UITestDataBridgeSession? {
        return UITestDataBridgeSession.currentSession()
    }
}

#Preview {
    ContentView()
}
