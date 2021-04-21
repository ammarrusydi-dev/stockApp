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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        fetchData()
    }
    
    // API Call
    func fetchData() {
        NetworkManager().fetchIntraday(symbol: "AAPL", interval: 5, outputSize: "compact") { (data) in
            self.apiData = data
            self.intradayData = data.timeSeries5Min
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

