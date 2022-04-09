//
//  Model_3.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 04.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

import Foundation



extension Optional {
    mutating func reset() {
        self = nil
    }
}



class Model_3{
   
    var typeBlock: UInt16?           // Тип блока
    var typeDefine = [0]
    var description = "description"

    func toString() -> String{
   
        for item in Mirror(reflecting: self).children{
            print(item)
        }
//        reset()
        return ""
    }

//    func reset(){
//        for item in Mirror(reflecting: self).children{
//
//            if var reset = item.value as? Bool?{
//                reset = nil
//            }
//            if var reset = item.value as? UInt8?{
//                reset = nil
//            }
//            if var reset = item.value as? UInt16?{
//                reset = nil
//            }
//            if var reset = item.value as? UInt32?{
//                reset = nil
//            }
//            if var reset = item.value as? String?{
//                reset = nil
//            }
//        }
//    }
    
    init(){
    }
    
    class Block_1_Country: Model_3{
        
        var ID         : UInt32? // - идентификатор
        var isRegion   : Bool?   // UInt32 - булев признак, регион ли это
        var name       : String? // - название страны
        var sort       : UInt32? // - сортировка
        var continentID: UInt8?  // - идентификатор континента
        var coord_X    : UInt16? // - координата флага по х
        var coord_Y    : UInt16? // - координата флага по у
        var isRussia   : Bool?   // UInt8 булев признак, является ли данная страна Россией
        
        override init() {
            super.init()
            typeDefine = [1]    // блок = 1, то читаем страну
            description = "Страна"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
            
            ID          = data.toUInt32(&shift)
            isRegion    = data.toUInt32(&shift) > 0 ? true : false
            name        = data.toString(&shift)
            sort        = data.toUInt32(&shift)
            continentID = data.toUInt8 (&shift)
            coord_X     = data.toUInt16(&shift)
            coord_Y     = data.toUInt16(&shift)
            isRussia    = data.toUInt8 (&shift) > 0 ? true : false
        }
        
        func reset() -> Self{
            ID          = nil
            isRegion    = nil
            name        = nil
            sort        = nil
            continentID = nil
            coord_X     = nil
            coord_Y     = nil
            isRussia    = nil
            
            return self
        }
    }
    
    class Block_2_Сhampionship: Model_3{
        
        var ID         : UInt32?  // - идентификатор
        var sportID    : UInt32?  // - идентификатор спорта
        var countryID  : UInt32?  // - идентификатор страны
        var name       : String?  // - название
        var sort       : UInt32?  // - сортировка
        var example    : UInt32?  // - пример
        var type       : UInt32?  // - тип
        var menuLevel  : UInt8?   // - уровень вложенности меню
        var menuSort   : UInt32?  // - сортировка в меню
        var menuSubSort: UInt32?  // - подсортировка в меню
        
        override init() {
            super.init()
            typeDefine = [2, 21] // блок = 2  или 21, то читаем страну
            description = "Чемпионат"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
            
            ID          = data.toUInt32(&shift)
            sportID     = data.toUInt32(&shift)
            countryID   = data.toUInt32(&shift)
            name        = data.toString(&shift)
            sort        = data.toUInt32(&shift)
            example     = data.toUInt32(&shift)
            type        = data.toUInt32(&shift)
            menuLevel   = data.toUInt8 (&shift)
            menuSort    = data.toUInt32(&shift)
            menuSubSort = data.toUInt32(&shift)
            
           // _ = data.toUInt32(&shift) // Дополнительно читаем 4 байта (не хватало  поля: "type")
        }

        func reset() -> Self{
            
            ID          = nil
            sportID     = nil
            countryID   = nil
            name        = nil
            sort        = nil
            example     = nil
            type        = nil
            menuLevel   = nil
            menuSort    = nil
            menuSubSort = nil
            
            return self
        }
    }
    
    class Block_3_Event: Model_3{
     
