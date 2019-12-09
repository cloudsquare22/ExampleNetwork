//
//  SendAndReceive.swift
//  ExampleNetwork
//
//  Created by Shin Inaba on 2019/12/08.
//  Copyright © 2019 shi-n. All rights reserved.
//

import Foundation
import Network

class SendAndReceive {
    public var running = true
    private var host:NWEndpoint.Host
    private var port:NWEndpoint.Port
    private var nWParameters: NWParameters
    
    init(host:NWEndpoint.Host, port:NWEndpoint.Port, nWParameters: NWParameters) {
        self.host = host
        self.port = port
        self.nWParameters = nWParameters
    }

    func startConnection() {
        let myQueue = DispatchQueue(label: "ExampleNetwork")
        let connection = NWConnection(host: host, port: port, using: nWParameters)
        connection.pathUpdateHandler = { (nWPath) in
            print("pathUpdateHandler:\(nWPath)")
        }
        connection.viabilityUpdateHandler = { (viability) in
            print("viabilityUpdateHandler:\(viability)")
        }
        connection.betterPathUpdateHandler = {(better) in
            print("betterPathUpdateHandler:\(better)")
        }
        connection.stateUpdateHandler = { (newState) in
            switch(newState) {
            case .setup:
                print("setup")
            case .waiting(let error):
                print("waiting")
                print(error)
            case .preparing:
                print("preparing")
            case .ready:
                print("ready")
                self.sendMessage(connection)
            case .failed(let error):
                print("failed")
                print(error)
            case .cancelled:
                print("cancelled")
            @unknown default:
                print("defaults")
                break
            }
        }
        connection.start(queue: myQueue)
        self.receive(nWConnection: connection)
    }

    func sendMessage(_ connection: NWConnection) {
        let data = "Example Send Data".data(using: .utf8)
        let completion = NWConnection.SendCompletion.contentProcessed { (error: NWError?) in
            print("送信完了")
//            self.running = false
        }
        connection.send(content: data, completion: completion)
    }

    func receive(nWConnection:NWConnection) {
        nWConnection.receive(minimumIncompleteLength: 1, maximumLength: 5, completion: { (data, context, flag, error) in
            print("receiveMessage")
            if let data = data {
                let receiveData = [UInt8](data)
                print(receiveData)
                print(flag)
                if(flag == false) {
                    self.receive(nWConnection: nWConnection)
                }
            }
            else {
                print("receiveMessage data nil")
            }
        })
    }

}
