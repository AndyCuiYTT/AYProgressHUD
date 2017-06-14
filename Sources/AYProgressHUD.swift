//
//  AYProgressHUD.swift
//  AYProgressHUD
//
//  Created by Andy on 2017/6/14.
//  Copyright © 2017年 Andy. All rights reserved.
//

import UIKit

var kScreenWidth: CGFloat = UIScreen.main.bounds.width
var kScreenHeight: CGFloat = UIScreen.main.bounds.height


class AYProgressHUD: UIView {
    
    
    /// 单例
    static let shareOnce: AYProgressHUD = AYProgressHUD.defaultHUB()
    
    
    private class func defaultHUB() -> AYProgressHUD{
        let hub: AYProgressHUD =  AYProgressHUD.init(frame: UIScreen.main.bounds)
        
        hub.mainView.frame = hub.mainRect
        hub.backgroundColor = hub.bgLayerColor
        hub.mainView.backgroundColor = hub.bgColor
        hub.mainView.layer.masksToBounds = true
        hub.mainView.layer.cornerRadius = 20
        hub.addSubview(hub.mainView)
        
        hub.mainView.addSubview(hub.activityView)
        hub.activityView.isHidden = true
        hub.activityView.activityIndicatorViewStyle = hub.indicatorViewStyle!
        hub.activityView.translatesAutoresizingMaskIntoConstraints = false
        hub.mainView.addSubview(hub.statusImgView)
        hub.statusImgView.isHidden = true
        hub.statusImgView.contentMode = .center
        hub.statusImgView.translatesAutoresizingMaskIntoConstraints = false
        hub.mainView.addSubview(hub.statusLabel)
        hub.statusLabel.isHidden = true
        hub.statusLabel.textAlignment = NSTextAlignment.center
        hub.statusLabel.translatesAutoresizingMaskIntoConstraints = false
        return hub
    }
    
    
    /// 主视图
    private var mainView: UIView = UIView()
    private var mainRect: CGRect = CGRect.init(x: kScreenWidth / 4, y: kScreenHeight / 2 - kScreenWidth / 4, width: kScreenWidth / 2, height: kScreenWidth / 2)
    
    /// 菊花转视图
    private var activityView = UIActivityIndicatorView()
    
    /// 状态视图
    private var statusImgView = UIImageView()
    
    private var statusLabel = UILabel()
    
    /// 错误提示图
    private var errorImg: UIImage? = UIImage.init(named: "error")
    
    /// 成功提示图
    private var successImg: UIImage? = UIImage.init(named: "success")
    
    /// 警告提示图
    private var infoImg: UIImage? = UIImage.init(named: "info")
    
    /// 背景色
    private var bgColor: UIColor? = UIColor.white
    
    /// 背景遮罩
    private var bgLayerColor: UIColor? = UIColor.black.withAlphaComponent(0.5)
    
    /// 加载图样式
    private var indicatorViewStyle: UIActivityIndicatorViewStyle? = .gray
    