        var ID              : UInt32?  // - идентификатор
        var serviceRadarID  : UInt32?  // - идентификатор сервиса радар
        var serviceGeniusID : UInt32?  // - идентификатор сервиса гениус
        var flagRadar       : UInt8?   // - признак радара
        var category        : UInt8?   // - категория
        var streamingLive   : Bool?    // UInt8 - булев признак, будет ли трансляция в лайве
        var props           : UInt8?   // - пропсы
        var cards           : UInt16?  // - карточки
        var channels        : String?  // - каналы
        var startDate       : UInt32?  // - дата начала
        var numberOfLines   : UInt8?   // - число линий
        var inExpress       : UInt8?   // - признак участия в экспрессе
        var firstTeamName   : String?  // - имя первой команды
        var secondTeamName  : String?  // - имя второй команды
        
        //        Если прочитали этот блок, значит событие добавлено.
        //        Это событие будет участвовать в том чемпионате, который мы прочитали в последним.
        
        override init() {
            super.init()
            typeDefine = [3]
            description = "Cобытие"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
        
             ID              = data.toUInt32(&shift)
             serviceRadarID  = data.toUInt32(&shift)
             serviceGeniusID = data.toUInt32(&shift)
             flagRadar       = data.toUInt8 (&shift)
             category        = data.toUInt8 (&shift)
             streamingLive   = data.toUInt8 (&shift) > 0 ? true : false
             props           = data.toUInt8 (&shift)
             cards           = data.toUInt16(&shift)
             channels        = data.toString(&shift)
             startDate       = data.toUInt32(&shift)
             numberOfLines   = data.toUInt8 (&shift)
             inExpress       = data.toUInt8 (&shift)
             firstTeamName   = data.toString(&shift)
             secondTeamName  = data.toString(&shift)
        }
        
        func reset() -> Self{
            
            ID              = nil
            serviceRadarID  = nil
            serviceGeniusID = nil
            flagRadar       = nil
            category        = nil
            streamingLive   = nil
            props           = nil
            cards           = nil
            channels        = nil
            startDate       = nil
            numberOfLines   = nil
            inExpress       = nil
            firstTeamName   = nil
            secondTeamName  = nil
            
            return self
        }
    }

    class Block_31_Event_UpdateDate: Model_3{
    
        //        Соответственно этот блок говорит о том, что по какому-то уже имеющемуся у нас событию произошло обновление,
        //        и это событие нужно обновить.
        
        var ID       : UInt32? //- идентификатор
        var startDate: UInt32? // - дата начала
        
        override init() {
            super.init()
            typeDefine = [31]
            description = "Изменение времени события"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
        
            ID        = data.toUInt32(&shift)
            startDate = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            
            ID        = nil
            startDate = nil
            
            return self
        }
    }
    
    class Block_32_Event_Delete: Model_3{
        
        var ID       : UInt32? //- идентификатор события, которое нужно удалить, так как оно закончилось или по иным причинам.
        
        override init() {
            super.init()
            typeDefine = [32]
            description = "Удаление события"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
            ID = data.toUInt32(&shift)
        }
        
        func reset() -> Self{
            ID = nil
            return self
        }
    }
    
    class Block_33_Event_UpdateLines: Model_3{
    
        var ID           : UInt32? // - идентификатор
        var numberOfLines: UInt8?  // - число линий
        var isExpress    : UInt8?  // - признак экспресса
        
        //        Если получили и прочитали данный блок, значит событие изменилось.
        
        override init() {
            super.init()
            typeDefine = [33]
            description = "Изменение линий событий"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
        
            ID            = data.toUInt32(&shift)
            numberOfLines = data.toUInt8 (&shift)
            isExpress     = data.toUInt8 (&shift)
        }
        
        func reset() -> Self{
            
            ID            = nil
            numberOfLines = nil
            isExpress     = nil
            
            return self
        }
    }
    
    class Block_34_Event_Update: Model_3{
        
