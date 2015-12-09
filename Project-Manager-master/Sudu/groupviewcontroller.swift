//
//  groupviewcontroller.swift
//  Sudu
//
//  Created by pengyuan zhao on 15/12/6.
//  Copyright © 2015年 xiwei feng. All rights reserved.
//

import Foundation

class GroupViewController: RCConversationViewController,RCIMUserInfoDataSource {
    var window: UIWindow?
    
    let APPKEY = "RC-App-Key"
    let NONCE = "RC-Nonce"
    let TIMESTAMP = "RC-Timestamp"
    let SIGNATURE = "RC-Signature"
    let URL="https://api.cn.ronghub.com/group/create.json"
    let appKey = "lmxuhwagx94wd"
    let CONTENT = "Content-Type"
    let SUDUURL = "https://superuserdue.herokuapp.com/sudu6770/"
    
    
    //gain username from segue
    var username:String?
    //gain groupname/id from segue
    var groupname:String?
    // gain from server
    var suduuserid: [String] = []
    var token =
    [String:String]()
    
    
    func getUserInfoWithUserId(userId: String!, completion: ((RCUserInfo!) -> Void)!) {
        let userInfo = RCUserInfo()
        userInfo.userId = userId
        switch userId {
            case "xiweifeng":
            userInfo.name = "xiweifeng"
            userInfo.portraitUri = "https://scontent-lga3-1.xx.fbcdn.net/hphotos-xap1/v/t1.0-9/12096362_10153934774793888_1372203077918095310_n.jpg?oh=864a0f74f4d8b7d18fbfeebe17cf988e&oe=5722852E"
        case "guihaoliang":
            userInfo.name = "guihaoliang"
            userInfo.portraitUri = "https://scontent-lga3-1.xx.fbcdn.net/hphotos-xta1/t31.0-8/12087669_1506140909703187_8773526418223106972_o.jpg"
        
        case "woo":
            userInfo.name = "woo"
            userInfo.portraitUri = "http://vignette2.wikia.nocookie.net/georgeshrinks/images/6/62/Dad.png/revision/latest?cb=20140102134700"
            
        case "thomas":
        
            userInfo.name = "thomas"
            userInfo.portraitUri = "http://24.media.tumblr.com/tumblr_m42h0g7f3v1qeojxio1_500.png"
       
        case "pengyuanzhao":
            
            userInfo.name = "pengyuanzhao"
            userInfo.portraitUri = "http://s9.favim.com/orig/130724/actor-boy-read-geek-hot-glasses-handsome-logan-lerman-Favim.com-798162.png"
            
        default: break
            
        }
        return completion(userInfo)
    }

    
    func getidfromserver()->Bool{
        let IDURL = SUDUURL+"projects/"

        var req = NSMutableURLRequest(URL:NSURL(string:IDURL)!)
        
        //        req.HTTPMethod = "GET"
        
        req.HTTPMethod = "POST"
        
        let postString = "email_addr=" + "\(username!)"+"@columbia.edu&project_name="+"\(groupname!)"
        print("post=\(postString)")
        
        req.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                print("something")
                return
            }
            print("response = \(response)")
            let d = NSString(data: data!, encoding:NSUTF8StringEncoding)
            print("data=\(d)")
            var myArray = d!.componentsSeparatedByString(",")
            for index in 0..<(myArray.count/4){
                self.token ["\(myArray[index*4+1])"] = "\(myArray[index*4+3])"
            }
            
            
            for (key,value) in self.token {
                self.suduuserid.append("\(key)")
                
            }
            
            print (self.suduuserid)
            
            let tokenCache = NSUserDefaults.standardUserDefaults().objectForKey("kDeviceToken")
            
            RCIM.sharedRCIM().initWithAppKey("lmxuhwagx94wd")
            
            var temmmm=self.token["\(self.username!)"]!
            let tem = temmmm.componentsSeparatedByString(" ")[0]
            print(tem)
            
            RCIM.sharedRCIM().connectWithToken(tem, success:
                {(_)->Void in
                    print("Success connected")
                    
                    let currentuser = RCUserInfo(userId: "\(self.username!)", name: "\(self.username!)", portrait: "http://xiaoboswift.com/1.jpg")
                    RCIMClient.sharedRCIMClient().currentUserInfo = currentuser
                    self.groupchat()
                    
                    
                }, error: {(RCConnectErrorCode)->Void in
                    print(RCConnectErrorCode)
                    
                    
                }, tokenIncorrect: {(_)->Void in
                    print("wrong token")
                }
            )
            
        }
        
        task.resume()
        
        return true
        
    }
    
    
    func groupchat (){
        
        let req = NSMutableURLRequest(URL:NSURL(string:URL)!)
        
        
        let nonce = Int(arc4random())%1000000+1
        
        let timestamp = String (format: "%f",NSDate().timeIntervalSince1970)
        
        let TimeStamp = (timestamp as NSString).intValue
        
        var sign = "kw6mF79yzYHfM3"+"\(nonce)"+"\(TimeStamp)"
        
        sign = sign.sha1()
        
        //build header
        
        req.HTTPMethod = "POST"
        req.addValue("\(appKey)", forHTTPHeaderField: APPKEY)
        req.addValue("\(nonce)", forHTTPHeaderField: NONCE)
        req.addValue("\(TimeStamp)", forHTTPHeaderField: TIMESTAMP)
        req.addValue("\(sign)", forHTTPHeaderField: SIGNATURE)
        req.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: CONTENT)
        let postString = useridstring(suduuserid)
        print(postString)
        req.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(req) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                print("something wrong")
                return
            }
            print("response = \(response)")
            print(data)
            
            
        }
        task.resume()
        
    }
    
    
    // generate http body
    
    func useridstring(Sdid:[String])->String{
        var allid = ""
        
        for str in Sdid{
            allid = allid+"userId="+str+"&"
        }
        
        allid = allid+"groupId="+"\(groupname!)"+"&groupName="+"\(groupname!)"
        
        return allid
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.hidden = true
        self.conversationType = .ConversationType_GROUP
        self.targetId = self.groupname!
        self.title = "SUDU"
        self.navigationItem.title!=self.groupname!
        var s = self.getidfromserver()
    
        RCIM.sharedRCIM().userInfoDataSource = self
        
        // Do any additional setup after loading the view.
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
