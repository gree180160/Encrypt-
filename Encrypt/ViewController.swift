//
//  ViewController.swift
//  Encrypt
//
//  Created by WillowRivers on 2017/3/16.
//  Copyright © 2017年 WillowRivers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //md5
        let password = "12345678" ;
        let result1 = MyOC.md5(password) ;
        print("result md5 oc is :\(result1!)") ;
        print("result md5 swift is :\(password.md5)") //扩展写在“File.swift” 中
        //base 64
        print("to base64 is : \(password.toBase64)") ;
        print("frome base64 is : \(password.toBase64.fromeBase64)") ;
 
       //oc AES
        let jiamiString = MyOC.aes256_encrypt("brjjj", encrypttext: "kkkk") ;
        print("AES jia mi result is :\(jiamiString)") ;
        let jiemiString = MyOC.aes256_decrypt("brjjj", decrypttext: jiamiString!) ;
        print("AES jie mi result is :\(jiemiString)") ;
        //swift AES 
        let sourceData : NSData = "Seng".data(using: .utf8) as! NSData ;
        let keyData : NSData = "just the one".data(using: .utf8) as! NSData;
        let result : NSData? = sourceData.AES128Crypt(operation: CCOperation(kCCEncrypt), keyData: keyData) ;
        print("swift aes jiami result is \(result?.description)") ;
        let oldData = result?.AES128Crypt(operation: CCOperation(kCCDecrypt), keyData: keyData) ;
        let oldString = String(data: oldData as! Data , encoding: String.Encoding.utf8) ;
        print("swift aes jiemi result is \(oldString)")
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

