//
//  ViewController.swift
//  LtoRRtoL
//
//  Created by Manish on 08/07/17.
//  Copyright © 2017 manish. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print(ViewSemantic.sharedInstance.localizedString(for: "manish"))
        ViewSemantic.sharedInstance.semanticView(parentView: self.view)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

