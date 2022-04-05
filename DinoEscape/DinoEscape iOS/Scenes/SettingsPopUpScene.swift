//
//  SettingsPopUpScene.swift
//  DinoEscape iOS
//
//  Created by Carolina Ortega on 31/03/22.
//

import Foundation

import SpriteKit

class SettingsPopUpScene: SKSpriteNode {
    var btnHome = SKButton()
    var btnBack = SKButton()

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
        
        background.addChild(createLabel(text: "Pause".localized(),
                                        fontSize: size.height/13,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: 0, y: background.frame.size.height/3),
                                        alignmentH: SKLabelHorizontalAlignmentMode.center
                                       ))
        
        background.addChild(createLabel(text: "Music".localized(),
                                        fontSize: size.height/20,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: background.frame.size.width/3 * -1, y: background.frame.size.height/8),
                                        alignmentH: SKLabelHorizontalAlignmentMode.left
                                       ))
        
        background.addChild(createLabel(text: "Vibration".localized(),
                                        fontSize: size.height/20,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: background.frame.size.width/3 * -1, y: background.frame.size.height/8 * -0.2),
                                        alignmentH: SKLabelHorizontalAlignmentMode.left
                                       ))
        
        background.addChild(createSwitch(pos: CGPoint(x: background.frame.size.width/4, y: background.frame.size.height/8), type: .music))
        
        background.addChild(createSwitch(pos: CGPoint(x: background.frame.size.width/4, y: background.frame.size.height/8 * -0.2), type: .vibration))
        
        HapticService.shared.addVibration(haptic: "Haptic")

        btnBack = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/4.0 * -1))
        btnHome = createHomeButton(position: CGPoint(x: 0, y: background.frame.size.height/2.6 * -1))
        background.addChild(btnBack)
        background.addChild(btnHome)
    }
    
    func changeSwitchMusic() -> String {
        var imageName : String
        if UserDefaults.standard.bool(forKey: "music") {
            imageName = "switchON"
        } else {
            imageName = "switchOFF"
        }
        return imageName
    }
    
    func changeSwitchVibration() -> String {
        var imageName : String
        if UserDefaults.standard.bool(forKey: "vibration") == true {
            imageName = "switchON"
        } else {
            imageName = "switchOFF"
        }
        return imageName
    }
    
    
    func createSwitch(pos: CGPoint, type: SwitchType) -> SKButton {
        let texture: SKTexture
        switch type {
        case .music:
            texture = SKTexture(imageNamed: "\(self.changeSwitchMusic())")
        case .vibration:
            texture = SKTexture(imageNamed: "\(changeSwitchVibration())")
        }
        
        texture.filteringMode = .nearest
        
        let width: CGFloat = size.width / 4.0
        let height = width * texture.size().height / texture.size().width

        let switchButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
        switchButton.position = pos
        
        switchButton.selectedHandler = {
            switch type {
            case .music:
                MusicService.shared.updateUserDefaults()
                switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchMusic())")
                MusicService.shared.playLoungeMusic()
            case .vibration:
                HapticService.shared.updateUserDefaults()
                switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchVibration())")
                HapticService.shared.addVibration(haptic: "Haptic")
            }
        }
        return switchButton
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
    
    func createBackButton(position: CGPoint) -> SKButton{
        let texture = SKTexture(imageNamed: "resumeButton")
        texture.filteringMode = .nearest
        
        let width: CGFloat = size.height / 2.8
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

    func createHomeButton(position: CGPoint) -> SKButton{
        
        let texture = SKTexture(imageNamed: "homeBackButton")
        texture.filteringMode = .nearest
        
        let width: CGFloat = size.height / 3.2
        let height = width * texture.size().height / texture.size().width
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: width, height: height))
        button.position = position
        button.selectedHandler = {
            GameController.shared.restartGame()
            self.scene?.view?.presentScene(HomeScene.newGameScene())
        }
        return button
    }
}
