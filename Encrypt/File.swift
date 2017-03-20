//
//  File.swift
//  Encrypt
//
//  Created by WillowRivers on 2017/3/16.
//  Copyright © 2017年 WillowRivers. All rights reserved.
//

import Foundation
extension String {
    
    var md5 : String{
        
        let str = self.cString(using: String.Encoding.utf8)
        
        let strLen = CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8))
        
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        
        //let result = UnsafeMutablePointer<<span class = "s3" >CUnsignedChar>.alloc(digestLen);
        let result = UnsafeMutablePointer<UInt8>.allocate(capacity: digestLen) ;
        
        CC_MD5(str!, strLen, result);
        
        let hash = NSMutableString();
        
        for i in 0 ..< digestLen {
            
            hash.appendFormat("%02x", result[i]); //***  "%02x" -》 x ：表示以十六进制形式输出 ，02: 表示不足两位，前面补0输出，出过两位，不影响
            
        }
        
        result.deinitialize();
        
        return String(format: hash as String)
        
    }
    
    //base64EncodedString(options: Data.Base64EncodingOptions = default) -> String
    var toBase64 : String{
       // Data.Base64DecodingOptions.init(rawValue: <#T##UInt#>)
        let sourceData = self.data(using: String.Encoding.utf8) ;
        return (sourceData?.base64EncodedString(options: .lineLength64Characters))!;
    }
    
    var fromeBase64 : String{
        let data = NSData(base64Encoded: self , options: .init(rawValue: 0)) ;
        return NSString(data: data as! Data , encoding: String.Encoding.utf8.rawValue) as! String
    }
    
}
extension NSData
{
    func AES128Crypt(operation:CCOperation,keyData:NSData)->NSData?{
        
        let keyBytes        = keyData.bytes
        let keyLength       = Int(kCCKeySizeAES256)
        
        let dataLength      = self.length
        let dataBytes       = self.bytes
        
        let cryptLength     = Int(dataLength+kCCBlockSizeAES128)
        let cryptPointer    = UnsafeMutablePointer<UInt8>.allocate(capacity: cryptLength)
        
        let algoritm:  CCAlgorithm = CCAlgorithm(kCCAlgorithmAES128)
        let option:   CCOptions    = CCOptions(kCCOptionECBMode + kCCOptionPKCS7Padding)
        
        let numBytesEncrypted = UnsafeMutablePointer<Int>.allocate(capacity: 1)
        numBytesEncrypted.initialize(to: 0)
        
        let cryptStatus = CCCrypt(operation, algoritm, option, keyBytes, keyLength, nil, dataBytes, dataLength, cryptPointer, cryptLength, numBytesEncrypted)
        
        if CCStatus(cryptStatus) == CCStatus(kCCSuccess) {
            let len = Int(numBytesEncrypted.pointee)
            let data:NSData = NSData(bytesNoCopy: cryptPointer, length: len)
            
            numBytesEncrypted.deallocate(capacity: 1)
            return data
            
        } else {
            numBytesEncrypted.deallocate(capacity: 1)
            cryptPointer.deallocate(capacity: cryptLength)
            
            return nil
        }
    }
   
}

