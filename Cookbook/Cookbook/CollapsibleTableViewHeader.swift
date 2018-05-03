//
//  CollapsibleTableViewHeader.swift
//  Cookbook
//
//  Created by Valentin Perez on 5/1/18.
//  Copyright © 2018 Valpe Technologies. All rights reserved.
//

import UIKit

protocol CollapsibleTableViewHeaderDelegate {
  func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView {

  var delegate: CollapsibleTableViewHeaderDelegate?
  var section: Int = 0

  let rect = CGRect(origin: CGPoint(x:0, y:0), size: CGSize(width:50, height:50))

  let titleLabel = UILabel()
  let arrowLabel = UILabel()

  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)

    // Content View
    contentView.backgroundColor = UIColor.white//UIColor(hex: 0x2E3944)

    let marginGuide = contentView.layoutMarginsGuide


   // arrowLabel.frame = rect
    arrowLabel.text = "+"
    // Arrow label
    contentView.addSubview(arrowLabel)
    arrowLabel.textColor = UIColor.black
    arrowLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 25)
    arrowLabel.translatesAutoresizingMaskIntoConstraints = false
    arrowLabel.widthAnchor.constraint(equalToConstant: 12).isActive = true
    arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    arrowLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true

    for family in UIFont.familyNames.sorted() {
      let names = UIFont.fontNames(forFamilyName: family)
      print("Family: \(family) Font names: \(names)")
    }

    // Title label
    contentView.addSubview(titleLabel)
    titleLabel.textColor = UIColor.black
    titleLabel.font = UIFont(name: "SFProDisplay-Semibold", size: 25)
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
    titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
    titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
    titleLabel.leadingAnchor.constraint(equalTo: arrowLabel.layoutMarginsGuide.leadingAnchor, constant: 10).isActive = true




    //
    // Call tapHeader when tapping on this header
    //
    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  //
  // Trigger toggle section when tapping on the header
  //
  @objc func tapHeader(_ gestureRecognizer: UITapGestureRecognizer) {
    guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
      return
    }

    delegate?.toggleSection(self, section: cell.section)
  }

  func setCollapsed(_ collapsed: Bool) {
    //
    // Animate the arrow rotation (see Extensions.swf)
    //
    // change to - and +

    arrowLabel.text = collapsed ? "+" : "-"
    //arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
  }

}
