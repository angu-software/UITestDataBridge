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
            Text(sessionID())
                .accessibilityIdentifier("bridge_session_ID_label")
        }
        .padding()
    }

    private func sessionID() -> String {
        guard let currentAttachedSessionID = UITestDataBridgeSession.currentSession()?.sessionID else {
            return "--"
        }

        return currentAttachedSessionID
    }
}

#Preview {
    ContentView()
}
