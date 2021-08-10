//
//  RepoViewController.swift
//  searchgit
//
//  Created by Samsud Dhuha on 09/08/21.
//

import UIKit

class RepoViewController: UIViewController {
    
    @IBOutlet weak var fieldSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    @IBOutlet weak var tableRepo: UITableView!
    @IBOutlet weak var labelCount: UILabel!
    @IBOutlet weak var viewEnterKeySearch: UIView!
    @IBOutlet weak var viewEmpty: UIView!
        
    let refresh = UIRefreshControl()
    var module: RepoModule?
    var listRepo = [Repo]()
    
    var tempKeySearch = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableRepo.delegate = self
        tableRepo.dataSource = self
        
        module = RepoModule.init(viewStateDelegate: self, controller: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        setView()
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        module?.searchRepo(key: fieldSearch.text!)
        tempKeySearch = fieldSearch.text!
    }
    
    private func setView(){

        btnSearch.dropShadow()
        fieldSearch.dropShadow()
        fieldSearch.setLeftPaddingPoints(8)
        fieldSearch.setRightPaddingPoints(8)
        
        viewEmpty.isHidden = true
        
        refresh.tintColor = UIColor.lightGray
        refresh.transform = CGAffineTransform(scaleX: 1, y: 1)
        tableRepo.addSubview(refresh)
        refresh.addTarget(self, action: #selector(searchRepo), for: .valueChanged)
    }
    
    @objc func searchRepo(){
        module?.searchRepo(key: tempKeySearch)
    }
}

extension RepoViewController: ViewStateDelegate{
    func onSuccess(data: Any?, tag: String, message: String) {
        listRepo.removeAll()
        listRepo = data as! [Repo]
        tableRepo.reloadData()
        labelCount.text = "Repo find : \(listRepo.count)"
        viewEnterKeySearch.isHidden = true
        if listRepo.count == 0 {
            viewEmpty.isHidden = false
        }else{
            viewEmpty.isHidden = true
        }
    }
    
    func onFailure(data: Any?, tag: String, message: String) {
        DialogFailure().showDialog(parent: self, message: message)
    }
    
    func onLoading(isLoading: Bool, tag: String, message: String) {
        showLoadingView(state: isLoading)
        if !isLoading {
            refresh.endRefreshing()
        }
    }
}


extension RepoViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listRepo.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableRepo.dequeueReusableCell(withIdentifier: "repoviewcell") as! RepoViewCell
        let data = listRepo[indexPath.row]
        
        if data.description == nil {
            cell.labelDescription.text = "Description : -"
        }else{
            cell.labelDescription.text = "Description : \(data.description ?? "")"
        }
        
        cell.labelFullName.text = data.fullName
        cell.imageOwner.downloaded(from: data.owner?.avatarUrl ?? "")
        cell.labelOwner.text = "Owner : \(data.owner?.login ?? "")"
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let temp = listRepo[indexPath.row]
        
        let url = URL(string: temp.htmlUrl ?? "https://github.com/")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
}

