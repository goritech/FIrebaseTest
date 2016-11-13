//
//  ViewController.swift
//  FirebaseTest
//
//  Created by goritech on 2016/11/01.
//  Copyright © 2016年 goritech. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    
    struct Firebase {
        static let users = "users"
    }
    
    struct Defaults {
        static let user_key = "user_key"
    }
    
    var ref: FIRDatabaseReference!
    var key: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Firebase Realtime Databaseの初期化
        ref = FIRDatabase.database().reference()
        
        // UserDefaultsを使う
        let ud = UserDefaults.standard
        // UserDefaultsからuser_keyを取得
        key = ud.string(forKey: Defaults.user_key)
        
        // user_keyが無ければ、作成
        if self.key == nil {
            // Firebase Realtime DatabaseのAutoIdをkeyとする
            key  = self.ref.child("users").childByAutoId().key
            // UserDefaultsに格納
            ud.set(key, forKey: Defaults.user_key)
        }
        
        // ログイン時間をDatabaseに登録
        let userData = ["login_time": now()]
        let updateData = ["/users/\(key!)": userData]
        ref.updateChildValues(updateData)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func now() -> String {
        let date = NSDate()
        let calendar = NSCalendar.current
        
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date as Date)
        let year = components.year
        let month = components.month
        let day = components.day
        let hour = components.hour
        let minute = components.minute
        let second = components.second
        
        
        return String(format: "%04d/%02d/%02d %02d:%02d:%02d", year!, month!, day!, hour!, minute!, second!)
    }

}

