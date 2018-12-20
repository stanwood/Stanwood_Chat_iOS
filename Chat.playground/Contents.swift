import PlaygroundSupport

import Chat

class ChatViewControllerConfiguration {
    weak var viewController: ChatViewController!
}

extension ChatViewControllerConfiguration: ChatViewControllerDelegate {
    func didReceive(_ message: String) {
        viewController.reply(with: .string("Thx for your message: \(message)"))
    }
}

let configuration = ChatViewControllerConfiguration()
let viewController = ChatWireframe.instantiateChatViewController(
    with: configuration
)
configuration.viewController = viewController

PlaygroundPage.current.liveView = viewController.view
PlaygroundPage.current.needsIndefiniteExecution = true
