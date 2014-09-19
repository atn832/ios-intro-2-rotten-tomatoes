//
//  DetailViewController.swift
//  tomatoes
//
//  Created by Anh Tuan on 9/14/14.
//  Copyright (c) 2014 Anh Tuan. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var movie: NSDictionary!
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        println(movie)
        
        descriptionLabel.text = movie["synopsis"] as String
        descriptionLabel.sizeToFit()
        
        let descriptionFrame = descriptionLabel.frame
        scroll.contentSize = CGSize(width: scroll.contentSize.width, height: descriptionFrame.maxY)
        
        titleLabel.text = movie["title"] as String
        let posters = movie["posters"] as NSDictionary
        let tmbImageURL = posters["original"] as String
        let orgImageURL = tmbImageURL.stringByReplacingOccurrencesOfString("_tmb.", withString: "_org.", options: nil, range: nil)
        image.setImageWithURL(NSURL.URLWithString(tmbImageURL))
        image.setImageWithURL(NSURL.URLWithString(orgImageURL))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
