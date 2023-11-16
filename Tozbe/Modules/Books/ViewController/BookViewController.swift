//
//  BookViewController.swift
//  Tozbe
//
//  Created by Artur Imanbaev on 16.11.2023.
//

import UIKit
import PDFKit

final class BookViewController: UIViewController {
    
    private let name: String
    private let pdfView: PDFView = {
        let view = PDFView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    init(name: String) {
        self.name = name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setView()
        if let path = Bundle.main.path(forResource: "richDad", ofType: "pdf") {
            if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                pdfView.displayMode = .singlePageContinuous
                pdfView.autoScales = true
                pdfView.displayDirection = .vertical
                pdfView.document = pdfDocument
            }
        }
    }
}
private extension BookViewController {
    func setView() {
        view.addSubview(pdfView)
        NSLayoutConstraint.activate([
            pdfView.topAnchor.constraint(equalTo: view.topAnchor),
            pdfView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pdfView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pdfView.rightAnchor.constraint(equalTo: view.rightAnchor),

        ])
    }
}
