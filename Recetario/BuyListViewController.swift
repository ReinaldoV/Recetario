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
        // Updates the view when the screen loads
        updateView()
    }
        
    func updateView() {
        listLabel.text = cartHandler.getCar().map { $0.name }.joined(separator: "\n")
        //cartHandler.getCar().map { $0.name }.joined(separator: "\n")
    }
    
}
