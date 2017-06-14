//
//  ViewController.swift
//  AYProgressHUD
//
//  Created by Andy on 2017/6/14.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var image: UIImage? = UIImage.init(named: "error")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let imgView = UIImageView.init(frame: CGRect.init(x: 20, y: 20, width: 100, height: 100))
//        image = UIImage.init(named: "info")
//        
//        imgView.image = image
//
//        self.view.addSubview(AYProgressHUD.shareOnce)
//
//        let window: UIWindow = ((UIApplication.shared.delegate?.window)!)!
//        
//        window.addSubview(AYProgressHUD.shareOnce)
        
        
        AYProgressHUD.setHiddenTime(time: 10)
        
        AYProgressHUD.showInfo(status: "Success")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

