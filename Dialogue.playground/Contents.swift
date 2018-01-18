import PlaygroundSupport

import Dialogue

class DialogueViewControllerConfiguration {
    weak var viewController: DialogueViewController!
    
    deinit {
        print("deinit")
    }
}

extension DialogueViewControllerConfiguration: DialogueViewControllerDelegate {
    func didReceive(_ message: String) {
        print("d")
        viewController.reply(with: "Thx for your message: \(message)")
    }
}

let configuration = DialogueViewControllerConfiguration()
let viewController = DialogueWireframe.instantiateDialogueViewController(
    with: configuration
)
configuration.viewController = viewController

PlaygroundPage.current.liveView = viewController.view
PlaygroundPage.current.needsIndefiniteExecution = true
