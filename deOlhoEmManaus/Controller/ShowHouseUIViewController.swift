//
//  ShowHouseUIViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 09/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import UIKit
import SafariServices


class ShowHouseUIViewController: UIViewController, ReachabilityObserverDelegate{
    
    let TAG = "[ShowHouseViewController]: "
   
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var popOverTextArea: UITextView!
    @IBOutlet var popOverView: UIView!
    @IBOutlet var noWebView: UIView!

    
    var downloaded: Bool = false
    
    
    override func viewWillAppear(_ animated: Bool) {
        try? addReachabilityObserver() //habilitando sistema para verificar se ha ou nao conexao com web
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.TAG + "Singleton show: \(ModelSingleton.shared.showSelected?.id)")
        self.popOverView.layer.cornerRadius = 10 //Ajustando o popover - contornos
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    @objc func shareButton(_ sender: Any) {
        print(self.TAG + "Sharing....")
        let image = self.imageView.image
        let imageShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageShare , applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    
    
     
    
    @objc func locationButton(_ sender: Any) {
        print(self.TAG + "Location....")
        
        let  location = "http://maps.google.com/maps?q=" + (ModelSingleton.shared.showSelected?.showHouse?.completAddress)!
        let safariURL = location.addingPercentEncoding(withAllowedCharacters:  CharacterSet.urlQueryAllowed)
              print("\(safariURL)")
        guard let url = URL(string: safariURL!) else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
        
    }
    
    
    
    
    
    @objc func phoneButton(_ sender: Any) {
       createAlertWithNumbers()
    }
    
    
    
    func createNavigationRightButtons(){
        
        //Criando o botao de share
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.setImage(UIImage(named: "share"), for: .normal)
        shareButton.addTarget(self, action:#selector(shareButton(_:)), for: .touchUpInside)
        shareButton.frame = CGRect(x: 0, y: 0, width: 40, height: 10)
        let barButtonShare = UIBarButtonItem(customView: shareButton)
        
        //criando o botao de location
        let locationButton = UIButton(type: UIButton.ButtonType.custom)
        locationButton.setImage(UIImage(named: "location"), for: .normal)
        locationButton.addTarget(self, action:#selector(locationButton(_:)), for: .touchUpInside)
        locationButton.frame = CGRect(x: 0, y: 0, width: 40, height: 10)
        let barButtonLocation = UIBarButtonItem(customView: locationButton)
        
        
        //Criando o botao de contatos
        let phoneButton = UIButton(type: UIButton.ButtonType.custom)
        phoneButton.setImage(UIImage(named: "phone"), for: .normal)
        phoneButton.addTarget(self, action:#selector(phoneButton(_:)), for: .touchUpInside)
        phoneButton.frame = CGRect(x: 0, y: 0, width: 40, height: 10)
        let barButtonPhone = UIBarButtonItem(customView: phoneButton)
        
        
        
        //Verificando se ha telefones para contato para esta casa do show
        //Caso tenha, colocar o item de phone na navigation
        //caso contrario, remover
        if ModelSingleton.shared.showSelected?.showHouse?.phones != nil {
            self.navigationItem.rightBarButtonItems = [barButtonShare,barButtonLocation,barButtonPhone]
        }else{
            self.navigationItem.rightBarButtonItems = [barButtonShare,barButtonLocation]
        }
    }
    
    
    
    //Mark: Funcoes do PopOver
    @IBAction func exitPopOverButton(_ sender: Any) {
        //Retira o popOver da tela
        self.popOverView.removeFromSuperview()
    }
    
    
    
    func createPopOver() {
        //adicionando o popover a tela
        self.view.addSubview(self.popOverView)
        popOverView.center = self.view.center
        
        //Colocando o numero de telefones
        var phoneStr = ""
        for phone in (ModelSingleton.shared.showSelected?.showHouse!.phones)! {
            phoneStr += phone + "\n"
        }
        
        if traitCollection.userInterfaceStyle == .dark {
            self.popOverTextArea.textColor = .white
        }
        
    
        self.popOverTextArea.text = phoneStr
        
    
    }
    
    
    
    
    //Mark: Funcoes para chamar e tratar os numeros de telefone de contato
    
    //Chama um determinado numero
    func callNumber(number: String){
        if let phoneCallURL = URL(string: "tel://\(number)") {
            print("Calling number....")
            
            let application:UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
              application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    
    
    
    //Cria um alerta com os numeros de telefone
    func createAlertWithNumbers() {
           
           let callNumbersAllert = UIAlertController(title: "Selecione um Número", message: "Escolha um número para ligar e entrar em contato", preferredStyle: .actionSheet)

        callNumbersAllert.addAction(UIAlertAction(title: ModelSingleton.shared.showSelected?.showHouse?.phones?.first, style: .default, handler: { (alertAction: UIAlertAction) in
               print("Calling number: \(ModelSingleton.shared.showSelected?.showHouse?.phones?.first)")
            self.callNumber(number: (ModelSingleton.shared.showSelected?.showHouse?.phones?.first)!)
           }))

        
        
        if (ModelSingleton.shared.showSelected?.showHouse?.phones!.count)! > 1 {
               callNumbersAllert.addAction(UIAlertAction(title: ModelSingleton.shared.showSelected?.showHouse?.phones?[1], style: .default, handler: { (alertAction: UIAlertAction) in
                   print("Calling number: \(ModelSingleton.shared.showSelected?.showHouse?.phones?[1])")
                self.callNumber(number: (ModelSingleton.shared.showSelected?.showHouse?.phones?[1])!)
               }))

           }
           
           callNumbersAllert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction: UIAlertAction) in
               print("cancel")
           }))
           
           present(callNumbersAllert, animated: true, completion: nil)
           
       }
       
    
    
    
    
    //Mark: Reachability protocol
    func reachabilityChanged(_ isReachable: Bool) {
         if isReachable {
            print(TAG + "web available. Downloading...")
            self.noWebView.isHidden = true
            self.imageView.loadImageUsingCache(withUrl: (ModelSingleton.shared.showSelected?.imageUrl)!)
            createNavigationRightButtons() //Renderizando os botoes direitos da navigation
            self.downloaded = true
         }else{
            print(self.TAG + "web not available. Prevent download....")
            if !self.downloaded {
                self.imageView.loadImageUsingCache(withUrl: (ModelSingleton.shared.showSelected?.imageUrl)!)
                         
                self.noWebView.isHidden = false
                AlertUtils.shared.webNotAvailableAlert(view: self)
            }
             
         }
     }
     
     
     deinit {
        removeReachabilityObserver()
        print("Exiting class")
     }
     
}
