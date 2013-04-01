class WelcomeController < UIViewController
  def viewDidLoad
    super

    gradient = CAGradientLayer.layer
    gradient.frame = view.bounds
    
    gradient.colors = [
      UIColor.blackColor.CGColor, 
      UIColor.colorWithRed(70/255.0, green: 70/255.0, blue: 88/255.0, alpha:1.0).CGColor
    ]

    view.layer.addSublayer(gradient)

    @welcome_label = UILabel.alloc.initWithFrame(CGRectZero)
    @welcome_label.text = "Welcome to\nKarmaKing"
    @welcome_label.numberOfLines = 2
    @welcome_label.font = UIFont.fontWithName("Marker Felt", size:20)
    @welcome_label.sizeToFit
    @welcome_label.center = self.view.center
    @welcome_label.backgroundColor = UIColor.clearColor
    @welcome_label.textColor = UIColor.whiteColor
    
    self.view.addSubview @welcome_label

    @start_button = KKButton.alloc.init
    @start_button.frame = [[20, self.view.frame.size.height * 0.75], [280, 80]]
    @start_button.setTitle("Get Started", forState: UIControlStateNormal)

    @start_button.addTarget(self, action: "getStartedTouched", forControlEvents: UIControlEventTouchUpInside)
    
    self.view.addSubview @start_button
  end

  def getStartedTouched
    name_controller = WelcomeNameViewController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(name_controller, animated: true)
  end

end