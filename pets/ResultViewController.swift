//
//  ResultViewController.swift
//  pets
//
//  Created by jerry on 2017/7/4.
//  Copyright © 2017年 jerry. All rights reserved.
//

import UIKit

var detail:Any?

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.brown
        
        self.title = "result"
        
        self.navigationController?.navigationBar.barTintColor = UIColor.lightGray
        
        self.navigationController?.navigationBar.isTranslucent = false
        
        // 導覽列左邊按鈕
        let leftButton = UIBarButtonItem(
            title: "bb",
            style:.plain,
            target:self,
            action: #selector(back))
        // 加到導覽列中
        self.navigationItem.leftBarButtonItem = leftButton

        // call api
        buildTable()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func back(sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    
    func buildTable(){
        
        // 建立 UITableView 並設置原點及尺寸
        let myTableView = UITableView(frame: CGRect(
            x: 0, y: 0,
            width: fullScreen.size.width,
            height: fullScreen.size.height),
            style: .plain)

        // 註冊 cell
        // "cell" -> tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        // 設置委任對象
        myTableView.delegate = self
        myTableView.dataSource = self
        
        // 分隔線的樣式
        myTableView.separatorStyle = .singleLine
        
        // 分隔線的間距 四個數值分別代表 上、左、下、右 的間距
        myTableView.separatorInset = UIEdgeInsetsMake(0, 20, 0, 20)
        
        // 是否可以點選 cell
        myTableView.allowsSelection = true
        
        // 是否可以多選 cell
        myTableView.allowsMultipleSelection = false
        
        // 加入到畫面中
        self.view.addSubview(myTableView)
    }
    
    
    
    // Delegate
    
    // 必須實作的方法：每一組有幾個 cell
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    // 必須實作的方法：每個 cell 要顯示的內容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 取得 tableView 目前使用的 cell

        // 同一形式的单元格重复使用，在声明时已注册"cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        // 設置 Accessory 按鈕樣式
        cell.accessoryType = .disclosureIndicator

        // 顯示的內容
        // cell.textLabel?.text = info![indexPath.row]["shelter_address"] as? String
        cell.textLabel?.text = info![indexPath.row]["animal_kind"] as? String

        return cell
    }
    
    // 點選 cell 後執行的動作
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 取消 cell 的選取狀態
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
        
        detail = info![indexPath.row]
        
        print("選擇的是 \(indexPath.row)")
        
        toDetail()
    }
    
    func toDetail(){
        self.navigationController?.pushViewController(DetailViewController(), animated: true)
    }

}
