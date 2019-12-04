//
//  String+Encryption.swift
//  MarvelTest
//
//  Created by Jesse Tello on 11/30/19.
//  Copyright © 2019 MarvelTest. All rights reserved.
//

import Foundation
import CommonCrypto

extension String {
    
    //MD5 is Deprecated by Apple but needed to access Marvel api
    func md5() -> String {
        let length = Int(CC_MD5_DIGEST_LENGTH)
        var digest = [UInt8](repeating: 0, count: length)
        
        if let d = self.data(using: String.Encoding.utf8) {
            _ = d.withUnsafeBytes({ (ptr: UnsafeRawBufferPointer) in
                if let ptrAddress = ptr.baseAddress, ptr.count > 0 {
                    let pointer = ptrAddress.assumingMemoryBound(to: UInt8.self)
                    CC_MD5(pointer, CC_LONG(d.count), &digest)
                }
            })
        }
        
        return (0..<length).reduce("") {
            $0 + String(format: "%02x", digest[$1])
        }
    }
}
