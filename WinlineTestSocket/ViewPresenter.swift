//
//  ViewPresenter.swift
//  WinlineTestSocket
//
//  Created by Garri Avakyan on 01.04.2022.
//  Copyright © 2022 StLiga. All rights reserved.
//

import Foundation
import Gzip

class ViewPresenter {
    
    var model_16: Model_16!
    
    
    var webSocketTask: URLSessionWebSocketTask!
    let wssAdressWinline = URL(string: "wss://wss.winline.ru/data_ng?client=ios")!
//    let wssAdressWinline = URL(string: "wss://wss.winline.ru/data")!
    var configWebSocket  = URLSessionConfiguration.default
    
    func serverUp(){
        
        model_16 = Model_16()
        
        openConnection()
        sendMessages()
        readMessages()
    }
    
    func openConnection(){
        
        // добавочные хэдеры
        configWebSocket.httpAdditionalHeaders = ["Origin": "https://winline.ru",
                                                 "Host": "wss.winline.ru",
                                                 "User-Client": "iOS"]
        
        let urlSession = URLSession(configuration: configWebSocket)
        
        // open a connection
        webSocketTask = urlSession.webSocketTask(with: wssAdressWinline)
        webSocketTask.resume()
    }
    
    func sendMessages(){
        let commands = ["menu", "data", "winline", "site.cfg", "AAAAAg=="]
        
        for command in commands {
            let message = URLSessionWebSocketTask.Message.string(command)
            webSocketTask.send(message) { error in
                if let error = error {
                    print("WebSocket sending error: \(error)")
                }
            }
        }
        webSocketTask.resume()
    }
    
    func readMessages(){
        webSocketTask.receive { result in
            switch result {
            case .failure(let error):
                print("Failed to receive message: \(error)")
            case .success(let message):
                switch message {
                case .string(let text):
                    print("Received text message: \(text)")
                case .data(let data):
                    print("Received binary message: \(data)")
                    self.pleaseUnZipThis(data)
                @unknown default:
                    fatalError()
                }
                
                self.readMessages()
            }
        }
    }
    
    
    func pleaseUnZipThis(_ data: Data){
        var decompressedData: Data
        if data.isGzipped {
            decompressedData = try! data.gunzipped()
            let type: UInt16 = UInt16(decompressedData[0]) | UInt16(decompressedData[1] << 8 )
            print(String (format: "incoming type: %-4d %d byte", type, decompressedData.count))
            pleaseParseThisPacket(type: type, data: decompressedData, 2)
        } else {
            decompressedData = data
            print("zip Fail")
        }
    }
    
    func pleaseParseThisPacket( type: UInt16,  data: Data, _ shift: Int){
        
        switch type{
          
        case 16:
            print("Виды спорта и маркеты")
            packet_16(data, shift)
            
        case 3:
            print("Прематч")
            packet_03(data, shift)
            
        case 4:
            print("Лайв")
//            packet_4(data, shift)
            
        default:
            break
        }
    }

    func packet_16(_ data: Data, _ shift: Int){
        
        var delta = shift
        

        
// parse sports
        model_16.sportsCount = data.toUInt32(&delta)
        
        for _ in 0..<model_16.sportsCount{
            
            let sport = Sport()
            
            sport.sportID    = data.toUInt32(&delta)
            sport.sportSort  = data.toUInt32(&delta)
            sport.sportTitle = data.toString(&delta)
            
            for _ in 1...9 {
                let str = data.toString(&delta)
                sport.serviceCharacteristics.append(str)
            }
            model_16.sport.append(sport)
        }

// parse markets
        model_16.marketCount = data.toUInt32(&delta)
        
        for _ in 0..<model_16.marketCount{
            
            let market = Market()
            
            market.marketID        = data.toUInt32(&delta)
            market.supportSports   = data.toString(&delta)
            market.isThereSelected = data.toUInt32(&delta)
            market.count           = data.toUInt32(&delta)
            market.type            = data.toUInt32(&delta)
            market.marketTitle     = data.toString(&delta)
            
            for _ in 1...30 {
                let str = data.toString(&delta)
                market.marketOutcome.append(str)
            }
            model_16.market.append(market)
        }
        
        let _ = 0 // break down
        
    }

