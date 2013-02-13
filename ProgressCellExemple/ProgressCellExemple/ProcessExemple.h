//
//  ProcessExemple.h
//  ProgressCellExemple
//
//  Created by HEINRICH Yannick on 13/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YGProgressCell.h"
#import "AppDelegate.h"
@interface ProcessExemple : NSObject <YGProgressCellDelegate>


@property (readwrite,nonatomic) CGFloat max;
@property (readwrite,nonatomic) CGFloat min;
@property (readwrite,nonatomic) CGFloat progress;
@property (readwrite,nonatomic) BOOL hidden;
@property (readwrite,nonatomic) BOOL complete;
@property (readwrite,nonatomic) BOOL error;
@property (readwrite,retain,nonatomic) NSTimer * timer;
@property (readwrite,assign) id<UpdateRowElement> tableViewController;


- (void) increment;
@end
