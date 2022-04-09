//
//  Data.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 05.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

import Foundation


extension Data {

    // return Strin from shift
    public func toString(_ shift: inout Int) -> String?
    {
        var arrayUTF8: [UInt8] = []
        let length = self.toUInt16(&shift)
        
        guard shift + Int(length) < count else {return nil}
        
        if length > 0{
            for _ in 0..<length {
                arrayUTF8.append(self.toUInt8(&shift))
            }
            let string = String(bytes: arrayUTF8, encoding : .utf8)
            return  string
        } else{
            return nil
        }
    }

    // return UInt8 from shift
    public func toUInt8( _ shift: inout Int) -> UInt8 {
        
        guard shift + 0 < count else {return UInt8(0)}
        
        let result = UInt8(self[shift + 0]) << 0
        shift += 1
        return  result
    }
    
    // return UInt16 from shift
    public func toUInt16(_ shift: inout Int) -> UInt16 {
        
        guard shift + 1 < count else {return UInt16(0)}
        
        let result = (UInt16(self[shift + 0]) << 0 ) |
                     (UInt16(self[shift + 1]) << 8 )
        shift += 2
        return result
    }
    
    // return UInt32 from shift
    public func toUInt32(_ shift: inout Int) -> UInt32 {
        
        guard shift + 3 < count else {return UInt32(0)}
        
        let result = (UInt32(self[shift + 0]) << 0 ) |
                     (UInt32(self[shift + 1]) << 8 ) |
                     (UInt32(self[shift + 2]) << 16) |
                     (UInt32(self[shift + 3]) << 24)
        shift += 4
        return result
    }
}

extension UInt32{
    
    mutating func restore(_ data: Data, _ shift: inout Int){
        self  = (UInt32(data[shift + 0]) << 0 ) |
                (UInt32(data[shift + 1]) << 8 ) |
                (UInt32(data[shift + 2]) << 16) |
                (UInt32(data[shift + 3]) << 24)
        shift += 4
    }
}

extension UInt16{
    
    mutating func restore(_ data: Data, _ shift: inout Int){
        self  = (UInt16(data[shift + 0]) << 0 ) |
                (UInt16(data[shift + 1]) << 8 )
        shift += 2
    }
}
