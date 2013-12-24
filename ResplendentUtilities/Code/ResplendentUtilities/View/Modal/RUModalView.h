//
//  PAModalView.h
//  Resplendent
//
//  Created by Benjamin Maer on 4/13/13.
//  Copyright (c) 2013 Resplendent G.P.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RUModalView : UIView

@property (nonatomic, readonly) UITapGestureRecognizer* tapGestureRecognizer;

-(void)showInView:(UIView*)presenterView completion:(void(^)())completion;
-(void)dismiss:(BOOL)animate completion:(void(^)())completion;

@end
