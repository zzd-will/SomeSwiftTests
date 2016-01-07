//
//  JSONParser.swift
//

// NetWorking json object  done

import Foundation


public typealias JSONDictionary = [String: AnyObject]

infix operator <-- { associativity right precedence 150 }


private func convertToNilIfNull(object: AnyObject?) -> AnyObject? {
  if object is NSNull {
    return nil
  }
  return object
}

// MARK: Deserialization

public func <-- <T>(inout property: T?, value: AnyObject?) -> T? {
  var newValue: T?
  ""
  if let unwrappedValue: AnyObject = convertToNilIfNull(value) {
  
    if let convertedValue = unwrappedValue as? T {
      
      newValue = convertedValue
    } else {
     
      switch property {
      case is Int?:
        if unwrappedValue is String {
          if let intValue = Int("\(unwrappedValue)") {
            newValue = intValue as? T
          }
        }
      case is NSURL?:
        newValue = NSURL(string: "\(unwrappedValue)") as? T
      case is NSDate?:
        if let timestamp = unwrappedValue as? Int {
          newValue = NSDate(timeIntervalSince1970: Double(timestamp)) as? T
        } else if let timestamp = unwrappedValue as? Double {
          newValue = NSDate(timeIntervalSince1970: timestamp) as? T
        } else if let timestamp = unwrappedValue as? NSNumber {
          newValue = NSDate(timeIntervalSince1970: timestamp.doubleValue) as? T
        }
      default:
        break
      }
    }
  }
  property = newValue
  return property
}


public func <-- <T>(inout property: T, value: AnyObject?) -> T {
  var newValue: T?
  newValue <-- value
  if let newValue = newValue { property = newValue }
  return property
}


public func <-- (inout property: NSDate?, valueAndFormat: (AnyObject?, AnyObject?)) -> NSDate? {
  var newValue: NSDate?
  if let dateString = convertToNilIfNull(valueAndFormat.0) as? String {
    if let formatString = convertToNilIfNull(valueAndFormat.1) as? String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = formatString
      if let newDate = dateFormatter.dateFromString(dateString) {
        newValue = newDate
      }
    }
  }
  property = newValue
  return property
}

public func <-- (inout property: NSDate, valueAndFormat: (AnyObject?, AnyObject?)) -> NSDate {
  var date: NSDate?
  date <-- valueAndFormat
  if let date = date { property = date }
  return property
}

// MARK:  Array Deserialization

