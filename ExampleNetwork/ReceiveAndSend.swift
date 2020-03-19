//
//  ReceiveAndSend.swift
//  ExampleNetwork
//
//  Created by Shin Inaba on 2020/03/19.
//  Copyright © 2020 shi-n. All rights reserved.
//

import Foundation
import Network

class ReceiveAndSend {
    public var running = true

    func startListener() {
        let myQueue = DispatchQueue(label: "ExampleNetwork")

        do {
            let nWListener = try NWListener(using: .tcp, on: 7777)
            nWListener.newConnectionHandler = { (newConnection) in
                print("New Connection!!")
                newConnection.start(queue: myQueue)
                self.receive(nWConnection: newConnection)
            }
            nWListener.start(queue: myQueue)
            print("start")
        }
        catch {
            print(error)
        }
    }
    
    func receive(nWConnection:NWConnection) {
        nWConnection.receive(minimumIncompleteLength: 1, maximumLength: 5, completion: { (data, context, flag, error) in
            print("receiveMessage")
            if let data = data {
                let receiveData = [UInt8](data)
                print(receiveData)
                print(flag)
                self.sendMessage(nWConnection)
                if(flag == false) {
                    self.receive(nWConnection: nWConnection)
                }
            }
            else {
                print("receiveMessage data nil")
            }
        })
    }

    func sendMessage(_ connection: NWConnection) {
        let data = "Answer".data(using: .utf8)
        let completion = NWConnection.SendCompletion.contentProcessed { (error: NWError?) in
            print("応答送信完了")
            self.running = false
        }
        connection.send(content: data, completion: completion)
    }
}
