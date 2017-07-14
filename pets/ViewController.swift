//
//  ViewController.swift
//  pets
//
//  Created by jerry on 2017/7/4.
//  Copyright © 2017年 jerry. All rights reserved.
//

import UIKit

var info:Array<[String:Any]>?
var fullScreen = UIScreen.main.bounds
//var searchBtn = UIButton(frame:CGRect(x: 0, y: 0, width: 100, height: 100))
//weak var searchBtn: UIButton? = UIButton(frame:CGRect(x: 0, y: 0, width: 100, height: 100))


class ViewController: UIViewController {
    
    @IBOutlet var searchBtn: UIButton! = UIButton(frame:CGRect(x: 0, y: 0, width: 100, height: 100))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        // 導覽列是否半透明
        self.navigationController?.navigationBar.isTranslucent = false
        
        // 導覽列右邊按鈕
        let backResult = UIBarButtonItem(
            title: "返回",
            style:.plain,
            target:self,
            action: #selector(toResult))

        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = backResult
        
        
        // self.searchBtn! = UIButton(frame:CGRect(x: 0, y: 0, width: 100, height: 100))
        searchBtn.center = self.view.center
        searchBtn.setTitle("Search", for: UIControlState.normal)
        searchBtn.setTitleColor(UIColor.black, for: UIControlState.normal)
        // #selector (swift3)
        searchBtn.addTarget(self, action: #selector(toResult), for: UIControlEvents.touchUpInside)
        searchBtn.isEnabled = false
        self.view.addSubview(searchBtn)
        api()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toResult(sender: UIButton){        
        self.navigationController?.pushViewController(ResultViewController(), animated: true)
    }
    
    func api(){ // http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx

        let urlString = "http://data.coa.gov.tw/Service/OpenData/AnimalOpenData.aspx"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error ?? "something wrong")
            } else {
                do {
                    info = try JSONSerialization.jsonObject(with: data!) as? Array<[String:Any]>
                    print(info?[0]["animal_place"] ?? "no data")
                    
                    // 非常重要：https://stackoverflow.com/questions/29220877/swift-changing-text-of-a-label-after-downloading-content-of-a-web-page
                    DispatchQueue.main.async {
                        self.showSearchBtn()
                    }

                    // let parsedData = try JSONSerialization.jsonObject(with: data!) as! Array<[String:Any]>
                    // self.render(arr: parsedData)
                } catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
    
    @IBAction func showSearchBtn() {
        // self.searchBtn.isHidden = false
        searchBtn.setTitle("ready", for: .normal)
        searchBtn.isEnabled = true
    }
}

