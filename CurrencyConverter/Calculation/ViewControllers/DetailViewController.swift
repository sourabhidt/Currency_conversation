//
//  DetailViewController.swift
//  Calculation
//
//  Created by Kripa on 21/11/22.
//

import Foundation
import UIKit
import IQKeyboardManagerSwift
import RxSwift
import RxCocoa

class DetailViewController: BaseViewController,UITableViewDelegate {
    
    // Outlets
    @IBOutlet weak var tblList: UITableView!
    let disposeBag = DisposeBag()
    
    
    // Variables and Constants
    var dictHistory: [String : Any] = Constants.userDefauls.dictionary(forKey: Constants.search_history) ?? [
        Constants.today: [String: [String]](),
        Constants.yesterday: [String: [String]](),
        Constants.day_before_yesterday: [String: [String]]()
    ]
    
    // View Controller Method
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI() {
        let items = Observable.just(
            dictHistory.map { "\($0)" }
        )
        
        items
            .bind(to: tblList.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) { [self] (row ,element, cell) in
                let keyValue = (self.dictHistory[Constants.today] as? [String: [String]])
                let valueArray = keyValue?["\((self.dictHistory[Constants.today] as? [String: [String]])?.keys.first ?? Constants.today)"]
                cell.textLabel?.text  = valueArray?[row]
            }
            .disposed(by: disposeBag)
        
        
        tblList.rx
            .modelSelected(String.self)
            .subscribe(onNext:  { value in
            })
            .disposed(by: disposeBag)
        
        tblList.rx
            .itemAccessoryButtonTapped
            .subscribe(onNext: { indexPath in
            })
            .disposed(by: disposeBag)
    }
}


