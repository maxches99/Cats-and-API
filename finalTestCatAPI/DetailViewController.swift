//
//  DetailViewController.swift
//  CatsApp
//
//  Created by Максим Чесников on 13.12.2019.
//  Copyright © 2019 Максим Чесников. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var bigImage: UIImageView!
    //    @IBOutlet weak var bigImage: UIImageView!
    var bigImageOr: UIImage!
    override func viewDidLoad() {
        super.viewDidLoad()
        bigImage.image = bigImageOr
        // Do any additional setup after loading the view.
    }
    
    @IBAction func shareButton2(_ sender: Any) {
        let activityItems = [bigImage.image!] // 1
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil) // 2
        self.present(activityController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
