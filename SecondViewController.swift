//
//  SecondViewController.swift
//  SwiftLogo
//
//  Created by I_MT on 16/9/24.
//  Copyright © 2016年 I_MT. All rights reserved.
//

import UIKit
/// 不太明白为什么这个mask是覆盖了整个view呢？它的大小不是已经有了吗？？？？？？
class SecondViewController: UITableViewController,UINavigationControllerDelegate {
    
    let maskLayer = swiftLogoLayer.logoLayer()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pack List"
        tableView.rowHeight = 54.0
        rootViewAddMask()
    }
    func rootViewAddMask() -> Void {
        maskLayer.position = CGPoint(x: view.layer.bounds.size.width/2, y: view.layer.bounds.size.height/2+30)
        view.layer.mask = maskLayer
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.view.layer.mask = nil
    }
    let packItems = ["Icecream money", "Great weather", "Beach ball", "Swim suit for him", "Swim suit for her", "Beach games", "Ironing board", "Cocktail mood", "Sunglasses", "Flip flops"]
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return packItems.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        cell.accessoryType = .None
        cell.textLabel!.text = packItems[indexPath.row]
        cell.imageView!.image = UIImage(named: "summericons_100px_0\(indexPath.row).png")
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
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
