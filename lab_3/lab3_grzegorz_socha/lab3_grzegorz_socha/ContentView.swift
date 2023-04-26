//
//  ContentView.swift
//  lab3_grzegorz_socha
//
//  Created by Grzegorz Socha on 25/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var currentRow = 0
    @State private var currentColumn = 0
    @State private var colors = Array(repeating: Array(repeating: Color.gray, count:5), count:5)
    @State private var values = Array(repeating: Array(repeating: "", count:5), count:5)
    @State private var guess = [4, 2, 6, 8, 3]
    
    
    var body: some View {
        VStack
        {
            ForEach(0..<5) { row in
                HStack {
                    ForEach(0..<5) { col in
                        Text(values[row][col])
                            .padding(.all)
                            .frame(width: 42.0, height: 50.0)
                            .background(colors[row][col])
                    }

                }
            }
            
            HStack {
                Button("^") {
                    currentColumn = 0
                }
                .padding(.all)
                .background()
                Button("^") {
                    currentColumn = 1
                }
                .padding(.all)
                Button("^") {
                    currentColumn = 2
                }
                .padding(.all)
                Button("^") {
                    currentColumn = 3
                }
                .padding(.all)
                Button("^") {
                    currentColumn = 4
                }
                .padding(.all)
            }
            HStack {
                Button("1") {
                    values[currentRow][currentColumn] = "1"
                }
                .padding(.all)
                Button("2") {
                    values[currentRow][currentColumn] = "2"
                }
                .padding(.all)
                Button("3") {
                    values[currentRow][currentColumn] = "3"
                }
                .padding(.all)
                Button("4") {
                    values[currentRow][currentColumn] = "4"
                }
                .padding(.all)
                Button("5") {
                    values[currentRow][currentColumn] = "5"
                }
                .padding(.all)
            }
            HStack {
                Button("6") {
                    values[currentRow][currentColumn] = "6"
                }
                .padding(.all)
                Button("7") {
                    values[currentRow][currentColumn] = "7"
                }
                .padding(.all)
                Button("8") {
                    values[currentRow][currentColumn] = "8"
                }
                .padding(.all)
                Button("9") {
                    values[currentRow][currentColumn] = "9"
                }
                .padding(.all)
                Button("0") {
                    values[currentRow][currentColumn] = "0"
                }
                .padding(.all)
            }
            HStack {
                
                Button("Submit") {
                    if values[currentRow][0] != "" && values[currentRow][1] != "" && values[currentRow][2] != "" && values[currentRow][3] != "" && values[currentRow][4] != "" {
                        for i in 0..<5 {
                            if Int(values[currentRow][i]) == guess[i] {
                                colors[currentRow][i] = Color.green
                            }
                            else {
                                for j in 0..<5 {
                                    if guess[j] == Int(values[currentRow][i]) {
                                        colors[currentRow][i] = Color.yellow
                                    }
                                    
                                }
                            }
                        }
                        currentRow += 1
                    }
                }
                .padding(.all)
                
                Button("New Game") {
                    for i in 0..<5 {
                        for j in 0..<5 {
                            values[i][j] = ""
                            colors[i][j] = Color.gray
                        }
                        guess[i] = Int.random(in: 0..<10)
                    }
                    currentRow = 0
                    currentColumn = 0
                    
                }
                .padding(.all)
                
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
