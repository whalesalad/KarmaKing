class WelcomeNameViewController < UIViewController

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
    @current_step.text = "Step 1 of 2"
    @current_step.numberOfLines = 0
    @current_step.font = UIFont.fontWithName("Marker Felt", size:20)
    @current_step.sizeToFit
    @current_step.textColor = UIColor.colorWithWhite(1, alpha:0.3)
    @current_step.backgroundColor = UIColor.clearColor
    @current_step.center = [self.view.center.x, 30]

    self.view.addSubview(@current_step)

    @upper_container = UIView.alloc.initWithFrame([[0,0], [300, 170]])
    @upper_container.center = [self.view.center.x, self.view.center.y]

    # add container view
    self.view.addSubview @upper_container

    @text_field = UITextField.alloc.initWithFrame [[0, 0], [240, 40]]
    @text_field.textAlignment = UITextAlignmentCenter
    @text_field.setContentVerticalAlignment(UIControlContentVerticalAlignmentCenter)
    @text_field.autocapitalizationType = UITextAutocapitalizationTypeWords
    @text_field.borderStyle = UITextBorderStyleRoundedRect

    # Set the text to the user's current name
    @text_field.text = App::Persistence['user_name']

    @upper_container.addSubview(@text_field)

    @text_field.center = CGPointMake(@upper_container.size.width/2, @upper_container.size.height/2 - @text_field.size.height/2)

    # @text_field.becomeFirstResponder
    @text_field.setReturnKeyType(UIReturnKeyDone)
    @text_field.delegate = self;

    # Create observers for the keyboard show/hide
    @keyboard_observer_visible = App.notification_center.addObserver(self, selector:'handleKeyboardVisible:', name:UIKeyboardDidShowNotification, object:nil)
    @keyboard_observer_hidden = App.notification_center.addObserver(self, selector:'handleKeyboardHidden:', name:UIKeyboardWillHideNotification, object:nil)

    @name_label = UILabel.alloc.initWithFrame(CGRectZero)
    @name_label.text = "What's your name?"
    @name_label.numberOfLines = 0
    @name_label.font = UIFont.fontWithName("Marker Felt", size:20)
    @name_label.sizeToFit
    
    # Position label above the text field
    @name_label.center = [@text_field.center.x, @text_field.center.y - @name_label.size.height - 16]

    @name_label.backgroundColor = UIColor.clearColor
    @name_label.textColor = UIColor.whiteColor
    
    # add to container
    @upper_container.addSubview @name_label

    # Add view for the next button
    @next_container = self.buildNextButtonContainer
    
    self.view.addSubview @next_container

    @next_button = self.buildNextButton("Next")
    @next_button.center = CGPointMake(@next_container.bounds.size.width / 2, @next_container.bounds.size.height / 2)
    @next_button.addTarget(self, action: "nextTouched", forControlEvents: UIControlEventTouchUpInside)
    
    @next_container.addSubview @next_button
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

  def keyboardSizeFromNotification(notification)
    notification.userInfo['UIKeyboardFrameBeginUserInfoKey'].CGRectValue.size
  end

  def handleKeyboardVisible(notification)
    keyboard_size = keyboardSizeFromNotification(notification)

    @old_center = @upper_container.center
    
    UIView.animateWithDuration(0.2,
      animations: lambda {
        @upper_container.center = CGPointMake(@upper_container.center.x, @upper_container.center.y - keyboard_size.height / 2)    
      },
      completion: lambda { |finished|
        # 
      }
    )
  end

  def handleKeyboardHidden(notification)
    UIView.animateWithDuration(0.2,
      animations: lambda {
        @upper_container.center = @old_center
      },
      completion: lambda { |finished|
        # 
      }
    )
  end

  def textFieldShouldReturn textField
    textField.resignFirstResponder
    true
  end

  def nextTouched
    App::Persistence['user_name'] = @text_field.text

    photo_controller = WelcomePhotoViewController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(photo_controller, animated: true)

    # puts "NEXT!!!!! Name: #{@text_field.text}"
  end

  def viewWillDisappear(animated)
    # Create observers for the keyboard show/hide
    App.notification_center.unobserve @keyboard_observer_visible
    App.notification_center.unobserve @keyboard_observer_hidden
  end

end