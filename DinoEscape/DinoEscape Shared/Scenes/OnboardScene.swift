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
        
        background.fillColor = SKColor(red: 235/255, green: 231/255, blue: 198/255, alpha: 1)
        print(background.position)
        self.addChild(background)
        
#if os(iOS) || os(tvOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            background.addChild(createImage(imageNamed: "meteorOnboard", position: CGPoint(x: background.frame.size.width/3 * -0.8, y: background.frame.size.height/8 * 1)))
            background.addChild(createImage(imageNamed: "badFood", position: CGPoint(x: background.frame.size.width/3 * -0.8, y: background.frame.size.height/8 * -1)))
            background.addChild(createImage(imageNamed: "goodFood", position: CGPoint(x: background.frame.size.width/3 * -0.8, y: background.frame.size.height/8 * -2)))
            background.addChild(createImage(imageNamed: "foodBar", position: CGPoint(x: background.frame.size.width/3 * -0.8, y: background.frame.size.height/8 * -3)))
            
            background.addChild(createLabel(text: "Tutorial".localized(),
                                            fontSize: size.height/13,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: 0, y: background.frame.size.height/3),
                                            alignmentH: SKLabelHorizontalAlignmentMode.center
                                           ))
            
            background.addChild(createLabel(text: self.text(type: 0).localized(),
                                            fontSize: size.height/40,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: background.frame.size.width/3 * -0.1, y: background.frame.size.height/8),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
            
            background.addChild(createLabel(text: self.text(type: 1).localized(),
                                            fontSize: size.height/40,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: background.frame.size.width/3 * -0.1, y: background.frame.size.height/8 * -1),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
            background.addChild(createLabel(text: self.text(type: 2).localized(),
                                            fontSize: size.height/40,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: background.frame.size.width/3 * -0.1, y: background.frame.size.height/8 * -2),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
            background.addChild(createLabel(text: self.text(type: 3).localized(),
                                            fontSize: size.height/40,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: background.frame.size.width/3 * -0.1, y: background.frame.size.height/8 * -3),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
            
            btnOk = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/1.5 * -1))
        case .pad:
            print("Config ipad")
        case .tv:
            print("Config tv")
        default:
            print("qualquer")
            
        }
        
#elseif os(macOS)
        background.addChild(createLabel(text: "Pause".localized(),
                                        fontSize: size.height/10,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: 0, y: background.frame.size.height/3),
                                        alignmentH: SKLabelHorizontalAlignmentMode.center
                                       ))
        background.addChild(createLabel(text: "Music".localized(),
                                        fontSize: size.height/18,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: background.frame.size.width/4 * -1, y: background.frame.size.height/8),
                                        alignmentH: SKLabelHorizontalAlignmentMode.left
                                       ))
        
        
        btnBack = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/5.5 * -1))
        btnHome = createHomeButton(position: CGPoint(x: 0, y: background.frame.size.height/3 * -1))
        
#endif
        
        #if os(tvOS)
        addTapGestureRecognizer()
        #endif
        
        background.addChild(btnOk)
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
    
    func createImage(imageNamed: String, position: CGPoint) -> SKSpriteNode {
        let image = SKSpriteNode(imageNamed: imageNamed)
        image.position = position
        return image
    }
    
    func createBackButton(position: CGPoint) -> SKButton{
        
        let texture = SKTexture(imageNamed: "resumeButton")
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
                      "Avoid bad foods.",
                      "Collect good foods",
                      "Earn power-ups!"
        ]
        return texts[type]
    }
}
