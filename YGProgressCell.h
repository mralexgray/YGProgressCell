//
//  ProgressCell.h
//  iSpoiler
//
//  Created by HEINRICH Yannick on 20/01/13.
//
//

#import <Cocoa/Cocoa.h>

@interface YGProgressCell : NSCell {
    CGFloat max;
    CGFloat min;
    CGFloat progress;
    CGFloat side;
}
@property (readwrite,nonatomic) CGFloat max;
@property (readwrite,nonatomic) CGFloat min;
@property(nonatomic) CGFloat progress;
@property(nonatomic) BOOL hidden;

- (id) initWithSide:(CGFloat) value;
- (void) incrementBy:(CGFloat) increment;
@end
