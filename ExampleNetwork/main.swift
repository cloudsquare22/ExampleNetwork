//
//  main.swift
//  ExampleNetwork
//
//  Created by Shin Inaba on 2019/09/04.
//  Copyright © 2019 shi-n. All rights reserved.
//

import Foundation
import Network

//var networkClient = NetworkClient(nWParameters: NWParameters.tcp)
var networkServer = NetworkServer()

//networkClient.startConnection()

networkServer.startListener()

//dispatchMain()

//while networkClient.running {
//    sleep(1)
//}

while networkServer.running {
    sleep(1)
}
