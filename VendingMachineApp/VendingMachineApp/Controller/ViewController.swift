//
//  ViewController.swift
//  VendingMachineApp
//
//  Created by CHOMINJI on 25/09/2019.
//  Copyright © 2019 cmindy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Properties
    
    private let vendingMachine = VendingMachine(storage: Storage())
    private let cellReuseID = "BeverageCollectionViewCell"
    private var beverages: [Item] {
        return vendingMachine.beverages
    }
    
    // MARK: IBOutlets
    
    @IBOutlet weak var beverageCollectionView: UICollectionView!
    @IBOutlet weak var balanceLabel: UILabel!
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beverageCollectionView.dataSource = self
        
        vendingMachine.addStock(of: StrawberryMilk(), count: 2)
        vendingMachine.addStock(of: ChocolateMilk(), count: 5)
        vendingMachine.addStock(of: Coke(), count: 1)
        
        vendingMachine.showInventory { beverage in
            beverage.forEach { item in
                print("\(item.name) (\(item.count)개)")
            }
        }
    }
    
    // MARK: - Methods
    // MARK: IBActions
    
    @IBAction func touchInsertMoneyButton(_ sender: UIButton) {
        guard vendingMachine.insertMoney(amount: sender.tag) else {
            return
        }
        vendingMachine.showBalance { balance in
            balanceLabel.text = "잔액: \(balance) 원"
        }
    }
}

// MARK: - Extensions
// MARK: CollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return beverages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseID, for: indexPath) as? BeverageCollectionViewCell else {
            return .init()
        }
        cell.delegate = self
        cell.indexPath = indexPath
        
        let beverage = beverages[indexPath.row]
        cell.quantityLabel.text = "\(beverage.count)개"
        cell.beverageImageView.image = UIImage(named: beverage.imageName ?? "")
        
        return cell
    }
}

extension ViewController: BeverageCollectionViewCellDelegate {
    func addStock(with indexPath: IndexPath) {
        guard let beverage =  vendingMachine.fetchBeverage(at: indexPath.item) else {
            return
        }
        vendingMachine.addStock(of: beverage, count: 1)
        
        beverageCollectionView.reloadData()
    }
}