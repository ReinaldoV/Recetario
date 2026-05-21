//
//  ViewController.swift
//  Recetario
//
//  Created by Reinaldo Villanueva on 19/4/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private var recepies: [Meal] = []
    private var shownRecepies: [Meal] = []
    private var showFavorites: Bool = false
    private let favoritesHandler: FavoriteHandlerProtocol = FavoriteHandler()
    private var carHandler: CarHandleProtocol = CarHandle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        Task {
            await loadMeals()
        }
    }
    
    func loadMeals() async {
        let meals = await ApiService.fetchMeals()
        shownRecepies = meals//meals.map(\.strMeal!)
        recepies = meals//meals.map(\.strMeal!)
        self.tableView.reloadData()
    }
    
    @IBAction func seatchButtonPressed(_ sender: Any) {
        guard let filterText = self.textField.text, !filterText.isEmpty else {
            shownRecepies = recepies
            self.tableView.reloadData()
            return
        }
        let filterRecepies = recepies.filter() { $0.strMeal?.lowercased(with: nil).contains(self.textField.text?.lowercased() ?? "") == true}
        self.shownRecepies = filterRecepies
        print("Buscando: \(self.textField.text ?? "error")") 
        self.tableView.reloadData()
    }
    
    @IBAction func favoritesButtonTapped(_ sender: Any) {
        showFavorites = !showFavorites
        if showFavorites {
            shownRecepies = favoritesHandler.getFavorites()
        } else {
            shownRecepies = recepies
        }
        self.tableView.reloadData()
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownRecepies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favorites = favoritesHandler.getFavorites()
        let recepie = shownRecepies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? RecipeTableViewCell
        cell?.nameLabel.text = recepie.strMeal
        cell?.meal = recepie
        let isFavorite = favorites.contains(where: { $0.strMeal == shownRecepies[indexPath.row].strMeal})
        
        if isFavorite {
            cell?.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            cell?.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRecipe = shownRecepies[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Aquí intentamos instanciar usando el ID que acabamos de poner en el Storyboard
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? RecepyViewController {
            
            // Pasamos los datos a las variables puente.
            detailVC.meal = selectedRecipe
            detailVC.nameData = selectedRecipe.strMeal
            detailVC.detailsData = selectedRecipe.strInstructions
            detailVC.imageURL = selectedRecipe.strMealThumb
            detailVC.favoriteHandler = favoritesHandler
            detailVC.isFavorite = favoritesHandler.getFavorites().contains(where: { $0.strMeal == selectedRecipe.strMeal})
            detailVC.addToCarHandler = carHandler
            detailVC.tableViewController = self
            
            // Navegamos
            if let nav = self.navigationController {
                nav.pushViewController(detailVC, animated: true)
            } else {
                self.present(detailVC, animated: true)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
