//
//  NSView+POViewFrameBuilder.m
//  DemoApp-Mac
//
//  Created by Shuo Yang on 12/26/12.
//  Copyright (c) 2012 LessApps. All rights reserved.
//

#ifndef __IPHONE_OS_VERSION_MAX_ALLOWED

#import "NSView+POViewFrameBuilder.h"

@implementation NSView (POViewFrameBuilder)

- (POViewFrameBuilder *)po_frameBuilder {
  return [POViewFrameBuilder frameBuilderForView:self];
}

@end

#endif