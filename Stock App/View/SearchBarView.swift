//
//  SearchBarView.swift
//  Stock App
//
//  Created by Massive Infinity on 20/4/21.
//  Copyright © 2021 ammar. All rights reserved.
//

import UIKit

class SearchBarView: UIView {

    @IBOutlet var contentView: UIView!
    
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

//           view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//           view.backgroundColor = UIColor.TAThemeColor
           addSubview(view)
           contentView = view
           

           
//           updateUI()
       }

}
