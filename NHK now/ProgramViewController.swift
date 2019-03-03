//
//  ProgramViewController.swift
//  NHK now
//
//  Created by 奥城健太郎 on 2019/03/03.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit

class ProgramViewController: UIViewController {
    
    @IBOutlet weak var nowStartTimeLabel: UILabel!
    @IBOutlet weak var nowEndTimeLabel: UILabel!
    @IBOutlet weak var nowTitleLabel: UITextView!
    @IBOutlet weak var nowSubtitleLabel: UITextView!
    @IBOutlet weak var nextStartTimeLabel: UILabel!
    @IBOutlet weak var nextEndTimeLabel: UILabel!
    @IBOutlet weak var nextTitleLabel: UITextView!
    @IBOutlet weak var nextSubtitleLabel: UITextView!
    
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //放送中の番組情報
        if let nowStart = userDefaults.object(forKey: "nowStart") as? String{
            nowStartTimeLabel.text = String(nowStart.suffix(14).prefix(5))
        }
        
        if let nowEnd = userDefaults.object(forKey: "nowEnd") as? String{
            nowEndTimeLabel.text = String(nowEnd.suffix(14).prefix(5))
        }
        
        nowTitleLabel.text = userDefaults.object(forKey: "nowTitle") as? String
        
        nowSubtitleLabel.text = (userDefaults.object(forKey: "nowSubtitle") as! String)
        
        //次の番組情報
        if let nextStart = userDefaults.object(forKey: "nextStart") as? String{
            nextStartTimeLabel.text = String(nextStart.suffix(14).prefix(5))
        }
        
        if let nextEnd = userDefaults.object(forKey: "nextEnd") as? String{
            nextEndTimeLabel.text = String(nextEnd.suffix(14).prefix(5))
        }
        
        nextTitleLabel.text = userDefaults.object(forKey: "nextTitle") as? String
        
        nextSubtitleLabel.text = (userDefaults.object(forKey: "nextSubtitle") as! String)
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
