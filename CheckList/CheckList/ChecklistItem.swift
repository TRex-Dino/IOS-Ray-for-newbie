//
//  ChecklistItem.swift
//  CheckList
//
//  Created by Dmitry on 26.08.2021.
//

import Foundation

struct ChecklistItem: Identifiable, Codable {

  // Properties
  // ==========
  
    var id = UUID()
  var name: String
  var isChecked: Bool = false
}