public func <-- (inout array: [String]?, value: AnyObject?) -> [String]? {
  if let stringArray = convertToNilIfNull(value) as? [String] {
    array = stringArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [String], value: AnyObject?) -> [String] {
  var newValue: [String]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Int]?, value: AnyObject?) -> [Int]? {
  if let intArray = convertToNilIfNull(value) as? [Int] {
    array = intArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Int], value: AnyObject?) -> [Int] {
  var newValue: [Int]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Float]?, value: AnyObject?) -> [Float]? {
  if let floatArray = convertToNilIfNull(value) as? [Float] {
    array = floatArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Float], value: AnyObject?) -> [Float] {
  var newValue: [Float]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Double]?, value: AnyObject?) -> [Double]? {
  if let doubleArrayDoubleExcitement = convertToNilIfNull(value) as? [Double] {
    array = doubleArrayDoubleExcitement
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Double], value: AnyObject?) -> [Double] {
  var newValue: [Double]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [Bool]?, value: AnyObject?) -> [Bool]? {
  if let boolArray = convertToNilIfNull(value) as? [Bool] {
    array = boolArray
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [Bool], value: AnyObject?) -> [Bool] {
  var newValue: [Bool]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [NSURL]?, value: AnyObject?) -> [NSURL]? {
  if let stringURLArray = convertToNilIfNull(value) as? [String] {
    array = [NSURL]()
    for stringURL in stringURLArray {
      if let url = NSURL(string: stringURL) {
        array!.append(url)
      }
    }
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [NSURL], value: AnyObject?) -> [NSURL] {
  var newValue: [NSURL]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [NSDate]?, valueAndFormat: (AnyObject?, AnyObject?)) -> [NSDate]? {
  var newValue: [NSDate]?
  if let dateStringArray = convertToNilIfNull(valueAndFormat.0) as? [String] {
    if let formatString = convertToNilIfNull(valueAndFormat.1) as? String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = formatString
      newValue = [NSDate]()
      for dateString in dateStringArray {
        if let date = dateFormatter.dateFromString(dateString) {
          newValue!.append(date)
        }
      }
    }
  }
  array = newValue
  return array
}

public func <-- (inout array: [NSDate], valueAndFormat: (AnyObject?, AnyObject?)) -> [NSDate] {
  var newValue: [NSDate]?
  newValue <-- valueAndFormat
  if let newValue = newValue { array = newValue }
  return array
}

public func <-- (inout array: [NSDate]?, value: AnyObject?) -> [NSDate]? {
  if let timestamps = convertToNilIfNull(value) as? [AnyObject] {
    array = [NSDate]()
    for timestamp in timestamps {
      var date: NSDate?
      date <-- timestamp
      if date != nil { array!.append(date!) }
    }
  } else {
    array = nil
  }
  return array
}

public func <-- (inout array: [NSDate], value: AnyObject?) -> [NSDate] {
  var newValue: [NSDate]?
  newValue <-- value
  if let newValue = newValue { array = newValue }
  return array
}


// MARK:  Map Deserialization

public func <-- (inout map: [String: String]?, value: AnyObject?) -> [String: String]? {
  if let stringMap = convertToNilIfNull(value) as? [String: String] {
    map = stringMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: String], value: AnyObject?) -> [String: String] {
  var newValue: [String: String]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Int]?, value: AnyObject?) -> [String: Int]? {
  if let intMap = convertToNilIfNull(value) as? [String: Int] {
    map = intMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Int], value: AnyObject?) -> [String: Int] {
  var newValue: [String: Int]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Float]?, value: AnyObject?) -> [String: Float]? {
  if let floatMap = convertToNilIfNull(value) as? [String: Float] {
    map = floatMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Float], value: AnyObject?) -> [String: Float] {
  var newValue: [String: Float]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Double]?, value: AnyObject?) -> [String: Double]? {
  if let doubleMapDoubleExcitement = convertToNilIfNull(value) as? [String: Double] {
    map = doubleMapDoubleExcitement
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Double], value: AnyObject?) -> [String: Double] {
  var newValue: [String: Double]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: Bool]?, value: AnyObject?) -> [String: Bool]? {
  if let boolMap = convertToNilIfNull(value) as? [String: Bool] {
    map = boolMap
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: Bool], value: AnyObject?) -> [String: Bool] {
  var newValue: [String: Bool]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: NSURL]?, value: AnyObject?) -> [String: NSURL]? {
  if let stringURLMap = convertToNilIfNull(value) as? [String: String] {
    map = [String: NSURL]()
    for (key, stringURL) in stringURLMap {
      if let url = NSURL(string: stringURL) {
        map![key] = url
      }
    }
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: NSURL], value: AnyObject?) -> [String: NSURL] {
  var newValue: [String: NSURL]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: NSDate]?, valueAndFormat: (AnyObject?, AnyObject?)) -> [String: NSDate]? {
  var newValue: [String: NSDate]?
  if let dateStringMap = convertToNilIfNull(valueAndFormat.0) as? [String: String] {
    if let formatString = convertToNilIfNull(valueAndFormat.1) as? String {
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateFormat = formatString
      newValue = [String: NSDate]()
      for (key, dateString) in dateStringMap {
        if let date = dateFormatter.dateFromString(dateString) {
          newValue![key] = date
        }
      }
    }
  }
  map = newValue
  return map
}

public func <-- (inout map: [String: NSDate], valueAndFormat: (AnyObject?, AnyObject?)) -> [String: NSDate] {
  var newValue: [String: NSDate]?
  newValue <-- valueAndFormat
  if let newValue = newValue { map = newValue }
  return map
}

public func <-- (inout map: [String: NSDate]?, value: AnyObject?) -> [String: NSDate]? {
  if let timestamps = convertToNilIfNull(value) as? [String: AnyObject] {
    map = [String: NSDate]()
    for (key, timestamp) in timestamps {
      var date: NSDate?
      date <-- timestamp
      if date != nil { map![key] = date! }
    }
  } else {
    map = nil
  }
  return map
}

public func <-- (inout map: [String: NSDate], value: AnyObject?) -> [String: NSDate] {
  var newValue: [String: NSDate]?
  newValue <-- value
  if let newValue = newValue { map = newValue }
  return map
}


