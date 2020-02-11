//
//  ShowHouseUIViewController.swift
//  deOlhoEmManaus
//
//  Created by Edson  Jr on 09/01/2020.
//  Copyright © 2020 Edson  Jr. All rights reserved.
//

import UIKit
import SafariServices


class ShowHouseUIViewController: UIViewController {

    
    @IBOutlet var imageView: CustomImageView!
    let TAG = "[ShowHouseViewController]: "
    @IBOutlet var popOverTextArea: UITextView!
    @IBOutlet var popOverView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.TAG + "Singleton show: \(ModelSingleton.shared.showSelected?.id)")
        
        verifyWebAndDownload() //verificando as condicoes da web e baixando dados
        createNavigationRightButtons() //Renderizando os botoes direitos da navigation
        
        //Ajustando o popover - contornos
        self.popOverView.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func verifyWebAndDownload() {
        if(InternetUtils.isConnectedToInternet()) {
            print(TAG + "web available. Downloading...")
            self.imageView.loadImageUsingCache(withUrlString: (ModelSingleton.shared.showSelected?.imageUrl)!)
        }else{
            print(self.TAG + "web not available. Prevent download....")
            AlertUtils.shared.webNotAvailableAlert(view: self)
        }
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
        //Sera chamado o popOver contendo as informacoes de contato
        createPopOver()
    }
    
    
    
    
    func createShareButton() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.addTarget(self, action:#selector(shareButton(_:)), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    
    
    
    
    func createNavigationRightButtons(){
        
        //Criando o botao de share
        let shareButton = UIButton(type: UIButton.ButtonType.custom)
        shareButton.setImage(UIImage(named: "share2"), for: .normal)
        shareButton.addTarget(self, action:#selector(shareButton(_:)), for: .touchUpInside)
        shareButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let barButtonShare = UIBarButtonItem(customView: shareButton)
        
        //criando o botao de location
        let locationButton = UIButton(type: UIButton.ButtonType.custom)
        locationButton.setImage(UIImage(named: "location2"), for: .normal)
        locationButton.addTarget(self, action:#selector(locationButton(_:)), for: .touchUpInside)
        locationButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let barButtonLocation = UIBarButtonItem(customView: locationButton)
        
        
        //Criando o botao de contatos
        let phoneButton = UIButton(type: UIButton.ButtonType.custom)
        phoneButton.setImage(UIImage(named: "phone2"), for: .normal)
        phoneButton.addTarget(self, action:#selector(phoneButton(_:)), for: .touchUpInside)
        phoneButton.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        let barButtonPhone = UIBarButtonItem(customView: phoneButton)
        
        
        //Adicionando a barra de navigation
        self.navigationItem.rightBarButtonItems = [barButtonShare,barButtonLocation,barButtonPhone]
        
        
        
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
        
        //Colocando agora o numero de telefone
        
        
    }
    

    
}
