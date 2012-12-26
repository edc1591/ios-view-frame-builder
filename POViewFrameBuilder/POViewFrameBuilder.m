//
//  POViewFrameBuilder.m
//
//  Created by Sebastian Rehnby on 10/11/12.
//  Copyright (c) 2012 Citrix Systems, Inc. All rights reserved.
//

#import "POViewFrameBuilder.h"
#import "POGeometry.h"

// We define NS_ENUM in case we build for iOS 5
#ifndef NS_ENUM
#define NS_ENUM(_type, _name) enum _name : _type _name; enum _name : _type
#endif

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
  #define NSUIEdgeInsetsMake(top,left,bottom,right) UIEdgeInsetsMake(top,left,bottom,right)
#else
  #define NSUIEdgeInsetsMake(top,left,bottom,right) NSEdgeInsetsMake(top,left,bottom,right)
#endif


typedef NS_ENUM(NSUInteger, POViewFrameBuilderEdge) {
  POViewFrameBuilderEdgeTop,
  POViewFrameBuilderEdgeBottom,
  POViewFrameBuilderEdgeLeft,
  POViewFrameBuilderEdgeRight,
};

@interface POViewFrameBuilder ()

@property (nonatomic) CGRect frame;

@end

@implementation POViewFrameBuilder

- (id)initWithView:(NSUIView *)view {
  self = [super init];
  if (self) {
    _view = view;
    _frame = view.frame;
    _automaticallyCommitChanges = YES;
  }
  return self;
}

+ (POViewFrameBuilder *)frameBuilderForView:(NSUIView *)view {
  return [[[self class] alloc] initWithView:view];
}

#pragma mark - Properties

- (void)setFrame:(CGRect)frame {
  _frame = frame;
  
  if (self.automaticallyCommitChanges) {
    [self commit];
  }
}

#pragma mark - Impl

- (void)commit {
#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED
  self.view.frame = self.frame;
#else
  [self.view.animator setFrame:self.frame];
#endif
}

- (void)reset {
  self.frame = self.view.frame;
}

- (void)update:(void (^)(POViewFrameBuilder *builder))block {
  [self disableAutoCommit];
  block(self);
  [self commit];
}

- (POViewFrameBuilder *)performChangesInGroupWithBlock:(void (^)(void))block {
  BOOL automaticCommitEnabled = self.automaticallyCommitChanges;
  
  self.automaticallyCommitChanges = NO;
  block();
  self.automaticallyCommitChanges = automaticCommitEnabled;
  
  if (self.automaticallyCommitChanges) {
    [self commit];
  }
  
  return self;
}

#pragma mark - Configure

- (POViewFrameBuilder *)enableAutoCommit {
  self.automaticallyCommitChanges = YES;
  
  return self;
}

- (POViewFrameBuilder *)disableAutoCommit {
  self.automaticallyCommitChanges = NO;
  
  return self;
}

#pragma mark - Move

- (POViewFrameBuilder *)setX:(CGFloat)x {
  self.frame = PORectWithX(self.frame, x);
  
  return self;
}

- (POViewFrameBuilder *)setY:(CGFloat)y {
  self.frame = PORectWithY(self.frame, y);
  
  return self;
}

- (POViewFrameBuilder *)setOriginWithX:(CGFloat)x y:(CGFloat)y {
  return [self performChangesInGroupWithBlock:^{
    [[self setX:x] setY:y];
  }];
}

- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX {
  self.frame = PORectWithX(self.frame, self.frame.origin.x + offsetX);
  
  return self;
}

- (POViewFrameBuilder *)moveWithOffsetY:(CGFloat)offsetY {
  self.frame = PORectWithY(self.frame, self.frame.origin.y + offsetY);
  
  return self;
}

- (POViewFrameBuilder *)moveWithOffsetX:(CGFloat)offsetX offsetY:(CGFloat)offsetY {
  return [self performChangesInGroupWithBlock:^{
    [[self moveWithOffsetX:offsetX] moveWithOffsetY:offsetY];
  }];
}

