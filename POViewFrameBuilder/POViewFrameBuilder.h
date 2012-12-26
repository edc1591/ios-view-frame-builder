//
//  POViewFrameBuilder.h
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POViewFrameBuilder : NSObject

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
  #define NSUIView UIView
  #define NSUIEdgeInsets UIEdgeInsets
#else
  #define NSUIView NSView
  #define NSUIEdgeInsets NSEdgeInsets
#endif

@property (nonatomic, weak, readonly) NSUIView *view;
@property (nonatomic) BOOL automaticallyCommitChanges; // Default is YES


- (id)initWithView:(NSUIView *)view;
+ (POViewFrameBuilder *)frameBuilderForView:(NSUIView *)view;

- (void)commit;
- (void)reset;
- (void)update:(void (^)(POViewFrameBuilder *builder))block;

// Configure
- (POViewFrameBuilder *)enableAutoCommit;
- (POViewFrameBuilder *)disableAutoCommit;

// Move
- (POViewFrameBuilder *)setX:(CGFloat)x;
- (POViewFrameBuilder *)setY:(CGFloat)y;
- (POViewFrameBuilder *)setOriginWithX:(CGFloat)x y:(CGFloat)y;

- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX;
- (POViewFrameBuilder *)moveWithOffsetY:(CGFloat)offsetY;
- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY;

- (POViewFrameBuilder *)centerInSuperview;
- (POViewFrameBuilder *)centerHorizontallyInSuperview;
- (POViewFrameBuilder *)centerVerticallyInSuperview;

- (POViewFrameBuilder *)alignToTopInSuperviewWithInset:(CGFloat)inset;
- (POViewFrameBuilder *)alignToBottomInSuperviewWithInset:(CGFloat)inset;
- (POViewFrameBuilder *)alignLeftInSuperviewWithInset:(CGFloat)inset;
- (POViewFrameBuilder *)alignRightInSuperviewWithInset:(CGFloat)inset;

- (POViewFrameBuilder *)alignToTopInSuperviewWithInsets:(NSUIEdgeInsets)insets;
- (POViewFrameBuilder *)alignToBottomInSuperviewWithInsets:(NSUIEdgeInsets)insets;
- (POViewFrameBuilder *)alignLeftInSuperviewWithInsets:(NSUIEdgeInsets)insets;
- (POViewFrameBuilder *)alignRightInSuperviewWithInsets:(NSUIEdgeInsets)insets;

- (POViewFrameBuilder *)alignToTopOfView:(NSUIView *)view offset:(CGFloat)offset;
- (POViewFrameBuilder *)alignToBottomOfView:(NSUIView *)view offset:(CGFloat)offset;
- (POViewFrameBuilder *)alignLeftOfView:(NSUIView *)view offset:(CGFloat)offset;
- (POViewFrameBuilder *)alignRightOfView:(NSUIView *)view offset:(CGFloat)offset;

+ (void)alignViewsVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(NSUIView *firstView, NSUIView *secondView))block;
+ (void)alignViewsHorizontally:(NSArray *)views spacingWithBlock:(CGFloat (^)(NSUIView *firstView, NSUIView *secondView))block;
+ (void)alignViewsVertically:(NSArray *)views spacing:(CGFloat)spacing;
+ (void)alignViewsHorizontally:(NSArray *)views spacing:(CGFloat)spacing;

// Resize
- (POViewFrameBuilder *)setWidth:(CGFloat)width;
- (POViewFrameBuilder *)setHeight:(CGFloat)height;
- (POViewFrameBuilder *)setSize:(CGSize)size;
- (POViewFrameBuilder *)setSizeWithWidth:(CGFloat)width height:(CGFloat)height;

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
- (POViewFrameBuilder *)setSizeToFitWidth;
- (POViewFrameBuilder *)setSizeToFitHeight;
- (POViewFrameBuilder *)setSizeToFit;

+ (void)sizeToFitViews:(NSArray *)views;
#endif

@end
