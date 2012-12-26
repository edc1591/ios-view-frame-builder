//
//  LAViewController.m
//  DemoApp-Mac
//
//  Created by Shuo Yang on 12/26/12.
//  Copyright (c) 2012 LessApps. All rights reserved.
//

#import "LAViewController.h"
#import "NSView+POViewFrameBuilder.h"

static NSTimeInterval kAnimationDuration = 1.0;
static CGFloat kEdgeInset = 10.0f;

@interface LAViewController ()

@end

@implementation LAViewController

- (void)loadView
{
  [super loadView];
  [self resetSquareView];
}

- (IBAction)animateButtonPressed:(NSButton *)sender
{
  [self animateSquareView];
}


- (void)resetSquareView {
  self.animateButton.enabled = YES;
  [[[[self.squareView.po_frameBuilder disableAutoCommit] setSizeWithWidth:40.0f height:40.0f] centerInSuperview] commit];
}

- (void)animateSquareView {
  
  self.animateButton.enabled = NO;
  
  [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
    context.duration = kAnimationDuration;
    // Left and resize
    [self.squareView.po_frameBuilder update:^(POViewFrameBuilder *builder) {
      [builder setSizeWithWidth:60.0f height:60.0f];
      [builder alignLeftInSuperviewWithInset:kEdgeInset];
    }];
  } completionHandler:^{
    [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
      context.duration = kAnimationDuration;
      // Center at top
      [self.squareView.po_frameBuilder update:^(POViewFrameBuilder *builder) {
        [builder centerHorizontallyInSuperview];
        [builder alignToTopInSuperviewWithInset:kEdgeInset];
      }];
    } completionHandler:^{
      [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
        context.duration = kAnimationDuration;
        // Right
        [self.squareView.po_frameBuilder alignRightInSuperviewWithInset:kEdgeInset];
      } completionHandler:^{
        [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
          context.duration = kAnimationDuration;
          // Bottom
          [self.squareView.po_frameBuilder alignToBottomInSuperviewWithInset:kEdgeInset];
        } completionHandler:^{
          [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
            context.duration = kAnimationDuration;
            // Left
            [self.squareView.po_frameBuilder alignLeftInSuperviewWithInset:kEdgeInset];
          } completionHandler:^{
            [NSAnimationContext runAnimationGroup:^(NSAnimationContext *context) {
              // Back to the start
              context.duration = kAnimationDuration;
              [self resetSquareView];
            } completionHandler:nil];
          }];
        }];
      }];
    }];
  }];

}

@end
