//
//  ViewController.swift
//  Zoolander
//
//  Created by Guo Tian on 1/19/21.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var animalLabel: UILabel!
    
    var zoo = [Animal]()
    
    var player = AVAudioPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dogSound = Bundle.main.path(forResource: "dogsound", ofType: "mp3")!
        let catSound = Bundle.main.path(forResource: "catsound", ofType: "mp3")!
        let squirrelSound = Bundle.main.path(forResource: "squirrelsound", ofType: "mp3")!
        
        let dog = Animal(name:"Puppy", species: "Dog", age: 5, image: UIImage(named:"dog.jpg")!,soundPath: dogSound)
        let cat = Animal(name:"Cookie", species: "Cat", age: 1, image: UIImage(named:"cat.jpg")!,soundPath: catSound)
        let squirrel = Animal(name:"Jack", species: "Squirrel", age: 2, image: UIImage(named:"squirrel.jpg")!,soundPath: squirrelSound)
        zoo = [dog,cat,squirrel]
        zoo.shuffle()
        print(zoo)
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1242, height: 600)
        
        for i in 0...2{

            let imageView = UIImageView()
            imageView.image = zoo[i].image
            let xPos = CGFloat(i) * 414
            imageView.frame = CGRect(x: xPos, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height)
            
            let button = UIButton(frame: CGRect(x: xPos + 127, y: 400, width: 130, height: 50))
            button.addTarget(self,
                             action: #selector(tapButton),
                             for: UIControl.Event.touchUpInside)
            button.tag = i
            button.backgroundColor = UIColor.systemGray2
            button.layer.cornerRadius = 22
            button.layer.borderWidth = 2
            button.layer.borderColor = UIColor.white.cgColor
            button.setTitle(zoo[i].name, for: .normal)
            button.setTitleColor(UIColor.white, for: .normal)
            button.setTitleColor(UIColor.systemPink, for: .highlighted)
            // button settings refer to module 2 example code
            
            scrollView.addSubview(imageView)
            scrollView.addSubview(button)
        }
        animalLabel.text = zoo[0].species
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("\(scrollView.contentOffset)")
        let imageNumber = round(scrollView.contentOffset.x / 414)
            switch imageNumber {
            case 0:
                animalLabel.text = zoo[0].species
            case 1:
                animalLabel.text = zoo[1].species
            case 2:
                animalLabel.text = zoo[2].species
            default:
                break
            }
        var xPos = scrollView.contentOffset.x
        if xPos >= 414{
            xPos = abs(xPos - imageNumber * 414)
        }
        animalLabel.alpha = 1 - xPos/414
                
    }
    
    @objc func tapButton(_ button: UIButton!) {
        do{
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: zoo[button.tag].soundPath))

            let alertController = UIAlertController(title: zoo[button.tag].species, message: "\(zoo[button.tag].name) is a \(zoo[button.tag].age)-year-old \(zoo[button.tag].species).", preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
                print(action)
            }
            alertController.addAction(cancelAction)

            let playAction = UIAlertAction(title: "Play sound", style: .default) { (action) in
                self.player.play()
                print(self.zoo[button.tag].description)
            }
            alertController.addAction(playAction)
            alertController.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor.white
            // alert background color change refer to
            // https://stackoverflow.com/questions/37293656/change-uialertcontroller-background-color
            self.present(alertController, animated: true, completion: nil)
            // alert settings refer to developer.apple.com
            // and https://nshipster.com/uialertcontroller/
        }
        catch{
            print(error)
        }
    }
}

