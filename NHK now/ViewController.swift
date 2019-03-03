//
//  ViewController.swift
//  NHK now
//
//  Created by 奥城健太郎 on 2019/03/02.
//  Copyright © 2019 奥城健太郎. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0{
            return area.count
        }else{
            return channel.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView,
                    titleForRow row: Int,
                    forComponent component: Int) -> String? {
        if component == 0{
            return area[row]
        }else{
            return channel[row]
        }
    }
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    let userDefaults = UserDefaults.standard
    
    let area: [String] = ["札幌","青森","盛岡","仙台","秋田","山形","福島","水戸","宇都宮","前橋","さいたま","千葉","東京","横浜","新潟","富山","金沢","福井","甲府","長野","岐阜","静岡","名古屋","津","大津","京都","大阪","神戸","奈良","和歌山","鳥取","松江","岡山","広島","山口","徳島","高松","松山","高知","福岡","佐賀","長崎","熊本","大分","宮崎","鹿児島","沖縄"]
    let channel: [String] = ["NHK 総合","NHK Eテレ","NHK BS1","NHK BSプレミアム"]
    let channelCode: [String] = ["g1","e1","s1","s3"]
    
    var areaRow:Int = 0
    var channelRow:Int = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.selectRow(12, inComponent: 0, animated: false)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func didTouchSearchBtn(_ sender: Any) {
        // 1列目の選択されているrowの取得
        areaRow = pickerView.selectedRow(inComponent: 0)
        // 2列目の選択されているrowの取得
        channelRow = pickerView.selectedRow(inComponent: 1)
        
        //URL
        let areaCode = String(format: "%03d", areaRow*10+10)
        let choiceChannel = String(channelCode[channelRow])
        let url:String = "https://api.nhk.or.jp/v2/pg/now/\(areaCode)/\(choiceChannel).json?key="
        print(url)
        
        //APIの取得
        Alamofire.request(
            url,
            method: .get,
            parameters: [:],
            encoding: URLEncoding.default,
            headers: nil
            )
            .responseJSON{(response: DataResponse<Any>) in
                
                let json = JSON(response.result.value as Any)
                
                
                print([json][0]["nowonair_list"]["\(choiceChannel)"]["present"]["title"])
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["present"]["title"].string, forKey: "nowTitle")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["present"]["subtitle"].string, forKey: "nowSubtitle")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["present"]["start_time"].string, forKey: "nowStart")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["present"]["end_time"].string, forKey: "nowEnd")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["following"]["title"].string, forKey: "nextTitle")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["following"]["subtitle"].string, forKey: "nextSubtitle")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["following"]["start_time"].string, forKey: "nextStart")
                self.userDefaults.set([json][0]["nowonair_list"]["\(choiceChannel)"]["following"]["end_time"].string, forKey: "nextEnd")
                
                self.performSegue(withIdentifier: "toSecondView", sender: nil)
        }
        
    }
    
}

