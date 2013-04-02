class KKButton < UIButton
  
  def button
    KKButton.buttonWithType(UIButtonTypeCustom)
  end

  # Orange Button
  # [UIColor colorWithRed:1.000 green:0.761 blue:0.000 alpha:1.000]
  # [UIColor colorWithRed:1.000 green:0.502 blue:0.000 alpha:1.000]

  def initWithFrame(frame)
    super

    self.setTitleColor(UIColor.whiteColor, forState:UIControlStateNormal)
    self.titleEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8)
  
    self.layer.cornerRadius = 10
    self.layer.borderWidth = 1;
    self.layer.borderColor = UIColor.blackColor.CGColor;
    self.clipsToBounds = true

    self.drawGradientLayer

    self.styleTitleLabel

    self
  end

  def gradientColors
    [
      UIColor.colorWithRed(1.000, green:0.761, blue:0.000, alpha:1.000).CGColor,
      UIColor.colorWithRed(1.000, green:0.502, blue:0.000, alpha:1.000).CGColor
    ]
  end

  def drawGradientLayer
    @gradient = CAGradientLayer.layer
    @gradient.frame = self.bounds
    @gradient.colors = self.gradientColors
    @gradient.cornerRadius = 11

    self.layer.addSublayer(@gradient)
  end

  def styleTitleLabel
    self.titleLabel.font = UIFont.fontWithName("HelveticaNeue-Bold", size:24)
    self.titleLabel.shadowColor = UIColor.blackColor
    self.titleLabel.shadowOffset = CGSizeMake(0, 1)
  end

  # def drawRect(rect)
  #   ctx = UIGraphicsGetCurrentContext()

  #   case self.state
  #   when UIControlStateHighlighted, UIControlStateSelected
  #     strokeColor = self.titleColorForState(UIControlStateNormal) ? self.titleColorForState(UIControlStateNormal).CGColor : UIColor.blackColor.CGColor
  #     fillColor   = self.titleColorForState(UIControlStateNormal) ? self.titleColorForState(UIControlStateNormal).CGColor : UIColor.blackColor.CGColor
  #   when UIControlStateDisabled
  #     strokeColor = self.titleColorForState(UIControlStateDisabled) ? self.titleColorForState(UIControlStateDisabled).CGColor : UIColor.blackColor.CGColor
  #     fillColor   = self.titleColorForState(UIControlStateDisabled) ? self.titleColorForState(UIControlStateDisabled).CGColor : UIColor.blackColor.CGColor
  #   else
  #     strokeColor = self.titleColorForState(UIControlStateNormal) ? self.titleColorForState(UIControlStateNormal).CGColor : UIColor.blackColor.CGColor
  #     fillColor   = UIColor.clearColor.CGColor
  #   end

  #   CGContextSetFillColorWithColor(ctx, fillColor)
  #   CGContextSetStrokeColorWithColor(ctx, strokeColor)
  
  #   CGContextSaveGState(ctx)
    
  #   lineWidth = self.thickness
  
  #   CGContextSetLineWidth(ctx, lineWidth)
  
  #   outlinePath = UIBezierPath.bezierPathWithRoundedRect(CGRectInset(self.bounds, lineWidth, lineWidth), cornerRadius:self.bounds.size.height/2)
 
  #   CGContextAddPath(ctx, outlinePath.CGPath)
  #   CGContextStrokePath(ctx)
  
  #   CGContextRestoreGState(ctx)
  
  #   if (self.highlighted?)
  #     CGContextSaveGState(ctx)
  #     fillPath = UIBezierPath.bezierPathWithRoundedRect(CGRectInset(self.bounds, lineWidth * 2.5, lineWidth * 2.5), cornerRadius:self.bounds.size.height/2)
    
  #     CGContextAddPath(ctx, fillPath.CGPath)
  #     CGContextFillPath(ctx)
    
  #     CGContextRestoreGState(ctx)
  #   end
  # end

  def layoutSubviews
    super

    @gradient.frame = self.bounds

    self.resizeTitleLabel

    self.setNeedsDisplay
  end

  def resizeTitleLabel
    new_size = ((self.size.height * 0.5) - 2).floor
    self.titleLabel.font = UIFont.fontWithName("HelveticaNeue-Bold", size:new_size)
  end

  def highlighted=(highlighted)
    super
    self.setNeedsDisplay
  end

  def selected=(selected)
    super
    self.setNeedsDisplay
  end

  def enabled=(enabled)
    super
    self.setNeedsDisplay
  end

  def frame=(frame)
    super
    self.setNeedsDisplay
  end
end