// MARK: Custom Object Deserialization

public protocol Deserializable {
  init(data: JSONDictionary)
}

public func <-- <T: Deserializable>(inout instance: T?, dataObject: AnyObject?) -> T? {
  if let data = convertToNilIfNull(dataObject) as? JSONDictionary {
    instance = T(data: data)
  } else {
    instance = nil
  }
  return instance
}

public func <-- <T: Deserializable>(inout instance: T, dataObject: AnyObject?) -> T {
  var newInstance: T?
  newInstance <-- dataObject
  if let newInstance = newInstance { instance = newInstance }
  return instance
}

// MARK: Custom Object Array Deserialization

public func <-- <T: Deserializable>(inout array: [T]?, dataObject: AnyObject?) -> [T]? {
  if let dataArray = convertToNilIfNull(dataObject) as? [JSONDictionary] {
    array = [T]()
    for data in dataArray {
      array!.append(T(data: data))
    }
  } else {
    array = nil
  }
  return array
}

public func <-- <T: Deserializable>(inout array: [T], dataObject: AnyObject?) -> [T] {
  var newArray: [T]?
  newArray <-- dataObject
  if let newArray = newArray { array = newArray }
  return array
}

// MARK: Custom Object Map Deserialization

public func <-- <T: Deserializable>(inout map: [String: T]?, dataObject: AnyObject?) -> [String: T]? {
  if let dataMap = convertToNilIfNull(dataObject) as? [String: JSONDictionary] {
    map = [String: T]()
    for (key, data) in dataMap {
      map![key] = T(data: data)
    }
  } else {
    map = nil
  }
  return map
}

public func <-- <T: Deserializable>(inout map: [String: T], dataObject: AnyObject?) -> [String: T] {
  var newMap: [String: T]?
  newMap <-- dataObject
  if let newMap = newMap { map = newMap }
  return map
}

// MARK: Raw Value Representable (Enum) Deserialization

public func <-- <T: RawRepresentable>(inout property: T?, value: AnyObject?) -> T? {
  var newEnumValue: T?
  var newRawEnumValue: T.RawValue?
  newRawEnumValue <-- value
  if let unwrappedNewRawEnumValue = newRawEnumValue {
    if let enumValue = T(rawValue: unwrappedNewRawEnumValue) {
      newEnumValue = enumValue
    }
  }
  property = newEnumValue
  return property
}


public func <-- <T: RawRepresentable>(inout property: T, value: AnyObject?) -> T {
  var newValue: T?
  newValue <-- value
  if let newValue = newValue { property = newValue }
  return property
}

// MARK: JSON String Deserialization

private func dataStringToObject(dataString: String) -> AnyObject? {
  let data: NSData = dataString.dataUsingEncoding(NSUTF8StringEncoding)!
    do {
        let jsonObject = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions(rawValue: 0))
        return jsonObject
    } catch {
        return nil
    }
}

public func <-- <T: Deserializable>(inout instance: T?, dataString: String) -> T? {
  return instance <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout instance: T, dataString: String) -> T {
  return instance <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout array: [T]?, dataString: String) -> [T]? {
  return array <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout array: [T], dataString: String) -> [T] {
  return array <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout map: [String: T]?, dataString: String) -> [String:T]? {
    return map <-- dataStringToObject(dataString)
}

public func <-- <T: Deserializable>(inout map: [String: T], dataString: String) -> [String:T] {
    return map <-- dataStringToObject(dataString)
}
/////////////////////////
extension Array where Element: Serializable {
    
    public func toNSDictionaryArray() -> [NSDictionary] {
        var subArray = [NSDictionary]()
        for item in self {
            subArray.append(item.toDictionary())
        }
        return subArray
    }
    
    /**
     Converts the array to JSON.
     
     :returns: The array as JSON, wrapped in NSData.
     */
    public func toJson(prettyPrinted : Bool = false) -> NSData? {
        let subArray = self.toNSDictionaryArray()
        
        if NSJSONSerialization.isValidJSONObject(subArray) {
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(subArray, options: (prettyPrinted ? .PrettyPrinted : NSJSONWritingOptions()))
                return json
            } catch let error as NSError {
                print("ERROR: Unable to serialize json, error: \(error)")
            }
        }
        
