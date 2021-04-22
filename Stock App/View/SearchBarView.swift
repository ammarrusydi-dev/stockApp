//
//  SearchBarView.swift
//  Stock App
//
//  Created by Massive Infinity on 20/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

// MARK: - Protocol
protocol CustomSearchbarDelegate {
    func cancelClicked()
}

class SearchBarView: UIView, UISearchBarDelegate {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchBarDelegate: CustomSearchbarDelegate?
    
    override open func awakeFromNib() {
           super.awakeFromNib()
       }
       
       override init(frame: CGRect) {
           super.init(frame: frame)

           initUI()
       }
       
       required init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)

           initUI()
       }
       
       // MARK: - Content
       
       private func initUI() {
           let bundle = Bundle(for: type(of: self))
           let nib = UINib(nibName: "SearchBarView", bundle: bundle)
           guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else{ return }
           view.frame = bounds
        
        searchBar.delegate = self

//           view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//           view.backgroundColor = UIColor.TAThemeColor
           addSubview(view)
           contentView = view
           

           
//           updateUI()
       }

}


extension SearchBarView {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        searchActive = false
    }

    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchActive = false;

        searchBar.text = nil
        searchBar.resignFirstResponder()
//        tableView.resignFirstResponder()
        searchBar.showsCancelButton = false
        searchBarDelegate?.cancelClicked()
//        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchActive = false
    }

    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
                return true
    }
}
