//
//  VendingMachineManager.swift
//  VendingMachineApp
//
//  Created by delma on 2020/03/12.
//  Copyright © 2020 delma. All rights reserved.
//

import Foundation
class VendingMachineManager {
    private var vendingMachine = VendingMachine()
    let vendingMachineString = "vendingMachine"
    
    func saveData() {
        do {
            let encodedData = try NSKeyedArchiver.archivedData(withRootObject: vendingMachine, requiringSecureCoding: false)
            UserDefaults.standard.set(encodedData, forKey: vendingMachineString)
        }catch {
            print(error.localizedDescription)
        }
        
    }
    
    func loadData() -> VendingMachine {
        guard let encodedData = UserDefaults.standard.value(forKey: vendingMachineString) as? Data else { return vendingMachine }
        do {
            guard let unarchivedData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(encodedData) as? VendingMachine else { return vendingMachine }
            vendingMachine = unarchivedData
            return vendingMachine
        } catch {
            print(error.localizedDescription)
        }
        return vendingMachine
    }
    
    func resetData() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
}
