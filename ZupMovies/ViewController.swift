//
//  ViewController.swift
//  ZupMovies
//
//  Created by Larissa Cavalcante on 16/01/17.
//  Copyright © 2017 Larissa Cavalcante. All rights reserved.
//

import UIKit
//import BRYXBanner

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func showAlertView(message: String) {
                
        let alertView = UIAlertController(title: message, message: nil, preferredStyle: UIAlertControllerStyle.alert)
        
        let cancelButton = UIAlertAction(title: "Descartar", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertView.addAction(cancelButton)
        
        present(alertView, animated: true, completion: nil)
    }
    
    func showAlertErroConexao(data: NSData?) {
        
//        let errorJSON = JSON(data: data!)
//        
////        let error = RequestError(message: errorJSON["error"].stringValue)
//        
//        showAlertView(error.message)
    }
    
    func showBannerView(message: String, color: UIColor) {
        
//        let banner = Banner(title: message, subtitle: nil, image: nil, backgroundColor: color)
//        
//        banner.dismissesOnTap = true
//        
//        banner.show(duration: 2)
    }
    
    func showErrorBannerConexao(data: NSData?, statusCode: Int?) {
        
//        if(statusCode == 500) || (statusCode == 502) {
//            
//            showBannerView(message: "Erro ao tentar conectar com o servidor. Por favor, tente novamente mais tarde.", color: UIColor(red: 232/255, green: 80/255, blue: 80/255, alpha: 1))
//            
//        } else {
//            
//            let errorJSON = JSON(data: data!)
//            
////            let error = RequestError(message: errorJSON["error"].stringValue)
//            
//            showBannerView(error.message, color: UIColor(red: 232/255, green: 80/255, blue: 80/255, alpha: 1))
        }
//    }
}

