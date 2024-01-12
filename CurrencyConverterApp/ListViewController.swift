//
//  ListViewController.swift
//  CurrencyConverterApp
//
//  Created by 전율 on 2023/11/03.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var inputUsdValue: UITextField!
    @IBOutlet weak var currencyTableView: UITableView!
    
    var rates:[(String,Double)]?
    var usdValue:Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "List"
        inputUsdValue.delegate = self
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        fetchJson()
        // cell 등록
        // forCellReuseIdentifier: 셀을 재사용하기 위한 아이덴티파이어
        let currencyCellNib = UINib(nibName: "CurrencyCell", bundle: nil)
        currencyTableView.register(currencyCellNib, forCellReuseIdentifier: "CurrencyCell")
    }
    
    func fetchJson(){
        NetworkLayer.fetchJson { model in
            self.rates = model.rates?.sorted(by: { current, new in current.key < new.key })
            DispatchQueue.main.async {
                self.currencyTableView.reloadData()
            }
        }
    }
}

extension ListViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rates?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyCell", for: indexPath) as! CurrencyCell
        if let rates = self.rates?[indexPath.row] {
            cell.presentCurrency(rates: rates, usdValue: usdValue ?? 0)
        }
        return cell
    }
}

extension ListViewController:UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        usdValue = Double(textField.text ?? "")
        currencyTableView.reloadData()
    }
}
