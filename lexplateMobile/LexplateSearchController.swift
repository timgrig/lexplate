//
//  LexplateSearchController.swift
//  lexplateMobile
//
//  Created by Vitaly Asadullin on 06/10/15.
//  Copyright © 2015 EcoSoft. All rights reserved.
//

import Foundation
import UIKit

class LexplateSearchController: UISearchController, UISearchBarDelegate {
    
    lazy var lexplateSearchBar: LexplateSearchBar = {
        [unowned self] in
        let result = LexplateSearchBar()
        result.delegate = self
        return result
        }()
    
    //    lazy var customSearchBar: UISearchBar = {
    //        [unowned self] in
    //        let result = UISearchBar()
    //        result.delegate = self
    //        return result
    //        }()
    
    override var searchBar: UISearchBar {
        get {
            return lexplateSearchBar
        }
    }
    
    init(searchViewController:UIViewController!) {
        super.init(searchResultsController: searchViewController)
        
        searchBar.delegate = self
    }
    //
    //
    //
    //
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        //print("qaz555")
        if(!searchBar.text!.isEmpty)
        {
            self.active=true
        }
        else
        {
            self.active=false
        }
    }
    
    
    
    //
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        // print("qa")
        searchBar.resignFirstResponder()
    }
    //
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
    private override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
}
