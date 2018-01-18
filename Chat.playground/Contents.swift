import PlaygroundSupport

import Chat

class ChatViewControllerConfiguration {
}

extension ChatViewControllerConfiguration: ChatViewControllerDelegate {
    func didSend(_ message: String) {
        print("Did send message: \(message)")
    }
}

let viewController = ChatWireframe.instantiateChatViewController(
    with: ChatViewControllerConfiguration()
)

let view = viewController.view

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
