//
//  TableViewController.swift
//  finalTestCatAPI
//
//  Created by Максим Чесников on 14.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    var countRowsInd = 100
    var loadMoreStatus = false
    var step: Float!
//    var refreshControl:UIRefreshControl!
    

    @IBOutlet weak var progressBar: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
         for i in 0...countRowsInd + 1 {
              data.append("\(i)")
         }
        for _ in 0...countRowsInd {
            imagesCat.append(UIImage(named: "one")!)
        }
        
        for i in 0...countRowsInd
        {
            cats.append(Cat(id: Int(data[i])!, image: imagesCat[i]))
        }
        step = Float(1.0 / Double(self.countRowsInd))
        getImage3(beginIm: 0, endIM: countRowsInd)
        self.refreshControl?.addTarget(self, action: #selector(refresh), for: UIControl.Event.valueChanged)
        
        tableView.dataSource = self
    }

    
    @objc func refresh(sender:AnyObject)
    {
        // Updating your data here...
        getImage3(beginIm: 0, endIM: countRowsInd)
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return countRowsInd
    }
    private var cats: [Cat] = []
    private var data: [String] = []
    private var imagesCat: [UIImage] = []
    
    
    func getImage3(beginIm: Int , endIM: Int){
        var schet = 0
        for _ in beginIm...endIM - 1
        {
        let urlString = "https://api.thecatapi.com/v1/images/search"
        let url = URL(string: urlString)
        let session = URLSession.shared
        let task = session.dataTask(with: url!) {(data, response, error) in
        print("Task completed")

            guard data != nil && error == nil else {
                print(error?.localizedDescription as Any)
                return
            }

            do{
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [[String: AnyObject]]
                if let location = json[0]["url"] as? String
                {
                    print(location)
                    let strLoc = String(location)
                    let urlLoc = URL(string: strLoc)
                    if let data1 = try? Data(contentsOf: urlLoc!) {
                        DispatchQueue.main.async {
                            let image_dow = UIImage(data: data1)!
                            self.imagesCat[schet] = image_dow
                            self.cats[schet].image = self.imagesCat[schet]
                            self.tableView.reloadData()
                            schet += 1
                            self.progressBar.progress += self.step
                            
                        }
                    }
                }
            }
            catch let parseError as NSError {
                print("JSON Error \(parseError.localizedDescription)")
            }
        }
            task.resume()
        }
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell = tableView.dequeueReusableCell(withIdentifier: "cellReuseIdentifier") as! CustomTableViewCell
        let text = String(cats[indexPath.row + 1].id)
        let imageRow = cats[indexPath.row].image
        cell.label.text = text
        cell.imageView2.image = imageRow

        return cell
    }
    
    override open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == data.count-1 { //you might decide to load sooner than -1 I guess...
          //load more into data here
            countRowsInd += 5
            print("down")
        }
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let cell = sender as! UITableViewCell
            let selectedRow = tableView.indexPath(for: cell)!.row
            destination.bigImageOr = cats[selectedRow].image
        }
    }
}
    


