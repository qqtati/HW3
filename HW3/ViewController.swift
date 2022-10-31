//
//  ViewController.swift
//  HW3
//
//  Created by qqtati on 11.10.2022.
//

import UIKit

final class WelcomeViewController : UIViewController {
    public override func viewDidLoad() {
        setupView();
    }
    private let commentLabel = UILabel()
    private let valueLabel = UILabel()
    
    private var value: Int = 0
    private let incrementButton = UIButton()
    let colorPalleteView = ColorPalleteView()
    
    private func setupIncrementButton() {
        incrementButton.setTitle("Increment", for: .normal)
        incrementButton.setTitleColor(.black, for: .normal)
        incrementButton.layer.cornerRadius = 12
        incrementButton.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        incrementButton.backgroundColor = .white
        incrementButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        incrementButton.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        incrementButton.layer.shadowOpacity = 1.0
        incrementButton.layer.shadowRadius = 0
        incrementButton.layer.masksToBounds = false
        incrementButton.layer.cornerRadius = 4.0
        self.view.addSubview(incrementButton)
        incrementButton.setHeight(48)
        incrementButton.pinCenterY(to: self.view, 60)
        incrementButton.pin(to: self.view, [.left: 24, .right: 24])
        incrementButton.addTarget(self, action: #selector(incrementButtonPressed), for: .touchUpInside)
    }
    private func setupValueLabel() {
        valueLabel.font = .systemFont(ofSize: 40.0, weight: .bold)
        valueLabel.textColor = .black
        valueLabel.text = "\(value)"
        self.view.addSubview(valueLabel)
        valueLabel.pinTop(to: self.view, 40)
        valueLabel.pinCenter(to: self.view)
    }
    private func setupView() {
        view.backgroundColor = .systemGray6
        colorPalleteView.isHidden = true
        setupIncrementButton()
        setupValueLabel()
        setupCommentView()
        setupMenuButtons()
        setupColorControlSV()
    }
    @objc
    private func incrementButtonPressed() {
        value += 1
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        UIView.animate(withDuration: 1) {
            self.updateUI()
        }
    }
    private func updateUI() {
        setupValueLabel()
        updateCommentLabel(value: value)
        setupCommentView()
    }
    private func setupCommentView(){
        let commentView = UIView()
        commentView.backgroundColor = .white
        commentView.layer.cornerRadius = 20
        view.addSubview(commentView)
        commentView.pinTop(to: self.view, 100)
        commentView.pin(to: self.view, [.left: 24, .right: 24])
        commentLabel.font = .systemFont(ofSize: 14.0, weight: .regular)
        commentLabel.numberOfLines = 0
        commentLabel.textAlignment = .center
        commentView.addSubview(commentLabel)
        commentLabel.pin(to: commentView, [.top: 16, .left: 16, .bottom : 16, .right : 16])
    }
    func updateCommentLabel(value: Int) {
        switch value {
        case 0...10:
            commentLabel.text = "1"
        case 10...20:
            commentLabel.text = "2"
        case 20...30:
            commentLabel.text = "3"
        case 30...40:
            commentLabel.text = "4"
        case 40...50:
            commentLabel.text = "EEEEEEEYYYYYYYYY"
        case 50...60:
            commentLabel.text = "big boy"
        case 60...70:
            commentLabel.text = "70 70 70 moooooore"
        case 70...80:
            commentLabel.text = "rock star!!!"
        case 80...90:
            commentLabel.text = "80+\n go higher"
        case 90...100:
            commentLabel.text = "100! to the mooon"
        default:
            break
        }
        commentLabel.textColor = colorPalleteView.chosenColor
    }
    private func makeMenuButtons(title: String) -> UIButton{
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .medium)
        button.backgroundColor = .white
        button.heightAnchor.constraint(equalTo: button.widthAnchor).isActive = true
        return button
    }
    private func setupMenuButtons() {
        let colorsButton = makeMenuButtons(title: "🎨")
        colorsButton.addTarget(self, action:
                                #selector(paletteButtonPressed), for: .touchUpInside)
        let notesButton = makeMenuButtons(title: "🧻")
        let newsButton = makeMenuButtons(title: "📨")
        let buttonSV = UIStackView(arrangedSubviews: [colorsButton, notesButton, newsButton])
        buttonSV.spacing = 12
        buttonSV.axis = .horizontal
        buttonSV.distribution = .fillEqually
        self.view.addSubview(buttonSV)
        buttonSV.pin(to: self.view, [.left: 24, .right: 24])
        buttonSV.pinBottom(to: self.view, 24)
    }
    private func setupColorControlSV() {
        colorPalleteView.addTarget(self, action: #selector(changeColor), for: .touchDragInside)
        colorPalleteView.isHidden = true
        colorPalleteView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(colorPalleteView)
        NSLayoutConstraint.activate([
            colorPalleteView.topAnchor.constraint(equalTo: incrementButton.bottomAnchor, constant: 8),
            colorPalleteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 24),
            colorPalleteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            colorPalleteView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150)
            
        ])
    }
    @objc
    private func paletteButtonPressed() {
        colorPalleteView.isHidden.toggle()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    @objc
    private func changeColor(_ slider: ColorPalleteView) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = slider.chosenColor;
            self.commentLabel.textColor = slider.chosenColor
            self.colorPalleteView.chosenColor = slider.chosenColor
        }
    }
}

