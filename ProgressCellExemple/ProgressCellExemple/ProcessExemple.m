//
//  ProcessExemple.m
//  ProgressCellExemple
//
//  Created by HEINRICH Yannick on 13/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import "ProcessExemple.h"

@implementation ProcessExemple

- (id) init{
    
    if(self = [super init]){
        timer = [NSTimer timerWithTimeInterval:3 target:self selector:@selector(increment) userInfo:nil repeats:YES];
    }
    return self;
}


- (void) increment{
    
}
@end
