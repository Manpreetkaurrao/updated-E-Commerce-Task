//
//  SecondViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData

class CartViewController: UIViewController {

    
    @IBOutlet var tableView: UITableView!
    var tempProductName = ""
    var currentCellValue = ""
    var tempIdentity = ""
    var tempProductPrice = ""
    var productNameList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "showItemsInCartSegue"
        {
            let Clistvc : CartListViewController = segue.destination as! CartListViewController
            Clistvc.received = currentCellValue
            print("\(currentCellValue)")
        }
    }*/
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(true)
        productNameList = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Productlist")
        do
        {
            let fetchedValues = try managedContext.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                productNameList.insert("", at: 0)
            }
            else
            {
                productNameList = []
                for  cname in fetchedValues
                {
                    productNameList.append(cname.value(forKeyPath: "productName") as! String? ?? "")
                }
            }
        }
        catch
        {
            fatalError("Could not fetch")
        }
        tableView.reloadData()
    }
    
    @IBAction func btnShowItemsInCart(_ sender: UIButton)
    {
         self.performSegue(withIdentifier: "showItemsInCartSegue", sender: self)
    }
    
    
    @IBAction func btnAddItemsInCart(_ sender: UIButton)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        let list = NSEntityDescription.entity(forEntityName: "Cartlist",in: context)!
        let product = NSManagedObject(entity: list, insertInto: context)
        let manageContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Productlist")
        do
        {
            let fetchedValues = try manageContext.fetch(fetchRequest)
            for  cname in fetchedValues
            {
                tempProductName = ""
                tempIdentity = ""
                tempProductPrice = ""
                tempProductName.append(cname.value(forKeyPath: "productName") as! String? ?? "")
                tempProductPrice.append(cname.value(forKeyPath: "price") as! String? ?? "")
                if (strcmp(currentCellValue, tempProductName) == 0)
                {
                    product.setValue(tempProductName, forKey: "cartProductName")
                    product.setValue(tempProductPrice, forKey: "cartProductPrice")
                    break
                }
            }
        }
        catch
        {
            fatalError("error")
        }
    }
    
    
    @IBAction func btnBack(_ sender: UIButton)
    {
         _ = navigationController?.popViewController(animated:true)
    }
    
    
}

//MARK: -> UITableViewDataSource, UITableViewDelegate

extension CartViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return productNameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "addItemsInCartCell", for: indexPath as IndexPath) as! CartTableViewCell
        cell.products = productNameList[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        currentCellValue = ""
        currentCellValue = productNameList[indexPath.row]
        //self.performSegue(withIdentifier: "showItemsInCartSegue", sender: self)
    }
    
    /*func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        cell.backgroundColor = .clear
    }*/
}


