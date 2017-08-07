//
//  ViewController.swift
//  BlurImageDemo
//
//  Created by ZhouYang on 16/5/24.
//  Copyright © 2016年 ZhouYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let imgView = UIImageView(frame: self.view.frame)
        self.view.addSubview(imgView)
        self.createImageWithBlurGaussianBlur(UIImage(named: "nvshen")!, bgView: imgView, radius: 40)
        
    }
    //高斯模糊
    func createImageWithBlurGaussianBlur (image:UIImage,bgView:UIView,radius:Float) {
        //原始图片
        let originImage = CIImage(CGImage: image.CGImage! )
        //创建高斯模糊滤镜
        let filter = CIFilter(name: "CIGaussianBlur") //高斯模糊滤镜
        filter!.setValue(originImage, forKey: kCIInputImageKey)
        filter!.setValue(NSNumber(float: radius), forKey: "inputRadius")//设置参数
        //生成模糊图片
        let context = CIContext(options: nil)
        let result:CIImage = filter!.valueForKey(kCIOutputImageKey) as! CIImage
        let blurImage = UIImage(CGImage: context.createCGImage(result, fromRect: result.extent))
        //将模糊图片加入背景
        let blurImageView = UIImageView()
        let w = bgView.frame.width
        let h = bgView.frame.height
        if (radius>30){
            blurImageView.frame = CGRectMake(-w/2, -h/2, 2*w, 2*h) //重新指定大小
        }else{
            blurImageView.frame = bgView.frame //保持原来的大小
        }
        blurImageView.contentMode = UIViewContentMode.ScaleAspectFill //使图片充满ImageView
        blurImageView.autoresizingMask = [UIViewAutoresizing.FlexibleWidth,UIViewAutoresizing.FlexibleHeight] //保持原图长宽比
        blurImageView.image = blurImage
        bgView.insertSubview(blurImageView, belowSubview: bgView) //保证模糊背景在原图片View的下层
    }


}

