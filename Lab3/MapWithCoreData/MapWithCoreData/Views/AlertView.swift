//
//  AlertView.swift
//  MapWithCoreData
//
//  Created by Nursat on 25.02.2021.
//

import Foundation
import SwiftUI
import CoreData

struct AlertControlView: UIViewControllerRepresentable {
    var viewContext: NSManagedObjectContext
    @State var titleString: String = ""
    @State var subtitleString: String = ""
        
    var title: String
    var message: String
    @ObservedObject var viewModel: ContentViewModel
    
    // Make sure that, this fuction returns UIViewController, instead of UIAlertController.
    // Because UIAlertController gets presented on UIViewController
    func makeUIViewController(context: UIViewControllerRepresentableContext<AlertControlView>) -> UIViewController {
         return UIViewController() // Container on which UIAlertContoller presents
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<AlertControlView>) {
        // Make sure that Alert instance exist after View's body get re-rendered
            guard context.coordinator.alert == nil else { return }

        if self.viewModel.showAlert {

                // Create UIAlertController instance that is gonna present on UIViewController
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                context.coordinator.alert = alert

                // Adds UITextField & make sure that coordinator is delegate to UITextField.
                alert.addTextField { textField in
                    textField.placeholder = "Enter title"
                    textField.text = self.titleString            // setting initial value
                    textField.delegate = context.coordinator    // using coordinator as delegate
                }
                alert.addTextField { textField in
                    textField.placeholder = "Enter subtitle"
                    textField.text = self.subtitleString            // setting initial value
                    textField.delegate = context.coordinator    // using coordinator as delegate
                }

                alert.addAction(UIAlertAction(title: NSLocalizedString("Add", comment: ""), style: .default) { _ in
                    // On submit action, get texts from TextField & set it on SwiftUI View's two-way binding varaible `textString` so that View receives enter response.
                    if let textField = alert.textFields?.first, let text = textField.text {
                        self.titleString = text
                    }
                    if let textField = alert.textFields?.last, let text = textField.text {
                        self.subtitleString = text
                    }
                    viewModel.addMark(viewContext: viewContext, title: titleString, subtitle: subtitleString, coordinate: viewModel.coordinate)
                    alert.dismiss(animated: true) {
                        viewModel.showAlert = false
                    }
                })

                // Most important, must be dispatched on Main thread,
                // Curious? then remove `DispatchQueue.main.async` & find out yourself, Dont be lazy
                DispatchQueue.main.async { // must be async !!
                    uiViewController.present(alert, animated: true, completion: {
                        viewModel.showAlert = false  // hide holder after alert dismiss
                        context.coordinator.alert = nil
                    })

                }
            }
    }
    
    func makeCoordinator() -> AlertControlView.Coordinator {
        Coordinator(self)
    }
      
    class Coordinator: NSObject, UITextFieldDelegate {

    // Holds reference of UIAlertController, so that when `body` of view gets re-rendered so that Alert should not disappear
        var alert: UIAlertController?

        // Holds back reference to SwiftUI's View
        var control: AlertControlView

        init(_ control: AlertControlView) {
            self.control = control
        }

//        func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//            if let text = textField.text as NSString? {
//                self.control.titleString = text.replacingCharacters(in: range, with: string)
//                self.control.subtitleString = tex
//            } else {
//                self.control.textString = ""
//            }
//            return true
//        }
    }
}

