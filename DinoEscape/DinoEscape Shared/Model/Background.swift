//  DinoEscape
//
//  Created by Luca Hummel on 17/03/22.
//

import Foundation

class Backgrounds {
    static var shared: Backgrounds = {
        let instance = Backgrounds()
        return instance
    }()
    
    var background = "redBackground"
    
    func newBackground(background: String) -> String {
        #if os(iOS)
        return background
        #else
        return background + "Mac"
        #endif
    }
}
