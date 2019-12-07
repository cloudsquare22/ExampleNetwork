//
//  NetworkServer.swift
//  ExampleNetwork
//
//  Created by Shin Inaba on 2019/12/05.
//  Copyright © 2019 shi-n. All rights reserved.
//

import Foundation
import Network

class NetworkServer {
    public var running = true

    func startListener() {
        let myQueue = DispatchQueue(label: "ExampleNetwork")

        do {
            let nWListener = try NWListener(using: .udp, on: 7777)
            nWListener.newConnectionHandler = { (newConnection) in
                print("New Connection!!")
//                newConnection.receiveMessage(completion: { (data, context, flag, error) in
//                    print("receiveMessage")
//                    let receiveData = [UInt8](data!)
//                    print(receiveData)
//                })
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
