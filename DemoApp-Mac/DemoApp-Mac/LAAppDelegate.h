//
//  LAAppDelegate.h
//  DemoApp-Mac
//
//  Created by Shuo Yang on 12/26/12.
//  Copyright (c) 2012 LessApps. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "LAViewController.h"

@interface LAAppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (strong, nonatomic) LAViewController *viewController;

@end