        return nil
    }
    
    /**
     Converts the array to a JSON string.
     
     :returns: The array as a JSON string.
     */
    public func toJsonString(prettyPrinted : Bool = false) -> String? {
        if let jsonData = toJson(prettyPrinted) {
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding) as String?
        }
        
        return nil
    }
}

public class Serializable: NSObject {
    private class SortedDictionary : NSMutableDictionary {
        var dictionary = [String: AnyObject]()
        
        override var count : Int {
            return dictionary.count
        }
        
        override func keyEnumerator() -> NSEnumerator {
            let sortedKeys : NSArray = dictionary.keys.sort()
            return sortedKeys.objectEnumerator()
        }
        
        override func setValue(value: AnyObject?, forKey key: String) {
            dictionary[key] = value
        }
        
        override func objectForKey(aKey: AnyObject) -> AnyObject? {
            return dictionary[aKey as! String]
        }
    }
    
    
    public func formatKey(key: String) -> String {
        return key
    }
    
    public func formatValue(value: AnyObject?, forKey: String) -> AnyObject? {
        return value
    }
    
    func setValue(dictionary: NSDictionary, value: AnyObject?, forKey: String) {
        dictionary.setValue(formatValue(value, forKey: forKey), forKey: formatKey(forKey))
    }
    
    /**
     Converts the class to a dictionary.
     
     - returns: The class as an NSDictionary.
     */
    public func toDictionary() -> NSDictionary {
        let propertiesDictionary = SortedDictionary()
        let mirror = Mirror(reflecting: self)
        for (propName, propValue) in mirror.children {
            if let propValue: AnyObject = self.unwrap(propValue) as? AnyObject, propName = propName {
                if let serializablePropValue = propValue as? Serializable {
                    setValue(propertiesDictionary, value: serializablePropValue.toDictionary(), forKey: propName)
                } else if let arrayPropValue = propValue as? [Serializable] {
                    let subArray = arrayPropValue.toNSDictionaryArray()
                    setValue(propertiesDictionary, value: subArray, forKey: propName)
                } else if propValue is Int || propValue is Double || propValue is Float || propValue is Bool {
                    setValue(propertiesDictionary, value: propValue, forKey: propName)
                } else if let dataPropValue = propValue as? NSData {
                    setValue(propertiesDictionary, value: dataPropValue.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), forKey: propName)
                } else if let datePropValue = propValue as? NSDate {
                    setValue(propertiesDictionary, value: datePropValue.timeIntervalSince1970, forKey: propName)
                } else {
                    setValue(propertiesDictionary, value: propValue, forKey: propName)
                }
            }
            else if let propValue:Int8 = propValue as? Int8 {
                setValue(propertiesDictionary, value: NSNumber(char: propValue), forKey: propName!)
            }
            else if let propValue:Int16 = propValue as? Int16 {
                setValue(propertiesDictionary, value: NSNumber(short: propValue), forKey: propName!)
            }
            else if let propValue:Int32 = propValue as? Int32 {
                setValue(propertiesDictionary, value: NSNumber(int: propValue), forKey: propName!)
            }
            else if let propValue:Int64 = propValue as? Int64 {
                setValue(propertiesDictionary, value: NSNumber(longLong: propValue), forKey: propName!)
            }
            else if let propValue:UInt8 = propValue as? UInt8 {
                setValue(propertiesDictionary, value: NSNumber(unsignedChar: propValue), forKey: propName!)
            }
            else if let propValue:UInt16 = propValue as? UInt16 {
                setValue(propertiesDictionary, value: NSNumber(unsignedShort: propValue), forKey: propName!)
            }
            else if let propValue:UInt32 = propValue as? UInt32 {
                setValue(propertiesDictionary, value: NSNumber(unsignedInt: propValue), forKey: propName!)
            }
            else if let propValue:UInt64 = propValue as? UInt64 {
                setValue(propertiesDictionary, value: NSNumber(unsignedLongLong: propValue), forKey: propName!)
            }
        }
        
