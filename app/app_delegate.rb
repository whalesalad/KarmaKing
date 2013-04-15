class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # @window.sendSubviewToBack(backgroundView)

    @window.makeKeyAndVisible

    backgroundView = UIImageView.alloc.initWithImage(UIImage.imageNamed('base/app-background.png'))
    backgroundView.frame = @window.bounds
    @window.addSubview(backgroundView)

    Parse.setApplicationId("EUrTZ8F8j53ankiunZgLBfuNjmmApgcf0hu3k5ax", 
      clientKey:"oN6d9KEJT9ppKSgtfKEhpnzOvAGzT6rPpMpsjlm6")

    if PFUser.currentUser
      puts PFUser.currentUser.objectForKey "name"
      PFUser.currentUser.incrementKey("runCount")
    else
      puts "No user found, enabling auto user."
      PFUser.enableAutomaticUser
    end

    finished_onboarding = !!PFUser.currentUser.objectForKey("onboardingComplete")

    _root = (finished_onboarding) ? KKHomeViewController : KKWelcomeViewController
    @root_controller = _root.alloc.initWithNibName(nil, bundle: nil)

    @nav_controller = UINavigationController.alloc.initWithRootViewController(@root_controller)
    @nav_controller.navigationBarHidden = true

    @window.rootViewController = @nav_controller
    @window.rootViewController.wantsFullScreenLayout = true

    true
  end
end
