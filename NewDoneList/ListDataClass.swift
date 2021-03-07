//
//  UserDefaults.swift
//  NewDoneList
//
//  Created by 福本伊織 on 2021/03/06.
//

import Foundation

class ListData{
    
    var list: [DoneStruct] = []
    
    //エンコード
    func serialize(doneStructList:[DoneStruct]) -> Data? {
        do{
            let encoder = JSONEncoder()
            return try encoder.encode(doneStructList)
        }catch {
            return nil
        }
    }
    
    //保存
    func save(list:[DoneStruct]){
        
        let doneStructList:[DoneStruct] = list
        guard let data = serialize(doneStructList: doneStructList) else {
            return
        }
        
        UserDefaults.standard.setValue(data, forKeyPath: "DoneStructList")
    }
    
    //デコード
    func processJson(data: Data) -> [DoneStruct]? {
        
        do{
            let jsonDecoder = JSONDecoder()
            return try jsonDecoder.decode([DoneStruct].self, from: data)
        }catch{
            return nil
        }
    }
    
    //取得
    func getValue() -> [DoneStruct]? {
        
        guard let data = UserDefaults.standard.data(forKey: "DoneStructList") else {
            return nil
        }
        return processJson(data: data)
    }
    
    
}

