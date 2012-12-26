//
//  NSView+POViewFrameBuilder.h
//  DemoApp-Mac
//
//  Created by Shuo Yang on 12/26/12.
//  Copyright (c) 2012 LessApps. All rights reserved.
//

#ifndef __IPHONE_OS_VERSION_MAX_ALLOWED

#import <Cocoa/Cocoa.h>
#import "POViewFrameBuilder.h"

@interface NSView (POViewFrameBuilder)

@property (nonatomic, strong, readonly) POViewFrameBuilder *po_frameBuilder;

@end

#endif