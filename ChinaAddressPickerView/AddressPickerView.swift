//
//  AddressPickerView.swift
//
//
//  Created by mac on 15/12/22.
//  Copyright © 2015年 planning. All rights reserved.
//
//  “道生一,一生二,二生三,三生万物”

import UIKit

public protocol AddressPickerDelegate:class {
    func OnUpdate(sender: AddressPickerView)
}
private struct PickerViewConstants{
    static private let COMPONENT_COUNT = 3
    static private let PROVINCE = 0
    static private let CITY = 1
    static private let DISTRICT = 2
}


public class AddressPickerView: UIPickerView,UIPickerViewDataSource,UIPickerViewDelegate {
    
    public var addressDelegate: AddressPickerDelegate?
    private(set) public var resultValue : String?
    private(set) public var rootNode: String?
    private(set) public var parentNode: String?
    private(set) public var chileNode: String?
    
    private(set) public var dataArray : NSArray?
    private(set) public var cityArray : NSArray?
    private(set) public var districtArray : NSArray?
    
    //省
    private(set) public var province : String?
    //市
    private(set) public var city : String?
    //区
    private(set) public var district : String?
    

    override public func didMoveToWindow() {
        super.didMoveToWindow()
        
        addressDelegate?.OnUpdate(self)
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
        self.initData(["北京","北京","朝阳区"])
        
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initData(["北京","北京","朝阳区"])
        
    }
    //custom init
    private func initData(defaultValue : [String] = []){
        
        self.delegate = self
        self.dataSource = self
        dataArray = AddressTool.getAddressArray()
        
        let firstAreaModel : AddressModel = dataArray!.firstObject as! AddressModel
        cityArray = firstAreaModel.cites
        
        let firstCitiesModel : AddressCitiesModel = cityArray!.firstObject as! AddressCitiesModel
        districtArray = firstCitiesModel.address
        
        province = firstAreaModel.state
        city = firstCitiesModel.state
        district = districtArray!.firstObject as? String
        
        if defaultValue.count > 0 {
            
            var provinceIndex : Int = 0
            var cityIndex : Int = 0
            var districtIndex : Int = 0
            
            dataArray!.enumerateObjectsUsingBlock({
                (item, idx, stop) in
                let currAreaModel : AddressModel = item as! AddressModel
                if currAreaModel.state == defaultValue[0] {
                    provinceIndex = idx
                    self.cityArray = currAreaModel.cites
                }
                
            })
            
            cityArray!.enumerateObjectsUsingBlock({
                (item, idx, stop) in
                let currCitiesModel : AddressCitiesModel = item as! AddressCitiesModel
                if currCitiesModel.state == defaultValue[1] {
                    cityIndex = idx
                    self.districtArray = currCitiesModel.address
                }
                
            })
            
            districtArray!.enumerateObjectsUsingBlock({
                (item, idx, flag) in
                let currDistrict : String = item as! String
                if currDistrict == defaultValue[2] {
                    districtIndex = idx
                }
                
            })
            
            if defaultValue[1] == "" && cityIndex == 0 {
                self.districtArray = NSArray()
            }
            if defaultValue[2] == "" && districtIndex == 0 {
                self.district = ""
            }
            resultValue = defaultValue[0] + " " + defaultValue[1] + " " + defaultValue[2]
            
            self.selectRow(provinceIndex, inComponent: PickerViewConstants.PROVINCE, animated: false)
            self.selectRow(cityIndex, inComponent: PickerViewConstants.CITY, animated: false)
            self.selectRow(districtIndex, inComponent: PickerViewConstants.DISTRICT, animated: false)
        }else{
            resultValue = province! + " " + city! + " " + district!
        }
    }
    func getResult() -> String{
        return resultValue!
    }
    
    // implement from UIPickerViewDataSource
    public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int{
    
        return PickerViewConstants.COMPONENT_COUNT
    }
    
    public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        var number : Int = 0
        
        switch (component) {
        case PickerViewConstants.PROVINCE:
            number = dataArray!.count
            break
        case PickerViewConstants.CITY:
            number = cityArray!.count
            break
        case PickerViewConstants.DISTRICT:
            number = districtArray!.count
            break
        default :
            break
        }
        return number;
        
    }
//    
//    public func pickerView(pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat{
//    return 1
//        
//    }
//    public func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat{
//        return 1
//        
//    }
    
    public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        var titleText : String = "请选择"
        switch (component) {
        case PickerViewConstants.PROVINCE:
            let currAreaModel : AddressModel = dataArray![row] as! AddressModel
            titleText = currAreaModel.state
            break
        case PickerViewConstants.CITY:
            if cityArray!.count>0 {
                let currAreaCityModel : AddressCitiesModel = cityArray![row] as! AddressCitiesModel
                titleText = currAreaCityModel.state
            }else{
                titleText = ""
            }
            
            break
        case PickerViewConstants.DISTRICT:
            if districtArray!.count>0 {
                titleText = districtArray![row] as! String
            }else{
                titleText = ""
            }
            break
        default :
            break
        }
        return titleText
        
    }
//    public func pickerView(pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString?{
//        return nil
//        
//    }

    public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if (PickerViewConstants.PROVINCE == component) {
            let areaModel : AddressModel = dataArray![row] as! AddressModel
            cityArray = areaModel.cites
            province = areaModel.state

            if cityArray!.count > 0 {
                let citiesModel : AddressCitiesModel = cityArray!.firstObject as! AddressCitiesModel
                districtArray = citiesModel.address
                city = citiesModel.state
            }else{
                city = ""
                districtArray = NSArray()
            }
            
            pickerView.reloadComponent(PickerViewConstants.CITY)
            pickerView.selectRow(0, inComponent: PickerViewConstants.CITY, animated: true)
            
            
            pickerView.reloadComponent(PickerViewConstants.DISTRICT)
            pickerView.selectRow(0, inComponent: PickerViewConstants.DISTRICT, animated: true)
            
            if districtArray!.count > 0{
                district = districtArray!.firstObject as? String
            }else{
                district = ""
            }
            
            
        } else if (PickerViewConstants.CITY == component) {
            if (cityArray!.count > 0) {
                let citiesModel : AddressCitiesModel = cityArray![row] as! AddressCitiesModel
                districtArray = citiesModel.address
                
                if citiesModel.state != city {
                    city = citiesModel.state
                    pickerView.reloadComponent(PickerViewConstants.DISTRICT)
                    pickerView.selectRow(0, inComponent: PickerViewConstants.DISTRICT, animated: true)
                }
                 district = districtArray!.firstObject as? String
                
            }
        } else if (PickerViewConstants.DISTRICT == component) {
            if districtArray!.count > 0{
                 district = districtArray![row] as? String
            }
            
        }
        
        resultValue = province! + " " + city! + " " + district!
        addressDelegate?.OnUpdate(self)
        
    }

}
