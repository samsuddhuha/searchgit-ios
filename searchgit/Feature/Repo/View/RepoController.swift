//
//  RepoController.swift
//  searchgit
//
//  Created by Samsud Dhuha on 09/08/21.
//

import UIKit

class RepoController: UIViewController {
    
    @IBOutlet weak var btnSearch: UIButton!
    
    var module: RepoModule?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        module = RepoModule.init(viewStateDelegate: self, controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setView()
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        
    }
    
    private func setView(){
        module?.searchRepo(key: "")
        
        btnSearch.dropShadow(color: UIColor.lightGray, offSet: CGSize(width: -1, height: 1), radius: 3, scale: true)
    }
}

extension RepoController: ViewStateDelegate{
    func onSuccess(data: Any?, tag: String, message: String) {
        
    }
    
    func onFailure(data: Any?, tag: String, message: String) {
        DialogFailure().showDialog(parent: self, message: message)
    }
    
    func onLoading(isLoading: Bool, tag: String, message: String) {
        showLoadingView(state: isLoading)
    }
}

