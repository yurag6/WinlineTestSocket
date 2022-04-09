//
//  Model_16.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 01.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

import Foundation




class Sport{
    var sportID               : UInt32    = 0
    var sportSort             : UInt32    = 0
    var sportTitle            : String?
    var serviceCharacteristics: [String?] = [] // 9
}

class Market{
    var marketID       : UInt32?
    var supportSports  : String?
    var isThereSelected: UInt32?
    var count          : UInt32?
    var type           : UInt32?
    var marketTitle    : String?
    var marketOutcome  : [String?] = [] //30
}

class Model_16{
    var sportsCount: UInt32    = 0
    var sport      : [Sport?]  = []
    var marketCount: UInt32    = 0
    var market     : [Market?] = []
    
    func getMarket(by ID: UInt32) -> Market? {

        var aray: [UInt32] = []
        
        for findMarket in market{
            
            if findMarket?.marketID == ID{
                return findMarket!
            }
            aray.append(findMarket?.marketID ?? 0)
            
            
        }
        aray.sort()
        return nil
    
    }
}



