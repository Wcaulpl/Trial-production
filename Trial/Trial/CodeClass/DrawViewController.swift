//
//  DrawViewController.swift
//  Crowd
//
//  Created by SL_linker on 16/6/11.
//  Copyright © 2016年 SL_linker. All rights reserved.
//

import UIKit

class DrawViewController: UIViewController {
    
    let width = UIScreen.mainScreen().bounds.width
    let height = UIScreen.mainScreen().bounds.height
    
    private let leftController = MoodViewController()
    private let mainController = MainViewController()
    private let tap = UITapGestureRecognizer()
    private let pan = UIPanGestureRecognizer()
    private let edge = UIScreenEdgePanGestureRecognizer()
    private let userIcon = UIButton(type: UIButtonType.Custom)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(leftController.view)
        view.addSubview(mainController.view)
        
        // 点击手势
        tap.addTarget(self, action: #selector(DrawViewController.tapAction(_:)))
        tap.enabled = false
        mainController.view.addGestureRecognizer(tap)
        
        // 滑动手势
        pan.addTarget(self, action: #selector(DrawViewController.panAction(_:)))
        pan.enabled = false
        mainController.view.addGestureRecognizer(pan)
        
        // 边缘滑动手势
        edge.addTarget(self, action: #selector(DrawViewController.edgeAction(_:)))
        edge.edges = UIRectEdge.Left
        mainController.view.addGestureRecognizer(edge)
        
        // 设置leftController.view 的位置
        let width = UIScreen.mainScreen().bounds.width
        let height = UIScreen.mainScreen().bounds.height
        
        
        leftController.view.frame = CGRect(x: -(width / 3), y: 0, width: width, height: height)
        
        // 设置滑动首饰优先级比点击优先级高
        tap.requireGestureRecognizerToFail(pan)
        
        addSubView()
        
    }
    
    func addSubView() {
        
        userIcon.frame = CGRect(x: 15, y: 20, width: 40, height: 40);
        userIcon.layer.masksToBounds = true
        userIcon.layer.cornerRadius = 20
        userIcon.setImage(UIImage(named: "userIcon"), forState: UIControlState.Normal)
        userIcon.addTarget(self, action: #selector(DrawViewController.barButtonAction), forControlEvents: UIControlEvents.TouchUpInside)
        mainController.view .addSubview(userIcon)
    }
    
    func edgeAction(edge: UIScreenEdgePanGestureRecognizer) -> Void {
        var point = edge.translationInView(view)
        switch edge.state {
        case UIGestureRecognizerState.Changed:
            if point.x > width - 100 {
                point.x = width - 100
            }else if point.x < 0 {
                point.x = 0
            }
            edge.view?.frame = CGRect(x: point.x, y: 0, width: width, height: height)
            leftController.view.frame = CGRect(x: -(width - 100)/2 + point.x/2, y: 0, width: width, height: height)
            userIcon.alpha = (width - 100 - point.x) / (width - 100)
        case UIGestureRecognizerState.Ended:
            if point.x > (width - 100) / 2 {
                point.x = width - 100
                tap.enabled = true
                pan.enabled = true
                userIcon.alpha = 0
            }else if point.x <= (width - 100) / 2 {
                point.x = 0
                tap.enabled = false
                pan.enabled = false
                userIcon.alpha = 1
            }
            weak var weakSelf = self
            UIView.animateWithDuration(0.1, animations: { 
                edge.view?.frame = CGRect(x: point.x, y: 0, width: weakSelf!.width, height: weakSelf!.height)
                weakSelf!.leftController.view.frame = CGRect(x: -(weakSelf!.width - 100)/2 + point.x/2, y: 0, width:weakSelf!.width, height: weakSelf!.height)
            })
        default: break
            
        }
        
        
    }

    func panAction(pan: UIPanGestureRecognizer) -> Void {
        var point = pan.translationInView(view)
        switch pan.state {
        case UIGestureRecognizerState.Changed:
            if point.x < 100 - width {
                point.x = 100 - width
            }else if point.x > 0 {
                point.x = 0
            }
            
            pan.view?.frame = CGRect(x: width - 100 + point.x, y: 0, width: width, height: height)
            leftController.view.frame = CGRect(x:point.x/2, y: 0, width: width, height: height)
            userIcon.alpha = 100 / (width - 100 + point.x)
            print((width - 100 + point.x))
        case UIGestureRecognizerState.Ended:
            if point.x < (100 - width) / 2 {
                point.x = 100 - width
                tap.enabled = false
                pan.enabled = false
                userIcon.alpha = 1
            }else if point.x > (100 - width) / 2 {
                point.x = 0
                tap.enabled = true
                pan.enabled = true
                userIcon.alpha = 0
            }
            weak var weakSelf = self
            UIView.animateWithDuration(0.1, animations: {
                pan.view?.frame = CGRect(x: weakSelf!.width - 100 + point.x, y: 0, width: weakSelf!.width, height: weakSelf!.height)
                weakSelf!.leftController.view.frame = CGRect(x: point.x/2, y: 0, width:weakSelf!.width, height: weakSelf!.height)
            })
        default: break
            
        }
   
    }
    
    
    func tapAction(tap: UITapGestureRecognizer) {
        weak var weakSelf = self
        UIView.animateWithDuration(0.5, animations: { 
            weakSelf!.leftController.view.frame = CGRect(x: -(weakSelf!.width / 3), y: 0, width: weakSelf!.width, height: weakSelf!.height)
            tap.view?.center = weakSelf!.view.center
            weakSelf!.userIcon.alpha = 1
            }) { (Bool) in
                tap.enabled = false
                weakSelf!.pan.enabled = false
        }
        
    }
    
    func barButtonAction(button: UIButton){
        weak var weakSelf = self
        UIView.animateWithDuration(0.5, animations: {
            weakSelf!.leftController.view.frame = CGRect(x: 0, y: 0, width: weakSelf!.width, height: weakSelf!.height)
            weakSelf!.tap.view?.frame = CGRect(x: weakSelf!.width - 100, y: 0, width: weakSelf!.width, height: weakSelf!.height)
            weakSelf!.userIcon.alpha = 0
        }) { (Bool) in
            weakSelf!.tap.enabled = true
            weakSelf!.pan.enabled = true
        }

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
