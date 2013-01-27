//
//  ProgressCell.m
//  iSpoiler
//
//  Created by HEINRICH Yannick on 20/01/13.
//
//

#import "YGProgressCell.h"

@implementation YGProgressCell
@synthesize progress;
@synthesize min;
@synthesize max;
@synthesize hidden;


static inline double radians (double degrees) { return degrees * M_PI/180; }

- (id) initWithSide:(CGFloat) value{
    if(self = [super init]){
        side = value;
        max = 5;
        min = 0;
        progress = 0;
        hidden = NO;
    }
    return self;
}
- (id) init{
    CGFloat defaultSide = 15;
    return [self initWithSide:defaultSide];
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    CGFloat defaultSide = 15;
    return [self initWithSide:defaultSide];
}

- (void) drawInteriorWithFrame:(NSRect)cellFrame inView:(NSView *)controlView{
    
    if(self.hidden == YES) return;
    
    CGPoint centerPoint = CGPointMake(cellFrame.origin.x + cellFrame.size.width/2, cellFrame.origin.y + cellFrame.size.height/2);

    CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
    CGContextSaveGState(context);
    //Draw Background circle
    CGRect backgroundCircleRect = cellFrame;
    backgroundCircleRect.size.width = side;
    backgroundCircleRect.size.height = side;

    //Centering
    backgroundCircleRect.origin.x = (cellFrame.size.width-backgroundCircleRect.size.width)/2;
    //Draw color background
    CGColorRef strokeColorLight =  [NSColor colorWithCalibratedRed:0.821 green:0.863 blue:0.963 alpha:1.000].CGColor;
    CGColorRef strokeColorDark =  [NSColor colorWithCalibratedRed:0.338 green:0.523 blue:0.863 alpha:1.000].CGColor;
    CGColorRef rotColor =  [NSColor colorWithCalibratedRed:0.863 green:0.000 blue:0.131 alpha:1.000].CGColor;

    size_t num_locations = 2;
    CGFloat locations[2] = { 0.5, 1.0 };
    CGFloat components[8] = { 0.821, 0.863, 0.963, 1.0,  // Start color
        0.338, 0.523, 0.863, 1.0 }; // End colo

    //Set up gradients
    CGColorSpaceRef colorSpace = CGColorSpaceCreateWithName(kCGColorSpaceGenericRGB);
    CGGradientRef strokeGradient = CGGradientCreateWithColorComponents(colorSpace, components,locations, num_locations);

    //Background circle
//    CGContextSetLineWidth(context, 3.0f);
//    CGPathRef backgroundCircle = CGPathCreateWithEllipseInRect(backgroundCircleRect, NULL);
//    CGContextAddPath(context, backgroundCircle);
//    CGContextReplacePathWithStrokedPath(context);
//    //CGContextClip(context);

    CGPoint startGradient = CGPointMake(centerPoint.x-side/2, centerPoint.y);
    CGPoint endGradient = CGPointMake(centerPoint.x+side/2, centerPoint.y);;
    //CGContextDrawLinearGradient(context, strokeGradient,startGradient , endGradient, 0);


    //Draw background and line
//    CGContextSetFillColorWithColor(context, strokeColorLight);
//    CGContextSetStrokeColorWithColor(context, strokeColorDark);
//    CGContextDrawPath(context, kCGPathFillStroke);

       
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGFloat startAngle=0;
        CGFloat endAngle = progress/(max-min)*2*M_PI;
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, side/2, startAngle, endAngle, NO);
        //CGPathAddLineToPoint(progressPath, NULL, centerPoint.x, centerPoint.y-side/2);
        //CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextSetFillColorWithColor(context, rotColor);
        CGContextFillPath(context);

    

    //Draw processing state
   CGContextRestoreGState(context);
}
- (void) incrementBy:(CGFloat)increment{
    if(increment > 0 && progress < max){
        progress = min +increment;
    }
}
- (id) copyWithZone:(NSZone *)zone{
  return [[[self class] allocWithZone:zone] initWithSide:self->side];
}

- (void) dealloc{
    [super dealloc];
}
@end
