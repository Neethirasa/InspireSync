import SwiftUI
import MessageUI

import Contacts

class EmailViewModel: ObservableObject {
    func requestEmailAccess(completion: @escaping (Bool) -> Void) {
        let contactStore = CNContactStore()
        let authorizationStatus = CNContactStore.authorizationStatus(for: .contacts)

        switch authorizationStatus {
        case .notDetermined:
            contactStore.requestAccess(for: .contacts) { success, error in
                completion(success)
            }
        case .authorized:
            completion(true)
        case .denied, .restricted:
            completion(false)
        @unknown default:
            fatalError("Unhandled authorization status")
        }
    }
}

struct MailView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = EmailViewModel()
    
    @Binding var result: Bool
    private let presentingViewController: UIViewController?
    @State private var recipients = ["nivethikan@hotmail.com"]
    @State private var subject = "Feedback"
    @State private var messageBody = ""
    @State private var senderEmail = ""
    
    
    private let coordinator: Coordinator // Retain the coordinator object

        init(result: Binding<Bool>, presentingViewController: UIViewController?, recipients: [String]) {
            self._result = result
            self.presentingViewController = presentingViewController
            self._recipients = State(initialValue: recipients)
            self.coordinator = Coordinator()
        }

    var body: some View {
        VStack {
            TextField("Your Email", text: $senderEmail)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
            
            TextField("To", text: $recipients[0])
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextField("Subject", text: $subject)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            TextView(text: $messageBody)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 100, maxHeight: .infinity)
                .padding()
            
            Button(action: {
                sendEmail()
                dismiss()
            }) {
                Text("Send")
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
        .navigationTitle("Send Email")
        .navigationBarItems(trailing: Button("Cancel") {
            result = false
        })
    }

    func sendEmail() {
        guard MFMailComposeViewController.canSendMail() else {
            print("Mail services are not available")
            return
        }

        let mail = MFMailComposeViewController()
        mail.setToRecipients(recipients)
        mail.setSubject(subject)
        mail.setMessageBody(messageBody, isHTML: false)
        mail.mailComposeDelegate = coordinator // Use the retained coordinator object

        if let presentingViewController = presentingViewController {
            presentingViewController.present(mail, animated: true)
        }
    }

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            controller.dismiss(animated: true)
        }
    }
}
