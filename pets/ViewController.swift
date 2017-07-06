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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // 導覽列底色
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        // 導覽列是否半透明
        self.navigationController?.navigationBar.isTranslucent = false
        
        // 導覽列左邊按鈕
        let backResult = UIBarButtonItem(
            title: "RR",
            style:.plain,
            target:self,
            action: #selector(toResult))

        // 加到導覽列中
        self.navigationItem.rightBarButtonItem = backResult
        
        let btn:UIButton = UIButton(frame:CGRect(x: 0, y: 0, width: 100, height: 100))
        btn.center = self.view.center
        btn.setTitle("Search", for: UIControlState.normal)
        btn.setTitleColor(UIColor.black, for: UIControlState.normal)
        // #selector (swift3)
        btn.addTarget(self, action: #selector(toResult), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(btn)
        
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
                    
                    // let parsedData = try JSONSerialization.jsonObject(with: data!) as! Array<[String:Any]>
                    print(info?[0]["animal_place"] ?? "no data")
                    // self.render(arr: parsedData)
                } catch let error as NSError {
                    print(error)
                }
            }
        }.resume()
    }
}

