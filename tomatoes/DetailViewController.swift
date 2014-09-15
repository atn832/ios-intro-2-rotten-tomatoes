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
        image.setImageWithURL(NSURL.URLWithString(posters["original"] as String))
        
        let YourApiKey = "naxm8cmrb6httu74m8t5hgfu" // Fill with the key you registered at http://developer.rottentomatoes.com
        let movieURL = ((movie["links"] as NSDictionary)["self"] as String) +
            "?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(movieURL))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            println("detailed movie view")
            println(dictionary);
        })
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
