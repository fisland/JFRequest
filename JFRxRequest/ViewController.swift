//
//  ViewController.swift
//  JFRxRequest
//
//  Created by fisker.zhang on 2019/3/25.
//  Copyright © 2019 fisker. All rights reserved.
//

import UIKit
import Moya
import NSObject_Rx

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    var dataSource = [Channel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        
        //获取频道 channel
        let doubanList = MultiTarget(DouBanAPI.channels)
        JFHTTPService.rxRequestData(doubanList, with: "channels", type: [Channel].self).subscribe(onSuccess: { [weak self](list) in
            guard let self = self else{ return }
            self.dataSource = list
            self.table.reloadData()
            print(list)
        }) { (error) in
            
        }.disposed(by: rx.disposeBag)
    }

}

extension ViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  self.table.dequeueReusableCell(withIdentifier: "ChannelCellID", for: indexPath)
        if let cell = cell as? ChannelViewCell {
            let channel = self.dataSource[indexPath.row]
            cell.lbl.text = channel.name
        }
        return cell
    }
    
    
}