        return propertiesDictionary
    }
    
    /**
     Converts the class to JSON.
     
     - returns: The class as JSON, wrapped in NSData.
     */
    public func toJson(prettyPrinted : Bool = false) -> NSData? {
        let dictionary = self.toDictionary()
        
        if NSJSONSerialization.isValidJSONObject(dictionary) {
            do {
                let json = try NSJSONSerialization.dataWithJSONObject(dictionary, options: (prettyPrinted ? .PrettyPrinted : NSJSONWritingOptions()))
                return json
            } catch let error as NSError {
                print("ERROR: Unable to serialize json, error: \(error)")
            }
        }
        
        return nil
    }
    
    /**
     Converts the class to a JSON string.
     
     - returns: The class as a JSON string.
     */
    public func toJsonString(prettyPrinted : Bool = false) -> String? {
        if let jsonData = self.toJson(prettyPrinted) {
            return NSString(data: jsonData, encoding: NSUTF8StringEncoding) as String?
        }
        
        return nil
    }
    
    
    /**
     Unwraps 'any' object. See http://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
     
     - returns: The unwrapped object.
     */
    func unwrap(any:Any) -> Any? {
        
        let mi = Mirror(reflecting: any)
        if mi.displayStyle != .Optional {
            return any
        }
        
        if mi.children.count == 0 { return nil }
        let (_, some) = mi.children.first!
        return some
    }
}
/// init
public class JSON {
    private let _value:AnyObject
    /// unwraps the JSON object
    public class func unwrap(obj:AnyObject) -> AnyObject {
        switch obj {
        case let json as JSON:
            return json._value
        case let ary as NSArray:
            var ret = [AnyObject]()
            for v in ary {
                ret.append(unwrap(v))
            }
            return ret
        case let dict as NSDictionary:
            var ret = [String:AnyObject]()
            for (ko, v) in dict {
                if let k = ko as? String {
                    ret[k] = unwrap(v)
                }
            }
            return ret
        default:
            return obj
        }
    }
    /// pass the object that was returned from
    /// NSJSONSerialization
    public init(_ obj:AnyObject) { self._value = JSON.unwrap(obj) }
    /// pass the JSON object for another instance
    public init(_ json:JSON){ self._value = json._value }
}
/// class properties
extension JSON {
    public typealias NSNull = Foundation.NSNull
    public typealias NSError = Foundation.NSError
    public class var null:NSNull { return NSNull() }
    /// constructs JSON object from data
    public convenience init(data:NSData) {
        do {
            // Try parsing some valid JSON
            let obj = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments)
            self.init(obj)
        }
        catch let error as NSError {
            // Catch fires here, with an NSErrro being thrown from the JSONObjectWithData method
            print("A JSON parsing error occurred, here are the details:\n \(error)")
            self.init(error)
        }
    }
    /// constructs JSON object from string
    public convenience init(string:String) {
        let enc:NSStringEncoding = NSUTF8StringEncoding
        self.init(data: string.dataUsingEncoding(enc)!)
    }
    /// parses string to the JSON object
    /// same as JSON(string:String)
    public class func parse(string:String)->JSON {
        return JSON(string:string)
    }
    /// constructs JSON object from the content of NSURL
    public convenience init(nsurl:NSURL) {
        var enc:NSStringEncoding = NSUTF8StringEncoding
        do {
            let str = try String(NSString(
                contentsOfURL:nsurl, usedEncoding:&enc))
            self.init(string:str)
        } catch let error as NSError {
            self.init(error)
        }
    }
    /// fetch the JSON string from NSURL and parse it
    /// same as JSON(nsurl:NSURL)
    public class func fromNSURL(nsurl:NSURL) -> JSON {
        return JSON(nsurl:nsurl)
    }
    /// constructs JSON object from the content of URL
    public convenience init(url:String) {
        if let nsurl = NSURL(string:url) as NSURL? {
            self.init(nsurl:nsurl)
        } else {
            self.init(NSError(
                domain:"JSONErrorDomain",
                code:400,
                userInfo:[NSLocalizedDescriptionKey: "malformed URL"]
                )
            )
        }
    }
    /// fetch the JSON string from URL in the string
    public class func fromURL(url:String) -> JSON {
        return JSON(url:url)
    }
    /// does what JSON.stringify in ES5 does.
    /// when the 2nd argument is set to true it pretty prints
    public class func stringify(obj:AnyObject, pretty:Bool=false) -> String! {
        if !NSJSONSerialization.isValidJSONObject(obj) {
            return JSON(NSError(
                domain:"JSONErrorDomain",
                code:422,
                userInfo:[NSLocalizedDescriptionKey: "not an JSON object"]
                )).toString(pretty)
        }
        return JSON(obj).toString(pretty)
    }
}
/// instance properties
extension JSON {
    /// access the element like array
    public subscript(idx:Int) -> JSON {
        switch _value {
        case _ as NSError:
            return self
        case let ary as NSArray:
            if 0 <= idx && idx < ary.count {
                return JSON(ary[idx])
            }
            return JSON(NSError(
                domain:"JSONErrorDomain", code:404, userInfo:[
                    NSLocalizedDescriptionKey:
                    "[\(idx)] is out of range"
                ]))
        default:
            return JSON(NSError(
                domain:"JSONErrorDomain", code:500, userInfo:[
                    NSLocalizedDescriptionKey: "not an array"
                ]))
        }
    }
    /// access the element like dictionary
    public subscript(key:String)->JSON {
        switch _value {
        case _ as NSError:
            return self
        case let dic as NSDictionary:
            if let val:AnyObject = dic[key] { return JSON(val) }
            return JSON(NSError(
                domain:"JSONErrorDomain", code:404, userInfo:[
                    NSLocalizedDescriptionKey:
                    "[\"\(key)\"] not found"
                ]))
        default:
            return JSON(NSError(
                domain:"JSONErrorDomain", code:500, userInfo:[
                    NSLocalizedDescriptionKey: "not an object"
                ]))
        }
    }
    /// access json data object
    public var data:AnyObject? {
        return self.isError ? nil : self._value
    }
    /// Gives the type name as string.
    /// e.g.  if it returns "Double"
    ///       .asDouble returns Double
    public var type:String {
        switch _value {
        case is NSError:        return "NSError"
        case is NSNull:         return "NSNull"
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":              return "Bool"
            case "q", "l", "i", "s":    return "Int"
            case "Q", "L", "I", "S":    return "UInt"
            default:                    return "Double"
            }
        case is NSString:               return "String"
        case is NSArray:                return "Array"
        case is NSDictionary:           return "Dictionary"
        default:                        return "NSError"
        }
    }
    /// check if self is NSError
    public var isError:      Bool { return _value is NSError }
    /// check if self is NSNull
    public var isNull:       Bool { return _value is NSNull }
    /// check if self is Bool
    public var isBool:       Bool { return type == "Bool" }
    /// check if self is Int
    public var isInt:        Bool { return type == "Int" }
    /// check if self is UInt
    public var isUInt:       Bool { return type == "UInt" }
    /// check if self is Double
    public var isDouble:     Bool { return type == "Double" }
    /// check if self is any type of number
    public var isNumber:     Bool {
        if let o = _value as? NSNumber {
            let t = String.fromCString(o.objCType)!
            return  t != "c" && t != "C"
        }
        return false
    }
    /// check if self is String
    public var isString:     Bool { return _value is NSString }
    /// check if self is Array
    public var isArray:      Bool { return _value is NSArray }
    /// check if self is Dictionary
    public var isDictionary: Bool { return _value is NSDictionary }
    /// check if self is a valid leaf node.
    public var isLeaf:       Bool {
        return !(isArray || isDictionary || isError)
    }
    /// gives NSError if it holds the error. nil otherwise
    public var asError:NSError? {
        return _value as? NSError
    }
    /// gives NSNull if self holds it. nil otherwise
    public var asNull:NSNull? {
        return _value is NSNull ? JSON.null : nil
    }
    /// gives Bool if self holds it. nil otherwise
    public var asBool:Bool? {
        switch _value {
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":  return Bool(o.boolValue)
            default:
                return nil
            }
        default: return nil
        }
    }
    /// gives Int if self holds it. nil otherwise
    public var asInt:Int? {
        switch _value {
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":
                return nil
            default:
                return Int(o.longLongValue)
            }
        default: return nil
        }
    }
    /// gives Int32 if self holds it. nil otherwise
    public var asInt32:Int32? {
        switch _value {
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":
                return nil
            default:
                return Int32(o.longLongValue)
            }
        default: return nil
        }
    }
    /// gives Int64 if self holds it. nil otherwise
    public var asInt64:Int64? {
        switch _value {
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":
                return nil
            default:
                return Int64(o.longLongValue)
            }
        default: return nil
        }
    }
    /// gives Float if self holds it. nil otherwise
    public var asFloat:Float? {
        switch _value {
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":
                return nil
            default:
                return Float(o.floatValue)
            }
        default: return nil
        }
    }
    /// gives Double if self holds it. nil otherwise
    public var asDouble:Double? {
        switch _value {
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":
                return nil
            default:
                return Double(o.doubleValue)
            }
        default: return nil
        }
    }
    // an alias to asDouble
    public var asNumber:Double? { return asDouble }
    /// gives String if self holds it. nil otherwise
    public var asString:String? {
        switch _value {
        case let o as NSString:
            return o as String
        default: return nil
        }
    }
    /// if self holds NSArray, gives a [JSON]
    /// with elements therein. nil otherwise
    public var asArray:[JSON]? {
        switch _value {
        case let o as NSArray:
            var result = [JSON]()
            for v:AnyObject in o { result.append(JSON(v)) }
            return result
        default:
            return nil
        }
    }
    /// if self holds NSDictionary, gives a [String:JSON]
    /// with elements therein. nil otherwise
    public var asDictionary:[String:JSON]? {
        switch _value {
        case let o as NSDictionary:
            var result = [String:JSON]()
            for (ko, v) in o {
                if let k = ko as? String {
                    result[k] = JSON(v)
                }
            }
            return result
        default: return nil
        }
    }
    /// Yields date from string
    public var asDate:NSDate? {
        if let dateString = _value as? String {
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
            return dateFormatter.dateFromString(dateString)
        }
        return nil
    }
    /// gives the number of elements if an array or a dictionary.
    /// you can use this to check if you can iterate.
    public var length:Int {
        switch _value {
        case let o as NSArray:      return o.count
        case let o as NSDictionary: return o.count
        default: return 0
        }
    }
    // gives all values content in JSON object.
    public var allValues:JSON{
        if(self._value.allValues == nil) {
            return JSON([])
        }
        return JSON(self._value.allValues)
    }
    // gives all keys content in JSON object.
    public var allKeys:JSON{
        if(self._value.allKeys == nil) {
            return JSON([])
        }
        return JSON(self._value.allKeys)
    }
}

