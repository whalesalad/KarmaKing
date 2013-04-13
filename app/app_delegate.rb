class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @window.makeKeyAndVisible

    Parse.setApplicationId("EUrTZ8F8j53ankiunZgLBfuNjmmApgcf0hu3k5ax", 
      clientKey:"oN6d9KEJT9ppKSgtfKEhpnzOvAGzT6rPpMpsjlm6")

    new_user = App::Persistence['user_uuid'].nil?

    if new_user
      # App::Persistence['user_uuid'] = BubbleWrap.create_uuid
      @root_controller = WelcomeController.alloc.initWithNibName(nil, bundle: nil)
    else
      # @root_controller = 
    end

    @nav_controller = UINavigationController.alloc.initWithRootViewController(@root_controller)
    @nav_controller.navigationBarHidden = true

    @window.rootViewController = @nav_controller
    @window.rootViewController.wantsFullScreenLayout = true

    true
  end
end
