//
//  ViewController.swift
//  PulseAnimation
//
//  Created by GLB-311-PC on 25/09/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class ViewController: UIViewController,URLSessionDownloadDelegate {
    
    @IBOutlet weak var buttonsearch: UIButtonX!
    @IBOutlet weak var textfiled: UITextField!
    @IBOutlet weak var roundTextfieldConstraint: NSLayoutConstraint!
    @IBOutlet weak var flipView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    var shapeLayer = CAShapeLayer()
    var pulsatingLayer:CAShapeLayer!
    var tapGestureRecognizer:UITapGestureRecognizer!
    @IBOutlet weak var view2: UIImageView!
    @IBOutlet weak var view1: UIView!
    var displayBlankView:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupNotificationObserver()
        
        tapGestureRecognizer = UITapGestureRecognizer(target:self, action:      #selector(handleTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        percentageLabel.isUserInteractionEnabled = true
        percentageLabel.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @IBAction func searchButtonAction(_ sender: UIButtonX) {
        if roundTextfieldConstraint.constant==40
        {
            roundTextfieldConstraint.constant=200
        }else{
            roundTextfieldConstraint.constant=40
        }
        UIView.animate(withDuration:1.0, animations: {
            self.view.layoutIfNeeded()
        })
    }
   
    override func viewDidAppear(_ animated: Bool) {
        setupCircleLayers()
       buttonsearch.layer.cornerRadius=buttonsearch.frame.size.width/2
       textfiled.layer.cornerRadius=buttonsearch.frame.size.width/2
        
        self.flipViewAnimation()
        UIView.transition(with:flipView, duration:1.0, options:displayBlankView ? .transitionFlipFromLeft:.transitionFlipFromRight, animations:{
//            if(self.displayBlankView){
                self.view1.isHidden=true
                self.view2.isHidden=false
//          }
//            else{
//                self.view1.isHidden=false
//                self.view2.isHidden=true
//            }
        }, completion:{
            (finished: Bool) in
//            self.displayBlankView = !self.displayBlankView;
        })
    }
   
    func flipViewAnimation(){
        flipView.layer.cornerRadius=flipView.frame.size.height/2
        view1.layer.cornerRadius=flipView.frame.size.height/2
        view2.layer.cornerRadius=flipView.frame.size.height/2
        view.layoutIfNeeded()
        flipView.layer.addGradienBorder(colors:[UIColor.red,UIColor.blue,UIColor.white,UIColor.yellow], width:10)
    }
    
    
    private func setupCircleLayers(){
        pulsatingLayer = createCircleShapeLAyer(strokeColor: .clear, fillColor: .pulsatingColor)
        
        view.layer.addSublayer(pulsatingLayer)
        animatingPulsatingLayer()
        
        //create my track layer
        let trackLayer = createCircleShapeLAyer(strokeColor: .trackStrokeColor, fillColor: .backgroundColor)
        view.layer.addSublayer(trackLayer)
        view.addSubview(percentageLabel)
        
        shapeLayer = createCircleShapeLAyer(strokeColor: .outlineStrokeColor, fillColor: .clear)
        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi/2,0,0,1)
        shapeLayer.strokeEnd=0
        view.layer.addSublayer(shapeLayer)
        
    }
    
    private func setupNotificationObserver(){
        NotificationCenter.default.addObserver(self, selector:#selector(handleEnterForeground), name: .UIApplicationWillEnterForeground, object:nil)
    }
    
    @objc private func handleEnterForeground(){
        animatingPulsatingLayer()
    }
    
    
    private func createCircleShapeLAyer(strokeColor:UIColor,fillColor:UIColor) -> CAShapeLayer {
        
        let circularPath = UIBezierPath(arcCenter:.zero, radius:100, startAngle:0, endAngle: 2*CGFloat.pi, clockwise:true)
        let layer = CAShapeLayer()
        layer.path=circularPath.cgPath
        layer.strokeColor = strokeColor.cgColor
        layer.lineWidth = 20
        layer.position=view.center
        layer.fillColor = fillColor.cgColor
        layer.lineCap = kCALineCapRound
        return layer
        
    }
    
    private func animatingPulsatingLayer(){
        let animation = CABasicAnimation(keyPath:"transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name:kCAMediaTimingFunctionEaseOut)
        animation.autoreverses=true
        animation.repeatCount=Float.infinity
        pulsatingLayer.add(animation, forKey:"pulsating")

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
   
    @objc func handleTap(_ sender: Any){
        beginDownloadFile()
    }
    
    let urlString = "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4"
    
    private func beginDownloadFile(){
        
        print("Attempting to download file")
        let configuration = URLSessionConfiguration.default
        let operationQueue = OperationQueue()
        let urlSession = URLSession(configuration:configuration, delegate:self, delegateQueue:operationQueue)
        guard let url = URL(string:urlString) else {return}
        let downloadTask = urlSession.downloadTask(with:url)
        downloadTask.resume()
        
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        let percentage = CGFloat(totalBytesWritten) / CGFloat(totalBytesExpectedToWrite)
        
        DispatchQueue.main.async {
            self.percentageLabel.text = "\(Int(percentage * 100))%"
            self.shapeLayer.strokeEnd = percentage
        }
        print(percentage)
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("Finished downloading file")
    }
    
    fileprivate func animateCircle() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 2
        
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

