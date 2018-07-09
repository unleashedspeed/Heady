//
//  FirstViewController.swift
//  Heady
//
//  Created by Saurabh Gupta on 09/07/18.
//  Copyright © 2018 saurabh. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        APIService.standard.getProducts { (products, error) in
            print(products)
        }
    }


}

