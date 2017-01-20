//
//  ViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 16/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
import SwiftyJSON
import BRYXBanner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func showAlertView(message: String) {
                
        let alertView = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelButton = UIAlertAction(title: "Descartar", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertView.addAction(cancelButton)
        
        present(alertView, animated: true, completion: nil)
    }
    
    func showAlertErroConexao(data: Data?) {
        
        let errorJSON = JSON(data: data!)

        let error = RequestError(message: errorJSON["Error"].stringValue)
        
        showBannerView(message: error.message, color: UIColor(red: 232/255, green: 80/255, blue: 80/255, alpha: 1))
    }
    
    func showBannerView(message: String, color: UIColor) {
        
        let banner = Banner(title: message, subtitle: nil, image: nil, backgroundColor: color)
        
        banner.dismissesOnTap = true
        
        banner.show(duration: 2)
    }
}

