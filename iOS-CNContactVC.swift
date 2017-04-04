//
//  ViewController.swift
//  MCTesting
//
//  Created by Yukui Ye on 4/4/17.
//  Copyright © 2017 Yukui Ye. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI

class ViewController: UIViewController, UINavigationControllerDelegate, CNContactViewControllerDelegate {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.toggleAddContact(true)
    }
    
    func toggleAddContact(_ flag: Bool) {
        if flag {
            let addContactButton = UIBarButtonItem(image: UIImage(named: "ic_person_add_black_48px"), style: .plain, target: self, action: #selector(addContact))
            addContactButton.accessibilityLabel = "Add new contact"
            navigationItem.setRightBarButton(addContactButton, animated: true)
        } else {
            navigationItem.setRightBarButton(nil, animated: true)
        }
    }
    
    func addContact(_ sender: UIBarButtonItem) {
        self.addContactToAddressBook("917-545-6689")
    }
    
    func addContactToAddressBook(_ phoneNumber: String?) {
        self.addContactToContactBook(phoneNumber)
    }
    
    fileprivate func addContactToContactBook(_ phoneNumber: String?) {
        let contactViewController: CNContactViewController
        if let phoneNumber = phoneNumber {
            let contact = CNMutableContact()
            let phoneNumberValue = CNLabeledValue(label: "", value: CNPhoneNumber(stringValue: phoneNumber))
            contact.phoneNumbers = [phoneNumberValue]
            contactViewController = CNContactViewController(forNewContact: contact)
        } else {
            contactViewController = CNContactViewController(forNewContact: nil)
        }
        contactViewController.delegate = self
        pushContactUIToView(contactViewController)
    }
    
    var appDelegate: AppDelegate? {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.red
        return UIApplication.shared.delegate as? AppDelegate
    }
    
    func pushContactUIToView(_ vc: UIViewController) {
        if let navController = appDelegate?.window?.rootViewController as? UINavigationController {
            navController.pushViewController(vc, animated: true)
            navController.navigationBar.backgroundColor = UIColor.blue
            
        }
        
    }
    
    // MARK: - CNContactViewControllerDelegate

    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        defer {
            _ = viewController.navigationController?.popViewController(animated: true)
        }
        appDelegate?.window?.backgroundColor = UIColor.red
        guard let contact = contact else {
            return
        }
    }
}

