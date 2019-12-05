//
//  NetworkClient.swift
//  ExampleNetwork
//
//  Created by Shin Inaba on 2019/12/04.
//  Copyright © 2019 shi-n. All rights reserved.
//

import Foundation
import Network

class NetworkClient {
    public var running = true
    private var nWParameters: NWParameters
    
    init(nWParameters: NWParameters) {
        self.nWParameters = nWParameters
    }

    func startConnection() {
        let myQueue = DispatchQueue(label: "ExampleNetwork")
        let connection = NWConnection(host: "localhost", port: 7777, using: nWParameters)
        connection.stateUpdateHandler = { (newState) in
            switch(newState) {
            case .ready:
                print("ready")
                self.sendMessage(connection)
            case .waiting(let error):
                print("waiting")
                print(error)
            case .failed(let error):
                print("failed")
                print(error)
            default:
                print("defaults")
                break
            }
        }
        connection.start(queue: myQueue)
    }

    func sendMessage(_ connection: NWConnection) {
        let data = "Example Send Data".data(using: .utf8)
        let completion = NWConnection.SendCompletion.contentProcessed { (error: NWError?) in
            print("送信完了")
            self.running = false
        }
        connection.send(content: data, completion: completion)
    }

}
