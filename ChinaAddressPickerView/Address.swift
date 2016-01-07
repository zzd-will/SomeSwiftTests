//
//  ChinaAddress.swift
//  pickViewTests
//
//  Created by mac on 15/12/22.
//  Copyright © 2015年 planning. All rights reserved.
//

import Foundation

class AddressModel : NSObject {
    var cites : NSArray = NSArray()
    var state : String = ""
    
    init(dictionary : NSDictionary){
        let citiesArray : NSMutableArray = NSMutableArray()
        dictionary["cities"]?.enumerateObjectsUsingBlock({
            (dict,idx,stop) in
            
            let addressCitiesModel : AddressCitiesModel = AddressCitiesModel(dict: dict as! NSDictionary)
            citiesArray.addObject(addressCitiesModel)
            
        })
        
        self.cites = citiesArray
        self.state = dictionary["state"] as! String
    }
}
class AddressCitiesModel : NSObject{
    var address : NSArray = NSArray()
    var state : String = ""
    init(dict : NSDictionary){
        if let stateStr : String = dict["state"] as? String{
            self.state = stateStr
        }
        
        if let addressArr : NSArray = dict["areas"] as? NSArray {
            self.address = addressArr
        }
    }
}

class AddressTool: NSObject {
    
    class func getAddressArray()->NSArray{
        let path : String = NSBundle.mainBundle().pathForResource("Address", ofType: "plist")!
        let resourceArray = NSArray(contentsOfFile: path)
        let modelArray : NSMutableArray = NSMutableArray()
        resourceArray?.enumerateObjectsUsingBlock({
            (item,idx,stop) -> Void in
            
            let model : AddressModel = AddressModel(dictionary: item as! NSDictionary)
            modelArray.addObject(model)
        })
        
        return modelArray
    }
    
}
