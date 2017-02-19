//
//  ListViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 16/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData

class ListViewController: UIViewController
{

    @IBOutlet var tableView: UITableView!
    var tempParentIdentity = ""
    var tempCategoryName = ""
    var matchidentity = ""
    var tempIdentity = ""
    var received : String = ""
    var tempvalue : String = ""
    var catergoryNameList : [String] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var categories : [NSManagedObject] = []
    var flagForSelection = 0
    var productParentIdentity = ""
    var flagGoToProductDesc = 0
    var selectedValue = ""
    var id = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tempvalue = received
        //print("\(tempvalue)")
        loadtabledata()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewDidAppear(true)
    }

    @IBAction func btnBack(_ sender: UIButton)
    {
        _ = navigationController?.popViewController(animated:true)
    }

    func loadtabledata()
    {
        catergoryNameList = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
        do
        {
            let fetchedValues = try managedContext.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                catergoryNameList.insert("", at: 0)
            }
            
            else
            {
                catergoryNameList = []
                for  cname in fetchedValues
                {
                    tempParentIdentity = ""
                    tempCategoryName = ""
                    tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    tempParentIdentity.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    if tempvalue == tempCategoryName
                    {
                        break
                    }
                }
                for cname in fetchedValues
                {
                    matchidentity = ""
                    flagForSelection = 0
                    matchidentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                    if matchidentity == tempParentIdentity
                    {
                        catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                        print("\(catergoryNameList)")
                    }
                }
            }
        }
        catch
        {
            fatalError("error")
        }
    }
    
    func selectedValueTable()
    {
        print("\(selectedValue)")
        catergoryNameList = []
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Categorylist")
        do
        {
            let fetchedValues = try managedContext.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                catergoryNameList.insert("", at: 0)
            }
                
            else
            {
                catergoryNameList = []
                for cname in fetchedValues
                {
                    tempCategoryName = ""
                    id = ""
                    id.append(cname.value(forKeyPath: "id") as! String? ?? "")
                    tempCategoryName.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    if tempCategoryName == selectedValue
                    {
                         print("condition true")
                        break
                    }
                }
                for cname in fetchedValues
                {
                    tempIdentity = ""
                    tempIdentity.append(cname.value(forKeyPath: "parentId") as! String? ?? "")
                    if(id == tempIdentity)
                    {
                        catergoryNameList.append(cname.value(forKeyPath: "categoryName") as! String? ?? "")
                    }
                }
                if catergoryNameList.count == 0
                {
                    loadProductList()
                }
            }
        }
        catch
        {
            fatalError("Could not fetch")
        }
        self.tableView.reloadData()
    }

    func loadProductList()
    {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Productlist")
        do
        {
            let fetchedValues = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                catergoryNameList.insert("", at: 0)
            }
            else
            {
                catergoryNameList = []
                for  pname in fetchedValues
                {
                    productParentIdentity = ""
                    productParentIdentity.append(pname.value(forKeyPath: "parentid") as! String? ?? "")
                    if strcmp(productParentIdentity, id) == 0
                    {
                        flagGoToProductDesc = 1
                        catergoryNameList.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                        break
                    }
                }
            }
        }
        catch
        {
            fatalError("error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueProductDetail"
        {
            let listvc : ProductDetailViewController = segue.destination as! ProductDetailViewController
            listvc.received = selectedValue
            print("\(listvc.received)")
            print("\(selectedValue)")
        }
    }
    
    func productselected()
    {
    }
    
}

//MARK: -> UITableViewDelegate, UITableViewDataSource

extension ListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return catergoryNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listcell", for: indexPath as IndexPath) as! ListTableViewCell
        cell.categories = catergoryNameList[indexPath.row]
        return cell

    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        selectedValue = ""
        selectedValue = catergoryNameList[indexPath.row]
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Productlist")
        do
        {
            let fetchedValues = try managedContext.fetch(fetchRequest)
            for  pname in fetchedValues
            {
                var productName = ""
                productName.append(pname.value(forKeyPath: "productName") as! String? ?? "")
                if strcmp(selectedValue, productName) == 0
                {
                     self.performSegue(withIdentifier: "segueProductDetail", sender: self)
                }
            }
        }
        catch
        {
            fatalError("error")
        }
        selectedValueTable()
    }

}
