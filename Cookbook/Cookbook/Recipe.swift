//
//  Recipe.swift
//  Cookbook
//
//  Created by Valentin Perez on 5/1/18.
//  Copyright © 2018 Valpe Technologies. All rights reserved.
//

import Foundation

struct Recipe {
  let title: String
  let description: String
  let imageURL: String
  let ingredients: Dictionary<String, Array<String>>
  
}
