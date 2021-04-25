//
//  SearchViewController.swift
//  Stock App
//
//  Created by Massive Infinity on 22/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

protocol SearchVCDelegate: NSObjectProtocol {
    func searchSymbol(symbol: String)
    func searchArrSymbol(arrSymbol: [String])
}

class SearchViewController: UIViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tblView: UITableView!
    
    var arrSearchResult: [SearchData] = []
    private let cellIdentifier = "SearchTableViewCell"
    weak var searchDelegate : SearchVCDelegate!
    
    // MARK: - Instance
       static func getInstance() -> SearchViewController {
           let vc = SearchViewController(nibName: "SearchViewController", bundle: nil)
           return vc;
           
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        tblView.register(UINib.init(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        
        setupSearchBar()
    }

    func setupSearchBar() {
        
        searchBar.delegate = self
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            
            textfield.backgroundColor = UIColor.RTBGrey
            textfield.placeholder = "Search symbol"
            textfield.font = UIFont.systemFont(ofSize: 12)
            textfield.textColor = UIColor.RTBTextGrey
            
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text
        arrSearchResult.removeAll()
        fetchAPICalls(text: text ?? "")
        print("text: \(text ?? "")")
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let textSearch = searchBar.text ?? ""
        arrSearchResult.removeAll()
        fetchAPICalls(text: textSearch + text )
        print("text: \(textSearch + text )")
        print("replacementText: \(text )")
        return true
    }
}

// API Call
extension SearchViewController {
    func fetchAPICalls(text: String) {
        arrSearchResult.removeAll()
        NetworkManager().fetchSearchResult(keyword: text) { (data) in
            
            guard let result = data.bestMatches else {
                return
            }
            
            self.arrSearchResult = result
            
            DispatchQueue.main.async{                
                self.tblView.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrSearchResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell else {
            fatalError("Issue with dequeuing \(cellIdentifier)")
        }
        
        let symbol = arrSearchResult[indexPath.row].symbol
//        guard let symbol = arrSearchResult[indexPath.row].symbol else {
//            return cell
//        }
        cell.configure(with : symbol ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 40
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchDelegate.searchSymbol(symbol: arrSearchResult[indexPath.row].symbol ?? "")
        self.navigationController?.popViewController(animated: true)
    }
}

