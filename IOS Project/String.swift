//
//  String.swift
//  IOS Project
//
//  Created by bou kisrane on 26/03/2017.
//  Copyright © 2017 leobaptiste. All rights reserved.
//

import Foundation
import CommonCrypto


public extension String {
    func sha1() -> String {
        let data = self.data(using: String.Encoding.utf8)!
        var digest = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA1($0, CC_LONG(data.count), &digest)
        }
        let hexBytes = digest.map { String(format: "%02hhx", $0) }
        return hexBytes.joined()
    }
}
