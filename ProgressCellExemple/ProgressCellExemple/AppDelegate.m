//
//  AppDelegate.m
//  ProgressCellExemple
//
//  Created by HEINRICH Yannick on 13/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import "AppDelegate.h"

#import "YGProgressCell.h"
#import "ProcessExemple.h"

@implementation AppDelegate

@synthesize processesArray;

- (id) init{
    if(self = [super init]){
        ProcessExemple * pro = [[ProcessExemple alloc] init];
        processesArray = [[NSMutableArray alloc] init];
        pro.tableViewController = self;
        [processesArray addObject:pro];
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
   
}


#pragma marks - NSTableViewDataSource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView{
    return [processesArray count];
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn *)aTableColumn row:(NSInteger)rowIndex{
    NSString * identifier = aTableColumn.identifier;
    if([identifier isEqualToString:@"col1Identifier"]) return [NSNumber numberWithInt:1]; //Need to return something but the information is ot used
    
    else{
        ProcessExemple * pro = processesArray[rowIndex];
        return [NSNumber numberWithFloat:pro.progress];
    }
}

- (void)tableView:(NSTableView *)aTableView willDisplayCell:(NSCell *)aCell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)rowIndex{
    ProcessExemple* item = [processesArray objectAtIndex:rowIndex];
    if([tableColumn.identifier isEqualToString:@"col1Identifier"]){
        YGProgressCell *YGCell = (YGProgressCell *) aCell;
        YGCell.delegate = item;
    }
}

- (void) updateDisplayForProcessExemple:(id) element{
    NSUInteger idx = [processesArray indexOfObject:element];
    [self.tableView reloadDataForRowIndexes:[NSIndexSet indexSetWithIndex:idx]columnIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,2)]];
    
    
}
@end
