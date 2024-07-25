import UIKit
import FirebaseFirestore

struct Message {
    let senderId: String
    let senderName: String
    let message: String
    let timestamp: Timestamp
}


class ChatViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var messageInputBar: UIView!
    var messageTextField: UITextField!
    var sendButton: UIButton!
    
    var messages = [Message]()
    var userId: String = "currentUserId" // Assign the current user's ID
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadMessages()
        registerForKeyboardNotifications()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func setupUI() {
        // Collection View setup
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 10
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SenderMessageCell.self, forCellWithReuseIdentifier: "SenderMessageCell")
        collectionView.register(ReceiverMessageCell.self, forCellWithReuseIdentifier: "ReceiverMessageCell")
        collectionView.backgroundColor = .white
        collectionView.alwaysBounceVertical = true
        collectionView.keyboardDismissMode = .interactive
        view.addSubview(collectionView)
        
        // Message Input Bar setup
        messageInputBar = UIView()
        messageInputBar.backgroundColor = .lightGray
        view.addSubview(messageInputBar)
        
        messageTextField = UITextField()
        messageTextField.placeholder = "Enter message"
        messageTextField.backgroundColor = .white
        messageTextField.layer.cornerRadius = 15
        messageTextField.layer.shadowColor = UIColor.black.cgColor
        messageTextField.layer.shadowOffset = CGSize(width: 0, height: 1)
        messageTextField.layer.shadowOpacity = 0.2
        messageTextField.layer.shadowRadius = 5
        messageInputBar.addSubview(messageTextField)
        
        sendButton = UIButton(type: .system)
        let sendImage = UIImage(systemName: "paperplane.fill")?.withRenderingMode(.alwaysTemplate)
        sendButton.setImage(sendImage, for: .normal)
        sendButton.tintColor = .blue
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        messageInputBar.addSubview(sendButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        messageInputBar.translatesAutoresizingMaskIntoConstraints = false
        messageTextField.translatesAutoresizingMaskIntoConstraints = false
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // Collection View Constraints
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: messageInputBar.topAnchor),
            
            // Message Input Bar Constraints
            messageInputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            messageInputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            messageInputBar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            messageInputBar.heightAnchor.constraint(equalToConstant: 50),
            
            // Message Text Field Constraints
            messageTextField.leadingAnchor.constraint(equalTo: messageInputBar.leadingAnchor, constant: 8),
            messageTextField.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            messageTextField.heightAnchor.constraint(equalToConstant: 35),
            messageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -8),
            
            // Send Button Constraints
            sendButton.trailingAnchor.constraint(equalTo: messageInputBar.trailingAnchor, constant: -8),
            sendButton.centerYAnchor.constraint(equalTo: messageInputBar.centerYAnchor),
            sendButton.widthAnchor.constraint(equalToConstant: 35),
            sendButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }
        
        let keyboardHeight = keyboardFrame.height
        view.frame.origin.y = -keyboardHeight
        scrollToBottom()
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func loadMessages() {
        db.collection("chats").document("chatId").collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching messages: \(error!)")
                    return
                }
                self.messages = snapshot.documents.map { doc in
                    let data = doc.data()
                    return Message(
                        senderId: data["senderId"] as! String,
                        senderName: data["senderName"] as! String,
                        message: data["message"] as! String,
                        timestamp: data["timestamp"] as! Timestamp
                    )
                }
                self.collectionView.reloadData()
                self.scrollToBottom()
            }
    }
    
    @objc func sendMessage() {
        guard let messageText = messageTextField.text, !messageText.isEmpty else { return }
        
        let messageData: [String: Any] = [
            "senderId": userId,
            "senderName": "Current User",
            "message": messageText,
            "timestamp": Timestamp(date: Date())
        ]
        
        db.collection("chats").document("chatId").collection("messages").addDocument(data: messageData) { error in
            if let error = error {
                print("Error sending message: \(error)")
            } else {
                self.messageTextField.text = ""
                self.messageTextField.resignFirstResponder() // Dismiss the keyboard
                self.scrollToBottom()
            }
        }
    }
    
    func scrollToBottom() {
        guard !messages.isEmpty else { return }
        let indexPath = IndexPath(item: messages.count - 1, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messages[indexPath.item]
        
        if message.senderId == userId {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SenderMessageCell", for: indexPath) as! SenderMessageCell
            cell.messageLabel.text = message.message
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReceiverMessageCell", for: indexPath) as! ReceiverMessageCell
            cell.messageLabel.text = message.message
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messages[indexPath.item]
        
        // Calculate the size of the message text
        let approximateWidthOfTextView = collectionView.frame.width * 0.7
        let size = CGSize(width: approximateWidthOfTextView, height: 1000)
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
        let estimatedFrame = NSString(string: message.message).boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil)
        
        // Return the size with some padding
        return CGSize(width: collectionView.frame.width, height: estimatedFrame.height + 20)
    }
    
}


import UIKit

class SenderMessageCell: UICollectionViewCell {
    let messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .right
        messageLabel.backgroundColor = UIColor.lightGray
        messageLabel.layer.cornerRadius = 8
        messageLabel.clipsToBounds = true
        contentView.addSubview(messageLabel)
        
        // Constraints for messageLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 50)
        ])
    }
}

class ReceiverMessageCell: UICollectionViewCell {
    let messageLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .left
        messageLabel.backgroundColor = UIColor.gray
        messageLabel.layer.cornerRadius = 8
        messageLabel.clipsToBounds = true
        contentView.addSubview(messageLabel)
        
        // Constraints for messageLabel
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            messageLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: 50),
            messageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            messageLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8)
        ])
    }
}
