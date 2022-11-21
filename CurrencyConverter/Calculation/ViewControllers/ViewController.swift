//
//  ViewController.swift
//  Calculation
//
//  Created by Kripa on 20/11/22.
//

import UIKit
import DropDown
import IQKeyboardManagerSwift

class ViewController: BaseViewController {
    
    // Outlets
    @IBOutlet weak var btnFrom: UIButton!
    @IBOutlet weak var btnTo: UIButton!
    @IBOutlet weak var txtFromValue: UITextField!
    @IBOutlet weak var txtToValue: UITextField!
    
    // Variables and Constants
    private var currenciesViewModel = CurrencyViewModel()
    let dropDown = DropDown()
    var arrCurrencyKeys = [String]()
    var arrCurrencyValues = [Double]()
    var firstValue = 0.0
    var secondValue = 0.0
    
    // View Controller Method
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // Do any additional setup after loading the view.
        setupUI()
        showLoader()
        getData()
    }
    
    // Actions
    @IBAction func tapChooseMenuItem(_ sender: UIButton) {
        self.resignFirstResponder()
        dropDown.dataSource = arrCurrencyKeys.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        dropDown.anchorView = sender
        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
            sender.setTitle(item, for: .normal)
            sender == self?.btnFrom ? self?.fetchCurrencyValue(wasThatFirstBtn: true) : self?.fetchCurrencyValue(wasThatFirstBtn: false)
        }
    }
    
    @IBAction func detail_Touch(_ sender: UIButton) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "detailViewController")
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // Functions and methods..........
    func getData() {
        self.currenciesViewModel.currenciesLoaded = { [weak self] (CurrencyResponse, success) in
            self?.hideLoader()
            self?.currenciesViewModel.currencyList = CurrencyResponse.rates
            self?.currenciesViewModel.currencyKeys = self?.currenciesViewModel.currencyList.keys.map{ $0 }
            self?.currenciesViewModel.currencyValues = self?.currenciesViewModel.currencyList.values.map{ $0 }
            if success {
                print(self!.currenciesViewModel.currencyKeys! as [String])
                if let arrayTemp = self!.currenciesViewModel.currencyKeys {
                    for each in arrayTemp {
                        self?.arrCurrencyKeys.append("\(each)")
                    }
                }
                if let arrayTemp = self!.currenciesViewModel.currencyValues {
                    for each in arrayTemp {
                        self?.arrCurrencyValues.append(each)
                    }
                }
            }
        }
    }
    
    func setupUI() {
        self.txtToValue.delegate = self
        self.txtFromValue.delegate = self
    }
    
    func fetchCurrencyValue(wasThatFirstBtn: Bool) {
        if wasThatFirstBtn {
            let index: Int = self.arrCurrencyKeys.firstIndex(of: btnFrom.title(for: .normal)!)!
            firstValue = self.arrCurrencyValues[index]
            txtFromValue.text = "\(self.arrCurrencyValues[index])"
        }else {
            let index: Int = self.arrCurrencyKeys.firstIndex(of: btnTo.title(for: .normal)!)!
            secondValue = self.arrCurrencyValues[index]
            txtToValue.text = "\(self.arrCurrencyValues[index])"
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.calculateOtherValue(textField: textField)
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        self.calculateOtherValue(textField: textField)
    }
    func calculateOtherValue(textField: UITextField) {
        
        if textField == txtFromValue && txtFromValue.text != "" {
            let multiplier = Double(txtFromValue.text ?? "0.0")!/firstValue
            let roundedValue = Double(round(1000 * secondValue * multiplier) / 1000)
            txtToValue.text = "\(roundedValue)"
        } else if txtToValue.text != "" { // second text field is changed
            let multiplier = Double(txtToValue.text ?? "0.0")!/secondValue
            let roundedValue = Double(round(1000 * firstValue * multiplier) / 1000)
            txtFromValue.text = "\(roundedValue)"
        }else {
            return
        }
        
        self.appendNewSearch()
    }
    
    func appendNewSearch() {
        
        if var dictHistory = Constants.userDefauls.dictionary(forKey: Constants.search_history), dictHistory[Constants.today] != nil, ((dictHistory[Constants.today] as? [String: [String]]) != nil){
            print("Today: \(dictHistory[Constants.today] ?? [])")
            //            dictHistory[Constants.today] = [String: [String]]()
            let todayDate = dictHistory[Constants.today] as? [String : [String]]
            var arrTodaySearch = todayDate?[Constants.todayDate()]
            arrTodaySearch?.append("From \"\(btnFrom.title(for: .normal) ?? "")\" To \"\(btnTo.title(for: .normal) ?? "")\"")
            
            dictHistory[Constants.today] = [Constants.todayDate(): arrTodaySearch]
            Constants.userDefauls.setValue(dictHistory, forKey: Constants.search_history)
        }else {
            var dictionary = [
                Constants.today: [String: [String]](),
                Constants.yesterday: [String: [String]](),
                Constants.day_before_yesterday: [String: [String]]()
            ] as [String : Any]
            
            
            dictionary[Constants.today] = [Constants.todayDate(): ["From \"\(btnFrom.title(for: .normal) ?? "")\" To \"\(btnTo.title(for: .normal) ?? "")\""]]
            dictionary[Constants.yesterday] = [Constants.yesterdayDate(): []]
            dictionary[Constants.day_before_yesterday] = [Constants.dayBeforeDate(): []]
            Constants.userDefauls.setValue(dictionary, forKey: Constants.search_history)
        }
    }
}
