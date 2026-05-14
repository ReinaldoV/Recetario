//
//  RecepyListViewController.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 13/5/26.
//

import Foundation
import UIKit

class BuyListViewController: UIViewController {
  
    @IBOutlet weak var listLabel: UILabel!
    var cartHandler: CarHandleProtocol = CarHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listLabel.text = cartHandler.getCar().joined(separator: ", ")
    }
    
    func updateView() {
        listLabel.text = cartHandler.getCar().joined(separator: ", ")
    }
    
}