- (POViewFrameBuilder *)centerInSuperview {
  return [self performChangesInGroupWithBlock:^{
    [[self centerHorizontallyInSuperview] centerVerticallyInSuperview];
  }];
}

- (POViewFrameBuilder *)centerHorizontallyInSuperview {
  if (!self.view.superview) {
    return self;
  }
  
  self.frame = PORectWithX(self.frame, roundf((self.view.superview.bounds.size.width - self.frame.size.width) / 2));
  
  return self;
}

- (POViewFrameBuilder *)centerVerticallyInSuperview {
  if (!self.view.superview) {
    return self;
  }
  
  self.frame = PORectWithY(self.frame, roundf((self.view.superview.bounds.size.height - self.frame.size.height) / 2));
  
  return self;
}

- (POViewFrameBuilder *)alignToTopInSuperviewWithInset:(CGFloat)inset {
  [self alignToTopInSuperviewWithInsets:NSUIEdgeInsetsMake(inset, 0.0f, 0.0f, 0.0f)];
  
  return self;
}

- (POViewFrameBuilder *)alignToBottomInSuperviewWithInset:(CGFloat)inset {
  [self alignToBottomInSuperviewWithInsets:NSUIEdgeInsetsMake(0.0f, 0.0f, inset, 0.0f)];
  
  return self;
}

- (POViewFrameBuilder *)alignLeftInSuperviewWithInset:(CGFloat)inset {
  [self alignLeftInSuperviewWithInsets:NSUIEdgeInsetsMake(0.0f, inset, 0.0f, 0.0f)];
  
  return self;
  
}

- (POViewFrameBuilder *)alignRightInSuperviewWithInset:(CGFloat)inset {
  [self alignRightInSuperviewWithInsets:NSUIEdgeInsetsMake(0.0f, 0.0f, 0.0f, inset)];
  
  return self;
}

- (POViewFrameBuilder *)alignToTopInSuperviewWithInsets:(NSUIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                self.frame.origin.x + insets.left - insets.right,
                                insets.top - insets.bottom);
  
  return self;
}

- (POViewFrameBuilder *)alignToBottomInSuperviewWithInsets:(NSUIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                self.frame.origin.x + insets.left - insets.right,
                                self.view.superview.bounds.size.height - self.frame.size.height + insets.top - insets.bottom);
  
  return self;
}

- (POViewFrameBuilder *)alignLeftInSuperviewWithInsets:(NSUIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                insets.left - insets.right,
                                self.frame.origin.y + insets.top - insets.bottom);
  
  return self;
}

- (POViewFrameBuilder *)alignRightInSuperviewWithInsets:(NSUIEdgeInsets)insets {
  self.frame = PORectWithOrigin(self.frame,
                                self.view.superview.bounds.size.width - self.frame.size.width + insets.left - insets.right,
                                self.frame.origin.y + insets.top - insets.bottom);
  
  return self;
}

- (POViewFrameBuilder *)alignToView:(NSUIView *)view edge:(POViewFrameBuilderEdge)edge offset:(CGFloat)offset {
  CGRect viewFrame = [view.superview convertRect:view.frame toView:self.view.superview];
  
  switch (edge) {
    case POViewFrameBuilderEdgeTop:
      self.frame = PORectWithY(self.frame, viewFrame.origin.y - offset - self.frame.size.height);
      break;
    case POViewFrameBuilderEdgeBottom:
      self.frame = PORectWithY(self.frame, CGRectGetMaxY(viewFrame) + offset);
      break;
    case POViewFrameBuilderEdgeLeft:
      self.frame = PORectWithX(self.frame, viewFrame.origin.x - offset - self.frame.size.width);
      break;
    case POViewFrameBuilderEdgeRight:
      self.frame = PORectWithX(self.frame, CGRectGetMaxX(viewFrame) + offset);
      break;
    default:
      break;
  }
  
  return self;
}

