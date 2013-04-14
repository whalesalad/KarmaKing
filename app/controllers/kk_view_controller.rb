class KKViewController < UIViewController
  def viewDidLoad
    super
    gradient = CAGradientLayer.layer
    gradient.frame = view.bounds
    gradient.colors = [
      UIColor.blackColor.CGColor, 
      UIColor.colorWithRed(70/255.0, green: 70/255.0, blue: 88/255.0, alpha:1.0).CGColor
    ]
    view.layer.addSublayer(gradient)
  end
end