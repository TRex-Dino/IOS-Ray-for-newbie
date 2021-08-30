//
//  Checklist.swift
//  CheckList
//
//  Created by Dmitry on 26.08.2021.
//

import Foundation

class Checklist: ObservableObject {

  // Properties
  // ==========

  @Published var items: [ChecklistItem] = []


  // Methods
  // =======

  init() {
    print("Documents directory is: \(documentsDirectory())")
    print("Data file path is: \(dataFilePath())")
    loadListItems()
  }

  func printChecklistContents() {
    for item in items {
      print(item)
    }
  }

  func deleteListItem(whichElement: IndexSet) {
    items.remove(atOffsets: whichElement)
    printChecklistContents()
    saveListItems()
  }

  func moveListItem(whichElement: IndexSet, destination: Int) {
    items.move(fromOffsets: whichElement, toOffset: destination)
    printChecklistContents()
    saveListItems()
  }

  func documentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory,
                                         in: .userDomainMask)
    return paths[0]
  }

  func dataFilePath() -> URL {
    return documentsDirectory().appendingPathComponent("Checklist.plist")
  }

  func saveListItems() {
    // 1
    let encoder = PropertyListEncoder()
    // 2
    do {
      // 3
      let data = try encoder.encode(items)
      // 4
      try data.write(to: dataFilePath(),
                     options: Data.WritingOptions.atomic)
      // 5
    } catch {
      // 6
      print("Error encoding item array: \(error.localizedDescription)")
    }
  }

  func loadListItems() {
    // 1
    let path = dataFilePath()
    // 2
    if let data = try? Data(contentsOf: path) {
      // 3
      let decoder = PropertyListDecoder()
      do {
        // 4
        items = try decoder.decode([ChecklistItem].self,
                                   from: data)
        // 5
      } catch {
        print("Error decoding item array: \(error.localizedDescription)")
      }
    }
  }
}

//MARK: - comments saveListItems
/*
 1. First, the method creates an instance of PropertyListEncoder, a type of object that Apple operating systems use to encode the data stored in an app’s objects into a property list.
 2. The do keyword, which you haven’t encountered before, sets up the first of two blocks of code, which are Swift’s way of catching errors that might come up when the program is running.
 3. Here, you call the encoder’s encode() method to encode the items array. The method could fail. It throws an error if it’s unable to encode the data for some reason: Perhaps it’s not in the expected format, or it’s corrupted, or the device’s flash drive is unavailable.
 4. If the call to encode() succeeds, data now contains the contents of the items array in encoded form. This line attempts to write this encoded data to a file using the file path returned by a call to dataFilePath(). The write() method, like many file operations, can fail for many reasons and throw an error. Once again, you have to make use of a try statement, so the catch block can handle the case where write() fails.
 5. This is the start of the catch block, which contains the code to execute if any line of code in the do block threw an error.
 6. This is the code that executes if code in the do block throws an error. If you were planning to sell this app in the App Store, you might do all kinds of things with this code to deal with cases where encoding the data or writing it to the device’s file system fails. In this case, you’ll simply print out an error message to Xcode’s console.
 */

//MARK: - comments loadListItems
/*
 1. First, you store the results of dataFilePath() — the path to the Checklist.plist file — in a temporary constant named path.
 2. The method tries to load the contents of Checklist.plist into a new Data object. The try? command attempts to create the Data object, but returns nil — Swift’s way of saying “no result” — if it fails. That’s why you put it in an if let statement.
 3. When the app does find a Checklist.plist file, the method creates an instance of PropertyListDecoder.
 4. The method loads the saved data back into items using the decoder’s decode method. The only item of interest here is the first parameter passed to decode . The decoder needs to know what type of data the result of the decode operation will be. You let it know that it will be an array of ChecklistItem objects.
 5. This is the start of the catch block, which contains the code that executes if any line of code in the do block throws an error.
 */
