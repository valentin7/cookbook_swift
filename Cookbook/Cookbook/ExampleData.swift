//
//  ExampleData.swift
//  Cookbook
//
//  Created by Valentin Perez on 5/1/18.
//  Copyright © 2018 Valpe Technologies. All rights reserved.
//

import Foundation

//
// MARK: - Section Data Structure
//
public struct Item {
  var name: String
  var detail: String

  public init(name: String, detail: String) {
    self.name = name
    self.detail = detail
  }
}

public struct Section {
  var name: String
  var items: [Item]
  var collapsed: Bool

  public init(name: String, items: [Item], collapsed: Bool = false) {
    self.name = name
    self.items = items
    self.collapsed = collapsed
  }
}

public var sectionsData: [Section] = [
  Section(name: "Environment", items: [
    Item(name: "Beach", detail: ""),
    Item(name: "Park", detail: ""),
    Item(name: "House", detail: ""),
    Item(name: "Auditorium", detail: ""),
    ]),
  Section(name: "Location", items: [
    Item(name: "Address", detail: ""),
    ]),
  Section(name: "Music", items: [
    Item(name: "Hard Rock", detail: ""),
    Item(name: "Techno", detail: ""),
    Item(name: "Folk", detail: ""),
    Item(name: "Pop", detail: "")
    ])
]
