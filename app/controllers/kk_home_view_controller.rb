class KKHomeViewController < KKViewController
  def viewDidLoad
    super
    @current_user = PFUser.currentUser

    @user_bar = KKUserBar.alloc.initWithUser(@current_user, andFrame:[[0, 0], [320, 80]])
    self.view.addSubview(@user_bar)    
  end

end