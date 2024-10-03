//
//  ContentView.swift
//  tipNiccalc2
//
//  Created by Nicolas Reilly on 6/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var amTaxed: Double = 0.0
    @State private var billAmount: String = ""
    @State private var taxRate: Double = 0.0
    @State private var tipResults: String = "0.0"
    
    
    @State private var isEditing = false
    @State private var theView15: Bool = false
    @State private var theView18: Bool = false
    @State private var theView20: Bool = false
    
    @State private var result15: Double = 0.0
    @State private var result18: Double = 0.0
    @State private var result20: Double = 0.0
    
    
    var objTipCalculator = tipCalculator(total: 0.0, taxPct: 0.0)
    @State private var subTotal2:Double = 0.0
    //set possible tip percentages
    let tipPercentages = [0.20, 0.18, 0.15]
    var body: some View {
        VStack {
            
            Text("Welcome to my Tip Calculator")
                .font(.largeTitle)
                .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            Spacer()
            Text("Enter total bill not including tax:")
                .font(.headline)
                .foregroundColor(Color.black)
                .padding(.leading)
            
            HStack {
                
                TextField("Enter amount", text: $billAmount)
                    .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                    .scaledToFit()
                
            }
            
            Text("Set tax rate below:")
                .padding(/*@START_MENU_TOKEN@*/[.top, .leading, .trailing]/*@END_MENU_TOKEN@*/)
            
            HStack{
                
                Slider(value: $taxRate,
                       in: 0...20,
                       onEditingChanged: { editing in
                    isEditing = editing })
                .padding(/*@START_MENU_TOKEN@*/[.leading, .bottom, .trailing]/*@END_MENU_TOKEN@*/)
                
                Text("\(round(taxRate))"+"%")
                    .foregroundColor(isEditing ? .red : .blue)
                    .padding(.all)
            }
            VStack{
                HStack{
                    VStack{
                        Text("Tip 15%")
                            .foregroundColor(Color.red)
                            .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    Toggle(isOn: $theView15) {
                        
                        
                    }
                }
                    VStack{
                        Text("Tip 18%")
                            .foregroundColor(Color.red)
                            .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                    Toggle(isOn: $theView18) {
                       
                        
                    }
                }
                    VStack{
                        Text("Tip 20%")
                            .foregroundColor(Color.red)
                            .padding(/*@START_MENU_TOKEN@*/.all, 10.0/*@END_MENU_TOKEN@*/).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
                        Toggle(isOn: $theView20) {
                            
                            
                        }
                    }
                }
                    VStack{
                      Spacer()
                        Button("Calculate Tip Options!", action: {
                            
                            //set the tipCalculator's percentage based on the value of the tax slider
                            objTipCalculator.taxPct = taxRate / 100.0
                            
                            //set tipCalculator's total from the billAmount textfield
                            if let totalBillAmount = Double(billAmount) {
                                
                                //accept only numeric values greater than or equal to zero
                                if totalBillAmount >= 0 {
                                    
                                    //set the TipCalculator's total bill amount
                                    objTipCalculator.total = totalBillAmount
                                    subTotal2 = objTipCalculator.subtotal
                                    //ask the objTipCalculator object to calculate all possible tips based on the tipPercentages
                                    
                                    if(theView15){
                                        result15 = subTotal2 * 0.15
                                    }
                                    
                                    
                                    
                                    if(theView18){
                                        result18 = subTotal2 * 0.18
                                    }
                                    
                                    
                                    
                                    
                                    if(theView20){
                                        result20 = subTotal2 * 0.20
                                    }
                                    
                                    let possibleTips = objTipCalculator.calcPossibleTips(tipPercentages: tipPercentages)
                                    
                                    amTaxed = subTotal2 - totalBillAmount
                                    //prepare a results string for output by traversing the possibleTips dictionary
                                    var results = ""
                                    
                                    
                                    for (tipPct, tipValue) in possibleTips {
                                        results += "A \(tipPct)% tip would be $\(tipValue)\n"
                                    }
                                    tipResults = "After excluding taxes, your tip options are:\n" + results
                                } else { tipResults = "Enter a numeric value greater than zero for total bill amount."}
                                
                            } else {
                                tipResults = "Enter only numeric values for total bill amount."
                                print("Console Message: Invalid input value for total bill amount.")
                            }
                            
                            
                        })
                        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                        
                        Text("You are taxed:")
                            .font(.body)
                        Text("$\(abs(amTaxed), specifier: "%.2f")")
                            .font(.body)
                        
                        Text("Your Subtotal is: ")
                            .font(.body)
                        
                        Text("$\(subTotal2, specifier: "%.2f")")
                            .font(.body)
                        if(theView20){
                            Text("A 20% tip would be:")
                                .font(.body)
                            Text("$\(result20, specifier: "%.2f")")
                                .font(.body)
                        }
                        
                        
                        if(theView18){
                            Text("A 18% tip would be:")
                                .font(.body)
                            Text("$\(result18, specifier: "%.2f")")
                                .font(.body)
                        }
                        
                        
                        if(theView15){
                            Text("A 15% tip would be:")
                                .font(.body)
                            Text("$\(result15, specifier: "%.2f")")
                                .font(.body)
                        }
                        
                        
                    }
                Spacer()
                        Button("Clear All", action: {
                            billAmount = ""
                            tipResults = ""
                            taxRate = 0.0
                            amTaxed = 0.0
                            subTotal2 = 0.0
                            theView15 = false
                            theView18 = false
                            theView20 = false
                        })
                        .padding(.all)
                        .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.blue/*@END_MENU_TOKEN@*/)
                        .accentColor(/*@START_MENU_TOKEN@*/.white/*@END_MENU_TOKEN@*/)
                        Spacer()
                    }
                    Spacer()
                }
            
        }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
