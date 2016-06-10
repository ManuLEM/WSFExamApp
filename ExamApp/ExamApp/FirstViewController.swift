//
//  FirstViewController.swift
//  ExamApp
//
//  Created by Iman Zarrabian on 07/06/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var charactersArray: [Character] = []
    var charactersOffset: Int {
        return charactersArray.count
    }
    
    @IBOutlet weak var characterTV: UITableView!
    func displayCharacters() {
        
        Character.getRemoteCharacters (charactersOffset) { (response) in
            
            switch response.result {
            case .Success:
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if let array = dict["results"] as? Array<AnyObject>  {
                            
                        self.charactersArray += array.map
                            { Character(dict: $0 as! [String: AnyObject]) }
                            
                        self.characterTV.reloadData()
                        
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        displayCharacters()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension FirstViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charactersArray.count + 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        if indexPath.row == charactersArray.count {
            let cell = tableView.dequeueReusableCellWithIdentifier("LoadMoreCell", forIndexPath: indexPath)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCellWithIdentifier("CharacterCell", forIndexPath: indexPath) as! CharacterCell
            let character = charactersArray[indexPath.row]
            cell.titleLabel.text = character.name
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == charactersArray.count {
            displayCharacters()
        }
    }
}


