

/*
 
 func documentsDirectory() -> URL {
     let paths = FileManager.default.urls(for: .documentDirectory,
                                          in: .userDomainMask)
     return paths[0]
 }
 
 func dataFilePath() -> URL {
     documentsDirectory().appendingPathComponent("Checklist.plist")
 }
 
 Notice that both methods return a URL object. You may think of a URL as a “web address”, but it’s really just a path for a given directory or file, which can be either online or on the local system. iOS uses URLs to refer to files in its file system. When a URL begins with http:// or https://, it refers to a directory or file on the web. When it refers to a local file, a URL will begin with file://.
 
 if we print() dataFilePath(), we get: file:///Users/dmitry/Library/Developer/CoreSimulator/Devices/066DF917-2364-419F-BC91-250F92EC2E93/data/Containers/Data/Application/06EEFA19-2F52-4BD8-9063-736E1547DDB2/Documents/Checklist.plist
 */
