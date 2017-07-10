//
//  LanguageManager.swift
//  SwiftDatabase
//
//  Created by Manish on 08/07/17.
//  Copyright © 2017 Manish. All rights reserved.
//

import UIKit


class ViewSemantic: NSObject {
    
    var bundle = Bundle.main
    var currentLanguage = ""
    var isNotificationActivated = false
    
    
    
    class var sharedInstance: ViewSemantic {
    
        struct Static {
            static var instance = ViewSemantic()
        }
        return Static.instance
    }
    
    // We can still have a regular init method, that will get called the first time the Singleton is used.
    override init() {
        super.init()
        
        
        var aLangauage = self.currentLanguage.components(separatedBy: CharacterSet(charactersIn: "-"))
        
        self.currentLanguage = aLangauage[0]
        let path = Bundle.main.path(forResource: self.currentLanguage, ofType: "lproj")!
        self.bundle = Bundle(path: path)!
    }
    

    func localizedString(for aStrRaw: String) -> String {
        let aStrLanguageCode = UserDefaults.standard.object(forKey: "Language") as? String
        
        let path: String? = Bundle.main.path(forResource: aStrLanguageCode, ofType: "lproj")
        
        let languageBundle = Bundle(path: path!)

        var strLocalized = languageBundle?.localizedString(forKey: aStrRaw, value: "", table: nil)
        if (strLocalized?.characters.count ?? 0) > 0 {
//            strLocalized = strLocalized
        }
        else {
            strLocalized = aStrRaw
        }
        return strLocalized!
    }
    
    
    func semanticView(parentView: UIView) -> Void {
        for view in parentView.subviews{
            if self.isRTL() {
                if #available(iOS 9.0, *) {
                    
                    view.semanticContentAttribute = UISemanticContentAttribute.forceRightToLeft
                    
                } else {
                    // Fallback on earlier versions
                }
            }
            else{
                if #available(iOS 9.0, *) {
                    view.semanticContentAttribute = UISemanticContentAttribute.forceLeftToRight
                } else {
                    // Fallback on earlier versions
                }
            }
            
            if  view is UITextField {
                let txtF: UITextField = view as! UITextField
                if txtF.placeholder != nil {
                    txtF.placeholder = self.localizedString(for: txtF.placeholder!)
                }
                if txtF.text != nil {
                    txtF.text = localizedString(for: txtF.text!)
                }
                if self.isRTL() {
                    txtF.textAlignment = .right
                }
                else{
                    txtF.textAlignment = .left
                }
            }
            else if view is UITextView{
                let txtView: UITextView = view as! UITextView
                if txtView.text != nil {
                    txtView.text = self.localizedString(for: txtView.text!)
                }
                
                if self.isRTL() {
                    txtView.textAlignment = .right
                }
                else{
                    txtView.textAlignment = .left
                }
                
            }
            else if view is UILabel{
                let lbl: UILabel = view as! UILabel
                if lbl.text != nil {
                    lbl.text = self.localizedString(for: lbl.text!)
                }
                
                if lbl.textAlignment != .center {
                    if self.isRTL() {
                        
                        lbl.textAlignment = .right
                    }
                    else{
                        lbl.textAlignment = .left
                    }
                    
                }
                
                
                
            }
            else if view is UIButton{
                let btn : UIButton = view as! UIButton
                if (btn.titleLabel?.text != nil) {
                    
                    btn.setTitle(self.localizedString(for: (btn.titleLabel?.text!)!), for: .normal)
                }
                
                if self.isRTL() {
                    btn.contentHorizontalAlignment = .center
                }
                else{
                    
                    btn.contentHorizontalAlignment = .center
                }
            }
            
            if view.subviews.count > 0 {
                
                self.semanticView(parentView: view)
                
            }
        }
    }
    
    func isRTL() -> Bool {
        if (UserDefaults.standard.object(forKey: "Language") as? String == "ar-AE") {
          return true
        }
        else {
          return false
        }
    }
}
