//
//  GameCenterController.swift
//  gameTesteGC
//
//  Created by Carolina Ortega on 15/03/22.
//

// swiftlint: disable identifier_name
// swiftlint:disable force_cast

import Foundation
import GameKit

#if os(macOS)
import Cocoa
#endif

#if os(iOS)
import UIKit
#endif

class GameCenterController {
    static var shared: GameCenterController = {
        let instance = GameCenterController(viewController: GameViewController())
        return instance
    }()
    
    let LEADERBOARD_ID = "dino_players" // na appstore connect deve ser criado um ID para o gameCnter
    let view = GKGameCenterViewController(leaderboardID: "dino_players", playerScope: .global, timeScope: .allTime)

    #if os(macOS)
    var viewController: NSViewController?
    init(viewController: NSViewController) {
        self.viewController = viewController
        auth()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    #elseif os(iOS) || os(tvOS)
    var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.auth() // chama a funcao de autenticacao
    }
    #endif
    
    func auth() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            // conseguiu criar a view
            if let vc = viewController {
                #if os(iOS) || os(tvOS)
                self.viewController?.present(vc, animated: true)
                #elseif os(macOS)
                self.viewController?.present(vc, animator: true as! NSViewControllerPresentationAnimator)
                #endif
                return
            } else {
                // caso a viewcontroller venha quebrada
                print("ERRO ao carregar a view")
            }
            
            if error != nil {
                // o usuario nao foi autenticado
                return
            }
            // MARK: CONFIGURACOES
            if GKLocalPlayer.local.isUnderage {
                // caso a pessoa seja menor de idade, voce pode esconder algum conteudo
            }
            if GKLocalPlayer.local.isMultiplayerGamingRestricted {
                // caso a pessoa nao tenha permitido o multiplayer
            }
        }
    }
    
    func setupActionPoint(location: GKAccessPoint.Location, showHighlights: Bool, isActive: Bool) {
        GKAccessPoint.shared.location = location
        GKAccessPoint.shared.showHighlights = showHighlights
        GKAccessPoint.shared.isActive = isActive
    }
    
    #if os(macOS)
    func showGame() {
        viewController?.presentAsModalWindow(view)
    }
    
    func closeGame() {
        viewController?.dismiss(view)
    }
    #endif
    
    func sendScoreToGameCenter(score: Int) {
        GKLeaderboard.submitScore(score,
                                  context: 0,
                                  player: GKLocalPlayer.local,
                                  leaderboardIDs: [LEADERBOARD_ID]) { error in
            if error != nil {
                print(error!)
            } else {
                print("Score atualizado: \(score)")
            }
        }
    }
}
