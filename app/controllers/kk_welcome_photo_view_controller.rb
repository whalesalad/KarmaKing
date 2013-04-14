class KKWelcomePhotoViewController < KKWelcomeViewControllerBase

  def viewDidLoad
    super

    @photo_container = UIButton.buttonWithType(UIButtonTypeCustom)
    @photo_container.frame = [[0,0], [200, 200]]
    @photo_container.center = [self.view.center.x, self.view.center.y - 20]
    @photo_container.backgroundColor = UIColor.colorWithWhite(0.2, alpha:1)
    @photo_container.layer.cornerRadius = 10
    @photo_container.layer.borderWidth = 1;
    @photo_container.layer.borderColor = UIColor.blackColor.CGColor;
    @photo_container.clipsToBounds = true
    self.view.addSubview(@photo_container)

    @label = UILabel.alloc.initWithFrame([[0, 0], [300, 32]])
    @label.text = "What do you look like?"
    @label.numberOfLines = 0
    @label.textAlignment = UITextAlignmentCenter
    @label.font = UIFont.fontWithName("Marker Felt", size:24)    
    @label.backgroundColor = UIColor.clearColor
    @label.textColor = UIColor.whiteColor
    @label.center = [self.view.center.x.floor, @photo_container.origin.y.floor - 24]
    self.view.addSubview(@label)

    @photo_container.when UIControlEventTouchUpInside do
      if BW::Device.camera.front?
        self.showPhotoActionSheet
      else
        self.choosePhotoTouched
      end
    end

    # Add view for the next button
    @next_container = self.buildNextButtonContainer
    self.view.addSubview(@next_container)

    @next_container.hidden = true

    @next_button = self.buildNextButton("Finish!")
    @next_button.center = CGPointMake(@next_container.bounds.size.width / 2, @next_container.bounds.size.height / 2)
    @next_button.addTarget(self, action:"finishTouched", forControlEvents:UIControlEventTouchUpInside)
    
    @next_container.addSubview(@next_button)
  end

  def showNextButton
    @next_container.hidden = false
  end

  def showPhotoActionSheet
    photo_sheet = UIActionSheet.alloc.initWithTitle(nil, delegate:self, cancelButtonTitle:"Cancel", destructiveButtonTitle:nil, otherButtonTitles:"Choose from Library","Take a Photo",nil)
    photo_sheet.showInView(self.view)
  end

  def actionSheet(actionSheet, didDismissWithButtonIndex:button_index)
    puts "A button was tapped, #{button_index}"
    
    case button_index
    when 0
      puts "Choose from Library"
      self.choosePhotoTouched
    when 1
      puts "Take a Photo"
      self.takePhotoTouched
    when 2
      puts "Cancel"
    end
  end

  def takePhotoTouched
    controller = UIImagePickerController.alloc.init
    controller.sourceType = UIImagePickerControllerSourceTypeCamera

    controller.mediaTypes = [KUTTypeImage]
    controller.allowsEditing = true
    controller.delegate = self

    self.navigationController.presentModalViewController(controller, animated:true)
    # BW::Device.camera.front.picture(media_types: [:image]) do |result|
    #   image_view = UIImageView.alloc.initWithImage(result[:original_image])
    # end
  end

  def choosePhotoTouched
    BW::Device.camera.any.picture(media_types:[:image], allows_editing:true) do |result|
      setUserImage(result)
    end
  end

  def setUserImage(result)
    puts "Setting user image."
    puts result

    @the_image = if result.has_key?(:edited_image)
      result[:edited_image]
    else
      result[:original_image]
    end

    image_view = UIImageView.alloc.initWithImage(@the_image)
    image_view.layer.cornerRadius = 11

    @photo_container.subviews.each { |v| v.removeFromSuperview }

    @photo_container.addSubview image_view

    # Set frame of the photo to the container bounds, so it's 200x200
    image_view.frame = @photo_container.bounds

    self.showNextButton
  end

  def finishTouched
    image_data = UIImagePNGRepresentation(@the_image)
    image_file = PFFile.fileWithName("image.png", data:image_data)
    image_file.saveInBackground
    
    current_user = PFUser.currentUser
    current_user.setObject(image_file, forKey:"photo")

    # Set onboarding to complete, since welcome tour is done
    current_user.setObject(true, forKey:"onboardingComplete")

    # Save user
    current_user.saveInBackground

    home = KKHomeViewController.alloc.initWithNibName(nil, bundle: nil)
    self.navigationController.pushViewController(home, animated: true)
  end

end