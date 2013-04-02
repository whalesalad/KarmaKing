class WelcomePhotoViewController < UIViewController

  def viewDidLoad
    super

    background_gradient = CAGradientLayer.layer
    background_gradient.frame = view.bounds
    
    background_gradient.colors = [
      UIColor.blackColor.CGColor, 
      UIColor.colorWithRed(70/255.0, green: 70/255.0, blue: 88/255.0, alpha:1.0).CGColor
    ]

    self.view.layer.addSublayer(background_gradient)

    @current_step = UILabel.alloc.initWithFrame(CGRectZero)
    @current_step.text = "Step 2 of 2"
    @current_step.numberOfLines = 0
    @current_step.font = UIFont.fontWithName("Marker Felt", size:20)
    @current_step.sizeToFit
    @current_step.textColor = UIColor.colorWithWhite(1, alpha:0.3)
    @current_step.backgroundColor = UIColor.clearColor
    @current_step.center = [self.view.center.x, 30]

    self.view.addSubview(@current_step)

    @photo_container = UIView.alloc.initWithFrame([[0,0], [200, 200]])
    @photo_container.center = [self.view.center.x, self.view.center.y - 20]
    @photo_container.backgroundColor = UIColor.colorWithWhite(0.2, alpha:1)
    @photo_container.layer.cornerRadius = 10
    @photo_container.layer.borderWidth = 1;
    @photo_container.layer.borderColor = UIColor.blackColor.CGColor;
    @photo_container.clipsToBounds = true

    # add container view
    self.view.addSubview(@photo_container)

    @name_label = UILabel.alloc.initWithFrame([[0, 0], [300, 32]])
    @name_label.text = "What do you look like?"
    @name_label.numberOfLines = 0
    @name_label.textAlignment = UITextAlignmentCenter
    @name_label.font = UIFont.fontWithName("Marker Felt", size:24)    
    @name_label.backgroundColor = UIColor.clearColor
    @name_label.textColor = UIColor.whiteColor
    
    # add to container
    self.view.addSubview(@name_label)

    @name_label.center = [self.view.center.x.floor, @photo_container.origin.y.floor - 24]

    # KKBlueButton
    @take_photo_button = self.buildBlueButton('Take a Photo')
    @choose_photo_button = self.buildBlueButton('Choose from Camera Roll')

    @take_photo_button.center = [self.view.center.x.floor, @photo_container.origin.y + @photo_container.size.height + 30]
    self.view.addSubview(@take_photo_button)

    @choose_photo_button.center = [@take_photo_button.center.x, @take_photo_button.center.y + @take_photo_button.size.height + 10]
    self.view.addSubview(@choose_photo_button)

    # # Add view for the next button
    # @next_container = self.buildNextButtonContainer
    
    # self.view.addSubview @next_container

    # @next_button = self.buildNextButton("Next")
    # @next_button.center = CGPointMake(@next_container.bounds.size.width / 2, @next_container.bounds.size.height / 2)
    # @next_button.addTarget(self, action: "nextTouched", forControlEvents: UIControlEventTouchUpInside)
    
    # @next_container.addSubview @next_button
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

  def nextTouched
    App::Persistence['user_name'] = @text_field.text
    # puts "NEXT!!!!! Name: #{@text_field.text}"
  end

end