extension JSON : SequenceType {
    public func generate()->AnyGenerator<(AnyObject,JSON)?> {
        switch _value {
        case let o as NSArray:
            var i = -1
            return anyGenerator() {
                if ++i == o.count { return nil }
                return (i, JSON(o[i]))
            }
        case let o as NSDictionary:
            let ks = o.allKeys.reverse()
            return anyGenerator() {
                if ks.isEmpty { return nil }
                if let k = ks.last as? String {
                    return (k, JSON(o.valueForKey(k)!))
                } else {
                    return nil
                }
            }
        default:
            return anyGenerator() { nil }
        }
    }
    public func mutableCopyOfTheObject() -> AnyObject {
        return _value.mutableCopy()
    }
}
extension JSON : CustomStringConvertible {
    /// stringifies self.
    /// if pretty:true it pretty prints
    public func toString(pretty:Bool=false)->String {
        switch _value {
        case is NSError: return "\(_value)"
        case is NSNull: return "null"
        case let o as NSNumber:
            switch String.fromCString(o.objCType)! {
            case "c", "C":
                return o.boolValue.description
            case "q", "l", "i", "s":
                return o.longLongValue.description
            case "Q", "L", "I", "S":
                return o.unsignedLongLongValue.description
            default:
                switch o.doubleValue {
                case 0.0/0.0:   return "0.0/0.0"    // NaN
                case -1.0/0.0:  return "-1.0/0.0"   // -infinity
                case +1.0/0.0:  return "+1.0/0.0"   //  infinity
                default:
                    return o.doubleValue.description
                }
            }
        case let o as NSString:
            return o.debugDescription
        default:
            let opts: NSJSONWritingOptions = pretty
                ? NSJSONWritingOptions.PrettyPrinted : []
            if let data = try! NSJSONSerialization.dataWithJSONObject(
                _value, options:opts
                ) as NSData? {
                    if let result = NSString(
                        data:data, encoding:NSUTF8StringEncoding
                        ) as? String {
                            return result
                    }
            }
            return "YOU ARE NOT SUPPOSED TO SEE THIS!"
        }
    }
    public var description:String { return toString() }
}


