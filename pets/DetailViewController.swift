//
//  DetailViewController.swift
//  pets
//
//  Created by jerry on 2017/7/6.
//  Copyright © 2017年 jerry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        makeDetail()
        
    }

    func makeDetail(){
        let photoImg = URL(string: (detail?["album_file"] as? String)!)
        let photodata = try? Data(contentsOf: photoImg!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        let photo = UIImageView(frame:CGRect(x: 0, y: 0, width: fullScreen.size.width, height: fullScreen.size.width))
        photo.image = UIImage(data: photodata!)
        
        let kind = UILabel(frame:CGRect(x: 0, y: fullScreen.size.width, width: fullScreen.size.width, height: 30))
        kind.text = detail?["animal_kind"] as? String
        
        self.view.addSubview(photo)
        self.view.addSubview(kind)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
