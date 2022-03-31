//
//  OnboardScene.swift
//  DinoEscape
//
//  Created by Beatriz Duque on 30/03/22.
//

import Foundation
import SpriteKit

class OnboardScene: SKSpriteNode {
    var btnOk = SKButton()
    override init(texture: SKTexture?, color: SKColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
        self.isUserInteractionEnabled = true
        self.setUpScene()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.isUserInteractionEnabled = true
    }
    
    func setUpScene() {
        self.isUserInteractionEnabled = true
        
        removeAllChildren()
        removeAllActions()
        
        let background = SKShapeNode(rect: CGRect(x: self.size.width/2 * -1,
                                                  y: self.size.height/2 * -1,
                                                  width: self.size.width,
                                                  height: self.size.height))
        
        background.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        print(background.position)
        self.addChild(background)
        
#if os(iOS) || os(tvOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            let sizes: [CGFloat] = [1,-0.1,-1.2,-2.2]
            let imageSize = CGSize(width: background.frame.size.width * 0.3, height: background.frame.size.height * 0.2)
            addImages(background: background,sizes: sizes,imageSize: imageSize, multipliery: 8, multiplierx: 3)
            btnOk = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/8 * -3.3))
        case .pad:
            print("Config ipad")
        case .tv:
            print("Config tv")
        default:
            print("qualquer")
            
        }
        
#elseif os(macOS)
        let sizes: [CGFloat] = [0.6,0.2,-0.2,-0.6]
        let imageSize = CGSize(width: background.frame.size.width * 0.1, height: background.frame.size.height * 0.2)
        addImages(background: background,sizes: sizes,imageSize: imageSize, multipliery: 3, multiplierx: 8)
        btnOk = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/3 * -1))
#endif
        
        #if os(tvOS)
        addTapGestureRecognizer()
        #endif
        
        background.addChild(btnOk)
    }
    func addImages(background: SKShapeNode,sizes: [CGFloat],imageSize: CGSize, multipliery: CGFloat, multiplierx: CGFloat){
        let imageNames = ["meteorOnboard", "badFood", "goodFood", "foodBar"]
        let labelColor = SKColor(red: 0.92, green: 0.91, blue: 0.78, alpha: 1)
        for i in 0..<imageNames.count{
            background.addChild(createImage(imageNamed: imageNames[i], position: CGPoint(x: background.frame.size.width/multiplierx * -0.8, y: background.frame.size.height/multipliery * sizes[i]), size: imageSize))
            background.addChild(createLabel(text: self.text(type: i).localized(),
                                            fontSize: size.height/40,
                                            fontColor: labelColor,
                                            position: CGPoint(x: background.frame.size.width/3 * -0.1, y: background.frame.size.height/multipliery * sizes[i]),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
        }
        
        background.addChild(createLabel(text: "Tutorial".localized(),
                                        fontSize: size.height/13,
                                        fontColor: labelColor,
                                        position: CGPoint(x: 0, y: background.frame.size.height/3),
                                        alignmentH: SKLabelHorizontalAlignmentMode.center
                                       ))
    }
    
    func createLabel(text: String, fontSize: CGFloat, fontColor: SKColor, position: CGPoint, alignmentH: SKLabelHorizontalAlignmentMode) -> SKLabelNode {
        let label: SKLabelNode = SKLabelNode(text: text)
        label.fontName = "Aldrich-Regular"
        label.fontSize = fontSize
        label.numberOfLines = 2
        label.horizontalAlignmentMode = alignmentH
        label.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        label.fontColor = fontColor
        label.position = position
        return label
    }
    
    func createImage(imageNamed: String, position: CGPoint, size: CGSize) -> SKSpriteNode {
        let image = SKSpriteNode(imageNamed: imageNamed)
        image.position = position
        image.size = size
        return image
    }
    
    func createBackButton(position: CGPoint) -> SKButton{
        
        let texture = SKTexture(imageNamed: "okButton")
        texture.filteringMode = .nearest
        
#if os(iOS)
        let w: CGFloat = size.height / 3.5
        let h = w * texture.size().height / texture.size().width
        
#elseif os(macOS) || os(tvOS)
        let w: CGFloat = size.height / 2.25
        let h = w * texture.size().height / texture.size().width
        
#endif
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = position
        button.selectedHandler = {
            self.removeFromParent()
            GameController.shared.gameData.gameStatus = .playing
            GameController.shared.pauseActionItems()
        }
        return button
        
        
    }
    
    func text(type: Int) -> String {
        let texts = [ "Escape the meteors!",
                      "Avoid bad foods",
                      "Collect good foods",
                      "Earn power-ups!"
        ]
        return texts[type]
    }
}
