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
        
        let background = SKShapeNode(rect: CGRect(x: self.size.width / 2 * -1,
                                                  y: self.size.height / 2 * -1,
                                                  width: self.size.width,
                                                  height: self.size.height))
        
        background.fillColor = SKColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        print(background.position)
        self.addChild(background)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            let sizes: [CGFloat] = [1.5, 0.5, -0.5, -1.5]
            let imageSize = CGSize(width: background.frame.size.width * 0.3, height: background.frame.size.height * 0.2)
            addImages(background: background, sizes: sizes, imageSize: imageSize, multipliery: 8, multiplierx: 3, fontSize: 40)
            btnOk = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height / 8 * -2.7))
        case .pad:
            let sizes: [CGFloat] = [1.5, 0.5, -0.5, -1.5]
            let imageSize = CGSize(width: background.frame.size.width * 0.35, height: background.frame.size.height * 0.25)
            addImages(background: background, sizes: sizes, imageSize: imageSize, multipliery: 8, multiplierx: 3.5, fontSize: 30)
            btnOk = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height / 8 * -2.7))
        default:
            print("qualquer")
            
        }
        background.addChild(btnOk)
    }
    func addImages(background: SKShapeNode, sizes: [CGFloat], imageSize: CGSize, multipliery: CGFloat, multiplierx: CGFloat, fontSize: CGFloat) {
        let imageNames = ["meteorOnboard", "badFood", "goodFood", "foodBar"]
        let labelColor = SKColor(red: 0.92, green: 0.91, blue: 0.78, alpha: 1)
        for names in 0..<imageNames.count {
            background.addChild(createImage(imageNamed: imageNames[names], position: CGPoint(x: background.frame.size.width / multiplierx * -0.8, y: background.frame.size.height / multipliery * sizes[names]), size: imageSize))
            background.addChild(createLabel(text: self.text(type: names).localized(),
                                            fontSize: size.height / fontSize,
                                            fontColor: labelColor,
                                            position: CGPoint(x: background.frame.size.width / 3 * -0.1,
                                                              y: background.frame.size.height / multipliery * sizes[names]),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
        }
        
        background.addChild(createLabel(text: "Tutorial".localized(),
                                        fontSize: size.height / 13,
                                        fontColor: labelColor,
                                        position: CGPoint(x: 0, y: background.frame.size.height / 3),
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
    
    func createBackButton(position: CGPoint) -> SKButton {
        let texture = SKTexture(imageNamed: "okButton")
        texture.filteringMode = .nearest
        
        let width: CGFloat = size.height / 3.5
        let height = width * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
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
