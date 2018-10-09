//
//  FinderW.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 05/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit
class FinderWViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate{
   var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    var foreCastList:[[ForeCastStruct]]?=[]
    var foreCastDaysList:[ForeCastStruct]?=[]
    
    var cities=[CityStruct]()
    var inSearchMode = false
    var filteredData :[CityStruct]?=[]
    
    var filteredCities = [CityStruct]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tableView.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        self.tableView.backgroundView = UIImageView(image: UIImage(named: "sandstorm.jpg"))
        startActivityIndicator()
        var localController=LocalController()
        cities=localController.loadcities()
        filteredCities = cities
        navigationItem.titleView=searchBar
        searchBar.showsScopeBar=false
        searchBar.placeholder = "Search Cities"
        //searchBar.returnKeyType = UIReturnKeyType.done
        stopActivityIndicator()
        //searchBar.endEditing(true)
}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell2=UITableViewCell(style: .default, reuseIdentifier:nil)
        cell2.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        
        cell2.textLabel?.text=self.filteredCities[indexPath.item].name
        return cell2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "selectedCityView", sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let add = UITableViewRowAction(style: .normal, title: "Add") { action, index in
            //self.isEditing = false
            CoreDataManager.storeObj(id: self.filteredCities[indexPath.row].id, country: self.filteredCities[indexPath.row].country, name: self.filteredCities[indexPath.row].name, population: self.filteredCities[indexPath.row].population)
            self.tabBarController?.tabBar.items?[2].badgeValue = "New"
            self.tabBarController?.tabBar.items?[2].badgeColor=UIColor.darkGray
            self.tableView.reloadData()
        }
        add.backgroundColor = UIColor.green
        
       
        
        return [add]
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SelectedCityViewController{
            
            destination.city = self.filteredCities[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        
        if searchBar.text == "" {
            self.filteredCities = self.cities
        } else {
            // Filter the results
            self.filteredCities = self.cities.filter { $0.name.lowercased().contains(searchBar.text!.lowercased())
                
            }
            
        }
        
        
        self.tableView.reloadData()
        
    }
        

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
       
        self.searchBar.endEditing(true)
        // print("Close Keyboard")
    }
        
    func startActivityIndicator()
    {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func stopActivityIndicator()
    {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
       

        
    
    
}
