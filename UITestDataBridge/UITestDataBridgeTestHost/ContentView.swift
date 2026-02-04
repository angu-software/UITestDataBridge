//
//  ContentView.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 04.02.26.
//

import SwiftUI

import UITestDataBridge

struct ContentView: View {

    private let dataToSend = "Hello, Test case"

    var body: some View {
        VStack {
            Text("UI data bridge session")
                .font(.title)
            Text(sessionID())
                .accessibilityIdentifier("label_bridge_session_ID")
            Spacer()
            Text("Received data")
                .fontWeight(.semibold)
                .italic()
            Text(sessionData())
                .accessibilityIdentifier("label_bridge_session_data")
            Spacer()
            Text(dataToSend)
                .accessibilityIdentifier("label_bridge_session_sending_data")
            Button("Send data") {
                sendData()
            }
            .buttonStyle(.borderedProminent)
            .accessibilityIdentifier("button_bridge_session_send_data")
            Spacer()
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

    private func sendData() {
        try? currentBridgeSession()?.publishData(dataToSend.data(using: .utf8)!,
                                                 forKey: "app_test_data")
    }
}

#Preview {
    ContentView()
}
