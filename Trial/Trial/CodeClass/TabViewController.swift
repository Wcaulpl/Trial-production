//
//  MineViewController.swift
//  Crowd
//
//  Created by SL_linker on 16/6/10.
//  Copyright © 2016年 SL_linker. All rights reserved.
//

import UIKit
/*
 快捷创建文件
 command + j -> 定位到目录结构
 ↑↓键选择文件夹
 回车键 -> command + c 拷贝文件名称
 command + n 创建文件
 */
class TabViewController: UITabBarController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBar.tintColor = UIColor.cyanColor()
        
        // 添加子控制器
        addChildViewController(RadioViewController(), title: "电台", imageName: "Radio")
        addChildViewController(ReadViewController(), title: "阅读", imageName: "Read")
        addChildViewController(VideoViewController(), title: "视频", imageName: "Video")

        
    }
    
    private func addChildViewController(childController: UIViewController, title:String, imageName:String) {
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.title = title
        addChildViewController(childController)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
