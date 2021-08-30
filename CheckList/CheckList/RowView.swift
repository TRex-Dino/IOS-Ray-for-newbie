//
//  RowView.swift
//  CheckList
//
//  Created by Dmitry on 28.08.2021.
//

import SwiftUI

struct RowView: View {

  // Properties
  // ==========

  @Binding var checklistItem: ChecklistItem

  // User interface content and layout
  var body: some View {
    NavigationLink(destination: EditChecklistItemView(checklistItem: $checklistItem)) {
      HStack {
        Text(checklistItem.name)
        Spacer()
        Text(checklistItem.isChecked ? "✅" : "🔲")
      }
    }
  }
}
//
//struct RowView_Previews: PreviewProvider {
//    static var previews: some View {
//        RowView()
//    }
//}
