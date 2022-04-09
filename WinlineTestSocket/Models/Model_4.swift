//
//  Model_4.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 06.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

import Foundation

class Model_4{
   
    var typeBlock: UInt16?           // Тип блока
    var description = "description"
   

    func toString() -> String{
        for item in Mirror(reflecting: self).children{
            print(item)
        }
        return ""
    }

    init(){
    }
    
    class Block_2_Championship: Model_4{
        
        var championshipID : UInt32? //-  идентификатор чемпионата
        var sportID        : UInt32? // - идентификатор спорта этого чемпионата
        var sort           : UInt32? // - сортировка
        var countryID      : UInt32? // - идентификатор страны
        
        override init() {
            super.init()
            typeBlock = 2
            description = "чемпионат"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
            
            championshipID = data.toUInt32(&shift)
            sportID        = data.toUInt32(&shift)
            sort           = data.toUInt32(&shift)
            countryID      = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            
            championshipID = nil
            sportID        = nil
            sort           = nil
            countryID      = nil
            
            return self
        }
    }
    
    class Block_3_Event: Model_4{
        
        var id_1 : UInt32? // -
        var id_2 : UInt32? // -
        var id_3 : UInt32? // -
        var id_4 : UInt32? // -
        
        override init() {
            super.init()
            typeBlock = 3
            description = "событие"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
            
            id_1 = data.toUInt32(&shift)
            id_2 = data.toUInt32(&shift)
            id_3 = data.toUInt32(&shift)
            id_4 = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            
            id_1 = nil
            id_2 = nil
            id_3 = nil
            id_4 = nil
            
            return self
        }
    }
    
    class Block_4_EventUpdate: Model_4{
        
        var id_1 : UInt32? // -
        var id_2 : UInt32? // -
        var id_3 : UInt32? // -
        var id_4 : UInt32? // -
        
        override init() {
            super.init()
            typeBlock = 4
            description = "обновление события"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
            
            id_1 = data.toUInt32(&shift)
            id_2 = data.toUInt32(&shift)
            id_3 = data.toUInt32(&shift)
            id_4 = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            
            id_1 = nil
            id_2 = nil
            id_3 = nil
            id_4 = nil
            
            return self
        }
    }
    
    class Block_5_Line: Model_4{
        
        var id_1 : UInt32? // -
        var id_2 : UInt32? // -
        var id_3 : UInt32? // -
        var id_4 : UInt32? // -
        
        override init() {
            super.init()
            typeBlock = 5
            description = "линия"
        }

        func parse(_ data: Data, _ shift: inout Int){
            
            id_1 = data.toUInt32(&shift)
            id_2 = data.toUInt32(&shift)
            id_3 = data.toUInt32(&shift)
            id_4 = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            
            id_1 = nil
            id_2 = nil
            id_3 = nil
            id_4 = nil
            
            return self
        }
    }
    
    class Block_6_LineAdding: Model_4{

        var id_1 : UInt32? // -
        var id_2 : UInt32? // -
        var id_3 : UInt32? // -
        var id_4 : UInt32? // -
        
        override init() {
            super.init()
            typeBlock = 6
            description = "обавление линии"
        }

        func parse(_ data: Data, _ shift: inout Int){
            
            id_1 = data.toUInt32(&shift)
            id_2 = data.toUInt32(&shift)
            id_3 = data.toUInt32(&shift)
            id_4 = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            
            id_1 = nil
            id_2 = nil
            id_3 = nil
            id_4 = nil
            
            return self
        }
    }
}
