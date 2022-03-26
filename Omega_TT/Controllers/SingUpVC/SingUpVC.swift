//
//  SingUpViewController.swift
//  Omega_TT
//
//  Created by Oleg on 08.02.2022.
//

import UIKit

class SingUpVC: UIViewController {
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
        
    }()
    
    var backgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Registration"
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var firstNameTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "First name"
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var firstNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var secondNameTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Second name"
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var secondNameValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var ageValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var phoneNumberTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "+7 (***) ***-**-**"
        textField.text = "+7"
        textField.keyboardType = .numberPad
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var phoneValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var emailTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Email"
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var emailValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var passwordTextfield: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.placeholder = "Password"
        textField.layer.shadowOpacity = 0.5
        textField.layer.shadowRadius = 1
        textField.layer.shadowOffset = CGSize(width: 0, height: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordValidLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var singUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemBlue
        button.setTitle("SingUP", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(singUpButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private func setupDataPicker() {
        datePicker.datePickerMode = .date
        datePicker.backgroundColor = .white
        datePicker.layer.borderColor = UIColor.white.cgColor
        datePicker.layer.borderWidth = 1
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 6
        datePicker.tintColor = .black
    }
    
    var elementStackView = UIStackView()
    var datePicker = UIDatePicker()
    
    let nameValidType: String.ValidTypes = .name
    let emailValidType: String.ValidTypes = .email
    let passwordValidType: String.ValidTypes = .password
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setConstrains()
        setupDelegate()
        setupDataPicker()
        registererKeyboardNotification()
    }
    
    deinit {
        remoteKeyboardNitification()
    }
    
    //MARK: SetupDelegate
    private func setupDelegate() {
        firstNameTextfield.delegate = self
        secondNameTextfield.delegate = self
        phoneNumberTextfield.delegate = self
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    //MARK: SingUpButtonTapped
    @objc private func singUpButtonTapped() {
        let firstNameText = firstNameTextfield.text ?? ""
        let secondNameText = secondNameTextfield.text ?? ""
        let emailText = emailTextfield.text ?? ""
        let passwordText = passwordTextfield.text ?? ""
        let phoneText = phoneNumberTextfield.text ?? ""
        
        if firstNameText.isValid(validType: nameValidType)
            && secondNameText.isValid(validType: nameValidType)
            && emailText.isValid(validType: emailValidType)
            && passwordText.isValid(validType: passwordValidType)
            && phoneText.count == 18
            && ageValid() == true {
            
            DataBase.shared.saveUser(firstName: firstNameText,
                                     secondName: secondNameText,
                                     phone: phoneText,
                                     email: emailText,
                                     password: passwordText,
                                     age: datePicker.date)
            loginLabel.text = "Complete"
        } else {
            loginLabel.text = "Not have all data"
            loginLabel.textColor = .systemRed
        }
        
    }
    
    //MARK: SetTextField
    private func setTextField(textField: UITextField, label: UILabel, validType: String.ValidTypes, validMessage: String, wrongMessage: String, string: String, range: NSRange) {
        let text = (textField.text ?? "") + string
        let result: String
        
        if range.length == 1 { // диапозон длинны
            let end = text.index(text.startIndex, offsetBy: text.count - 1)
            result = String(text[text.startIndex..<end])
        } else {
            result = text
        }
        
        textField.text = result
        
        if result.isValid(validType: validType) {
            label.text = validMessage
            label.textColor = .systemGreen
        } else {
            label.text = wrongMessage
            label.textColor = .systemRed
        }
    }
    
    //MARK: SetPhoneNumberMask
    private func setPhoneNumberMask(textField: UITextField, mask: String, string: String, range: NSRange) -> String {
        let text = textField.text ?? ""
        
        let phone = (text as NSString).replacingCharacters(in: range, with: string) // замена символов
        let number = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = number.startIndex
        
        for character in mask where index < number.endIndex {
            if character == "X" {
                result.append(number[index])
                index = number.index(after: index)
            } else {
                result.append(character)
            }
        }
        
        if result.count == 18 {
            phoneValidLabel.text = "Phone is valid"
            phoneValidLabel.textColor = .systemGreen
        } else {
            phoneValidLabel.text = "Phone is not valid"
            phoneValidLabel.textColor = .systemRed
        }
        
        return result
    }
    
    //MARK: AgeValid
    private func ageValid() -> Bool {
        let calendar = NSCalendar.current
        let dateNow = Date()
        let birthday = datePicker.date
        
        let age = calendar.dateComponents([.year], from: birthday, to: dateNow)
        let ageYear = age.year
        guard let ageUser = ageYear else {return false}
        return (ageUser < 18 ? false : true )
    }
}

//MARK: UITextFieldDelegate
extension SingUpVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case firstNameTextfield: setTextField(textField: firstNameTextfield,
                                              label: firstNameValidLabel,
                                              validType: nameValidType,
                                              validMessage: "Name is valid",
                                              wrongMessage: "Only A-Z characters, min 1 character",
                                              string: string,
                                              range: range)
        case secondNameTextfield: setTextField(textField: secondNameTextfield,
                                               label: secondNameValidLabel,
                                               validType: nameValidType,
                                               validMessage: "Name is valid",
                                               wrongMessage: "Only A-Z characters, min 1 character",
                                               string: string,
                                               range: range)
        case emailTextfield: setTextField(textField: emailTextfield,
                                          label: emailValidLabel,
                                          validType: emailValidType,
                                          validMessage: "Email is valid",
                                          wrongMessage: "Email is not valid",
                                          string: string,
                                          range: range)
        case passwordTextfield: setTextField(textField: passwordTextfield,
                                             label: passwordValidLabel,
                                             validType: passwordValidType,
                                             validMessage: "Password is valid",
                                             wrongMessage: "Password is not valid",
                                             string: string,
                                             range: range)
            
        case phoneNumberTextfield: phoneNumberTextfield.text = setPhoneNumberMask(textField: phoneNumberTextfield,
                                                                                  mask: "+X (XXX) XXX-XX-XX",
                                                                                  string: string,
                                                                                  range: range)
        default:
            break
        }
        
        return false
    }
    
    // После нажатия ввод убираем клавиатуру
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        firstNameValidLabel.resignFirstResponder()
        secondNameTextfield.resignFirstResponder()
        emailTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        return true
    }
}




