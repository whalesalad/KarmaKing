class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    @window.makeKeyAndVisible

    @welcome_controller = WelcomeController.alloc.initWithNibName(nil, bundle: nil)
    @nav_controller = UINavigationController.alloc.initWithRootViewController(@welcome_controller)

    @nav_controller.navigationBarHidden = true

    @window.rootViewController = @nav_controller
    @window.rootViewController.wantsFullScreenLayout = true

    true
  end
end
