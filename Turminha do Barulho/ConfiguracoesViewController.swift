//
//  ConfiguracoesViewController.swift
//  Turminha do Barulho
//
//  Created by Bruno Eiji Yoshida on 23/10/15.
//  Copyright © 2015 Lucas Coiado Mota. All rights reserved.
//

import UIKit
import Parse

class ConfigViewController: UIViewController, UITableViewDataSource,UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var sairButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var actInd: UIActivityIndicatorView!
    
    var usuario: Usuario?
    var notificacoes = [Notificacao]()
    
    var lastIndex  = 0
    
    var question : Question?
    
    //COR
    let bgColor = UIColor(red: 27/255, green: 55/255, blue: 76/255, alpha: 1)  //Cor de fundo
    
    let detailsColor = UIColor(red: 255/255, green: 209/255, blue: 0/255, alpha: 1) //Cor dos detalhes (fonte, icones, etc)
    
    //ImagePicker
    var imagePicker : UIImagePickerController!
    var newUserPhoto : UIImage!
    
    
    // Dicionario para imagens
    var imagesDictionary = [String:UIImage]()
    
    //ImagePickerDelegateMethods
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        imagePicker.dismissViewControllerAnimated(false, completion: nil)
        self.newUserPhoto = info[UIImagePickerControllerOriginalImage] as? UIImage
        self.saveImage(self.newUserPhoto, completionHandler: { (sucess, error) -> Void in
            
            if error == nil{
                
                self.tableView.reloadData()
                
            }
            else{
                
                
                let alert = ParseErrorHandler.errorHandler((error?.code)!)
                
                self.presentViewController(alert, animated: true, completion: nil)
                
            }
        })

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        self.imagesDictionary.removeAll()
        
        // Dispose of any resources that can be recreated.
    }
    
    func choosePhoto()
    {
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: false, completion: nil)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
}

    
    
    
    override func viewWillAppear(animated: Bool) {
        let currentUser = PFUser.currentUser()
        if currentUser != nil{
            getUser()
            getNotification()
            configRefresh()
            configButton()
            
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            self.tableView.reloadData()
        }
        else{
            let vc : UIViewController = self.storyboard?.instantiateViewControllerWithIdentifier("vcMainLogin") as! UINavigationController
            self.presentViewController(vc, animated: true, completion: { () -> Void in
                
                self.tabBarController?.selectedIndex = 0
                
            })
            
        }
    }
    
    
    func configButton(){
        
        self.sairButton.addTarget(self, action: "sair:", forControlEvents: UIControlEvents.TouchUpInside)
        
    }
    
    func sair(sender: AnyObject){
        
        PFUser.logOut()
        self.tabBarController?.selectedIndex = 0
        
    }
    
    func getUser(){

        
        let user = PFUser.currentUser()
        
        let foto = user?.valueForKey("foto") as? PFFile
        
        let nome = user?.valueForKey("nome") as! String 
        
        self.usuario = Usuario(nome: nome, foto: foto)
        
        if foto == nil {
            
            self.usuario?.imagem = UIImage(named: "userIcon")!
            
        }
        else{
            foto!.getDataInBackgroundWithBlock { (data, error) -> Void in
            
                if error == nil {
                    
                    self.usuario?.imagem = UIImage(data: data!)!
                    self.tableView.reloadData()
                    
                }
                
            }
        }
        
    }
    
    func getNotification(){
        
        ParseModel.findAllNotifications { (array, error) -> Void in
            if error == nil{
                
                self.notificacoes = array!
                self.lastIndex = self.notificacoes.count
                self.tableView.reloadData()
                self.actInd.stopAnimating()
                
            }
            else{
                //deu ruim
            }
        }
    
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 2
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 1
        }
        else{
            
            return self.notificacoes.count
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0{
            
            return ("Perfil")
            
        }
        else{
            
            return ("Notificações")
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section != 0{
            
            self.actInd.startAnimating()
            
            let index = indexPath.row
            
            let perguntaId = self.notificacoes[index].para
            
            let query = PFQuery(className: "Question")

            query.includeKey("usuarioPergunta")
            
            query.getObjectInBackgroundWithId(perguntaId, block: { (object, error) -> Void in
                
                self.actInd.stopAnimating()
                
                if error == nil{
                    
                    let text = object!["textoPergunta"] as! String
                    
                    let titulo = object!["tituloPergunta"] as! String
                    
                    let tags = object!["tagsPergunta"] as! String
                    
                    let upvote = object!["upvotePergunta"] as! Int
                    
                    let comentarios = object!["comentariosPergunta"] as! Int
                    
                    let user = object!["usuarioPergunta"] as! PFUser
                    
                    let nick = user["nome"] as? String
                    
                    let icon = user["foto"] as? PFFile
                    
                    let id = perguntaId
                    
                    let date = object?.createdAt
                    
                    self.question = Question(nickname: nick , userIcon: icon, questionTitle: titulo, questionText: text, answers: nil, id: id, comentarios: comentarios, upvotes: upvote, tags: tags, user: user.objectId!,date: date! )
                    
                    
                    self.performSegueWithIdentifier("pergunta", sender: self)
                    
                }
                
            })
            
            
        }
        
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "pergunta"{
            
            let destination = segue.destinationViewController as! AnswerViewController
            
            destination.question = self.question
            
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("Perfil", forIndexPath: indexPath) as! userCell
            
            //cell.actInd.startAnimating()
            
            cell.userLabel.text = self.usuario?.nome
            
            cell.userLabel.textColor = UIColor.blackColor()
            
            cell.userImageButton.layer.cornerRadius = 24
            
            cell.userImageButton.layer.masksToBounds = true
            
            cell.userImageButton.tintColor = UIColor.clearColor()
            
            cell.userImageButton.setBackgroundImage(self.usuario?.imagem, forState: .Normal)
            
            cell.userImageButton.addTarget(self, action: "choosePhoto", forControlEvents: .TouchUpInside)
            
            cell.editarButton.addTarget(self, action: "choosePhoto", forControlEvents: .TouchUpInside)
            
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("Notificacao", forIndexPath: indexPath) as! notificacaoCell
            
            let data = self.notificacoes[indexPath.row ]
            
            cell.actInd.startAnimating()
            
            let texto = " respondeu a sua pergunta."
            
            let user = data.usuario
            
            cell.userImage.layer.masksToBounds = true
            
            cell.userImage.layer.cornerRadius = 24
            
            let file = String(data.imagem)
            
            if let image = self.imagesDictionary[file]{
                
                cell.userImage.image = image
                
            }
            else{
                
                if let file = data.imagem {
                    ParseModel.getImage(file, completionHandler: { (imagem, error, file) -> Void in
                        
                        if error == nil {
                            
                            let image = UIImage(data: imagem!)
                            let file = String(data.imagem)
                            cell.userImage.image = image
                            self.imagesDictionary[file] = image
                            
                        }
                        else{
                            
                            cell.userImage.image = UIImage(named: "userIcon")
                        }
                        
                    })
                    
                }
                else{
                    
                    cell.userImage.image = UIImage(named: "userIcon")
                    
                }
            }
            
            cell.notificationLabel.text = (user) + texto
            
            return cell
            
        }
        
    }
    
    
    
    func saveImage(image:UIImage, completionHandler:(sucess:Bool, error: NSError?) -> Void){
        
        let compressedImage = compressImage(image)
        
        let picture = PFFile(name: "image.png", data: compressedImage)
        
        PFUser.currentUser()!["foto"] = picture
        
        self.usuario?.imagem = UIImage(data: compressedImage)!
        
        PFUser.currentUser()!.saveInBackgroundWithBlock {
            (success: Bool, error: NSError?) -> Void in
            if (success) {
                completionHandler(sucess: true, error: nil)
            } else {
                completionHandler(sucess: false, error: error)
            }
        }
        
        
    }
    
    func compressImage(image:UIImage) -> NSData {
        // Reducing file size to a 10th
        
        var actualHeight : CGFloat = image.size.height
        var actualWidth : CGFloat = image.size.width
        let maxHeight : CGFloat = 1136.0
        let maxWidth : CGFloat = 640.0
        var imgRatio : CGFloat = actualWidth/actualHeight
        let maxRatio : CGFloat = maxWidth/maxHeight
        let compressionQuality : CGFloat = 0.5
        
        if (actualHeight > maxHeight || actualWidth > maxWidth){
            if(imgRatio < maxRatio){
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight;
                actualWidth = imgRatio * actualWidth;
                actualHeight = maxHeight;
            }
            else if(imgRatio > maxRatio){
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth;
                actualHeight = imgRatio * actualHeight;
                actualWidth = maxWidth;
            }
            else{
                actualHeight = maxHeight;
                actualWidth = maxWidth;
            }
        }
        
        let rect = CGRectMake(0.0, 0.0, actualWidth, actualHeight);
        UIGraphicsBeginImageContext(rect.size);
        image.drawInRect(rect)
        let img = UIGraphicsGetImageFromCurrentImageContext();
        let imageData = UIImageJPEGRepresentation(img, compressionQuality);
        UIGraphicsEndImageContext();
        
        return imageData!;
    }
    
    
    func configRefresh(){
        
        let refreshControl = UIRefreshControl()
        refreshControl.backgroundColor = bgColor
        refreshControl.tintColor = detailsColor
        refreshControl.addTarget(self, action: "refreshTableView:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
    }
    
    func refreshTableView(refreshControl: UIRefreshControl){
        
        getNotification()
        
        refreshControl.endRefreshing()
        
        self.tableView.reloadData()
    }
    
    
    //MARK: - Metodos para carregar mais
    
    let threshold: CGFloat = -10.0 // threshold from bottom of tableView
    var isLoadingMore = false // flag
    
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        if !isLoadingMore && (maximumOffset - contentOffset <= threshold) {
            self.isLoadingMore = true
            
            getMoreNotification()
        }
    }
    
    func getMoreNotification(){
        
//        self.activityIndicator.startAnimating() adicionar depois, nao quero mexer no storyboard
        
        ParseModel.findMoreNotification(self.notificacoes.count) { (array, error) -> Void in
            
            if error == nil {
                
                if let array = array {
                    
                    self.notificacoes = self.notificacoes + array
                    self.tableView.reloadData()
                    self.isLoadingMore = false
                    
                }
                
            }
            
//            self.activityIndicator.stopAnimating()
            
        }
        
    }
    
}



