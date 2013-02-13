//
//  ProcessExemple.m
//  ProgressCellExemple
//
//  Created by HEINRICH Yannick on 13/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import "ProcessExemple.h"

@implementation ProcessExemple

@synthesize timer;
@synthesize tableViewController;
- (id) init{
    
    if(self = [super init]){
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(increment) userInfo:nil repeats:YES];
        self.max = 5;
        self.min = 0;
        self.progress = 0;
    }
    return self;
}


- (void) increment{
    self.progress = self.progress + 1;
    if(self.progress > self.max){
        self.progress = self.min;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableViewController updateDisplayForProcessExemple:self];
    
    });
}
@end
