//
//  UIView+POViewFrameBuilder.m
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "UIView+POViewFrameBuilder.h"

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

@implementation UIView (POViewFrameBuilder)

- (POViewFrameBuilder *)po_frameBuilder {
  return [POViewFrameBuilder frameBuilderForView:self];
}

@end

#endif