# JFRequest
Rxswift+Moya+Codable的简单封装

基于Moya封装，model遵循codable协议，返回的是Single信息流

用法：
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
        
        
        //获取语言
        let api = MultiTarget(TestAPI.language)
        //返回的是信息流 Single的
        JFHTTPService.rxRequest(api, type: Languages.self).subscribe(onSuccess: { (languages) in
            print(languages)
        }) { (error) in

        }.disposed(by: rx.disposeBag)

```
