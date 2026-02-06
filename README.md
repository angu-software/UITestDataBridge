# UITestDataBridge

`UITestDataBridge` provides a simple communication channel between UI tests and the app under test.

## Purpose

`UITestDataBridge` is designed to support Acceptance (ACC) UI tests and behavior-driven development (BDD) scenarios.

ACC tests validate application behavior from the user’s perspective and focus on acceptance criteria rather than internal implementation details. These tests are often close to end-to-end, but deliberately avoid the complexity and fragility of full system integration.

In this context, `UITestDataBridge` provides two essential capabilities:

### 1. Controlled data injection

Some application states are difficult, time-consuming, or impossible to reach through the UI alone. This is especially true when data is normally provided by external systems such as:

- backend services
- `HealthKit` or other system frameworks
- long-running background processes

`UITestDataBridge` allows ACC UI tests to inject controlled, deterministic data into the app under test, enabling acceptance criteria to be validated without relying on complex or unstable setup steps.

### 2. Observing non-visible state and events

In Acceptance UI tests, observable user behavior should be validated through the UI whenever possible.

Lower-level tests (unit, integration, or component tests) are generally better suited to verify internal state changes or background events and should be preferred when they can confidently cover the acceptance criteria.

However, some behaviors cannot be reliably triggered or observed outside of a real app runtime. In such cases, UITestDataBridge allows selected internal events or state to be exposed to the test environment in a controlled and explicit way.

A common example is verifying that the app initiates a background data sync when it opens. Since an actual app launch cannot be reliably simulated in lower-level tests, observing this behavior through the UI alone is often not possible. In these scenarios, the data bridge provides a pragmatic way to validate the acceptance criteria without resorting to full end-to-end system tests.

> **Note**:<br/>
> Whenever possible, internal behavior should be verified using lower-level tests.<br/>
> `UITestDataBridge` is intended for scenarios where such tests cannot reliably cover acceptance criteria, such as behaviors triggered only during real app launches.

## Quick Start

`UITestDataBridge` allows ACC UI tests to send and receive controlled data between the test and the app under test. It comes in two products:

1.	`UITestDataBridge`
    
    - The core API for creating sessions and exchanging data
    - Import into both your app target and your `XCTest` target.

2.	`XCTestDataBridge` 
    
    - A convenience layer for attaching a session to `XCUIApplication` in tests.
	- Import into your UI test target only.
  
### 1. Import the packages

```swift
import XCTest
import UITestDataBridge // Core session API
import XCTestDataBridge // Convenience helpers for UI tests
```

### 2. Create a bridge session

```swift
// Create a new bridge session for this test
let bridgeSession = UITestDataBridgeSession()
```

### 3. Attach the session to your app

```swift
let app = XCUIApplication()

// Attach the session using the convenience helper
app.attach(bridgeSession)
```

### 4. Send data from the test to the app

```swift
// Send any Codable data (string, object, etc.)
try bridgeSession.publish("Hello, App!", forKey: "data_from_test")
```

### 5. Receive data in the app

```swift
import UITestDataBridge

func dataFromTest() -> String? {
    guard let bridgeSession = UITestDataBridgeSession.currentSession() else { 
        return nil 
    }

    return bridgeSession.retrieve(forKey: "data_from_test")
}
````

### 6. Optional: Send data from the app to the test

```swift
// App side
bridgeSession.publish("Hello, Test!", forKey: "data_from_app")

// Test side
let received: String? = bridgeSession.retrieve(forKey: "data_from_app")
XCTAssertEqual(received, "Hello, Test!")
```

## Data flow summary

```text
+-----------------+        +-------------------------+         +-----------------+
|   UI Test Case  |  <-->  | UITestDataBridgeSession |  <-->   |  App Under Test |
+-----------------+        +-------------------------+         +-----------------+
        |                              |                               |
        |  publish("foo")              |                               |
        |----------------------------->|                               |
        |                              |  retrieve("foo")           |
        |                              |------------------------------>|
        |                              |                               |
        |  retrieve("bar")             |                               |
        |<-----------------------------|                               |
        |                              |  publish("bar")           |
        |                              |<------------------------------|
```

## Features

- **Controlled Data Injection**: send arbitrary Codable data from your test case to the app under test.
- **Observation of Non-Visible State**: read app state or events that are not exposed in the UI.
- **Session Isolation**: each UITestDataBridgeSession is independent; data is never shared across sessions.
- **Codable Support**: send strings, structs, arrays, or any Codable types.
- **Simulator-Only**: relies on SIMULATOR_SHARED_RESOURCES_DIRECTORY, ensuring deterministic behavior without affecting physical devices.
- **Convenience Helpers**: attach sessions to XCUIApplication easily (for your UI test target).

## Installation

**Swift Package Manager**

You can add `UITestDataBridge` as a dependency in your Xcode project:

1.	In Xcode, go to *File → Add Packages…*
2.	Enter the repository URL:
    ```text
    https://github.com/angu-software/UITestDataBridge.git
    ```
3.	Choose the version or branch you want to use.
4.	Link the following products to your targets:

    In the target settings, under the *Frameworks, Libraries, and Embedded Content* section, add:

	- `UITestDataBridge` – link to App/Framework target + UITest target.
	- `XCTestDataBridge` – link UITest target only.

> In case you have trouble setting up `UITestDataBridge` see the [UITestDataBridge project] in this reposotory.

## Behind the Scenes

`UITestDataBridge` works by storing session data in the `SIMULATOR_SHARED_RESOURCES_DIRECTORY`, which is only available when running on the iOS simulator.

- Session isolation: Data is scoped to a single UITestDataBridgeSession. Other sessions cannot access it.
- Codable support: Any data sent through a session is serialized using Codable.
- Simulator-only limitation: Because it relies on simulator shared resources, the bridge does not work on physical devices.

This ensures that each test session is isolated, deterministic, and does not interfere with other tests or app instances.

## Usage Scenarios

`UITestDataBridge` can be used in any situation where controlled data exchange between the test and the app is needed, particularly for ACC UI tests. 

Examples may include:

- **Health Data Injection**: provide steps, workouts, or other HealthKit data without requiring real user activity.
- **Feature Flags / Remote Config**: test different app behaviors by injecting backend configuration.
- **Authentication State**: simulate logged-in, logged-out, or other user states for ACC tests.
- **Third-Party SDK Events**: trigger events or responses that are difficult to produce with the SDK in a test environment.
- **Background Tasks / Sync Events**: validate app reactions to background processes without waiting for full end-to-end triggers.

## Acknowledgments

This library was inspired by [Managing iOS UI Testing Fixtures] by [Paulo Andrade].
The blog post demonstrated techniques for bridging data between tests and apps, which guided the design and purpose of UITestDataBridge.

## License

`UITestDataBridge` is released under the MIT License. See LICENSE for details.

---
[Managing iOS UI Testing Fixtures]: https://pfandrade.me/blog/managing-ios-ui-testing-fixtures/
[Paulo Andrade]: https://github.com/pfandrade/
[UITestDataBridge project]: ./UITestDataBridge/
[LICENSE]: ./LICENSE.md
