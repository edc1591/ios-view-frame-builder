//
//  LAViewController.h
//  DemoApp-Mac
//
//  Created by Shuo Yang on 12/26/12.
//  Copyright (c) 2012 LessApps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface LAViewController : NSViewController

@property (weak) IBOutlet NSImageView *squareView;
@property (weak) IBOutlet NSButton *animateButton;

- (IBAction)animateButtonPressed:(NSButton *)sender;

@end
