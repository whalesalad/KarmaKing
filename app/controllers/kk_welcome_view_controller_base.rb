class KKWelcomeViewControllerBase < UIViewController
  attr_accessor :step

  def initWithStep(step)
    initWithNibName(nil, bundle:nil)
    self.step = step
    self
  end

  def viewDidLoad
    super
    self.applyBackground()
    self.addStepLabel()
  end

  def applyBackground
    gradient = CAGradientLayer.layer
    gradient.frame = view.bounds
    gradient.colors = [
      UIColor.blackColor.CGColor, 
      UIColor.colorWithRed(70/255.0, green: 70/255.0, blue: 88/255.0, alpha:1.0).CGColor
    ]
    view.layer.addSublayer(gradient)
  end

  def addStepLabel
    @current_step = UILabel.alloc.initWithFrame([[0, 0], [300, 30]])
    @current_step.text = "Step #{self.step} of 2"
    @current_step.numberOfLines = 0
    @current_step.font = UIFont.fontWithName("Marker Felt", size:20)
    @current_step.textAlignment = UITextAlignmentCenter
    @current_step.textColor = UIColor.colorWithWhite(1, alpha:0.4)
    @current_step.backgroundColor = UIColor.clearColor
    @current_step.center = [self.view.center.x, 30]
    self.view.addSubview(@current_step)
  end

  def buildNextButtonContainer
    next_container = UIView.alloc.initWithFrame([[0, self.view.size.height - 90], [self.view.size.width, 90]])

    gradient = CAGradientLayer.layer
    gradient.frame = next_container.bounds
    
    gradient.colors = [
      UIColor.colorWithWhite(0, alpha:0.3).CGColor,
      UIColor.clearColor.CGColor
    ]

    next_container.layer.addSublayer(gradient)

    return next_container
  end

  def buildNextButton(title)
    button = KKButton.alloc.init
    button.frame = [[0, 0], [280, 50]]
    button.setTitle(title, forState: UIControlStateNormal)
    return button
  end

  def buildBlueButton(title)
    button = KKBlueButton.alloc.init
    button.frame = [[0, 0], [260, 40]]
    button.setTitle(title, forState: UIControlStateNormal)
    return button
  end

end