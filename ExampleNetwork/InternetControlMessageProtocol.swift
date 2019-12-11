//
//  InternetControlMessageProtocol.swift
//  ExampleNetwork
//
//  Created by Shin Inaba on 2019/12/11.
//  Copyright © 2019 shi-n. All rights reserved.
//

import Foundation
import Network

@available(OSX 10.15, *)
class InternetControlMessageProtocol: NWProtocolFramerImplementation {
    static var label: String = "ICMP"
    
    static let definition = NWProtocolFramer.Definition(implementation: InternetControlMessageProtocol.self)
    
    required init(framer: NWProtocolFramer.Instance) {
    }
    
    func start(framer: NWProtocolFramer.Instance) -> NWProtocolFramer.StartResult {
        return .ready
    }
    
    func handleInput(framer: NWProtocolFramer.Instance) -> Int {
        <#code#>
    }
    
    func handleOutput(framer: NWProtocolFramer.Instance, message: NWProtocolFramer.Message, messageLength: Int, isComplete: Bool) {
        <#code#>
    }
    
    func wakeup(framer: NWProtocolFramer.Instance) {
    }
    
    func stop(framer: NWProtocolFramer.Instance) -> Bool {
        return true
    }
    
    func cleanup(framer: NWProtocolFramer.Instance) {
    }
}
