//
//  UIView+POViewFrameBuilder.h
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

#import <UIKit/UIKit.h>
#import "POViewFrameBuilder.h"

@interface UIView (POViewFrameBuilder)

@property (nonatomic, strong, readonly) POViewFrameBuilder *po_frameBuilder;

@end

#endif