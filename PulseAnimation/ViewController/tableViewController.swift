//
//  tableViewController.swift
//  PulseAnimation
//
//  Created by GLB-311-PC on 27/09/18.
//  Copyright © 2018 Globussoft. All rights reserved.
//

import UIKit

class tableViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var basicTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        basicTableView.isHidden=true
        animateTable()
      
        // Do any additional setup after loading the view.
    }

    @IBAction func animateButtonAction(_ sender: UIButton) {
        animateTable()
        
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"Cell", for:indexPath)
        cell.textLabel?.text="cell\(indexPath.row)"
        let separatorLineView = UIView(frame: CGRect(x: 0, y: 0, width:cell.frame.size.width, height: 5))
        /// change size as you need.
        separatorLineView.backgroundColor = UIColor.white
        // you can also put image here
        cell.contentView.addSubview(separatorLineView)
        return cell
    }
    
    func animateTable(){
        basicTableView.reloadData()
        let cells = basicTableView.visibleCells
        let tbleHeight:CGFloat = basicTableView.bounds.size.height
        for i in cells{
            let cell:UITableViewCell = i as UITableViewCell
            cell.transform = CGAffineTransform(translationX: 0, y:tbleHeight )
        }
        var index = 0
        for a in cells {
            self.basicTableView.isHidden=false
            let cell:UITableViewCell = a as UITableViewCell
            UIView.animate(withDuration:1.5, delay:0.05 * Double(index), usingSpringWithDamping:0.8, initialSpringVelocity: 0, options: .transitionFlipFromTop, animations:{
                cell.transform=CGAffineTransform(translationX:0, y: 0)
            }, completion: nil)
            index += 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
