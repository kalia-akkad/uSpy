//
//  SwiftRecognitionViewController.swift
//  ClarifaiApiDemo
//

import UIKit

/**
 * This view controller performs recognition using the Clarifai API.
 */
class SwiftRecognitionViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // IMPORTANT NOTE: you should replace these keys with your own App ID and secret.
    // These can be obtained at https://developer.clarifai.com/applications
    static let appID = "vM05qo55uhZard2dL4BixmMm4WsHIl6CsGCTgS_7"
    static let appSecret = "rx4oPPiXiCWNRVcoJ0huLz02cKiQUZtq5JPVrhjM"
    
    // Custom Training (Alpha): to predict against a custom concept (instead of the standard
    // tag model), set this to be the name of the concept you wish to predict against. You must
    // have previously trained this concept using the same app ID and secret as above. For more
    // info on custom training, see https://github.com/Clarifai/hackathon
    static let conceptName: String? = nil
    static let conceptNamespace = "default"
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var tag1: UILabel!
    @IBOutlet weak var tag2: UILabel!
    @IBOutlet weak var tag3: UILabel!
    @IBOutlet weak var scoreF: UILabel!
    
    private lazy var client : ClarifaiClient = {
        let c = ClarifaiClient(appID: appID, appSecret: appSecret)
        // Uncomment this to request embeddings. Contact us to enable embeddings for your app:
        // c.enableEmbed = true
        return c
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.textView.hidden = true
        let url = NSURL(string: "https://www.wolframcloud.com/objects/d5484999-7deb-421c-a7a7-8b74bb382fc3?x=3")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url) { (data, response, error) -> Void in
            
            // Will happen when task completes
            
                let urlContent = data
                
                let webContent = NSString(data: urlContent!, encoding: NSUTF8StringEncoding)
                
                let stringwithoutquotes = webContent!.stringByReplacingOccurrencesOfString("\"", withString: "")
                
                let removeBracket1 = stringwithoutquotes.stringByReplacingOccurrencesOfString("{", withString: "")
                
                let removeBracket2 = removeBracket1.stringByReplacingOccurrencesOfString("}", withString: "")
                
                let removeSpace = removeBracket2.stringByReplacingOccurrencesOfString(" ", withString: "")

                let thisArray = removeSpace.characters.split{$0 == ","}.map(String.init)
                
                
                self.tag1.text = thisArray[0]
                self.tag2.text = thisArray[1]
                self.tag3.text = thisArray[2]
            
        }
        task.resume()
    }
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    @IBAction func buttonPressed(sender: UIButton) {
        // Show a UIImagePickerController to let the user pick an image from their library.
        let picker = UIImagePickerController()
        picker.sourceType = .PhotoLibrary
        picker.allowsEditing = false
        picker.delegate = self
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // The user picked an image. Send it Clarifai for recognition.
            imageView.image = image
            textView.text = "Recognizing..."
            button.enabled = false
            recognizeImage(image)
        }
    }
    
    private func recognizeImage(image: UIImage!) {
        // Scale down the image. This step is optional. However, sending large images over the
        // network is slow and does not significantly improve recognition performance.
        let size = CGSizeMake(320, 320 * image.size.height / image.size.width)
        UIGraphicsBeginImageContext(size)
        image.drawInRect(CGRectMake(0, 0, size.width, size.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Encode as a JPEG.
        let jpeg = UIImageJPEGRepresentation(scaledImage, 0.9)!
        
        if SwiftRecognitionViewController.conceptName == nil {
            // Standard Recognition: Send the JPEG to Clarifai for standard image tagging.
            client.recognizeJpegs([jpeg]) {
                (results: [ClarifaiResult]?, error: NSError?) in
                if error != nil {
                    print("Error: \(error)\n")
                    self.textView.text = "Sorry, there was an error recognizing your image."
                } else {
                    self.textView.text = results![0].tags.joinWithSeparator(",")
                    let tagStr = self.textView.text
                    let tagArr = tagStr.characters.split{$0 == ","}.map(String.init)
                    let score: String
                    var counter = 0
                    for score: String in tagArr {
                        if score == self.tag1.text {
                            counter = counter + 1
                        }
                        if score == self.tag2.text {
                            counter = counter + 1
                        }
                        if score == self.tag3.text {
                            counter = counter + 1
                        }
                    }
                    var finalScore = 0
                    if counter == 0 {
                        finalScore = 0
                    }else if counter == 1{
                        finalScore = 1
                    }else if counter == 2{
                        finalScore = 4
                    }else if counter == 3{
                        finalScore = 9
                    }
                    
                    self.scoreF.text = String(Int(self.scoreF.text!)! + finalScore)
                }
                self.textView.hidden = true
                self.button.enabled = true
            }
        } else {
            // Custom Training: Send the JPEG to Clarifai for prediction against a custom model.
            client.predictJpegs([jpeg], conceptNamespace: SwiftRecognitionViewController.conceptNamespace, conceptName: SwiftRecognitionViewController.conceptName) {
                (results: [ClarifaiPredictionResult]?, error: NSError?) in
                if error != nil {
                    print("Error: \(error)\n")
                    self.textView.text = "Sorry, there was an error running prediction on your image."
                } else {
                    self.textView.text = "Prediction score for \(SwiftRecognitionViewController.conceptName!):\n\(results![0].score)"
                }
                self.button.enabled = true
            }
        }
    }
}
