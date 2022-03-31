//
//  SettingsPopUp.swift
//  DinoEscape
//
//  Created by Raphael Alkamim on 21/03/22.
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
        
#if os(iOS) || os(tvOS)
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
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
            
            btnBack = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/4.0 * -1))
            btnHome = createHomeButton(position: CGPoint(x: 0, y: background.frame.size.height/2.6 * -1))
        case .pad:
            print("Config ipad")
        case .tv:
            background.addChild(createLabel(text: "Pause".localized(),
                                            fontSize: size.height/13,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: 0, y: background.frame.size.height/3),
                                            alignmentH: SKLabelHorizontalAlignmentMode.center
                                           ))
            
            background.addChild(createLabel(text: "Music".localized(),
                                            fontSize: size.height/20,
                                            fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                            position: CGPoint(x: background.frame.size.width/3 * -0.5, y: background.frame.size.height/8),
                                            alignmentH: SKLabelHorizontalAlignmentMode.left
                                           ))
            
            background.addChild(createSwitch(pos: CGPoint(x: background.frame.size.width/8, y: background.frame.size.height/8), type: .music))
            
            btnBack = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/2.5 * -0.35))
            btnHome = createHomeButton(position: CGPoint(x: 0, y: background.frame.size.height/1.5 * -0.5))
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
        HapticService.shared.updateUserDefaults()
#if os(iOS)
        switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchVibration())")
#endif
        HapticService.shared.addVibration(haptic: "Haptic")
        background.addChild(createLabel(text: "Music".localized(),
                                        fontSize: size.height/18,
                                        fontColor: SKColor(red: 57/255, green: 100/255, blue: 113/255, alpha: 1),
                                        position: CGPoint(x: background.frame.size.width/4 * -1, y: background.frame.size.height/8),
                                        alignmentH: SKLabelHorizontalAlignmentMode.left
                                       ))
        
        background.addChild(createSwitch(pos: CGPoint(x: background.frame.size.width/4, y: background.frame.size.height/8), type: .music))
        
        btnBack = createBackButton(position: CGPoint(x: 0, y: background.frame.size.height/5.5 * -1))
        btnHome = createHomeButton(position: CGPoint(x: 0, y: background.frame.size.height/3 * -1))
        
#endif
        
#if os(tvOS)
        addTapGestureRecognizer()
#endif
        
        background.addChild(btnBack)
        background.addChild(btnHome)
    }
    
    //    func changeSwitchImageState(switchButton: SKButton, state: inout Bool){
    //
    //        if state {
    //            switchButton.texture = SKTexture(imageNamed: "switchOFF")
    //        } else {
    //            switchButton.texture = SKTexture(imageNamed: "switchON")
    //        }
    //        state.toggle()
    //    }
    
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
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.width / 4.0
        let h = w * texture.size().height / texture.size().width
        
#elseif os(macOS)
        let w: CGFloat = size.width / 8.0
        let h = w * texture.size().height / texture.size().width
        
#endif
        
        let switchButton: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        switchButton.position = pos
        
        switchButton.selectedHandler = {
            switch type {
            case .music:
                _ = MusicService.shared.updateUserDefaults()
                switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchMusic())")
                MusicService.shared.playLoungeMusic()
                
            case .vibration:
                _ = HapticService.shared.updateUserDefaults()
                #if os(iOS)
                switchButton.texture =  SKTexture(imageNamed: "\(self.changeSwitchVibration())")
#endif
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
        
#if os(iOS) || os(tvOS)
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
    func createHomeButton(position: CGPoint) -> SKButton{
        
        let texture = SKTexture(imageNamed: "homeBackButton")
        texture.filteringMode = .nearest
        
#if os(iOS) || os(tvOS)
        let w: CGFloat = size.height / 1.5
        let h = w * texture.size().height / texture.size().width
        
#elseif os(macOS) || os(tvOS)
        let w: CGFloat = size.height / 3
        let h = w * texture.size().height / texture.size().width
        
#endif
        
        
        let button: SKButton = SKButton(texture: texture, color: .clear, size: CGSize(width: w, height: h))
        button.position = position
        button.selectedHandler = {
            GameController.shared.restartGame()
            self.scene?.view?.presentScene(HomeScene.newGameScene())
        }
        return button
        
        
    }
#if os( tvOS )
    func addTapGestureRecognizer() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped(sender:)))
        self.scene?.view?.addGestureRecognizer(tapRecognizer)
        
    }
    
    
    
    @objc func tapped(sender: AnyObject) {
        
        if (btnBack.isFocused){
            
            self.removeFromParent()
            GameController.shared.gameData.gameStatus = .playing
            GameController.shared.pauseActionItems()
            
        }
        else {
            print("não sei ler oq vc quer")
        }
    }
#endif
    
}
