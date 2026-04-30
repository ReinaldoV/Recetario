//
//  REcepyViewController.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 26/4/26.
//

import UIKit

class RecepyViewController: UIViewController {
    
    // Outlets: Asegúrate de conectar estos en el Storyboard
    // Si cambiaste los nombres en el Storyboard, cámbiados aquí también
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    // Variables "puente" para recibir los datos
    var nameData: String?
    var detailsData: String?

    // Quitamos el init personalizado porque rompe la carga desde Storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuramos la interfaz con los datos recibidos
        setupUI()
    }
    
    private func setupUI() {
        // Usamos el nombre del label que configuraste
        nameLabel.text = nameData
        textView.text = detailsData
    }
}
