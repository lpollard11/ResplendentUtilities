//
//  RUScrollWithKeyboardAdjustmentView.m
//  Resplendent
//
//  Created by Benjamin Maer on 12/21/13.
//  Copyright (c) 2013 Resplendent G.P.. All rights reserved.
//

#import "RUScrollWithKeyboardAdjustmentView.h"
#import "RUKeyboardAdjustmentHelper.h"





@interface RUScrollWithKeyboardAdjustmentView ()

@property (nonatomic, readonly) CGRect scrollViewFrame;
@property (nonatomic, readonly) CGFloat scrollViewKeyboardBottomPadding;

@property (nonatomic, readonly) UIView* scrollViewLowestFirstResponder;
@property (nonatomic, readonly) UIView* scrollViewSubviewFirstResponder;

@end






@implementation RUScrollWithKeyboardAdjustmentView

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        _scrollView = [UIScrollView new];
        [_scrollView setBackgroundColor:[UIColor clearColor]];
        [_scrollView setShowsVerticalScrollIndicator:NO];
        [self addSubview:_scrollView];
        
        _keyboardHelper = [RUKeyboardAdjustmentHelper new];
        [_keyboardHelper setDelegate:self];
        [_keyboardHelper setRegisteredForKeyboardNotifications:YES];
    }
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [_scrollView setFrame:self.scrollViewFrame];
    [_scrollView setContentSize:self.scrollViewContentSize];
}

#pragma mark - Public
-(void)addSubviewToScrollView:(UIView*)view
{
    NSAssert(view != nil, @"view must be non-nil");
    [_scrollView addSubview:view];
    [self setNeedsLayout];
}

#pragma mark - Frames
-(CGRect)scrollViewFrame
{
    CGRect scrollViewFrame = self.bounds;
    
    scrollViewFrame.size.height -= self.scrollViewKeyboardBottomPadding;
    
    return scrollViewFrame;
}

-(CGFloat)scrollViewKeyboardBottomPadding
{
    if (_keyboardHelper.keyboardTop)
    {
        UIView* relativeView = [UIApplication sharedApplication].keyWindow;
        CGRect frameInWindow = [self.superview convertRect:self.frame toView:relativeView];
        CGFloat bottom = CGRectGetMaxY(frameInWindow);
        CGFloat yOffset = CGRectGetHeight(relativeView.frame) - bottom;
        
        return _keyboardHelper.keyboardTop.floatValue - yOffset;
    }
    else
    {
        return 0;
    }
}

-(CGSize)scrollViewContentSize
{
    return (CGSize){CGRectGetWidth(self.bounds),self.scrollViewContentSizeHeight};
}

-(CGFloat)scrollViewContentSizeHeight
{
    return CGRectGetMaxY(self.scrollViewLowestFirstResponder.frame);
}

#pragma mark - Getters
-(UIView *)scrollViewLowestFirstResponder
{
    UIView* scrollViewLowestFirstResponder = nil;
    for (UIView* scrollViewSubview in _scrollView.subviews)
    {
        if (!scrollViewLowestFirstResponder ||
            (CGRectGetMaxY(scrollViewLowestFirstResponder.frame) < CGRectGetMaxY(scrollViewSubview.frame)))
        {
            scrollViewLowestFirstResponder = scrollViewSubview;
        }
    }
    
    return scrollViewLowestFirstResponder;
}

-(UIView *)scrollViewSubviewFirstResponder
{
    for (UIView* scrollViewSubview in _scrollView.subviews)
    {
        if (scrollViewSubview.isFirstResponder)
        {
            return scrollViewSubview;
        }
    }
    
    return nil;
}

#pragma mark - RUKeyboardAdjustmentHelperDelegate
-(void)keyboardAdjustmentHelper:(RUKeyboardAdjustmentHelper *)keyboardAdjustmentHelper willShowWithAnimationDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration animations:^{
        [self layoutSubviews];
        
        UIView* scrollViewSubviewFirstResponder = self.scrollViewSubviewFirstResponder;
        if (scrollViewSubviewFirstResponder)
        {
            CGRect scrollToFrame = scrollViewSubviewFirstResponder.frame;
            scrollToFrame.origin.y = scrollToFrame.origin.y + self.scrollViewBottomKeyboardPadding;
            
            [_scrollView scrollRectToVisible:scrollToFrame animated:NO];
        }
    }];
}

-(void)keyboardAdjustmentHelper:(RUKeyboardAdjustmentHelper *)keyboardAdjustmentHelper willHideWithAnimationDuration:(NSTimeInterval)animationDuration
{
    [UIView animateWithDuration:animationDuration animations:^{
        [self layoutSubviews];
    }];
}

@end