        var ID              : UInt32?  // - идентификатор
        var serviceRadarID  : UInt32?  // - идентификатор сервиса радар
        var serviceGeniusID : UInt32?  // - идентификатор сервиса гениус
        var flagRadar       : UInt8?   // - признак радара
        var category        : UInt8?   // - категория
        var streamingLive   : Bool?    // UInt8 - булев признак, будет ли трансляция в лайве
        var props           : UInt8?   // - пропсы
        var cards           : UInt16?  // - карточки
        var channels        : String?  // - каналы
        var ChampionshipID  : UInt32?  // - ID Чемпионата
        var startDate       : UInt32?  // - дата начала
        var numberOfLines   : UInt8?   // - число линий
        var inExpress       : UInt8?   // - признак участия в экспрессе
        var firstTeamName   : String?  // - имя первой команды
        var secondTeamName  : String?  // - имя второй команды
        
        override init() {
            super.init()
            typeDefine = [34]
            description = "Обновление события"
        }
        
        func parse(_ data: Data, _ shift: inout Int){
        
             ID              = data.toUInt32(&shift)
             serviceRadarID  = data.toUInt32(&shift)
             serviceGeniusID = data.toUInt32(&shift)
             flagRadar       = data.toUInt8 (&shift)
             category        = data.toUInt8 (&shift)
             streamingLive   = data.toUInt8 (&shift) > 0 ? true : false
             props           = data.toUInt8 (&shift)
             cards           = data.toUInt16(&shift)
             channels        = data.toString(&shift)
             ChampionshipID  = data.toUInt32(&shift)
             startDate       = data.toUInt32(&shift)
             numberOfLines   = data.toUInt8 (&shift)
             inExpress       = data.toUInt8 (&shift)
             firstTeamName   = data.toString(&shift)
             secondTeamName  = data.toString(&shift)
        }
        
        func reset() -> Self{
            
            ID              = nil
            serviceRadarID  = nil
            serviceGeniusID = nil
            flagRadar       = nil
            category        = nil
            streamingLive   = nil
            props           = nil
            cards           = nil
            channels        = nil
            startDate       = nil
            numberOfLines   = nil
            inExpress       = nil
            firstTeamName   = nil
            secondTeamName  = nil
            
            return self
        }
    }
    
    class Block_4_ReadLine: Model_3{
       
        var ID                : UInt32? // - идентификатор
        var typeLine          : UInt16? // - тип линии (идентификатор маркета линии)
        var margining_1       : UInt16? // - маржирование 1
        var margining_2       : UInt16? // - маржирование 2
        var flagFavorite      : UInt8?  // - признак фаворита
        var parameterValue    : UInt16? // - значение параметра
        var coeffFirstOption  : UInt16? // - коэффициент на первый вариант
        var coeffSecondOption : UInt16? // - коэффициент на второй вариант
        var coeffThirdOption  : UInt16? // - коэффициент на третий вариант
        var coeffFourthOption : UInt16? // - коэффициент на четвёртый вариант
        
        func parse(_ data: Data, _ shift: inout Int, _ model_16: Model_16? = nil){

            guard model_16 != nil else {return}
            
            ID              = data.toUInt32(&shift)
            typeLine        = data.toUInt16(&shift)
            margining_1     = data.toUInt16(&shift)
            margining_2     = data.toUInt16(&shift)

            // По типу линии находим маркет, который был прочитан в степе 16, и получаем его
            let market = model_16?.getMarket(by: UInt32(typeLine!))
            
            // Проверяем его тип
            let typeMarket = market?.type ?? 9999
            
            //print("typeMarket == \(typeMarket )")

            
            switch typeMarket{

            case 3, 6:
                flagFavorite   = data.toUInt8(&shift)
                parameterValue = data.toUInt16(&shift)
                
            case 4, 7:
                parameterValue = data.toUInt16(&shift)
                
            case 51, 151:
                break
                
            case 61, 71:
                parameterValue = data.toUInt16(&shift)
            default:
                break
            }
            
            coeffFirstOption  = data.toUInt16(&shift)
            coeffSecondOption = data.toUInt16(&shift)
            
            switch typeMarket{  //typeLine

            case 2, 5, 51:
                coeffThirdOption = data.toUInt16(&shift)
                
            case 9:
                coeffThirdOption  = data.toUInt16(&shift)
                coeffFourthOption = data.toUInt16(&shift)
                
            default:
                break
            }
        }

