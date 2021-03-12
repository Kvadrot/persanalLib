//
//  ViewController.swift
//  PesonalNetLib
//
//  Created by 1 on 04.03.2021.
//

import UIKit

struct Info: Codable {
    var login: String?
    var  id: Int
    var node_id: String?
}

class ViewController: UIViewController {

    
    var net = ResourceObject(requestMethod: .get,
                             requestScheme: "https",
                             requestHost: "api.github.com",
                             requestPath: "/users/defunkt",
                             requestQueryItemes: nil
                            )
    var doit = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! doit.doNetwork(net, Info.self, completion: { (result: Result< Info?, Error>) in
            DispatchQueue.main.async {
                print(result)
            }
            return
        })

    }

}


