import PlaygroundSupport

import Dialogue

class DialogueViewControllerConfiguration {
    weak var viewController: DialogueViewController!
}

extension DialogueViewControllerConfiguration: DialogueViewControllerDelegate {
    func didReceive(_ message: String) {
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
