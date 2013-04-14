class KKWelcomeNameViewController < KKWelcomeViewControllerBase

  def viewDidLoad
    super
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

    @label = UILabel.alloc.initWithFrame([[0, 0], [300, 32]])
    @label.text = "What's your name?"
    @label.numberOfLines = 0
    @label.textAlignment = UITextAlignmentCenter
    @label.font = UIFont.fontWithName("Marker Felt", size:24)    
    @label.backgroundColor = UIColor.clearColor
    @label.textColor = UIColor.whiteColor
    @label.center = [@text_field.center.x, @text_field.center.y - @label.size.height - 16]
    
    # add to container
    @upper_container.addSubview(@label)

    # Add view for the next button
    @next_container = self.buildNextButtonContainer
    
    self.view.addSubview @next_container

    @next_button = self.buildNextButton("Next")
    @next_button.center = CGPointMake(@next_container.bounds.size.width / 2, @next_container.bounds.size.height / 2)
    @next_button.addTarget(self, action: "nextTouched", forControlEvents: UIControlEventTouchUpInside)
    
    @next_container.addSubview @next_button
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

    PFUser.currentUser.setObject @text_field.text, forKey: "name"
    PFUser.currentUser.saveInBackground

    photo_controller = KKWelcomePhotoViewController.alloc.initWithStep(2)
    self.navigationController.pushViewController(photo_controller, animated: true)
  end

  def viewWillDisappear(animated)
    # Create observers for the keyboard show/hide
    App.notification_center.unobserve @keyboard_observer_visible
    App.notification_center.unobserve @keyboard_observer_hidden
  end

end