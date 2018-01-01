//
//  ImageStore.swift
//  Homepwner
//
//  Created by EasonChan on 12/31/17.
//  Copyright © 2017 Eason Chan. All rights reserved.
//

import UIKit

class ImageStore{
    let cache = NSCache<AnyObject, AnyObject>()

    func imageURLForKey(key:String) -> NSURL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        
        return documentDirectory.appendingPathComponent(key) as NSURL
    }
    func setImage(image: UIImage, forKey key: String){
        cache.setObject(image,forKey:key as AnyObject)
        
        //create full URL for image
        let imageURL = imageURLForKey(key: key)
        
        if let data = UIImageJPEGRepresentation(image, 0.5){
        //if let data = UIImagePNGRepresentation(image){ //bronze challenge
            //write it to full URL
            do{
                try data.write(to: imageURL as URL, options: .atomic )
            }
            catch{
                print("Error setting the image form disk \(error)")
            }
        }
    }
    
    func imageForKey(key:String) -> UIImage?{
        //return cache.object(forKey: key as AnyObject) as? UIImage
        if let existingImage = cache.object(forKey: key as AnyObject) as? UIImage {
            return existingImage
        }
        let imageURL = imageURLForKey(key: key)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else{
            return nil
        }
        
        cache.setObject(imageFromDisk, forKey: key as AnyObject)
        return imageFromDisk
    }

    func deleteImageForKey(key:String){
        cache.removeObject(forKey: key as AnyObject)
        
        let imageURL = imageURLForKey(key: key)
        do{
            try FileManager.default.removeItem(at: imageURL as URL)
        }
        catch let deleteError{
            print("Error removing the image from disk \(deleteError)")
        }
    }
}
