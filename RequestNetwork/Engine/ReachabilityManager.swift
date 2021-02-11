//
//  ReachabilityManager.swift
//  Network
//
//  Created by Vitor Ferraz Varela on 10/02/21.
//

import Foundation

public class ReachabilityManager {

    public static let shared = ReachabilityManager()

    private let reachability: Reachability

    init() {
        do {
            self.reachability = try Reachability()
        } catch {
            fatalError("Reachability initialization failed: \(error)")
        }
    }

    public var connection: Reachability.Connection {
        return reachability.connection
    }
}