    /// 默认关闭时间
    private var time: TimeInterval? = 2
    
    
    /// 设置背景颜色
    ///
    /// - Parameter color: 背景色
    public class func setBgColor(color: UIColor) -> Void {
        shareOnce.backgroundColor = color
        shareOnce.mainView.backgroundColor = color
    }
    
    
    /// 设置警告图片
    ///
    /// - Parameter image: 警告图片
    public class func setInfoImage(image: UIImage) -> Void {
        shareOnce.infoImg = image;
    }
    
    
    /// 设置错误图片
    ///
    /// - Parameter image: 错误图片
    public class func setErrorImage(image: UIImage) -> Void {
        shareOnce.errorImg = image
    }
    
    
    /// 设置成功图片
    ///
    /// - Parameter image: 成功图片
    public class func setSuccessImage(image: UIImage) -> Void {
        shareOnce.successImg = image
    }
    
    
    /// 设置自动关闭时间(默认 2)
    ///
    /// - Parameter time: 显示时长
    public class func setHiddenTime(time: TimeInterval) -> Void {
        shareOnce.time = time
    }
    
    
    /// 显示加载
    public class func show() -> Void{
        shareOnce.statusImgView.isHidden = true
        shareOnce.statusLabel.isHidden = true
        let activity: UIActivityIndicatorView = shareOnce.activityView
        activity.center = CGPoint.init(x:shareOnce.mainView.frame.width / 2, y:shareOnce.mainView.frame.height / 2 )
        activity.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        activity.isHidden = false
        activity.startAnimating()
        shareOnce.getWindow().addSubview(shareOnce)
    }
    
    
    /// 显示加载,不可自动关闭
    ///
    /// - Parameter status: 说明文字
    public class func show(status: String) -> Void{
        shareOnce.statusImgView.isHidden = true
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imgView]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgView":shareOnce.activityView])
        let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imgview]-5-[label(30)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgview":shareOnce.activityView,"label":shareOnce.statusLabel])
        let hLabelConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[label]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["label":shareOnce.statusLabel])
        shareOnce.mainView.addConstraints(hConstraint)
        shareOnce.mainView.addConstraints(hLabelConstraint)
        shareOnce.mainView.addConstraints(vConstraint)
        shareOnce.statusLabel.text = status
        shareOnce.statusLabel.isHidden = false
        shareOnce.activityView.isHidden = false
        shareOnce.activityView.startAnimating()
        shareOnce.getWindow().addSubview(shareOnce)
    }
    
    
    /// 成功显示,可自动关闭
    ///
    /// - Parameter status: 成功说明文字
    public class func showSuccess(status: String) -> Void{
        shareOnce.activityView.isHidden = true
        shareOnce.activityView.stopAnimating()
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imgView]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgView":shareOnce.statusImgView])
        let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imgview]-5-[label(30)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgview":shareOnce.statusImgView,"label":shareOnce.statusLabel])
        let hLabelConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[label]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["label":shareOnce.statusLabel])
        shareOnce.mainView.addConstraints(hConstraint)
        shareOnce.mainView.addConstraints(hLabelConstraint)
        shareOnce.mainView.addConstraints(vConstraint)
        shareOnce.statusLabel.text = status
        shareOnce.statusLabel.isHidden = false
        shareOnce.statusImgView.isHidden = false
        shareOnce.statusImgView.image = shareOnce.successImg
        shareOnce.getWindow().addSubview(shareOnce)
        AYProgressHUD.hiddenAfterTime()
    }
    
    
    /// 提示显示,可自动回收
    ///
    /// - Parameter status: 提示说明文字
    public class func showInfo(status: String) -> Void{
        shareOnce.activityView.isHidden = true
        shareOnce.activityView.stopAnimating()
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imgView]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgView":shareOnce.statusImgView])
        let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imgview]-5-[label(30)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgview":shareOnce.statusImgView,"label":shareOnce.statusLabel])
        let hLabelConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[label]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["label":shareOnce.statusLabel])
        shareOnce.mainView.addConstraints(hConstraint)
        shareOnce.mainView.addConstraints(hLabelConstraint)
        shareOnce.mainView.addConstraints(vConstraint)
        shareOnce.statusLabel.text = status
        shareOnce.statusLabel.isHidden = false
        shareOnce.statusImgView.isHidden = false
        shareOnce.statusImgView.image = shareOnce.infoImg
        shareOnce.getWindow().addSubview(shareOnce)
        AYProgressHUD.hiddenAfterTime()
    }
    
    
    /// 错误显示,可自动回收
    ///
    /// - Parameter status:错误显示文字
    public class func showError(status: String) -> Void{
        shareOnce.activityView.isHidden = true
        shareOnce.activityView.stopAnimating()
        let hConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[imgView]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgView":shareOnce.statusImgView])
        let vConstraint = NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[imgview]-5-[label(30)]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["imgview":shareOnce.statusImgView,"label":shareOnce.statusLabel])
        let hLabelConstraint = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[label]-10-|", options: .directionLeadingToTrailing, metrics: nil, views: ["label":shareOnce.statusLabel])
        shareOnce.mainView.addConstraints(hConstraint)
        shareOnce.mainView.addConstraints(hLabelConstraint)
        shareOnce.mainView.addConstraints(vConstraint)
        shareOnce.statusLabel.text = status
        shareOnce.statusLabel.isHidden = false
        shareOnce.statusImgView.isHidden = false
        shareOnce.statusImgView.image = shareOnce.errorImg
        shareOnce.getWindow().addSubview(shareOnce)
        AYProgressHUD.hiddenAfterTime()
    }


    
    public class func hidden() -> Void {
        shareOnce.activityView.isHidden = true
        shareOnce.statusImgView.isHidden = true
        shareOnce.statusLabel.isHidden = true
        shareOnce.activityView.startAnimating()
        shareOnce.removeFromSuperview()
    }
    
    
    private class func hiddenAfterTime() -> Void{
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + shareOnce.time!) {
            AYProgressHUD.hidden()
        }
    }
    
    
    /// 获取 window 视图
    ///
    /// - Returns: window 视图
    private func getWindow() -> UIWindow{
        return ((UIApplication.shared.delegate?.window)!)!
    }
    
    
    
}
