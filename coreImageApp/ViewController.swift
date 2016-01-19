//
//  ViewController.swift
//  coreImageApp
//
//  Created by Kikuchi Shigeo on 2016/01/19.
//  Copyright © 2016年 sigepon. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        facial()
    }
    
    func facial(){
        //imageViewに描画されている画像をCIImage形式で取得
        let ciImage = CIImage(CGImage: (imageView.image?.CGImage)!)
        //顔検出
        let detector = CIDetector(ofType: CIDetectorTypeFace
            , context: nil
            , options: nil
        )
        
        let features = detector.featuresInImage(ciImage) //CIImageから顔検出
        
        UIGraphicsBeginImageContext((imageView.image?.size)!)
        //現在表示されている画像をコンテキストに描画
        imageView.image?.drawInRect(CGRectMake(0, 0, imageView.image!.size.width, imageView.image!.size.height))
        
        //得られた顔情報から矩形を描画していく
        for feature in features{
            var faceRect = (feature as! CIFaceFeature).bounds
            //CIImageで取得した座標系とUIKit座標系はy座標が逆方向のため変換
            faceRect.origin.y = (imageView.image?.size.height)! - faceRect.origin.y - faceRect.size.height
            
            let context = UIGraphicsGetCurrentContext()                             // コンテキストを取得
            CGContextSetStrokeColorWithColor(context, UIColor.redColor().CGColor)   // 塗りつぶしの色を指定
            CGContextStrokeRect(context, faceRect)                                  // 顔の位置と大きさに矩形を描画
        }
        drawing()
    }
    
    func drawing(){
        let drawedImage = UIGraphicsGetImageFromCurrentImageContext()     //コンテキストから画像に変換
        UIGraphicsEndImageContext()                                       //コンテキストを閉じる
        imageView.image = drawedImage
    }
}

