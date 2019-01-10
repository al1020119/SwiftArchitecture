//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//                  http://www.icocos.cn                       //
//                 https://icocos.github.io                    //
//                https://al1020119.github.io                  //
// **************************************************************
//  ************  😂🤔 曹理鹏(梦工厂@iCocos) 🤔😂  ************  //
// **************************************************************
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************
//
//  Single_App
//  TiledPDFDocument
//
//  Created by iCocos on 2018/12/24.
//  Copyright © 2018年 iCocos. All rights reserved.
//
// @class TiledPDFDocument.swift
// @abstract PDF文档操作
// @discussion 实现PDF文档操作和内存处理
//
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
// **************************************************************

import UIKit
import Foundation

class TiledPDFDocument
{
    class func createX(_ documentURL: URL!, password: String!) -> CGPDFDocument?
    {
        // Check for non-NULL CFURLRef
        guard let document = CGPDFDocument(documentURL as CFURL) else {
            return nil
        }

        // Encrypted
        // Try a blank password first, per Apple's Quartz PDF example
        if document.isEncrypted == true &&
           document.unlockWithPassword("") == false {
            // Nope, now let's try the provided password to unlock the PDF
            if let cPasswordString = password.cString(using: String.Encoding.utf8) {
                if document.unlockWithPassword(cPasswordString) == false {
                    // Unlock failed
                    #if DEBUG
                        print("CGPDFDocumentCreateX: Unable to unlock \(documentURL)")
                    #endif
                }
            }
        }

        return document
    }

    class func needsPassword(_ documentURL: URL!, password: String!) -> Bool
    {
        var needsPassword = false

        // Check for non-NULL CFURLRef
        guard let document = CGPDFDocument(documentURL as CFURL) else {
            return needsPassword
        }
        // Encrypted
        // Try a blank password first, per Apple's Quartz PDF example
        if document.isEncrypted == true &&
           document.unlockWithPassword("") == false {
            // Nope, now let's try the provided password to unlock the PDF
            if let cPasswordString = password.cString(using: String.Encoding.utf8) {
                if document.unlockWithPassword(cPasswordString) == false {
                    needsPassword = true
                }
            }
        }

        return needsPassword
    }

}