        func reset() -> Self{
            
             ID                = nil
             typeLine          = nil
             margining_1       = nil
             margining_2       = nil
             flagFavorite      = nil
             parameterValue    = nil
             coeffFirstOption  = nil
             coeffSecondOption = nil
             coeffThirdOption  = nil
             coeffFourthOption = nil
            
            return self
        }

        override init() {
            super.init()
            typeDefine = [4]
            description = "Читаем линию"
        }
    }
    
    class Block_42_DeleteLine: Model_3{
       
        var ID: UInt32? // - идентификатор
        
        func parse(_ data: Data, _ shift: inout Int){
            ID = data.toUInt32(&shift)
        }
 
        func reset() -> Self{
            
            ID = nil
            
            return self
        }
        
        override init() {
            super.init()
            typeDefine = [42]
            description = "Удаление линии"
        }
    }
 
    class Block_43_UpdateLine: Model_3{
       
        var ID                : UInt32? // - идентификатор
        var EventID           : UInt32? // - идентификатор события, которому линия принадлежит
        var typeLine          : UInt16? // - тип линии (идентификатор маркета линии)
        var margining_1       : UInt16? // - маржирование 1
        var margining_2       : UInt16? // - маржирование 2
        var flagFavorite      : UInt8?  // - признак фаворита
        var parameterValue    : UInt16? // - значение параметра
        var coeffFirstOption  : UInt16? // - коэффициент на первый вариант
        var coeffSecondOption : UInt16? // - коэффициент на второй вариант
        var coeffThirdOption  : UInt16? // - коэффициент на третий вариант
        var coeffFourthOption : UInt16? // - коэффициент на четвёртый вариант

        func parse(_ data: Data, _ shift: inout Int, _ model_16: Model_16? = nil){

            guard model_16 != nil else {return}
            
            ID              = data.toUInt32(&shift)
            EventID         = data.toUInt32(&shift)
            typeLine        = data.toUInt16(&shift)
            margining_1     = data.toUInt16(&shift)
            margining_2     = data.toUInt16(&shift)

            // По типу линии находим маркет, который был прочитан в степе 16, и получаем его
            let market = model_16?.getMarket(by: UInt32(typeLine!))
            
            guard market != nil else {return}
            
            // Проверяем его тип
            let typeMarket = market?.type
            
            switch typeMarket{
                
            case 3, 6:
                flagFavorite   = data.toUInt8(&shift)
                parameterValue = data.toUInt16(&shift)
                
            case 4, 7:
                parameterValue = data.toUInt16(&shift)
                
            case 51, 151:
                break
                
            case 61, 71:
                parameterValue = data.toUInt16(&shift)
            default:
                break
            }

            coeffFirstOption  = data.toUInt16(&shift)
            coeffSecondOption = data.toUInt16(&shift)
            
            switch typeMarket{ //typeLine{
                
            case 2, 5, 51:
                coeffThirdOption = data.toUInt16(&shift)
                
            case 9:
                coeffThirdOption  = data.toUInt16(&shift)
                coeffFourthOption = data.toUInt16(&shift)
                
            default:
                break
            }
        }

        func reset() -> Self{
            
             ID                = nil
             EventID           = nil
             typeLine          = nil
             margining_1       = nil
             margining_2       = nil
             flagFavorite      = nil
             parameterValue    = nil
             coeffFirstOption  = nil
             coeffSecondOption = nil
             coeffThirdOption  = nil
             coeffFourthOption = nil
            
            return self
        }

        override init() {
            super.init()
            typeDefine = [43]
            description = "Обновление линии"
        }
    }
}






//
//protocol MyType {}
//extension Data: MyType {
//
//static    var x = 0
//    func z(){
//
//    }
//}
