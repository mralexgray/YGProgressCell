//
//  AppDelegate.h
//  ProgressCellExemple
//
//  Created by HEINRICH Yannick on 13/02/13.
//  Copyright (c) 2013 HEINRICH Yannick. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "ProcessExemple.h"
@interface AppDelegate : NSObject <NSApplicationDelegate, NSTableViewDataSource>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTableView *tableView;

/*********
 * Here is the data model
 */
@property (readwrite,retain) NSMutableArray *processesArray;

- (void) updateDisplayForProcessExemple:(ProcessExemple*) pro;
@end
