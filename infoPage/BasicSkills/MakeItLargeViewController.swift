
import UIKit

class MakeItLargeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate
{
    var tempArr = [String]()

    @IBOutlet weak var MilScrollView: UIScrollView!
    
    @IBOutlet var textCellView: UIView!
    @IBOutlet weak var popUpTextView: UITextView!
    
    var sections =
    [
        MilSection(mainSkill: "Dribbling", skillData: ["Closed-Space dribbling Drill","Cone Drill","Step Over move","Rainbow Move"],
                expanded: false),
        
        MilSection(mainSkill: "Juggling", skillData: ["Alternating Feet","Shoulder Juggle","Alternating Thighs"],
                   expanded: false),
        
        MilSection(mainSkill: "Passing", skillData: ["Push Pass","Long Pass","Backward Pass","Piercing Pass","Wall Pass"],
                expanded: false),
        
        MilSection(mainSkill: "Shooting", skillData: ["Standard Shot","Straight Shot","Chip Shot","Inside Shot","Bending Shot","Outside Shot","Toe Shot"],
                   expanded: false),
        
        MilSection(mainSkill: "Receiving", skillData: ["Tips to receive the ball"],
        expanded: false)
     
    ]
    
     var tipsCellText = [String]()
    
    
    @IBOutlet weak var MilTableView: UITableView!
    
    var scrollImageArray = [UIImage(named: "1"),UIImage(named: "2"),UIImage(named: "3"),UIImage(named: "4"),UIImage(named: "5"),UIImage(named: "6"),UIImage(named: "7"),UIImage(named: "8"),UIImage(named: "9"),UIImage(named: "10"),UIImage(named: "11")]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return scrollImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "scrollCell", for: indexPath) as! ScrollImageCollectionViewCell
        
        cell.ScrollImg.image = scrollImageArray[indexPath.row]
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
            return sections[section].skillData.count
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {
        return sections.count
    }
    

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {
        return 45
    }

    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if (sections[indexPath.section].expanded)
        {
            return 45
        }
        
        else
        {
            return 0
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {
        return 3
    }
    

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
            let header = ExpandableHeaderView()
            header.customInit(title: sections[section].mainSkill, section: section, delegate: self)
            return header
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {

           let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as! UITableViewCell
            
            cell.textLabel?.text = sections[indexPath.section].skillData[indexPath.row]
        
            cell.textLabel?.textColor = UIColor.white
        
        return cell
        
    }
    
    
    func toggleSection(header: ExpandableHeaderView, section: Int)
    {
        sections[section].expanded = !sections[section].expanded
        
        MilTableView.beginUpdates()
        
        for i in 0 ..< sections[section].skillData.count
        {
            MilTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
            
        }
        MilTableView.endUpdates()
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
            let Xcell = tableView.cellForRow(at: indexPath)
            print(Xcell?.textLabel?.text ?? "nil")
            
            animateIn(textString: Xcell?.textLabel?.text ?? "Nil")

    }
    
    
    func animateIn( textString: String)
    {
        self.view.addSubview(textCellView)
        textCellView.center = self.view.center
        
        textCellView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        textCellView.alpha = 0
        popUpTextView.text = textString
        UIView.animate(withDuration: 0.4)
        {
            self.textCellView.alpha = 1
            self.textCellView.transform = CGAffineTransform.identity
        }
        
    }
    
    
    func animateOut()
    {
        popUpTextView.text = nil
        UIView.animate(withDuration: 0.3, animations:
            {
                self.textCellView.transform  = CGAffineTransform(scaleX: 1.3, y: 1.3)
                //self.visualEffectView.effect = nil
        })
        {
            (success:Bool) in
            self.textCellView.removeFromSuperview()
        }
    }
    
    
    @IBAction func cellBack(_ sender: Any)
    {
        animateOut()
    }
    
    @IBAction func downScrollButton(_ sender: Any)
    {
        MilScrollView.setContentOffset(CGPoint(x : 0, y: 650), animated: true)
    }
    
    
    @IBAction func tipsDown(_ sender: Any)
    {
        MilScrollView.setContentOffset(CGPoint(x : 0, y: 1295), animated: true)
    }
    
}
