//
//  ProgressCell.m
//  iSpoiler
//
//  Created by HEINRICH Yannick on 20/01/13.
//
//

#import "YGProgressCell.h"
#import "NSColor+CGColor.m"
@interface ProgressCell()
+ (CGImageRef) okImage;
+ (CGImageRef) errorImage;
@end

@implementation ProgressCell
@synthesize delegate;

static inline double radians (double degrees) { return degrees * M_PI/180; }

static inline CGRect centerSubRectInRect(CGRect rect, CGRect SubRect){
     return CGRectMake(rect.origin.x + (rect.size.width - SubRect.size.width)/2, rect.origin.y + (rect.size.height - SubRect.size.height)/2, SubRect.size.width, SubRect.size.height);
}

- (id) initWithSide:(CGFloat) value{
    if(self = [super init]){
        side = value;
        errorImage = [ProgressCell errorImage];
        okImage = [ProgressCell okImage];
        delegate = nil;
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

        
    if(delegate.hidden == YES) return;
    else if (delegate.complete == YES) {
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextSaveGState(context);

        CGFloat width = CGImageGetWidth(okImage), height = CGImageGetHeight(okImage);

        CGRect imgRect =centerSubRectInRect(cellFrame,CGRectMake(0, 0, width, height));
        CGContextDrawImage(context, imgRect, okImage);

        
        CGContextRestoreGState(context);
        
    }else if(delegate.error == YES){
        
        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextSaveGState(context);
        CGFloat width = CGImageGetWidth(errorImage), height = CGImageGetHeight(errorImage);
        CGContextDrawImage(context, centerSubRectInRect(cellFrame,CGRectMake(0, 0, width, height)), errorImage);
        
        CGContextRestoreGState(context);
        
    }
    else {
        
        CGPoint centerPoint = CGPointMake(cellFrame.origin.x + cellFrame.size.width/2, cellFrame.origin.y + cellFrame.size.height/2);

        CGContextRef context = [[NSGraphicsContext currentContext] graphicsPort];
        CGContextSaveGState(context);
        //Draw color background
        CGColorRef strokeColorLight =  [NSColor colorWithCalibratedRed:0.821 green:0.863 blue:0.963 alpha:1.000].CGColor;
        CGColorRef strokeColorDark =  [NSColor colorWithCalibratedRed:0.338 green:0.523 blue:0.863 alpha:1.000].CGColor;
      
        //Background circle
        CGMutablePathRef backgroundCirclePath = CGPathCreateMutable();
        CGPathMoveToPoint(backgroundCirclePath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(backgroundCirclePath, NULL, centerPoint.x, centerPoint.y, side/2, 0, 2*M_PI, NO);
        CGContextAddPath(context, backgroundCirclePath);
        CGContextSetFillColorWithColor(context, strokeColorLight);
        CGContextFillPath(context);
        
        CGContextAddPath(context, backgroundCirclePath);
        CGContextSetLineWidth(context, 2.0f);
        CGContextReplacePathWithStrokedPath(context);
        CGContextSetFillColorWithColor(context, strokeColorDark);
        CGContextDrawPath(context, kCGPathFillStroke);

        CGContextAddPath(context, backgroundCirclePath);
        CGContextSetFillColorWithColor(context, strokeColorDark);
        CGContextSetLineWidth(context, 2.0f);
        CGContextReplacePathWithStrokedPath(context);
        CGContextDrawPath(context, kCGPathFillStroke);


        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGFloat startAngle=0;
        CGFloat endAngle = delegate.progress/(delegate.max-delegate.min)*2*M_PI;
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, side/2+1, startAngle, endAngle, NO);
        CGContextAddPath(context, progressPath);
        CGContextSetFillColorWithColor(context, strokeColorDark);
        CGContextFillPath(context);

        //Draw processing state
        CGContextRestoreGState(context);

        //Release element
        CFRelease(backgroundCirclePath);
        CFRelease(progressPath);

    }
}
- (void) incrementBy:(CGFloat)increment{
    if(increment > 0 && delegate.progress < delegate.max){
        delegate.progress = delegate.min +increment;
    }
}

- (void) dealloc{
    [super dealloc];
}
+ (CGImageRef) okImage{
    static CGImageRef img=NULL;
    if(img==NULL){
        NSURL * url = [[NSBundle mainBundle] URLForImageResource:@"ok"];
        CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef) url,NULL);
        img = CGImageSourceCreateImageAtIndex(source,0,NULL);
        CFRelease(source);
    }
    return img;
}
+ (CGImageRef) errorImage{
    static CGImageRef img=NULL;
    if(img==NULL){
        NSURL * url = [[NSBundle mainBundle] URLForImageResource:@"error"];
        CGImageSourceRef source = CGImageSourceCreateWithURL((CFURLRef) url,NULL);
        img = CGImageSourceCreateImageAtIndex(source,0,NULL);
        CFRelease(source);

    }
    return img;
}

@end