- (POViewFrameBuilder *)alignToTopOfView:(NSUIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeTop offset:offset];
}

- (POViewFrameBuilder *)alignToBottomOfView:(NSUIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeBottom offset:offset];
}

- (POViewFrameBuilder *)alignLeftOfView:(NSUIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeLeft offset:offset];
}

- (POViewFrameBuilder *)alignRightOfView:(NSUIView *)view offset:(CGFloat)offset {
  return [self alignToView:view edge:POViewFrameBuilderEdgeRight offset:offset];
}

+ (void)alignViewsVertically:(NSArray *)views spacing:(CGFloat)spacing {
  [self alignViewsVertically:views spacingWithBlock:^CGFloat(NSUIView *firstView, NSUIView *secondView) {
    return spacing;
  }];
}

+ (void)alignViewsVertically:(NSArray *)views spacingWithBlock:(CGFloat (^)(NSUIView *firstView, NSUIView *secondView))block {
  NSUIView *previousView = nil;
  for (NSUIView *view in views) {
    if (previousView) {
      CGFloat spacing = block != nil ? block(previousView, view) : 0.0f;
      [[[self alloc] initWithView:view] alignToBottomOfView:previousView offset:spacing];
    }
    
    previousView = view;
  }
}

+ (void)alignViewsHorizontally:(NSArray *)views spacing:(CGFloat)spacing {
  [self alignViewsHorizontally:views spacingWithBlock:^CGFloat(NSUIView *firstView, NSUIView *secondView) {
    return spacing;
  }];
}

+ (void)alignViewsHorizontally:(NSArray *)views spacingWithBlock:(CGFloat (^)(NSUIView *firstView, NSUIView *secondView))block {
  NSUIView *previousView = nil;
  for (NSUIView *view in views) {
    if (previousView) {
      CGFloat spacing = block != nil ? block(previousView, view) : 0.0f;
      [[[self alloc] initWithView:view] alignRightOfView:previousView offset:spacing];
    }
    
    previousView = view;
  }
}

#pragma mark - Resize

- (POViewFrameBuilder *)setWidth:(CGFloat)width {
  self.frame = PORectWithWidth(self.frame, width);
  
  return self;
}

- (POViewFrameBuilder *)setHeight:(CGFloat)height {
  self.frame = PORectWithHeight(self.frame, height);
  
  return self;
}

- (POViewFrameBuilder *)setSize:(CGSize)size {
  self.frame = PORectWithSize(self.frame, size.width, size.height);
  
  return self;
}

- (POViewFrameBuilder *)setSizeWithWidth:(CGFloat)width height:(CGFloat)height {
  return [self performChangesInGroupWithBlock:^{
    [[self setWidth:width] setHeight:height];
  }];
}

#ifdef __IPHONE_OS_VERSION_MAX_ALLOWED

- (POViewFrameBuilder *)setSizeToFitWidth {
  CGRect frame = self.frame;
  frame.size.width = [self.view sizeThatFits:CGSizeMake(CGFLOAT_MAX, self.frame.size.height)].width;
  self.frame = frame;
  
  return self;
}

- (POViewFrameBuilder *)setSizeToFitHeight {
  CGRect frame = self.frame;
  frame.size.height = [self.view sizeThatFits:CGSizeMake(self.frame.size.width, CGFLOAT_MAX)].height;
  self.frame = frame;
  
  return self;
}

- (POViewFrameBuilder *)setSizeToFit {
  CGSize size = [self.view sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];
  
  CGRect frame = self.frame;
  frame.size.height = size.height;
  frame.size.width = size.width;
  self.frame = frame;
  
  return self;
}

+ (void)sizeToFitViews:(NSArray *)views {
  for (NSUIView *view in views) {
    [view sizeToFit];
  }
}

#endif

@end
