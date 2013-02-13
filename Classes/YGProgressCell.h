//
//  ProgressCell.h
//  iSpoiler
//
//  Created by HEINRICH Yannick on 20/01/13.
//
//

#import <Cocoa/Cocoa.h>


@protocol ProgressCellDelegate

@required

@property (readwrite,nonatomic) CGFloat max;
@property (readwrite,nonatomic) CGFloat min;
@property (readwrite,nonatomic) CGFloat progress;
@property (readwrite,nonatomic) BOOL hidden;
@property (readwrite,nonatomic) BOOL complete;
@property (readwrite,nonatomic) BOOL error;
@end

@interface ProgressCell : NSCell {
    CGFloat max;
    CGFloat min;
    CGFloat side;
    CGImageRef okImage;
    CGImageRef errorImage;
    id<ProgressCellDelegate> delegate;
}

@property (nonatomic,assign)  id<ProgressCellDelegate> delegate;

- (id) initWithSide:(CGFloat) value;
- (void) incrementBy:(CGFloat) increment;
@end
