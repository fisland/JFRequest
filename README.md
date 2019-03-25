# JFRequest
Rxswift+Moya+Codable的简单封装

```swift
        //获取频道 channel
        let doubanList = MultiTarget(DouBanAPI.channels)
        JFHTTPService.rxRequestData(doubanList, with: "channels", type: [Channel].self).subscribe(onSuccess: { [weak self](list) in
            guard let self = self else{ return }
            self.dataSource = list
            self.table.reloadData()
            print(list)
        }) { (error) in
            
        }.disposed(by: rx.disposeBag)
```
