//
//  FirstViewController.swift
//  Stock App
//
//  Created by Massive Infinity on 14/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var symbolLbl: UILabel!
    @IBOutlet weak var stockNameBtn: UIButton!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    private let cellIdentifier = "FieldTableViewCell"
    private var apiData: APIData?
    var intradayData: [String: IntradayData]? = [:]
    var arrDate: [String] = []
    var arrStockData: [IntradayData] = []
    var interval: Int = 15
    var symbol: String = "AAPL"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.isHidden = true
        self.spinner.startAnimating()
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        symbolLbl.text = symbol
        fetchData()
    }
    
    // API Call
    func fetchData() {
        NetworkManager().fetchIntraday(symbol: symbol, interval: interval, outputSize: "compact") { (data) in
            self.apiData = data
            
            self.intradayData = data.timeSeries5Min
            
            if self.interval == 1 {
                self.intradayData = data.timeSeries1Min
            }
            else if self.interval == 5 {
                self.intradayData = data.timeSeries5Min
            }
            else if self.interval == 15 {
                self.intradayData = data.timeSeries15Min
            }
            else if self.interval == 30 {
                self.intradayData = data.timeSeries30Min
            }
            else if self.interval == 60 {
                self.intradayData = data.timeSeries60Min
            }
            
            
            if self.intradayData?.count ?? 0 > 0 {
                for (key, value) in self.intradayData! {
                    self.arrDate.append(key)
                    self.arrStockData.append(value)
                }
                for i in 0...self.arrStockData.count - 1 {
                    self.arrStockData[i].date = self.arrDate[i]
                }
            }
            
           
            
            DispatchQueue.main.async{
                guard !self.arrStockData.isEmpty else {
                    print("Re-fetching API again~~")
                    print("self.intradayData data: \(String(describing: self.intradayData))")
                    self.spinner.stopAnimating()
                    return
                }
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.spinner.stopAnimating()
            }
        }
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
        vc.searchDelegate = self
        vc.isFromFirsVC = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension FirstViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return intradayData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FieldTableViewCell else {
            fatalError("Issue with dequeuing \(cellIdentifier)")
        }
        cell.configure(with : arrStockData[indexPath.row], date: self.arrStockData[indexPath.row].date ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 60
    }
}

extension FirstViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FirstViewController: SearchVCDelegate {
    func searchArrSymbol(arrSymbol: [String]) {
        
    }
    
    func searchSymbol(symbol: String) {
        print("arrSymbol: \(symbol)")
        symbolLbl.text = symbol
        self.symbol = symbol
        self.arrDate = []
        self.arrStockData = []
        self.tableView.isHidden = true
        self.spinner.startAnimating()
        fetchData()
    }
}
