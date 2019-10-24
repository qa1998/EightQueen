//
//  ViewController.swift
//  BanCo
//
//  Created by QuangAnh on 10/21/19.
//  Copyright © 2019 QuangAnh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var screenWidth: CGFloat = 0 // chieu rong man hinh
    var screenHeight:CGFloat = 0 // chieu cao man hinh
    var squareWidht:CGFloat = 0 // chieu rong mot o ban co
    var squareHeight:CGFloat = 0 // chieu cao mot o ban co
    
    var margin:CGFloat = 40
    var images:[UIImageView] = [] // mang image chua taph hop cac anh
    var arrays = Array(repeating: 0, count: 9) // mang array de lu vi tri thoa man cac truong hop
    var queen = [[Queen]]()
    var index = 0
    var total = 0
    var n:Int = 8
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        // Do any additional setup after loading the view, typically from a nib.
        // ve o ban co
        drawBoard()
        putQueen(row: 1)
        total = queen.count
        print(total)
//        placeQueen(isHas: true, row: 3, col: 4)
        gestureWidthChessBoard()
//        for i in queen{
//            for j in i {
////                print("Queen:Row \(j.row), col: \(j.col)")
//                print("(\(j.row),\(j.col))", terminator:" ")
//            }
//        }
    }
    func drawSque(isWhite:Bool,width:CGFloat,col:Int, row:Int)  {
        func computPositionofSquare(row:Int, col:Int, squareWidth:CGFloat)->CGRect{
            return CGRect(x: margin + CGFloat(col) * squareWidth, y: margin+CGFloat(row)*squareWidth , width: squareWidth, height: squareWidth)
            
        }
        let square = UIView(frame: computPositionofSquare(row: row, col: col, squareWidth: width))
        square.backgroundColor = isWhite ? UIColor.white : UIColor.black
        view.addSubview(square)
    }
    func drawBoard(){
         screenWidth = self.view.bounds.width
         screenHeight = self.view.bounds.height
        squareWidht = (screenWidth - margin*2) / 8
        print(screenWidth)
        print(squareWidht)
        for row in 0..<8{
            for col in 0..<8{
                let isWhiteSquare = (row + col) % 2 == 1 ? true: false
                drawSque(isWhite: isWhiteSquare, width: squareWidht, col: col, row: row)
            }
            
        }
    }
    func isSafe(row:Int, col:Int) ->Bool{
        for i in 1..<row{
            if arrays[i] == col || abs(i - row ) == abs(arrays[i] - col){
                return false
            }
        }
        return true
    }
    func saveResult(){
        var object = [Queen]()
        var row = 1
        for col in 1...n {
            print("object:\(object)")
            object.append(Queen(row: row, col: arrays[col]))
            row += 1
        }
        queen.append(object)
        print(queen)
    }
    func putQueen(row:Int){
        // di lan luot tu cac cot tu 1 -> n
        for col in 1...n{
            if isSafe(row: row, col: col){
                arrays[row] = col
                if row == n {
                    saveResult()
                }
                putQueen(row: row+1)
            }
            
        }
    }
    func placeQueen(isHas:Bool, row:Int, col:Int){
        let queen = UIImageView(image: UIImage(named: "ricardo"))
        queen.backgroundColor = UIColor.purple
        if isHas{
            print("true")
            queen.frame = CGRect(x: margin+CGFloat(col)*squareWidht, y: margin + CGFloat(row) * squareWidht, width: squareWidht, height: squareWidht)
            queen.contentMode = .scaleToFill
            images.append(queen)
            self.view.addSubview(queen)
            
        }
    }
    func gestureWidthChessBoard(){
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = .right
        
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        swipeRight.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    
        
        
    }
    @objc func swiped(gesture:UISwipeGestureRecognizer){
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction{
            case UISwipeGestureRecognizer.Direction.right:
                swipeRight()
            case UISwipeGestureRecognizer.Direction.left:
                swipeLeft()
            default:
                break
            }
        }
        
    }
    func swipeRight() {
        print("swipe right")
        // xoá các con hậu đang nằm trên bàn cờ nếu có
        for image in images{
            image.removeFromSuperview()
        }
        
        index = index - 1
        if index < 0 {
            index = 0
        }
        
        if index > 0 && index < total{
            for i in queen[index]{
                placeQueen(isHas: true, row: i.row-1, col: i.col-1)
            }
        }
    }
    
    func swipeLeft() {
        print("swipe left")
        for image in images{
            image.removeFromSuperview()
        }
        index = index + 1
        if index > total {
            index = total
        }
        if index > 0 && index < total{
            for i in queen[index]{
                placeQueen(isHas: true, row: i.row-1, col: i.col-1)
            }
        }
    }
    

}

