//
//  PodcastTableViewController.swift
//  DVRGV_app
//
//  Created by Clément BOUSSIRON on 21/07/2018.
//  Copyright © 2018 Clément BOUSSIRON. All rights reserved.
//

import UIKit
import CoreData
class PodcastTableViewController: UITableViewController {
	var coreDataStack:CoreDataStack!
	var podcastCategory:Category?
	var categorySelected:Category?
	var posts:[Post]?
	override func viewDidLoad() {
		super.viewDidLoad()
		let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
		fetchRequest.predicate = NSPredicate(format: "%K == %@", #keyPath(Category.name), "Podcast")
		fetchRequest.resultType = .managedObjectResultType
		do {
			let categories = try coreDataStack.mainContext.fetch(fetchRequest)
			podcastCategory = categories.first
		} catch let error as NSError {
			print("error, \(error), \(error.userInfo)")
		}
		guard let podcastCategory = podcastCategory else {
			return
		}
		categorySelected = podcastCategory
		guard let categorySelected = categorySelected,
		let possts = categorySelected.posts else {
			return
		}
		self.posts = Array(possts)

		let postsSorted = posts?.sorted(by: {$0.date_gmt! > $1.date_gmt!})
		self.posts = postsSorted
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard let posts = posts else {
			return 0
		}
		return posts.count
	}

	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "podcastCell", for: indexPath) as! PodcastTableViewCell
		guard let post = posts?[indexPath.row] else {
			return cell
		}
		cell.update(post: post)
		return cell
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
