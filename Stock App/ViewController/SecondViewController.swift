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
    var arrSymbol: [String] = []
    var arrStockData: [IntradayData] = []
    var arrStockAll : [[IntradayData]] = []
    var interval: Int = 15
    var symbol: [String] = ["AAPL", "IBM", "TSLA"]
    var isDoneFetchingAPI : Bool = false
    
    struct Objects {
        var sectionName : String = ""
        var sectionObjects : [IntradayData] = []
    }

    var objectArray = [Objects]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        self.spinner.startAnimating()
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        let symbolTxt = symbol.joined(separator: ", ")
        symbolLbl.text = symbolTxt
        dateLbl.text = "Symbol"
        self.title = "Second Screen"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Refresh", style: .plain, target: self, action: #selector(refreshBtnTapped))
        callAPI(arrSymbol: symbol)
    }
    
    @objc func refreshBtnTapped() {
        self.arrDate = []
        self.arrStockData = []
        self.objectArray = []
        self.arrSymbol = []
        self.tableView.isHidden = true
        self.spinner.startAnimating()
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
            
            self.intradayData = data.timeSeriesDaily
            
            if self.intradayData?.count ?? 0 > 0 {
                for (key, value) in self.intradayData! {
                    self.arrDate.append(key)
                    self.arrStockData.append(value)
                    self.arrSymbol.append(data.metaData?.symbol ?? "")
                }
                for i in 0...self.arrStockData.count - 1 {
                    self.arrStockData[i].date = self.arrDate[i]
                    self.arrStockData[i].symbol = self.arrSymbol[i]
                }

            }
            if self.isDoneFetchingAPI {
                let dictionary = Dictionary(grouping: self.arrStockData, by: { (element: IntradayData) in
                    return element.date
                })
                
                for (key, value) in dictionary {
                    self.objectArray.append(Objects(sectionName: key ?? "", sectionObjects: value))
                }
                                              
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
        vc.isFromFirsVC = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension SecondViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
     print("numberOfSections: \(self.objectArray.count)")
        return self.objectArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 50))
        
        let label = UILabel()
        label.frame = CGRect.init(x: 5, y: 5, width: headerView.frame.width-10, height: headerView.frame.height-10)
        label.text = objectArray[section].sectionName
        label.font = .systemFont(ofSize: 20)
        label.textColor = .systemGray
        headerView.backgroundColor = .black
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objectArray[section].sectionObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MultipleSymbolCell else {
            fatalError("Issue with dequeuing \(cellIdentifier)")
        }
        
        let data =  objectArray[indexPath.section].sectionObjects[indexPath.row]
        cell.configure(with : data)
                
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
}

extension SecondViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SecondViewController: SearchVCDelegate {
    func searchArrSymbol(arrSymbol: [String]) {
        guard !arrSymbol.isEmpty else {
            return
        }
        let symbolTxt = arrSymbol.joined(separator: ", ")
        symbolLbl.text = symbolTxt
        self.symbol = arrSymbol
        self.arrDate = []
        self.arrStockData = []
        self.objectArray = []
        self.arrSymbol = []
        self.tableView.isHidden = true
        self.spinner.startAnimating()
        
        self.callAPI(arrSymbol: arrSymbol)
    }
    
    func searchSymbol(symbol: String) {
    }
}
