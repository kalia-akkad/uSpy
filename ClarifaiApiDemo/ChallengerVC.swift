//
//  ChallengerVC.swift
//  ClarifaiApiDemo
//
//  Created by Kalia Akkad on 2015-11-14.
//  Copyright © 2015 Clarifai, Inc. All rights reserved.
//

import UIKit
//import MobileCoreServices
/*
import AVFoundation
import CoreMedia

let CMYKHalftone = "CMYK Halftone"
let CMYKHalftoneFilter = CIFilter(name: "CICMYKHalftone", withInputParameters: ["inputWidth" : 20, "inputSharpness": 1])

let ComicEffect = "Comic Effect"
let ComicEffectFilter = CIFilter(name: "CIComicEffect")

let Crystallize = "Crystallize"
let CrystallizeFilter = CIFilter(name: "CICrystallize", withInputParameters: ["inputRadius" : 30])

let Edges = "Edges"
let EdgesEffectFilter = CIFilter(name: "CIEdges", withInputParameters: ["inputIntensity" : 10])

let HexagonalPixellate = "Hex Pixellate"
let HexagonalPixellateFilter = CIFilter(name: "CIHexagonalPixellate", withInputParameters: ["inputScale" : 40])

let Invert = "Invert"
let InvertFilter = CIFilter(name: "CIColorInvert")

let Pointillize = "Pointillize"
let PointillizeFilter = CIFilter(name: "CIPointillize", withInputParameters: ["inputRadius" : 30])

let LineOverlay = "Line Overlay"
let LineOverlayFilter = CIFilter(name: "CILineOverlay")

let Posterize = "Posterize"
let PosterizeFilter = CIFilter(name: "CIColorPosterize", withInputParameters: ["inputLevels" : 5])

let Filters = [
    CMYKHalftone: CMYKHalftoneFilter,
    ComicEffect: ComicEffectFilter,
    Crystallize: CrystallizeFilter,
    Edges: EdgesEffectFilter,
    HexagonalPixellate: HexagonalPixellateFilter,
    Invert: InvertFilter,
    Pointillize: PointillizeFilter,
    LineOverlay: LineOverlayFilter,
    Posterize: PosterizeFilter
]

let FilterNames = [String](Filters.keys).sort()

*/
class ChallengerVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    @IBOutlet weak var tag1: UILabel!
   
    @IBOutlet weak var tag2: UILabel!
    
    /*
    @IBOutlet weak var cameraImageView: UIImageView!
    
    @IBOutlet weak var previewView: UIView!
    
    @IBAction func cameraViewTapped(sender: AnyObject) {
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let url = NSURL(string: "https://www.wolframcloud.com/objects/d5484999-7deb-421c-a7a7-8b74bb382fc3?x=2")!
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // Will happen when task completes
            
            if let urlContent = data {
                
                let webContent = NSString(data: urlContent, encoding: NSUTF8StringEncoding)
                
                let stringwithoutquotes = webContent!.stringByReplacingOccurrencesOfString("\"", withString: "")
                
                let removeBracket1 = stringwithoutquotes.stringByReplacingOccurrencesOfString("{", withString: "")
                
                let removeBracket2 = removeBracket1.stringByReplacingOccurrencesOfString("}", withString: "")
                
                let removeSpace = removeBracket2.stringByReplacingOccurrencesOfString(" ", withString: "")
                
                print (removeSpace)
                
                let thisArray = removeSpace.characters.split{$0 == ","}.map(String.init)
                
                
                self.tag1.text = thisArray[0]
                self.tag2.text = thisArray[1]
                
            } else {
                
                // Show error message
                
            }
            
            
        }
        task.resume()
        
    }
    

    /*
    @IBAction func takePicture(sender: AnyObject) {
       
        if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)){
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.mediaTypes = [String(kUTTypeImage)]
            picker.allowsEditing = true
            self.presentViewController(picker, animated: true, completion: nil)
        }
        else{
            NSLog("No Camera.")
        }
        
    }
    */
    /*
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: NSDictionary!) {
        NSLog("Received image from camera")
        let mediaType = info[UIImagePickerControllerMediaType] as String
        var originalImage:UIImage?, editedImage:UIImage?, imageToSave:UIImage?
        let compResult:CFComparisonResult = CFStringCompare(mediaType as NSString!, kUTTypeImage, CFStringCompareFlags.CompareCaseInsensitive)
        if ( compResult == CFComparisonResult.CompareEqualTo ) {
            
            editedImage = info[UIImagePickerControllerEditedImage] as UIImage?
            originalImage = info[UIImagePickerControllerOriginalImage] as UIImage?
            
            if ( editedImage != nil ) {
                imageToSave = editedImage
            } else {
                imageToSave = originalImage
            }
            imgView.image = imageToSave
            imgView.reloadInputViews()
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
