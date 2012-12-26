//
//  LAAppDelegate.m
//  DemoApp-Mac
//
//  Created by Shuo Yang on 12/26/12.
//  Copyright (c) 2012 LessApps. All rights reserved.
//

#import "LAAppDelegate.h"

@implementation LAAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
  
  self.viewController = [[LAViewController alloc] initWithNibName:@"LAViewController" bundle:nil];
  [self.window setContentView:self.viewController.view];
}

@end
