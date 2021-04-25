//
//  SecondViewController.swift
//  Stock App
//
//  Created by Massive Infinity on 14/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let cellIdentifier = "MultipleSymbolCell"
    private var apiData: APIData?
    var intradayData: [String: IntradayData]? = [:]
    var arrDate: [String] = []
    var arrStockData1: [IntradayData] = []
    var arrStockData2: [IntradayData] = []
    var arrStockData3: [IntradayData] = []
    var arrStockAll : [[IntradayData]] = []
    var interval: Int = 15
    var symbol: [String] = ["AAPL", "IBM", "IBMO"]
    var isDoneFetchingAPI : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        self.spinner.startAnimating()
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        symbolLbl.text = symbol[0] //+ ", " + symbol[1] + ", " + symbol[2]
        callAPI(arrSymbol: symbol)
    }
    
    func callAPI(arrSymbol: [String]) {
        var index: Int = 0
        for data in arrSymbol {
            if index == arrSymbol.count - 1 {
                isDoneFetchingAPI = true
            }
            fetchData(symbol: data, index: index)
            index += 1
        }
    }
    
    // API Call
    func fetchData(symbol: String, index: Int) {
        NetworkManager().fetchDailyAdjusted(symbol: symbol) { (data) in
            self.apiData = data
            
//            print("data: \(data)")
            self.intradayData = data.timeSeriesDaily
            
            if self.intradayData?.count ?? 0 > 0 {
                for (key, value) in self.intradayData! {
//                    print("\(key) -> \(value)")
                    self.arrDate.append(key)
                    if index == 0 {
                        self.arrStockData1.append(value)
                    }
                    else if index == 1 {
                        self.arrStockData2.append(value)
                    }
                    else if index == 2 {
                        self.arrStockData3.append(value)
                    }
                }
                for i in 0...self.arrStockData1.count - 1 {
                    self.arrStockData1[i].date = self.arrDate[i]
                }
                for i in 0...self.arrStockData2.count - 1 {
                    self.arrStockData2[i].date = self.arrDate[i]
                }
                for i in 0...self.arrStockData3.count - 1 {
                    self.arrStockData3[i].date = self.arrDate[i]
                }
                print("arrStockData1.count: \(self.arrStockData1.count)")
                print("arrStockData2.count: \(self.arrStockData2.count)")
                print("arrStockData3.count: \(self.arrStockData3.count)")
            }
            if self.isDoneFetchingAPI {
                
                
                
                self.arrStockAll = [self.arrStockData1, self.arrStockData2, self.arrStockData3]
                DispatchQueue.main.async{
                    self.tableView.reloadData()
                    self.tableView.isHidden = false
                    self.spinner.stopAnimating()
                }
            }
            
        }
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        vc.searchDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension SecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
     print("numberOfSections: \(self.arrStockAll.count)")
        return self.arrStockAll.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrStockAll[section].count //self.symbol.count //+ self.arrStockData2.count + self.arrStockData3.count //intradayData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MultipleSymbolCell else {
            fatalError("Issue with dequeuing \(cellIdentifier)")
        }
        
        let data =  arrStockAll[indexPath.section][indexPath.row]
        cell.configure(with : data, date: self.arrDate[indexPath.row], symbol: symbol[indexPath.section])
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SecondViewController: SearchVCDelegate {
    func searchArrSymbol(arrSymbol: [String]) {
        print("arrSymbol: \(symbol)")
//        symbolLbl.text = symbol
        self.symbol = arrSymbol
        self.arrDate = []
        self.arrStockData1 = []
        self.arrStockData2 = []
        self.arrStockData3 = []
        self.tableView.isHidden = true
        self.spinner.startAnimating()
        
        var index: Int = 0
        for data in arrSymbol {
            fetchData(symbol: data, index: index)
            index += 1
        }
        

    }
    
    func searchSymbol(symbol: String) {
//        print("arrSymbol: \(symbol)")
//        symbolLbl.text = symbol
//        self.symbol[0] = symbol
//        self.arrDate = []
//        self.arrStockData1 = []
//        self.tableView.isHidden = true
//        self.spinner.startAnimating()
//        fetchData(symbol: <#String#>, index: <#Int#>)
    }
}
