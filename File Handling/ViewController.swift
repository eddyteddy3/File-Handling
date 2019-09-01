//
//  ViewController.swift
//  File Handling
//
//  Created by Moazzam Tahir on 02/09/2019.
//  Copyright © 2019 Moazzam Tahir. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    var fileMng: FileManager = FileManager.default //selecting the defualt location of App Sandbox File.
    var docsDir: String? //string to store the document directory from user's domain
    var dataFile: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkFile()
    }

    func checkFile() {
        //user domain mask is user's app home directory
        let dirPath = fileMng.urls(for: .documentDirectory, in: .userDomainMask)
        
        dataFile = dirPath[0].appendingPathComponent("datafile.dat").path //getting the path as String
        
        if fileMng.fileExists(atPath: dataFile) { //check whether the file path exists
            if let dataBuffer = fileMng.contents(atPath: dataFile) { //getting the contents of file
                let dataString = NSString(data: dataBuffer, encoding: String.Encoding.utf8.rawValue)
                print("data read from file: \(dataString)")
                textField.text = dataString as String?
            }
        }
    }
    
    @IBAction func saveText(_ sender: Any) {
        
        if let text = textField.text {
            let dataBuffer = text.data(using: String.Encoding.utf8)
            fileMng.createFile(atPath: dataFile, contents: dataBuffer, attributes: nil) //creates the file to the document directory
        }
        
    }
    
}

