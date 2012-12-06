//
//  UIImage+Resizing.h
//  Memeni
//
//  Created by Sheldon on 10/2/12.
//
//

#import <UIKit/UIKit.h>

static inline double radians (double degrees) {return degrees * M_PI/180;}

extern UIImage* resizedIfLargerImagePreservingAspectRatio(UIImage* sourceImage, CGSize targetSize);
extern UIImage* resizedImagePreservingAspectRatio(UIImage* sourceImage, CGSize targetSize);

//extern UIImage* resizedIfLargerImage(UIImage* sourceImage, CGSize targetSize);
//extern UIImage* resizedImage(UIImage* sourceImage, CGSize targetSize);

@interface UIImage (Resizing)

@end
