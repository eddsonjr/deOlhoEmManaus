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

    
    let TAG = "[ShowHouseViewController]: "
   
    @IBOutlet var imageView: CustomImageView!
    @IBOutlet var popOverTextArea: UITextView!
    @IBOutlet var popOverView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.TAG + "Singleton show: \(ModelSingleton.shared.showSelected?.id)")
        
        verifyWebAndDownload() //verificando as condicoes da web e baixando dados
        
        
        //Ajustando o popover - contornos
        self.popOverView.layer.cornerRadius = 10

        
        //self.navigationController?.navigationBar.barStyle = .black
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func verifyWebAndDownload() {
        if(InternetUtils.isConnectedToInternet()) {
            print(TAG + "web available. Downloading...")
            self.imageView.loadImageUsingCache(withUrlString: (ModelSingleton.shared.showSelected?.imageUrl)!)
            createNavigationRightButtons() //Renderizando os botoes direitos da navigation
        }else{
            print(self.TAG + "web not available. Prevent download....")
            AlertUtils.shared.webNotAvailableAlert(view: self)
            self.imageView.loadImageUsingCache(withUrlString: (ModelSingleton.shared.showSelected?.imageUrl)!)
            
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
        
        self.popOverTextArea.text = phoneStr
        
    
    }
    

    
}
