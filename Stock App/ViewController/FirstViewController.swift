//
//  FirstViewController.swift
//  Stock App
//
//  Created by Massive Infinity on 14/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    @IBOutlet weak var SearchBarView: SearchBarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var stockNameBtn: UIButton!
    
    private let cellIdentifier = "FieldTableViewCell"
    private var apiData: APIData?
    var intradayData: [String: IntradayData]? = [:]
    var arrDate: [String] = []
    var arrStockData: [IntradayData] = []
    var interval: Int = 60
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fetchData()
    }
    
    // API Call
    func fetchData() {
        NetworkManager().fetchIntraday(symbol: "AAPL", interval: interval, outputSize: "compact") { (data) in
            self.apiData = data
            
            self.intradayData = data.timeSeries5Min
            
            if self.interval == 1 {
                self.intradayData = data.timeSeries1Min
            }
            else if self.interval == 5 {
                self.intradayData = data.timeSeries5Min
            }
            else if self.interval == 10 {
                self.intradayData = data.timeSeries10Min
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
                    print("\(key) -> \(value)")
                    self.arrDate.append(key)
                    self.arrStockData.append(value)
                }
            }
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func searchBtnClicked(_ sender: Any) {
        self.navigationController?.pushViewController(SearchViewController.getInstance(), animated: true)
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
        cell.configure(with : arrStockData[indexPath.row], date: self.arrDate[indexPath.row])
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
        
        //    let category = categories[indexPath.row]
        //    let viewController: UIViewController
        //
        //    switch category {
        //    case .films: viewController = FilmsViewController()
        //    default: viewController = FilmsViewController()
        //    }
        
        //    navigationController?.pushViewController(viewController, animated: true)
    }
}

