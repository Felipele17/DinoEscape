//
//  GameController.swift
//  DinoEscape iOS
//
//  Created by Beatriz Duque on 07/03/22.
//

import Foundation
import SpriteKit
import GameController

class GameController{
    
    static var shared: GameController = {
        let instance = GameController()
        return instance
    }()
    
    #if os(tvOS)
    var swipe: UISwipeGestureRecognizer?
    var pause: UITapGestureRecognizer?
    var backButton: UITapGestureRecognizer?
    #endif
    
    var gameData: GameData
    var renderer: RenderController
    let joystickController: JoystickController = JoystickController()
    
    var isFirstRun = true
    
    private init(){
        let player = Player(name: "DinoRex",
                            color: .yellow,
                            position: CGPoint(x: 0, y: 0),
                            size: CGSize(width: 50, height: 50),
                            skin: .dino1,
                            gameCommand: .PAUSE,
                            powerUp: .none)
        gameData = GameData(player: player)
        gameData.skinSelected = try! SkinDataModel.getSkinSelected().name ?? "notFound"
        renderer = RenderController()
    }
    
    func restartGame() {
        if let player = gameData.player {
            player.position = CGPoint(x: 0, y: 0)
            player.size = CGSize(width: 50, height: 50)
            player.life = 3
            player.powerUp = .none
            player.gameCommand = .PAUSE
            player.foodBar = 6.0
        }
        gameData.restartGameData()
        gameData.skinSelected = try! SkinDataModel.getSkinSelected().name ?? "notFound"
        
        #if os(iOS)
        joystickController.virtualController.resetStick()
        #endif
        renderer.restartGame()
    }
    
    // MARK: Setup e Set Scene
    
    func setScene(scene: MyScene){
        
        renderer.scene = scene
        
    }

    func setupScene(){
        MusicService.shared.playGameMusic()
        //player
        let player = GameController.shared.gameData.player!
        player.position = CGPoint(x: renderer.scene.size.width/2, y: renderer.scene.size.height/2)
        
        #if os( iOS )
        joystickController.virtualController.position = CGPoint(x: renderer.scene.size.width/2, y: renderer.scene.size.height/7)
        #endif
        
        
        
        renderer.setUpScene()
        
        //controle da cena
        joystickController.delegate = self
        joystickController.observeForGameControllers()
        
        //fisica da cena
        renderer.scene.physicsBody = SKPhysicsBody(edgeLoopFrom: GameController.shared.renderer.scene.frame)
        renderer.scene.physicsWorld.contactDelegate = GameController.shared.renderer.scene.self
        recursiveActionItems(time: 1.5)
        
        //onboard
        if isFirstRun{
            self.renderer.contagemLabel.removeFromParent()
            self.onboardGame()
        }
        else{
            //contagem regressiva
            self.counterGame()
        }

    }
    // MARK: Update
    func update(_ currentTime: TimeInterval){
        if gameData.gameStatus == .end {
            cancelActionItems()
            //chamar tela de gameOver
            renderer.lifesLabel.text = "0"
        } else {
            if gameData.gameStatus == .playing {
                joystickController.update(currentTime)
                movePlayer(dx: gameData.player?.dinoVx ?? 0, dy: gameData.player?.dinoVy ?? 0)
                renderer.update(currentTime, gameData: gameData)
            }
            
        }
        
    }
    
    // MARK: Estados do jogo
    func pauseGame() {
        if gameData.gameStatus != .end && gameData.gameStatus != .pause {
            gameData.gameStatus = .pause
            pauseActionItems()
            renderer.showPauseMenu()
            
        }
    }
    
    func onboardGame(){
        gameData.gameStatus = .pause
        pauseActionItems()
        renderer.showOnboard()
    }
    
    func counterGame(){
        var runCount = 3 {
            didSet {
                renderer.contagemLabel.text = "\(runCount)"
            }
        }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount -= 1
            if runCount == 0 {
                self.gameData.gameStatus = .playing
                self.renderer.contagemLabel.removeFromParent()
                timer.invalidate()
            }
        }
    }
    
    //MARK: Movimentacao
