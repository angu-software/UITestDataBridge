//
//  UITestDataBridgeSession+Codable.swift
//  UITestDataBridge
//
//  Created by Andreas Günther on 05.02.26.
//

import Foundation

extension UITestDataBridgeSession {

    public func publish<Value: Encodable>(_ encodable: Value, forKey key: String) throws(SessionError) {
        let data = try encode(encodable)

        return try publishData(data, forKey: key)
    }

    public func retrieve<Value: Decodable>(forKey key: String) throws(SessionError) -> Value? {
        guard let data = try retrieveData(forKey: key) else {
            return nil
        }

        return try decode(data)
    }

    private func encode<Value: Encodable>(_ value: Value) throws(SessionError) -> Data {
        let encoder = JSONEncoder()

        do {
            return try encoder.encode(value)
        } catch {
            throw .encodingOfDataFailed
        }
    }

    private func decode<Value: Decodable>(_ data: Data) throws(SessionError) -> Value {
        let decoder = JSONDecoder()

        do {
            return try decoder.decode(Value.self, from: data)
        } catch {
            throw .decodingOfDataFailed
        }
    }
}
