//
//  POViewFrameBuilder.h
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface POViewFrameBuilder : NSObject

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
  @property (nonatomic, weak, readonly) UIView *view;
#else
  @property (nonatomic, weak, readonly) NSView *view;
#endif
@property (nonatomic) BOOL automaticallyCommitChanges; // Default is YES


#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
  - (id)initWithView:(UIView *)view;
  + (POViewFrameBuilder *)frameBuilderForView:(UIView *)view;
#else
  - (id)initWithView:(NSView *)view;
  + (POViewFrameBuilder *)frameBuilderForView:(NSView *)view;
#endif

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

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
  - (POViewFrameBuilder *)alignToTopInSuperviewWithInsets:(UIEdgeInsets)insets;
  - (POViewFrameBuilder *)alignToBottomInSuperviewWithInsets:(UIEdgeInsets)insets;
  - (POViewFrameBuilder *)alignLeftInSuperviewWithInsets:(UIEdgeInsets)insets;
  - (POViewFrameBuilder *)alignRightInSuperviewWithInsets:(UIEdgeInsets)insets;

  - (POViewFrameBuilder *)alignToTopOfView:(UIView *)view offset:(CGFloat)offset;
  - (POViewFrameBuilder *)alignToBottomOfView:(UIView *)view offset:(CGFloat)offset;
  - (POViewFrameBuilder *)alignLeftOfView:(UIView *)view offset:(CGFloat)offset;
  - (POViewFrameBuilder *)alignRightOfView:(UIView *)view offset:(CGFloat)offset;

  + (void)alignViewsVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;
  + (void)alignViewsHorizontally:(NSArray *)views spacingWithBlock:(CGFloat (^)(UIView *firstView, UIView *secondView))block;
#else
  - (POViewFrameBuilder *)alignToTopInSuperviewWithInsets:(NSEdgeInsets)insets;
  - (POViewFrameBuilder *)alignToBottomInSuperviewWithInsets:(NSEdgeInsets)insets;
  - (POViewFrameBuilder *)alignLeftInSuperviewWithInsets:(NSEdgeInsets)insets;
  - (POViewFrameBuilder *)alignRightInSuperviewWithInsets:(NSEdgeInsets)insets;

  - (POViewFrameBuilder *)alignToTopOfView:(NSView *)view offset:(CGFloat)offset;
  - (POViewFrameBuilder *)alignToBottomOfView:(NSView *)view offset:(CGFloat)offset;
  - (POViewFrameBuilder *)alignLeftOfView:(NSView *)view offset:(CGFloat)offset;
  - (POViewFrameBuilder *)alignRightOfView:(NSView *)view offset:(CGFloat)offset;

  + (void)alignViewsVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(NSView *firstView, NSView *secondView))block;
  + (void)alignViewsHorizontally:(NSArray *)views spacingWithBlock:(CGFloat (^)(NSView *firstView, NSView *secondView))block;
#endif

+ (void)alignViewsVertically:(NSArray *)views spacing:(CGFloat)spacing;
+ (void)alignViewsHorizontally:(NSArray *)views spacing:(CGFloat)spacing;

// Resize
- (POViewFrameBuilder *)setWidth:(CGFloat)width;
- (POViewFrameBuilder *)setHeight:(CGFloat)height;
- (POViewFrameBuilder *)setSize:(CGSize)size;
- (POViewFrameBuilder *)setSizeWithWidth:(CGFloat)width height:(CGFloat)height;
- (POViewFrameBuilder *)setSizeToFitWidth;
- (POViewFrameBuilder *)setSizeToFitHeight;
- (POViewFrameBuilder *)setSizeToFit;

+ (void)sizeToFitViews:(NSArray *)views;

@end
