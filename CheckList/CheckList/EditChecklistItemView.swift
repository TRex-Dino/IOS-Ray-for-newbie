//
//  EditChecklistItemView.swift
//  CheckList
//
//  Created by Dmitry on 26.08.2021.
//

import SwiftUI

struct EditChecklistItemView: View {

  // Properties
  // ==========

  @Binding var checklistItem: ChecklistItem

  // User interface content and layout
  var body: some View {
    Form {
      TextField("Name", text: $checklistItem.name)
      Toggle("Completed", isOn: $checklistItem.isChecked)
    }
  }
}

//struct EditChecklistItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditChecklistItemView()
//    }
//}
