class KKWelcomeViewController < KKViewController
  
  def viewDidLoad
    super
    
    @welcome_label = UILabel.alloc.initWithFrame(CGRectZero)
    @welcome_label.text = "Welcome to\nKarmaKing"
    @welcome_label.numberOfLines = 2
    @welcome_label.font = UIFont.fontWithName("Marker Felt", size:24)
    @welcome_label.sizeToFit
    @welcome_label.center = self.view.center
    @welcome_label.backgroundColor = UIColor.clearColor
    @welcome_label.textColor = UIColor.whiteColor
    
    self.view.addSubview(@welcome_label)

    @start_button = KKButton.alloc.init
    @start_button.frame = [[20, self.view.frame.size.height * 0.75], [280, 80]]
    @start_button.setTitle("Get Started", forState: UIControlStateNormal)

    @start_button.addTarget(self, action: "getStartedTouched", forControlEvents: UIControlEventTouchUpInside)
    
    self.view.addSubview(@start_button)
  end

  def getStartedTouched
    name_controller = KKWelcomeNameViewController.alloc.initWithStep(1)
    self.navigationController.pushViewController(name_controller, animated: true)
  end

end