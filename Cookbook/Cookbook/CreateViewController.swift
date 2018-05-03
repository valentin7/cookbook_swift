//
//  CreateViewController.swift
//  Cookbook
//
//  Created by Valentin Perez on 5/1/18.
//  Copyright © 2018 Valpe Technologies. All rights reserved.
//

import UIKit

class CreateViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CollapsibleTableViewHeaderDelegate {


  @IBOutlet var ingredientsTableViewController: UITableView!

  var sections = sectionsData
  var indexPathsSelectedSet: Set<IndexPath> = []
  var listOfIngredients: Dictionary<String, Array<String>> = [:]
  var totalNumIngredients: Int = 0

  @IBOutlet var cookButton: UIButton!
  @IBOutlet var numIngredientsButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    totalNumIngredients = 0
    roundAndShadow(view: cookButton)
    roundAndShadow(view: numIngredientsButton)
    cookButton.isEnabled = false

    ingredientsTableViewController.dataSource = self
    ingredientsTableViewController.delegate = self
    ingredientsTableViewController.separatorStyle = UITableViewCellSeparatorStyle.none

    numIngredientsButton.isHidden = true
        // Do any additional setup after loading the view.
    }

  func roundAndShadow(view: UIView) {
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.cornerRadius = view.frame.width / 2
    view.layer.shadowOffset = CGSize(width: 2, height: 2)
    view.layer.shadowOpacity = 0.5
    view.layer.shadowRadius = 2
    view.layer.masksToBounds = false
    //view.clipsToBounds = true
  }

  override func viewDidAppear(_ animated: Bool) {

  }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func clickedBack(_ sender: Any) {

    _ = navigationController?.popViewController(animated: true)

  }

  @IBAction func clickedCook(_ sender: Any) {
    print("readyy")
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return sections.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return sections[section].collapsed ? 0 : sections[section].items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
      CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")

    let item: Item = sections[indexPath.section].items[indexPath.row]

    cell.nameLabel.text = "   + " + item.name
    cell.nameLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 25)
    cell.detailLabel.text = item.detail
    cell.removeSectionSeparators()

    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableViewAutomaticDimension
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")

    header.titleLabel.text = sections[section].name
    header.titleLabel.adjustsFontForContentSizeCategory = true
    header.arrowLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 25)
    header.setCollapsed(sections[section].collapsed)

    header.section = section
    header.delegate = self

    return header
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let cell: CollapsibleTableViewCell  = tableView.cellForRow(at: indexPath) as! CollapsibleTableViewCell
    let headerView: CollapsibleTableViewHeader = tableView.headerView(forSection: indexPath.section) as! CollapsibleTableViewHeader
    let typeOfIngredient = sections[indexPath.section].name

    if indexPathsSelectedSet.contains(indexPath) {
      indexPathsSelectedSet.remove(indexPath)
      cell.nameLabel.textColor = CookbookColors.black

      if listOfIngredients[typeOfIngredient] != nil {
        let ingredientToRemove = sections[indexPath.section].items[indexPath.row].name
        let index = listOfIngredients[typeOfIngredient]?.index(of: ingredientToRemove)
        listOfIngredients[typeOfIngredient]!.remove(at: index!)


        if listOfIngredients[typeOfIngredient]!.count == 0 {
          headerView.titleLabel.textColor = CookbookColors.black
          headerView.arrowLabel.textColor = CookbookColors.black
        }

        totalNumIngredients -= 1
      }


    } else {
      totalNumIngredients += 1

      let newIngredient = sections[indexPath.section].items[indexPath.row].name
      if listOfIngredients[typeOfIngredient] != nil {
        listOfIngredients[typeOfIngredient]!.insert(newIngredient, at: 0)

      } else {
        listOfIngredients[typeOfIngredient] = [newIngredient]
      }

      indexPathsSelectedSet.insert(indexPath);
      let colorForPath = CookbookColors.ingredientsColors[indexPath.section % (CookbookColors.ingredientsColors.count)]

      cell.nameLabel.textColor = colorForPath
      headerView.titleLabel.textColor = colorForPath
      headerView.arrowLabel.textColor = colorForPath
    }
    numIngredientsButton.isHidden = totalNumIngredients == 0
    cookButton.isEnabled = totalNumIngredients > 0

    numIngredientsButton.setTitle(String(totalNumIngredients), for: UIControlState.normal)
  }

  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 44.0
  }

  func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    return 1.0
  }

  func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {

    let collapsed = !sections[section].collapsed

    // Toggle collapse
    sections[section].collapsed = collapsed
    header.setCollapsed(collapsed)

    ingredientsTableViewController.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
  }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UITableViewCell {
  func removeSectionSeparators() {
    for subview in subviews {
      if subview != contentView && subview.frame.width == frame.width {
        subview.removeFromSuperview()
      }
    }
  }
}
//
// MARK: - Section Header Delegate
//
//extension CreateViewController: CollapsibleTableViewHeaderDelegate {
//
//  func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
//    let collapsed = !sections[section].collapsed
//
//    // Toggle collapse
//    sections[section].collapsed = collapsed
//    header.setCollapsed(collapsed)
//
//    ingredientsTableViewController.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
//  }
//
//}
