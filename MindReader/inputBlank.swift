//
//  inputBlankUtils.swift
//  MindReader
//
//  Created by mac on 2023/4/28.
//

import UIKit
class inputBlank{
    public var inputStack: UIStackView?
    public var inputContent: String
    public var size: CGFloat
    public var maxLenth = 180
    let caret = UIImageView()
    init(inputStack: UIStackView?, inputContent: String?, size: CGFloat?, maxLen: Int?) {
         
        if let inputStack = inputStack{
            self.inputStack = inputStack
            
            for view in self.inputStack!.arrangedSubviews {
                self.inputStack!.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
        else {
            self.inputStack = nil
        }
        if let inputContent = inputContent {
            self.inputContent = inputContent
            
        } else {
            self.inputContent = ""
        }
        
        if let size = size {
            self.size = size
            if let inputStack = inputStack{
                inputStack.spacing=4*size
            }
        } else {
            self.size = 1
        }
        
        
        if let maxLen = maxLen{
            self.maxLenth = maxLen
        }
        clear()
        print(maxLenth)
        

        for char in self.inputContent{
            add(toAdd:char)
        }
        caret.translatesAutoresizingMaskIntoConstraints = false
        caret.image = UIImage(named: "caret")
        caret.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            caret.widthAnchor.constraint(equalToConstant: 3*self.size),
            caret.heightAnchor.constraint(equalToConstant: 30*self.size),
        ])
        if let inputStack = self.inputStack{
            let parentView = inputStack.superview
            parentView?.addSubview(caret)
            NSLayoutConstraint.activate([ caret.leadingAnchor.constraint(equalTo: inputStack.trailingAnchor),
                                          caret.centerYAnchor.constraint(equalTo: inputStack.centerYAnchor),])
        }
        caret.isHidden = true
        _ = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.caret.isHidden = !self.caret.isHidden
        }


     }
    
    init(inputStack: UIStackView?, inputContent: String?, size: CGFloat?) {
         
         if let inputStack = inputStack{
             self.inputStack = inputStack
             
             for view in self.inputStack!.arrangedSubviews {
                 self.inputStack!.removeArrangedSubview(view)
                 view.removeFromSuperview()
             }
         }
         else {
             self.inputStack = nil
         }
         if let inputContent = inputContent {
             self.inputContent = inputContent
             
         } else {
             self.inputContent = ""
         }
         
         if let size = size {
             self.size = size
             
             if let inputStack = inputStack{
                 inputStack.spacing=4*size
             }
         } else {
             self.size = 1
         }


         clear()
         for char in self.inputContent{
             add(toAdd:char)
         }
        caret.image = UIImage(named: "caret")
        caret.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            caret.widthAnchor.constraint(equalToConstant: 3*self.size),

            caret.heightAnchor.constraint(equalToConstant: 30*self.size),
        ])
        if let inputStack = self.inputStack{
            let parentView = inputStack.superview
            parentView?.addSubview(caret)
            NSLayoutConstraint.activate([ caret.leadingAnchor.constraint(equalTo: inputStack.trailingAnchor),
                                          caret.centerYAnchor.constraint(equalTo: inputStack.centerYAnchor),])
        }
        caret.isHidden = true
        let timer = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            self.caret.isHidden = !self.caret.isHidden
        }

      }
    
    init(inputStack: UIStackView?) {
         
         if let inputStack = inputStack{
             self.inputStack = inputStack
             
             for view in self.inputStack!.arrangedSubviews {
                 self.inputStack!.removeArrangedSubview(view)
                 view.removeFromSuperview()
             }
         }
         else {
             self.inputStack = nil
         }
             self.inputContent = ""

             self.size = 1

         clear()
        

        
         for char in self.inputContent{
             add(toAdd:char)
         }
        caret.image = UIImage(named: "caret")
        caret.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            caret.widthAnchor.constraint(equalToConstant: 3*self.size),
            caret.heightAnchor.constraint(equalToConstant: 30*self.size),
        ])
        if let inputStack = self.inputStack{
            let parentView = inputStack.superview
            parentView?.addSubview(caret)
            NSLayoutConstraint.activate([ caret.leadingAnchor.constraint(equalTo: inputStack.trailingAnchor),
                                          caret.centerYAnchor.constraint(equalTo: inputStack.centerYAnchor),])
        }
        caret.isHidden = true
        _ = Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            self.caret.isHidden = !self.caret.isHidden
        }

      }
    
    public func add(toAdd: String){
            let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
        inputContent += toAdd
        switch toAdd{
        case ".":
            newImageView.image = UIImage(named:"dot")
            newImageView.widthAnchor.constraint(equalToConstant: 10*size).isActive = true
                newImageView.heightAnchor.constraint(equalToConstant: 10*size).isActive = true
            inputStack!.addArrangedSubview(newImageView)

            break;
        case "-":
            newImageView.image = UIImage(named:"slash")
                newImageView.widthAnchor.constraint(equalToConstant: 30*size).isActive = true
                newImageView.heightAnchor.constraint(equalToConstant: 10*size).isActive = true
            inputStack!.addArrangedSubview(newImageView)

            break;
        case "+":
            newImageView.image = UIImage(named:"cross")
                newImageView.widthAnchor.constraint(equalToConstant: 30*size).isActive = true
                newImageView.heightAnchor.constraint(equalToConstant: 30*size).isActive = true
            inputStack!.addArrangedSubview(newImageView)
            break;
        case " ":
                newImageView.widthAnchor.constraint(equalToConstant: 15*size).isActive = true
                newImageView.heightAnchor.constraint(equalToConstant: 15*size).isActive = true
            inputStack!.addArrangedSubview(newImageView)

            break;
        default:
            break;
        }
        
        if calcLength()>maxLenth{
            while(calcLength()>maxLenth/3){
                inputContent = String(inputContent.dropFirst(1)).trimmingCharacters(in: .whitespaces)
            }
        }
    }
    public func add(toAdd: Character){
        inputContent+=String(toAdd)
        let newImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 15, height: 15))
    switch toAdd{
    case ".":
        newImageView.image = UIImage(named:"dot")
        newImageView.widthAnchor.constraint(equalToConstant: 10*size).isActive = true
            newImageView.heightAnchor.constraint(equalToConstant: 10*size).isActive = true
        inputStack!.addArrangedSubview(newImageView)

        break;
    case "-":
        newImageView.image = UIImage(named:"slash")
            newImageView.widthAnchor.constraint(equalToConstant: 30*size).isActive = true
            newImageView.heightAnchor.constraint(equalToConstant: 10*size).isActive = true
        inputStack!.addArrangedSubview(newImageView)

        break;
    case "+":
        newImageView.image = UIImage(named:"cross")
            newImageView.widthAnchor.constraint(equalToConstant: 30*size).isActive = true
            newImageView.heightAnchor.constraint(equalToConstant: 30*size).isActive = true
        inputStack!.addArrangedSubview(newImageView)
        break;
    case " ":
            newImageView.widthAnchor.constraint(equalToConstant: 15*size).isActive = true
            newImageView.heightAnchor.constraint(equalToConstant: 15*size).isActive = true
        inputStack!.addArrangedSubview(newImageView)

        break;
    default:
        break;
    }
        
        if calcLength()>maxLenth{
            while(calcLength()>maxLenth/3){
                inputContent = String(inputContent.dropFirst(1)).trimmingCharacters(in: .whitespaces)
                
            }
        }
}
    
    public func calcLength()-> Int{
        var len = 0
        for char in inputContent{
            switch char{
            case ".":
                len = len+Int(14*size)
                break
            case "-":
                len = len+Int(34*size)
                break
            case "+":
                len = len+Int(34*size)
                break
            case " ":
                len = len+Int(19*size)
            default:
                break
            }
        }
        return len
    }
    
    
    public func renewContent(newContent:String){
        inputContent = newContent
        genNewStack()
    }
    
    public func clear(){
        if let inputStack = inputStack{
            
            for view in inputStack.arrangedSubviews {
                inputStack.removeArrangedSubview(view)
                view.removeFromSuperview()
            }
        }
    }
    public func genNewStack(){
        clear()
        if inputStack != nil{
            for char in inputContent{
                add(toAdd: char)
            }
        }
    }
    public func genNewStack(newContent: String){
        clear()
        inputContent = newContent
        if calcLength()>maxLenth{
            while(calcLength()>maxLenth/3){
                inputContent = String(inputContent.dropFirst(1)).trimmingCharacters(in: .whitespaces)
            }
        }
        if inputStack != nil{
            for char in inputContent{
                add(toAdd: char)
            }
        }
    }
}
