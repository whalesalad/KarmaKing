class KKUserBar < UIView
  attr_accessor :user

  def initWithUser(user, andFrame:frame)
    self.user = user
    self.initWithFrame(frame)
    self
  end

  def initWithFrame(frame)
    super
    self.clipsToBounds = false

    self.applyShadow()
    self.applyBackground()

    @image_view = UIImageView.alloc.initWithFrame([[15, 15], [50, 50]])
    @image_view.contentMode = UIViewContentModeScaleAspectFit
    @image_view.layer.cornerRadius = 5
    @image_view.backgroundColor = UIColor.colorWithWhite(0.2, alpha:1)
    @image_view.layer.borderWidth = 1;
    @image_view.layer.borderColor = UIColor.blackColor.CGColor;
    @image_view.clipsToBounds = true

    self.addSubview(@image_view)

    user_photo = user.objectForKey "photo"

    user_photo.getDataInBackgroundWithBlock(lambda do |data, error|
      if error
        puts "Error fetching user photo."
      else
        image = UIImage.imageWithData(data)
        @image_view.setImage(image)
        @image_view.setNeedsDisplay
      end
    end)

    # Get user name, add as label
    @user_name = self.upperLabelWithText(self.user.objectForKey("name"), andFrame:[[80, 13], [200, 30]])
    @user_name.font = UIFont.fontWithName("HelveticaNeue-Bold", size:18)
    self.addSubview(@user_name)

    # Get user karma, add as label
    @user_karma = self.upperLabelWithText("300 Karma", andFrame:[[80, 35], [200, 30]])
    @user_karma.font = UIFont.fontWithName("HelveticaNeue", size:18)
    self.addSubview(@user_karma)

    # Display settings button
    # XXX TODO
  end

  def upperLabelWithText(text, andFrame:frame)
    label = UILabel.alloc.initWithFrame(frame || [[0, 0], [200, 30]])
    label.text = text
    label.numberOfLines = 0
    label.backgroundColor = UIColor.clearColor
    label.textColor = UIColor.whiteColor
    
    # Shadow
    label.shadowColor = UIColor.colorWithWhite(0, alpha:0.2)
    label.shadowOffset = CGSizeMake(0, 1)
    label
  end

  def applyBackground
    gradient = CAGradientLayer.layer
    gradient.frame = self.bounds
    gradient.colors = [
      UIColor.colorWithRed(1.000, green:0.761, blue:0.000, alpha:1.000).CGColor,
      UIColor.colorWithRed(1.000, green:0.502, blue:0.000, alpha:1.000).CGColor
    ]
    self.layer.addSublayer(gradient)
  end

  def applyShadow
    layer.shadowOffset = CGSizeMake(0, 2)
    layer.shadowColor = UIColor.blackColor.CGColor
    layer.shadowRadius = 5
    layer.shadowOpacity = 0.5
  end

end