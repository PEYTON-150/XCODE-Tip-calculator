//
//  TipCalculatorClass.swift
//  tipNiccalc2
//
//  Created by Nicolas Reilly on 6/8/23.
//

import Foundation

//To follow Object-Oriented design principles,
//we create below a separate model class for the Tip Calculator

class tipCalculator {
    
    //class properties
    var total: Double
    var taxPct: Double
    //computed property
    var subtotal: Double {
        return total / (taxPct + 1) //calculates subtotal by removing the tax
    }
    
    //this is an initializer--same as a constructor in other languages
    init(total: Double, taxPct: Double) {
        self.total = total
        self.taxPct = taxPct
    }
    
    //method to calculate the tip of the subtotal given the tax percentage
    func calcTip(tipPct: Double) -> Double {
        return round(subtotal * tipPct)
    }
    //method to calculate a list of tip options based on possible tip percentages
    func calcPossibleTips(tipPercentages: [Double]) -> [Int: Double] {
        
        //create a tipsDictionary [tipPercentage: tipAmount]
        var tipsDictionary = [Int: Double]()
        
        //build and populate the tipsDictionary
        for pct in tipPercentages {
            let intPct = Int(pct * 100) //convert to integer value
            tipsDictionary[intPct] = calcTip(tipPct: pct)
        }
        return tipsDictionary
    }
}
