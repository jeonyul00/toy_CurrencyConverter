//
//  ViewController.swift
//  CurrencyConverterApp
//
//  Created by 전율 on 2023/11/03.
//

import UIKit

class PickerViewController: UIViewController {
    var rates:[(String,Double)]?
    var selectedRow = 0 {
        didSet {
            selectedCurrencyName.text = rates?[selectedRow].0
            selectedCurrency.text = calculateCurrency()
        }
    }
    @IBOutlet weak var usdTextField: UITextField!
    @IBOutlet weak var selectedCurrency: UITextField!
    @IBOutlet weak var selectedCurrencyName: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Currency Converter Picker"
        // currencyPicker 규격
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        
        // textField 규격
        usdTextField.delegate = self
        
        fetchJson()
    }
    
    func calculateCurrency() -> String {
        let selectedValue = rates?[selectedRow].1 ?? 0
        let useValue = Double(usdTextField.text ?? "") ?? 0
        let resultValue = String(format: "%.2f", (selectedValue * useValue))
        return resultValue
    }
    
    func fetchJson(){
        Task {
            do{
                let model = try await NetworkLayer.fetchJsonAsync()
                self.rates = model.rates?.sorted(by: { current, new in current.key < new.key }) // 순서보장
                
                // DispatchQueue.main.async { self.currencyPicker.reloadAllComponents() } 또는
                await MainActor.run {
                    self.currencyPicker.reloadAllComponents()
                }
            }catch{
                print(error)
            }
        }
        
        
    }
}

extension PickerViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return rates?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let key = rates?[row].0 ?? ""
        let value = rates?[row].1.description ?? ""
        return key + "  " + value
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedRow = row
    }
    
}

extension PickerViewController:UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        selectedCurrency.text = calculateCurrency()
    }
}
