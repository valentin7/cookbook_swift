//
//  BrowseViewController.swift
//  Cookbook
//
//  Created by Valentin Perez on 5/1/18.
//  Copyright © 2018 Valpe Technologies. All rights reserved.
//

import UIKit

class BrowseViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

  
  @IBOutlet var upcomingCollectionView: UpcomingCollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()

    upcomingCollectionView.dataSource = self
    upcomingCollectionView.delegate = self
    //upcomingCollectionView.register(UpcomingCollectionViewCell.self, forCellWithReuseIdentifier: "upcomingCell")

    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 3
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell : UpcomingCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "upcomingCell", for: indexPath) as! UpcomingCollectionViewCell

    //cell.titleLabel.text = "Recipe Title"
    //cell.descriptionLabel!.text = "Description can go here.. "
//    cell.ingredient1Label.text = "Ingredient"
//    cell.ingredient2Label.text = "Ingredient"
//    cell.ingredient3Label.text = "Ingredient"
//    cell.numberOfPeopleLabel.text = "574"

    return cell
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    

  }


}