    func packet_03(_ data: Data, _ shift: Int){

        var delta = shift
        
        var dic: [ Int: Model_3] = [ : ]
        
        dic[1]  = Model_3.Block_1_Country()
        dic[2]  = Model_3.Block_2_Сhampionship()
        dic[21] = dic[2]
        dic[3]  = Model_3.Block_3_Event()
        dic[31] = Model_3.Block_31_Event_UpdateDate()
        dic[32] = Model_3.Block_32_Event_Delete()
        dic[33] = Model_3.Block_33_Event_UpdateLines()
        dic[34] = Model_3.Block_34_Event_Update()
        dic[4]  = Model_3.Block_4_ReadLine()
        dic[42] = Model_3.Block_42_DeleteLine()
        dic[43] = Model_3.Block_43_UpdateLine()
    
        
        for _ in 1...16{
            print ("\(data.toUInt8(&delta)) ", terminator: "")
        }
        print("")

        
//----------------------------------------
        // delta      - текущее
        // data.count - общее

        while delta < data.count{
            
            let type = data.toUInt8(&delta)
         //   print ("block: \(type); ", terminator: "")
            
            if dic[Int(type)] != nil{
         //       print(dic[Int(type)]?.description ?? "", terminator: "")
                
                switch type{
                    
                case 1:
                    let model = dic[Int(type)] as? Model_3.Block_1_Country
                    model?.reset().parse(data, &delta)
                  //  print(model?.toString() ?? "")
                    
                case 2, 21:
                    let model = dic[Int(type)] as? Model_3.Block_2_Сhampionship
                    model?.reset().parse(data, &delta)
                  //  print(model?.toString() ?? "")
                    
                case 3:
                    let model = dic[Int(type)] as? Model_3.Block_3_Event
                    model?.reset().parse(data, &delta)
                 //   print(model?.toString() ?? "")
                    
                case 31:
                    let model = dic[Int(type)] as? Model_3.Block_31_Event_UpdateDate
                    model?.reset().parse(data, &delta)
                //    print(model?.toString() ?? "")

                case 32:
                    let model = dic[Int(type)] as? Model_3.Block_32_Event_Delete
                    model?.reset().parse(data, &delta)
                 //   print(model?.toString() ?? "")
                    
                case 33:
                    let model = dic[Int(type)] as? Model_3.Block_33_Event_UpdateLines
                    model?.reset().parse(data, &delta)
                 //   print(model?.toString() ?? "")
                    
                case 34:
                    let model = dic[Int(type)] as? Model_3.Block_34_Event_Update
                    model?.reset().parse(data, &delta)
                //    print(model?.toString() ?? "")
                    
                case 4:
                    let model = dic[Int(type)] as? Model_3.Block_4_ReadLine
                    model?.reset().parse(data, &delta, model_16)
                //    print(model?.toString() ?? "")
                    
                case 42:
                    let model = dic[Int(type)] as? Model_3.Block_42_DeleteLine
                    model?.reset().parse(data, &delta)
                //    print(model?.toString() ?? "")
                    
                case 43:
                    let model = dic[Int(type)] as? Model_3.Block_43_UpdateLine
                    model?.reset().parse(data, &delta, model_16)
                //    print(model?.toString() ?? "")
                    
                default:
                //    print("")
                    break
                }//switch
            }//if
            else{
                print("Unknow packet !!!")
            }
            
       //     print(" parse \(delta) - \(data.count) ")
                        
        }// while
            
        print("...finish")
        
        
    }

    func packet_4(_ data: Data, _ shift: Int){
        
        var delta = shift
        var dic: [ Int: Model_4] = [ : ]
        
        dic[2] = Model_4.Block_2_Championship()
        dic[3] = Model_4.Block_3_Event()
        dic[4] = Model_4.Block_4_EventUpdate()
        dic[5] = Model_4.Block_5_Line()
        dic[6] = Model_4.Block_6_LineAdding()
        
        
        for _ in 1...12{
            print ("\(data.toUInt8(&delta)) ", terminator: "")
        }
       // print("")
        
        while delta < data.count{
            
            let type = data.toUInt8(&delta)
            print ("block: \(type); ", terminator: "")
            
            if dic[Int(type)] != nil{
                print(dic[Int(type)]?.description ?? "")
                
                switch type{
                    
                case 2:
                    if let model = dic[Int(type)] as? Model_4.Block_2_Championship{
                        model.reset().parse(data, &delta)
                        print(model.toString())
                    }
                    
                case 3:
                    if let model = dic[Int(type)] as? Model_4.Block_3_Event{
                        model.reset().parse(data, &delta)
                        print(model.toString())
                    }
                    
                case 4:
                    if let model = dic[Int(type)] as? Model_4.Block_4_EventUpdate{
                        model.reset().parse(data, &delta)
                        print(model.toString())
                    }
                    
                case 5:
                    if let model = dic[Int(type)] as? Model_4.Block_5_Line{
                        model.reset().parse(data, &delta)
                        print(model.toString())
                    }
                    
                case 6:
                    if let model = dic[Int(type)] as? Model_4.Block_2_Championship{
                        model.reset().parse(data, &delta)
                        print(model.toString())
                    }
                    
                default:
                    break
                }// switch
            }//if e
            else{
                print("Unknow packet !!!")
            }
            
            //print("parse \(data.count) - \(delta)")
            
        }// while
        
        print("...finish")
    }

    
    
    
}




