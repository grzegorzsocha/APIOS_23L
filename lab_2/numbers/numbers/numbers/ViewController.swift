//
//  ViewController.swift
//  numbers
//
//  Created by grzegorz socha on 13/04/2023.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var newGameButton: NSButton!
    @IBOutlet weak var submitButton: NSButton!
    @IBOutlet weak var textFieldsGrid: NSGridView!
    @IBOutlet weak var numbersGrid: NSGridView!
    
    var textFields = [[NSTextField]]()
    var digitButtons = [NSButton]()
    var result = [Int]()
    var currentRow = 0
    var currentColumn = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTextFields()
        setUpDigitButtons()
        generateResult()
        submitButton.isEnabled = false
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func digitButtonPressed(_ sender: NSButton) {
        if let digit = sender.title as String? {
            changeTextField(number: digit)
        }
    }
    
    @IBAction func submitButtonPressed(_ sender: Any) {
        if currentColumn == 4 {
            var guessedNumbers = [Int]()
            var correctOnPlace = 0
            var correctButMisplaced = 0
            
            for i in 0..<5 {
                if let number = Int(textFields[currentRow][i].stringValue) {
                    guessedNumbers.append(number)
                    if number == result[i] {
                        correctOnPlace += 1
                        textFields[currentRow][i].backgroundColor = NSColor.green
                    } else if result.contains(number) {
                        correctButMisplaced += 1
                        textFields[currentRow][i].backgroundColor = NSColor.yellow
                    }
                }
            }
            
            currentRow += 1
            currentColumn = 0
        }
    }

    
    @IBAction func newGameButtonPressed(_ sender: Any) {
        generateResult()
        resetBoard()
    }
    
    func setUpTextFields() {
        for i in 0..<6 {
            textFields.append([])
            for j in 0..<5 {
                let textField = textFieldsGrid.cell(atColumnIndex: j, rowIndex: i).contentView as! NSTextField
                textFields[i].append(textField)
            }
        }
    }
    
    func setUpDigitButtons() {
        for i in 0..<10 {
            let digitButton = numbersGrid.cell(atColumnIndex: i % 3, rowIndex: i / 3).contentView as! NSButton
            digitButton.title = "\(i)"
            digitButtons.append(digitButton)
        }
    }
    
    func changeTextField(number: String) {
        if currentColumn < 5, currentRow < 6 {
            textFields[currentRow][currentColumn].stringValue = number
            currentColumn += 1
            if currentColumn == 4 {
                submitButton.isEnabled = true
            }
        }
    }

    func generateResult() {
        while result.count < 5 {
            let number = Int.random(in: 0...9)
            result.append(number)
        }
        return result
    }
    
    func resetBoard() {
        for i in 0..<6 {
            for j in 0..<5 {
                textFields[i][j].stringValue = ""
                textFields[i][j].backgroundColor = NSColor.clear
            }
        }
        currentRow = 0
        currentColumn = 0
        submitButton.isEnabled = false
        newGameButton.isHidden = true
    }
}
