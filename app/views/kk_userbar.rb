class KKUserbar < UIView
  
  def gradientColors
    [
      UIColor.colorWithRed(1.000, green:0.761, blue:0.000, alpha:1.000).CGColor,
      UIColor.colorWithRed(1.000, green:0.502, blue:0.000, alpha:1.000).CGColor
    ]
  end

  def drawRect(rect)
    gradient = CAGradientLayer.layer
    gradient.frame = self.bounds
    gradient.colors = [
      UIColor.colorWithRed(1.000, green:0.761, blue:0.000, alpha:1.000).CGColor,
      UIColor.colorWithRed(1.000, green:0.502, blue:0.000, alpha:1.000).CGColor
    ]
    self.layer.addSublayer(gradient)
  end
  
end