

import UIKit

func lend<T where T:NSObject> (closure:(T)->()) -> T {
    let orig = T()
    closure(orig)
    return orig
}

extension CGRect {
    init(_ x:CGFloat, _ y:CGFloat, _ w:CGFloat, _ h:CGFloat) {
        self.init(x:x, y:y, width:w, height:h)
    }
}
extension CGSize {
    init(_ width:CGFloat, _ height:CGFloat) {
        self.init(width:width, height:height)
    }
}
extension CGPoint {
    init(_ x:CGFloat, _ y:CGFloat) {
        self.init(x:x, y:y)
    }
}
extension CGVector {
    init (_ dx:CGFloat, _ dy:CGFloat) {
        self.init(dx:dx, dy:dy)
    }
}



class ViewController: UIViewController {
    
    @IBOutlet var tv : UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.pathForResource("brillig", ofType: "txt")!
        let s = try! String(contentsOfFile:path, encoding: .utf8)
        let s2 = s.replacingOccurrences(of:"\n", with: "")
        let mas = NSMutableAttributedString(string:s2, attributes:[
            NSFontAttributeName: UIFont(name:"GillSans", size:14)!
            ])
        
        mas.addAttribute(NSParagraphStyleAttributeName,
            value:lend(){
                (para:NSMutableParagraphStyle) in
                para.alignment = .left
                para.lineBreakMode = .byWordWrapping
                para.hyphenationFactor = 1
            },
            range:NSMakeRange(0,1))
        
        self.tv.attributedText = mas
        
        self.tv.textContainerInset = UIEdgeInsetsMake(20, 20, 20, 0)
        self.tv.isScrollEnabled = false

    }
    
    override func viewDidLayoutSubviews() {
        let sz = self.tv.textContainer.size
        let p = UIBezierPath()
        p.move(to: CGPoint(sz.width/4.0,0))
        p.addLine(to: CGPoint(sz.width,0))
        p.addLine(to: CGPoint(sz.width,sz.height))
        p.addLine(to: CGPoint(sz.width/4.0,sz.height))
        p.addLine(to: CGPoint(sz.width,sz.height/2.0))
        p.close()
        self.tv.textContainer.exclusionPaths = [p]
    }
}
