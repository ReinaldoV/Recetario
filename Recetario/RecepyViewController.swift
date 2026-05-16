//
//  RecepyViewController.swift
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
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // Variables "puente" para recibir los datos
    var meal: Meal?
    var nameData: String?
    var detailsData: String?
    var imageURL: String?
    var isFavorite: Bool = false
    var favoriteHandler: FavoriteHandlerProtocol?
    var addToCarHandler: CarHandleProtocol? = CarHandle()
    
    weak var tableViewController: ViewController?

    // Quitamos el init personalizado porque rompe la carga desde Storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configuramos la interfaz con los datos recibidos
        setupUI()
    }
    
    @IBAction func favoriteButtonPressed(_ sender: Any) {
       guard let meal = meal else { return }
        favoriteHandler?.toggleFavorite(meal)
        isFavorite = favoriteHandler?.getValueOf(meal) ?? false
        setupUI()
    }
    
    @IBAction func addToCartButtonPressed(_ sender: Any) {
        print("added to cart: \(meal?.ingredientsList ?? [])")
        addToCarHandler?.addIngredientsToCart(ingredients: meal?.ingredientsList ?? [])
    }
    
    private func setupUI() {
        
        // Usamos el nombre del label que configuraste
        nameLabel.text = nameData
        var text = ""
        text.append("Ingredientes: \n\n\(meal!.ingredientsList.joined(separator: "\n"))")
        text.append("\n\n")
        textView.text = text.appending(detailsData ?? "")
        imageView.userActivity?.webpageURL = URL(string: imageURL ?? "")
        let url = URL(string: imageURL ?? "")
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            imageView.image = image
        }
        
        favoriteButton.setTitle("", for: .normal)
        setImage(isFavorite: isFavorite)
        self.reloadInputViews()
        self.tableViewController?.tableView.reloadData()
    }
    
    private func setImage(isFavorite: Bool) {
        favoriteButton.setImage(nil, for: .normal)
        if isFavorite {
            favoriteButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            favoriteButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}
