//
//  CartListViewController.swift
//  E-CommerceTask
//
//  Created by Sierra 4 on 18/02/17.
//  Copyright © 2017 codebrew2. All rights reserved.
//

import UIKit
import CoreData

class CartListViewController: UIViewController
{
    @IBOutlet var lblTotalNumberOfItems: UILabel!

    @IBOutlet var lblTotalAmount: UILabel!
    @IBOutlet var tableView: UITableView!
    var cartListName : [String] = []
    var received = ""
    var valueForCell = ""
    var productName = ""
    var productPrice = ""
    var selectedValue = ""
    var totalAmount = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var products : [NSManagedObject] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadTableData()
    }
    
    @IBAction func btnBack(_ sender: UIButton)
    {
        _ = navigationController?.popViewController(animated:true)
    }
    
    func loadTableData()
    {
        cartListName = []
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Cartlist")
        do
        {
            let context = appDelegate.persistentContainer.viewContext
            let fetchedValues = try context.fetch(fetchRequest)
            if fetchedValues.count == 0
            {
                cartListName.insert("", at: 0)
                lblTotalAmount.text = "0"
                lblTotalNumberOfItems.text = "0"
            }
                
            else
            {
                cartListName = []
                var amount = 0
                for  pname in fetchedValues
                {
                    
                    productName = ""
                    productPrice = ""
                    productPrice.append(pname.value(forKeyPath: "cartProductPrice") as! String? ?? "")
                    cartListName.append(pname.value(forKeyPath: "cartProductName") as! String? ?? "")
                    amount = Int(productPrice)!
                    totalAmount = totalAmount + amount
                }
                lblTotalNumberOfItems.text = String(fetchedValues.count)
                lblTotalAmount.text = String(totalAmount)
            }
        }
        catch
        {
            fatalError("error")
        }
    }
}



//MARK: -> UITableViewDelegate, UITableViewDataSource

extension CartListViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return cartListName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemsInCartCell", for: indexPath as IndexPath) as! ItemsInCartTableViewCell
        cell.productsInCart = cartListName[indexPath.row]
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
}
