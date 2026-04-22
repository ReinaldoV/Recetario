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
    private var recepies: [String] = ["patatas fritras", "pollo", "cafe", "pizza", "pasta", "hamburguesa", "tortilla", "ensalada", "tostadas", "sopa"]
    private var shownRecepies: [String] = []
    
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
        shownRecepies = meals.map(\.strMeal!)
        recepies = meals.map(\.strMeal!)
        self.tableView.reloadData()
    }
    
    @IBAction func seatchButtonPressed(_ sender: Any) {
        guard let filterText = self.textField.text, !filterText.isEmpty else {
            shownRecepies = recepies
            self.tableView.reloadData()
            return
        }
        let filterRecepies = recepies.filter() { $0.lowercased(with: nil).contains(self.textField.text?.lowercased(with: nil) ?? "") }
        self.shownRecepies = filterRecepies
        print("Buscando: \(self.textField.text ?? "error")") 
        self.tableView.reloadData()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownRecepies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recepie = shownRecepies[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as? RecepietableViewCell
        cell?.nameLabel.text = recepie
        return cell!
    }
}

class RecepietableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
}
