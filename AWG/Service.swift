//
//  Service.swift
//  AWG
//
//  Created by Влад Барченков on 15.05.2021.
//

import Foundation
import Alamofire

class Service {
    
    func getData(url: String, response: @escaping ([Item]?) -> Void) {
        
        let headers: HTTPHeaders = ["x-apikey": "041d4d0457dc9f1e1a49880d56d6c1b657d02"]
        
        AF.request(url, headers: headers).validate().responseJSON { resp in
            switch resp.result {
            case .success(_):
                guard let data = resp.data else { return }
                do {
                    let decode = try JSONDecoder().decode([Item].self, from: data)
                    response(decode)
                } catch {
                    print("Error: == \(error)")
                }
            case .failure(let error):
                response(nil)
                print(error.localizedDescription)
            }
        }
    }
}
