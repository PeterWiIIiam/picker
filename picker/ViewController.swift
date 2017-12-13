//
//  ViewController.swift
//  picker
//
//  Created by 何幸宇 on 12/12/17.
//  Copyright © 2017 X. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var image_view : UIImageView!
    var share_btn : UIButton!
    var safari_btn : UIButton!
    var photo_btn : UIButton!
    var date_pick : UIDatePicker!
    var date_pick_btn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    func updateUI() {
        image_view = UIImageView(frame: CGRect(x: 0, y: 0, width: 420, height: 500))
        image_view.backgroundColor = UIColor(named: "green")
        image_view.layer.borderWidth = 5
        image_view.layer.borderColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        image_view.image = (#imageLiteral(resourceName: "20171118_223730"))
        
        
        share_btn = UIButton(frame: CGRect(x: 0, y: 500, width: 100, height: 50))
        share_btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        share_btn.setTitle("share", for: .normal)
        share_btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        share_btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        share_btn.layer.borderWidth = 3
        share_btn.layer.cornerRadius = 5
        share_btn.addTarget(self, action: #selector(share), for: .touchUpInside)
        
        safari_btn = UIButton(frame: CGRect(x: 100, y: 500, width: 100, height: 50))
        safari_btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        safari_btn.setTitle("safari", for: .normal)
        safari_btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        safari_btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        safari_btn.layer.borderWidth = 3
        safari_btn.layer.cornerRadius = 5
        safari_btn.addTarget(self, action: #selector(safari), for: .touchUpInside)
        
        photo_btn = UIButton(frame: CGRect(x: 200, y: 500, width: 100, height: 50))
        photo_btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        photo_btn.setTitle("photo", for: .normal)
        photo_btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        photo_btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        photo_btn.layer.borderWidth = 3
        photo_btn.layer.cornerRadius = 5
        photo_btn.addTarget(self, action: #selector(photo), for: .touchUpInside)

        date_pick = UIDatePicker(frame: CGRect(x: 0, y: 600, width: view.bounds.width, height: 100))
        date_pick.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        date_pick.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        date_pick.layer.borderWidth = 3
        date_pick.layer.cornerRadius = 5
        date_pick.timeZone = NSTimeZone.local
        date_pick.addTarget(self, action: #selector(date_picker), for: .valueChanged)
        
        date_pick_btn = UIButton(frame: CGRect(x: 0, y: 550, width: view.bounds.width, height: 50))
        date_pick_btn.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        date_pick_btn.setTitle("pick a date", for: .normal)
        date_pick_btn.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        date_pick_btn.layer.borderColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        date_pick_btn.layer.borderWidth = 3
        date_pick_btn.layer.cornerRadius = 5
        date_pick_btn.addTarget(self, action: #selector(show_date_picker), for: .touchUpInside)
        
        view.addSubview(image_view)
        view.addSubview(share_btn)
        view.addSubview(safari_btn)
        view.addSubview(photo_btn)
        view.addSubview(date_pick)
        view.addSubview(date_pick_btn)
        
    }
    
    @objc func share() {
        guard let image = image_view.image else {return}
        let activity_controller = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activity_controller.popoverPresentationController?.sourceView = share_btn
        
        present(activity_controller, animated: true, completion: nil)
        print("present")
    }
    
    @objc func safari(){
        let url = URL(string: "http://www.apple.com")
        let safari_vc = SFSafariViewController(url: url!)
        
        present(safari_vc, animated: true, completion: nil)
    }
    @objc func photo(){
        
        let aletController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        let cancel_action = UIAlertAction(title: "Cancel", style: .default) { (action) in
            aletController.dismiss(animated: true, completion: nil)
        }
        aletController.addAction(cancel_action)
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let camera_action = UIAlertAction(title: "Camera", style: .default, handler: { (action) in
                imagePicker.sourceType = .camera
                self.present(imagePicker, animated: true, completion: nil)
            })
            aletController.addAction(camera_action)
        }
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let photo_action = UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
                imagePicker.sourceType = .photoLibrary
                self.present(imagePicker, animated: true, completion: nil)
            })
            aletController.addAction(photo_action)
        }
        present(aletController, animated: true, completion: nil)
    }
    @objc func date_picker(){
        
        let date_formatter = DateFormatter()
        date_formatter.dateFormat = "MM/dd/yyyy hh:mm a"
        
        let selected_date = date_formatter.string(from: date_pick.date)
        print(selected_date)
        
    }
    
    @objc func show_date_picker(){
        
        if self.date_pick.isHidden == false{
            self.date_pick.isHidden = true
        }else{
            self.date_pick.isHidden = false
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        image_view.image = (info[UIImagePickerControllerOriginalImage] as! UIImage)
        picker.dismiss(animated: true, completion: nil)
    }
}

