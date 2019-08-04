//
//  ViewController.swift
//  study011
//
//  Created by PeiYu Wang on 2019/8/4.
//  Copyright © 2019 PeiYu Wang. All rights reserved.
//UIView 动画

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let rect=CGRect(x: 100, y: 100, width: 240, height: 240)
        let view=UIView(frame: rect)
        view.backgroundColor=UIColor.red
        view.tag=1
        self.view.addSubview(view)
        
        let button=UIButton(type: .system)
        button.frame=CGRect(x: 100, y: 400, width: 220, height: 44)
        button.backgroundColor=UIColor.black
        button.setTitle("过度动画", for: UIControl.State())
        button.tintColor=UIColor.white
        button.addTarget(self, action: #selector(playAnimation), for: .touchUpInside)
        self.view.addSubview(button)
        
        //帧动画
        var images=[UIImage]()
        for i in 1 ... 8{
            images.append(UIImage(named: "huiyuan_\(i)")!)
        }
        let imageView=UIImageView(frame:CGRect(x: 100, y: 500, width: 100, height: 100))
        imageView.animationImages=images
        imageView.animationDuration=5//动画时间5秒播放8帧  默认为0: 1秒播放30帧
        imageView.animationRepeatCount=0//不限次循环播放
        imageView.startAnimating()//播放动画
        
        self.view.addSubview(imageView)
        
        //位移关键帧动画
        let imageView2=UIImageView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        imageView2.image=UIImage(named: "huiyuan_1")
        self.view.addSubview(imageView2)
        
        let animation=CAKeyframeAnimation(keyPath: "position")
        
        
        let value1: NSValue = NSValue(cgPoint: CGPoint(x: 100, y: 100))
        let value2: NSValue = NSValue(cgPoint: CGPoint(x: 200, y: 100))
        let value3: NSValue = NSValue(cgPoint: CGPoint(x: 200, y: 200))
        let value4: NSValue = NSValue(cgPoint: CGPoint(x: 100, y: 200))
        let value5: NSValue = NSValue(cgPoint: CGPoint(x: 100, y: 300))
        let value6: NSValue = NSValue(cgPoint: CGPoint(x: 200, y: 400))
        animation.values = [value1, value2, value3, value4, value5, value6]
        animation.keyTimes=[NSNumber(value: 0.0),NSNumber(value: 0.1),NSNumber(value: 0.2),NSNumber(value: 0.3),NSNumber(value: 0.4),NSNumber(value: 1.0)]
       
        animation.repeatCount = MAXFLOAT//重复
        animation.autoreverses = true//自动返回
//
//        animation.isRemovedOnCompletion = false
//        animation.fillMode = kCAFillModeForwards
//        animation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)]
        
        animation.delegate=self
        animation.duration=5.0
        imageView2.layer.add(animation, forKey: nil)
        
       
    }

   

    @objc func playAnimation()  {
        /*老方法
        UIView.beginAnimations(nil, context: nil)//启动动画设置
        UIView.setAnimationCurve(.easeOut)//动画曲线
        UIView.setAnimationDuration(5)//动画时间 秒
        UIView.setAnimationBeginsFromCurrentState(true)//是否从当前状态开始
        
        let view=self.view.viewWithTag(1)
        
//        view?.frame=CGRect(x: 40, y: 40, width: 10, height: 10)
//        view?.backgroundColor=UIColor.blue
//        view?.alpha=0.2
        
        UIView.setAnimationTransition(.curlUp, for: view!, cache: true)//过度效果
        
        UIView.setAnimationDelegate(self)//动画代理
        UIView.setAnimationDidStop(#selector(animationStop))//结束回调
        UIView.commitAnimations()//开始动画
        */
        UIView.animate(withDuration: 5,//时长
                       delay: 0,//延时
                       options: [.curveEaseOut],//属性
                       animations: {//设置
            let view=self.view.viewWithTag(1)
            view?.frame=CGRect(x: 40, y: 40, width: 10, height: 10)
            view?.backgroundColor=UIColor.blue
            view?.alpha=0.2
        },
                       completion: {//会调
            (value:Bool) in
            print("动画结束")
        })
    }
    @objc func animationStop(){
        print("动画结束")
//        let view1=self.view.viewWithTag(1)
//        view1?.frame=CGRect(x: 100, y: 100, width: 200, height: 200)
//        view1?.backgroundColor=UIColor.red
//        view1?.alpha=1
//        self.view.viewWithTag(1)?.removeFromSuperview()//移除视图
    }
    
    func animationDidStart(_ anim: CAAnimation) {
        print("开始")
    }
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("结束")
    }
}
extension ViewController: CAAnimationDelegate {
    
    
}

