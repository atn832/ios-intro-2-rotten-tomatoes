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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        // what does this do??
        tableView.delegate = self
        tableView.dataSource = self
        
        let YourApiKey = "naxm8cmrb6httu74m8t5hgfu" // Fill with the key you registered at http://developer.rottentomatoes.com
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL.URLWithString(RottenTomatoesURLString))
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
            var errorValue: NSError? = nil
            let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
//            println(dictionary)
            self.movies = dictionary["movies"] as [NSDictionary]
            println("\(self.movies.count) movies found");

            self.tableView.reloadData()
        })
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
//
//    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int {
//        // #warning Potentially incomplete method implementation.
//        // Return the number of sections.
//        return 100
//    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        println("table item count called")
        return 5//movies.count
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return movies.count
    }
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell! {
//        
//    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // Configure the cell...
        println("returning cell, start")
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell") as MovieTableViewCell
        cell.titleLabel.text = "the title section \(indexPath)"
        let movie = movies[indexPath.row]
        cell.titleLabel.text = movie["title"] as? String
        cell.descriptionLabel.text = "the description section"
        
        var posterDictionary = movie["posters"] as NSDictionary
        var posterUrl = posterDictionary["thumbnail"] as String
//        cell.movieImage.setImageWithURL();
//        cell.movieImage.set
        
        println("returning cell")
//        return UITableViewCell()
        
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
        destinationViewController.movie = nil
//        tableViewCell.rowIndex?...
    }

}