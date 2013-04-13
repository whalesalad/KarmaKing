class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @window.makeKeyAndVisible

    Parse.setApplicationId("EUrTZ8F8j53ankiunZgLBfuNjmmApgcf0hu3k5ax", 
      clientKey:"oN6d9KEJT9ppKSgtfKEhpnzOvAGzT6rPpMpsjlm6")

    current_user = PFUser.currentUser

    if current_user
      puts current_user.objectForKey "name"
      current_user.incrementKey("runCount")
    else
      puts "No user found, enabling auto user."
      PFUser.enableAutomaticUser
    end

    finished_onboarding = !!current_user.objectForKey("onboardingComplete")
    # finished_onboarding = true

    _root = (finished_onboarding) ? HomeViewController : WelcomeViewController
    @root_controller = _root.alloc.initWithNibName(nil, bundle: nil)

    @nav_controller = UINavigationController.alloc.initWithRootViewController(@root_controller)
    @nav_controller.navigationBarHidden = true

    @window.rootViewController = @nav_controller
    @window.rootViewController.wantsFullScreenLayout = true

    true
  end
end
