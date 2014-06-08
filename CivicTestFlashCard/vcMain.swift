//
//  vcMain.swift
//  CivicTestFlashCard
//
//  Created by Xiaolong Zhang on 6/7/14.
//  Copyright (c) 2014 xiaolozhang. All rights reserved.
//

import UIKit
import CoreData

class vcMain: UIViewController {
    @IBOutlet var txtUsername: UITextField!
    @IBOutlet var txtPassword: UITextField!
    
    @IBAction func btnSave(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext
        
        var newUser = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context) as NSManagedObject
        newUser.setValue("\(txtUsername.text)", forKey: "username")
        newUser.setValue("\(txtPassword.text)", forKey: "password")
        context.save(nil)
        println(newUser)
        
    }
    
    @IBAction func btnLoad(){
        var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        var context:NSManagedObjectContext = appDel.managedObjectContext

        var request = NSFetchRequest(entityName: "Users")
        request.returnsObjectsAsFaults = false
        
        request.predicate = NSPredicate(format: "username = %@", ""+txtUsername.text)
        
        var results:NSArray = context.executeFetchRequest(request, error: nil)
        if(results.count > 0){
            var res = results[0] as NSManagedObject
            txtUsername.text = res.valueForKey("username") as String
            txtPassword.text = res.valueForKey("password") as String
//            for res in results{
//                println(res)
//            }
        }else{
            println("0 results returned")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
