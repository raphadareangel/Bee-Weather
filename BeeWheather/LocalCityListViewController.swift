//
//  LocalCityListViewController.swift
//  BeeWheather
//
//  Created by Rafael Torres Balderas on 06/10/2018.
//  Copyright © 2018 Rafael Torres Balderas. All rights reserved.
//

import Foundation
import UIKit


class LocalCityListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableViewLocal: UITableView!
    
    
    
    fileprivate var cityItemArray = [cityItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //CoreDataManager.fetchObj()
        updateData()
        tableViewLocal.reloadData()
        tabBarController?.tabBar.items?[2].badgeValue = nil
        
        
        
    }
    
    func updateData() {
        cityItemArray = CoreDataManager.fetchObj()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityItemArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        
        //let cell2=UITableViewCell(style: .default, reuseIdentifier:nil)
         let cell2=tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath)
        cell2.backgroundColor = UIColor(patternImage: UIImage(named: "sandstorm.jpg")!)
        cell2.textLabel?.text=self.cityItemArray[indexPath.item].name
        return cell2
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        CoreDataManager.deletecityCoreData(CityID: cityItemArray[indexPath.row].id!)
        cityItemArray.remove(at: indexPath.row)
                    tableView.reloadData()
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = foods[indexPath.row]
//        return cell
//    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
//    {
//        if editingStyle == UITableViewCellEditingStyle.delete
//        {
//            cityItemArray.remove(at: indexPath.row)
//            tableView.reloadData()
//        }
//    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "localpanelweather", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? LocalPanelWeatherController{
            
            destination.cityID = self.cityItemArray[(tableViewLocal.indexPathForSelectedRow?.row)!].id!
        }
    }
}
