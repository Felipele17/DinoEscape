//
//  GameCenterController.swift
//  DinoEscape
//
//  Created by Carolina Ortega on 15/03/22.
//

import Foundation
import GameKit
#if os(iOS)
import UIKit
#endif

class GameCenterController {
    let LEADERBOARD_ID = "dino_players"
    
    #if os(iOS)
    var viewController: UIViewController?
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.auth()
    }
    #endif
    
    //MARK: - Autenticação
    
    func auth() {
        GKLocalPlayer.local.authenticateHandler = { viewController, error in
            if let vc = viewController {
                #if os(iOS) || os(tvOS)
                self.viewController?.present(vc, animated: true)
                #elseif os(macOS)
                self.viewController.present(vc, animator: true as? NSViewControllerPresent)
                #endif
                return
            } else {
                print("Erro ao carregar a view")
                //Tratar erro
            }
            
            if error != nil { //Não autenticação do usuário
                return
            }
            
            
        }
    }
    
    func setupActionPoint(location: GKAccessPoint.Location, showHighlights: Bool, isActive: Bool) {
        GKAccessPoint.shared.location = location
        GKAccessPoint.shared.showHighlights = showHighlights
        GKAccessPoint.shared.isActive = isActive
    }

    func sendScoreToGameCenter(score: Int) {
        GKLeaderboard.submitScore(score, context: 0, player: GKLocalPlayer.local, leaderboardIDs: [LEADERBOARD_ID]) { error in
            if error != nil {
                print(error!)
            } else {
                print("Score atualizado: \(score)")
            }
        }
    }
    
}