#if os(tvOS)
    func getSwipe(swipe: UISwipeGestureRecognizer){
        self.swipe = swipe
    }
    
    func getPause(pause: UITapGestureRecognizer){
        self.pause = pause
    }
    func getBackButton(backButton: UITapGestureRecognizer) {
        print("Tô entrando na função de getBackButton")
    }
    
#endif
    
   
    func movePlayer(dx: CGFloat, dy: CGFloat){
        
        if let player = gameData.player {
            
            // Iguala size do player para size da hitBox
            player.size = CGSize(width: renderer.scene.size.height*0.05, height: renderer.scene.size.height*0.035)
            let mult = player.foodBar
            let midWidthPlayer = player.size.width/2
            let midHeightPlayer = player.size.height/2
            
            var xValue = player.position.x + dx * mult
            if xValue > renderer.scene.size.width * 0.94 - midWidthPlayer{
                xValue = renderer.scene.size.width * 0.94 - midWidthPlayer
            } else if xValue < renderer.scene.size.width * 0.06 + midWidthPlayer{
                xValue = renderer.scene.size.width * 0.06 + midWidthPlayer
            }
           
            
            var yValue = player.position.y + dy * mult
            if yValue > renderer.scene.size.height * 0.84 - midHeightPlayer{
                yValue = renderer.scene.size.height * 0.84 - midHeightPlayer
            } else if yValue < renderer.scene.size.height * 0.125 + midHeightPlayer{
                yValue = renderer.scene.size.height * 0.125 + midHeightPlayer
            }
            
            player.position = CGPoint(x: xValue, y: yValue)
        }
    }
    
    // MARK: Itens na tela
    func createItems(){
        
        let badOrGood = Int.random(in: 0...1)
        let spoiledOrMeteor = Int.random(in: 0...1)

        let directions: [GameCommand] = [.LEFT, .RIGHT, .UP, .DOWN]
        let goodImages: [String] = ["cherry","banana","apple"]
        let badImages: [String] = ["spoiledCherry", "spoiledBanana", "spoiledApple"]
        let direction = directions[Int.random(in: 0..<directions.count)]
        let item = Items(image: "", vy: 0, vx: 0, direction: direction)
        
        
        var xInitial: CGFloat = 0
        var yInitial: CGFloat = 0
        
        if badOrGood == 1 {
            item.texture = SKTexture(imageNamed: goodImages[Int.random(in: 0..<goodImages.count)])
            item.name = "good"
        } else {
            if spoiledOrMeteor == 1 {
                item.texture = SKTexture(imageNamed: badImages[Int.random(in: 0..<badImages.count)])
                item.name = "bad"
            } else {
                item.texture = SKTexture(imageNamed: "meteoro1")
                item.name = "meteoro"
            }
            
        }
        
        
        switch direction {
        case .UP:
            xInitial = CGFloat.random(in: renderer.scene.size.width * 0.06...renderer.scene.size.width * 0.94)
            yInitial = renderer.scene.size.height*1.1
            item.vy = -gameData.velocidadeGlobal
          
        case .DOWN:
            xInitial = CGFloat.random(in: renderer.scene.size.width * 0.06...renderer.scene.size.width * 0.94)
            yInitial = renderer.scene.size.height * -0.1
            item.vy = gameData.velocidadeGlobal
            
        case .RIGHT:
            xInitial = renderer.scene.size.width * 1.1
            yInitial = CGFloat.random(in: renderer.scene.size.height * 0.125...renderer.scene.size.height * 0.84)
            item.vx = -gameData.velocidadeGlobal

        case .LEFT:
            xInitial = renderer.scene.size.width * -0.1
            yInitial = CGFloat.random(in: renderer.scene.size.height * 0.125...renderer.scene.size.height * 0.84)
            item.vx = gameData.velocidadeGlobal
            
            
        case .NONE:
            print()
        case .DEAD:
            print()
        case .PAUSE:
            print()
        }
        
        renderer.drawItem(item: item, x: xInitial, y: yInitial)
        
    }
    
    func nextLevel(points: Int){
        if points == 0 {
            renderer.changeBackground(named: Backgrounds.shared.newBackground(background: "redBackground"))
        }
        else if points == 200 || points == 210 {
            newEra()
            cancelActionItems()
            recursiveActionItems(time: 1.2)
            renderer.changeBackground(named: Backgrounds.shared.newBackground(background: "blueBackground"))
        }
        else if points == 500 || points == 510 {
            newEra()
            cancelActionItems()
            recursiveActionItems(time: 1)
            renderer.changeBackground(named: Backgrounds.shared.newBackground(background: "lightGreenBackground"))
            gameData.velocidadeGlobal = 4
        }
        else if points == 800 || points == 810 {
            newEra()
            cancelActionItems()
            recursiveActionItems(time: 0.8)
            renderer.changeBackground(named: Backgrounds.shared.newBackground(background: "greenBackground"))
        }
        else if points == 1200 || points == 1210  {
            newEra()
            cancelActionItems()
            recursiveActionItems(time: 0.6)
            renderer.changeBackground(named: Backgrounds.shared.newBackground(background: "cityBackground"))
            gameData.velocidadeGlobal = 5

        }
        else if points == 1500 || points == 1510 {
            cancelActionItems()
            newEra()
            recursiveActionItems(time: 0.4)
            renderer.changeBackground(named: Backgrounds.shared.newBackground(background: "planetBackground"))
        }
    }
    
    func recursiveActionItems(time: CGFloat){
        let recursive = SKAction.sequence([
            SKAction.run(createItems),
            SKAction.wait(forDuration: time),
            SKAction.run({[unowned self] in self.recursiveActionItems(time: time)})
        ])
        
        renderer.scene.run(recursive, withKey: "aKey")
    }
    
    func pauseActionItems() {
        if gameData.gameStatus == .pause {
            renderer.scene.action(forKey: "aKey")?.speed = 0
        } else {
            renderer.scene.action(forKey: "aKey")?.speed = 1
        }
    }
    
    func cancelActionItems() {
        renderer.scene.removeAction(forKey: "aKey")
    }
    
    // MARK: Power-ups e New Era
    func getPowerUp() -> PowerUp{
        let powerUps: [PowerUp] = [.slow, .allFood, .doubleXP]
        return powerUps[Int.random(in: 0..<powerUps.count)]
    }

    func powerUpLogic(powerUp: PowerUp) {

        let powerUpLabel = renderer.drawPowerUp(powerUp: powerUp)
        var runCount = 0
        var runPower = 0
        
        // adiciona o label que indica o powerup selecionado
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runPower += 1
            if runPower == 3 {
                self.renderer.excludeNode(label: powerUpLabel)
                timer.invalidate()
            }
        }
        
        
        if powerUp == .allFood {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                runCount += 1
                // conversa com a render para ela mudar os assets dos powerUps
                self.renderer.allFoodRender()
                if runCount == 5 {
                    timer.invalidate()
                }
            }
            
            
            
        } else if powerUp == .slow {
            // conversa com a render para ela mudar a velocidade dos assets dos powerUps
            renderer.slowRender()
            
        } else if powerUp == .doubleXP {
            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                runCount += 1
                self.gameData.addPoints = 20
                if runCount == 10 {
                    self.gameData.addPoints = 10
                    timer.invalidate()
                }
            }
        }
    }
    func newEra(){
        let newEraLabel = renderer.drawNewEra()
        var runCount = 0
        // adiciona o label que indica o powerup selecionado
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            runCount += 1
            if runCount == 2 {
                self.renderer.excludeNode(label: newEraLabel)
                timer.invalidate()
            }
        }
    }
 
}

