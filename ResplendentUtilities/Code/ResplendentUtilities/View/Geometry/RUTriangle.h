//
//  RUTriangle.h
//  Resplendent
//
//  Created by Benjamin Maer on 10/10/13.
//  Copyright (c) 2013 Resplendent G.P.. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum{
    RUTriangleOrientationUp,
    RUTriangleOrientationDown,
    RUTriangleOrientationLeft,
    RUTriangleOrientationRight,
}RUTriangleOrientation;

@interface RUTriangle : UIView

@property (nonatomic, assign) BOOL fillTriangle;
@property (nonatomic, strong) UIColor* color;
@property (nonatomic, assign) RUTriangleOrientation orientation;

-(void)drawTrianglePathInRect:(CGRect)rect withContent:(CGContextRef)context;

@end
