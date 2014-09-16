//
//  MoviesTableViewController.swift
//  tomatoes
//
//  Created by Anh Tuan on 9/9/14.
//  Copyright (c) 2014 Anh Tuan. All rights reserved.
//

import UIKit

class MoviesTableViewController: UITableViewController {

    var movies: [NSDictionary]! = []
    var myRefreshControl:UIRefreshControl!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        // what does this do??
        tableView.delegate = self
        tableView.dataSource = self
        
        /*
        let manager = AFHTTPRequestOperationManager()
        manager.GET(
            "http://example.com/resources.json",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation!,
                responseObject: AnyObject!) in
                println("JSON: " + responseObject.description)
            },
            failure: { (operation: AFHTTPRequestOperation!,
                error: NSError!) in
                println("Error: " + error.localizedDescription)
        })
        */
        
        self.myRefreshControl = UIRefreshControl()
        self.myRefreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.myRefreshControl.addTarget(self, action: "refresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.myRefreshControl.backgroundColor = UIColor.blackColor()
        self.myRefreshControl.tintColor = UIColor.whiteColor()
        self.tableView.addSubview(myRefreshControl)
        
        refresh(self)
    }
    
    func refresh(sender:AnyObject) {
        let YourApiKey = "naxm8cmrb6httu74m8t5hgfu" // Fill with the key you registered at http://developer.rottentomatoes.com
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        println(RottenTomatoesURLString)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil

            if (data != nil) {
                let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
                self.movies = dictionary["movies"] as [NSDictionary]
            }
            self.networkErrorLabel.hidden = data != nil
            self.tableView.reloadData()
        })
        
        self.myRefreshControl.endRefreshing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return movies.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieTableViewCell
        cell.titleLabel.text = "the title section \(indexPath)"
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.descriptionLabel.text = movie["synopsis"] as? String
        
        var posterDictionary = movie["posters"] as NSDictionary
        var posterUrl = posterDictionary["thumbnail"] as String

        cell.movieImage2.setImageWithURL(NSURL.URLWithString(posterUrl))
        return cell as UITableViewCell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        var destinationViewController = segue.destinationViewController as DetailViewController
        var tableViewCell = sender as UITableViewCell
        let index = tableView.indexPathForCell(tableViewCell)
        let row = index?.row
        destinationViewController.movie = movies[row!]
    }

}
