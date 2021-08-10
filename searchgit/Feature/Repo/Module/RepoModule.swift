//
//  RepoModule.swift
//  searchgit
//
//  Created by Samsud Dhuha on 09/08/21.
//

import Foundation
import SwiftyJSON

protocol RepoDelegate {
    func searchRepo(key: String)
}

class RepoModule: ModuleDelegate, RepoDelegate {
    
    let TAG_SEARCH_REPO = "TAG-SEARCH-REPO"

    override init(viewStateDelegate: ViewStateDelegate, controller: UIViewController) {
        super.init(viewStateDelegate: viewStateDelegate, controller: controller)
    }
    
    func searchRepo(key: String) {
        self.network.networkConfiguration(tag: TAG_SEARCH_REPO)
        self.network.onLoading(isLoading: true, message: "")

        commonService.request(Common.search(key: key), completion: {result in switch result {
        

        case .success(let response):
            self.network.onLoading(isLoading: false, message: "")
            let data = JSON.init(response.data)
            
            print(data)
            do {
                _ = try response.filterSuccessfulStatusCodes()
                
                let dataMap = try JSONDecoder().decode([Repo].self, from: data["items"].rawData())
                self.network.onSucess(data: dataMap, message: data[KEY_MESSAGE].stringValue)

            } catch {
                print("1")
                self.network.onLoading(isLoading: false, message: "")
                self.network.onFailure(data: "", message: data[KEY_MESSAGE].stringValue)
            }

        case .failure(_):
            print("2")
            self.network.onLoading(isLoading: false, message: "")
            self.network.onFailure(data: "", message: ERROR_MESSAGE)
        }})
    }
}
