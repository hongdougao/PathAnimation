//
//  UIButton+MSPathAnimation.h
//  PathAnimation
//
//  Created by Yangyue on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MSPathAnimation)

-(void)turnAroundSelfWithFromValue:(CGFloat)fromValue andToValue:(CGFloat  )toValue andRotation:(CGFloat)rotation andDuration:(CFTimeInterval)duration;

@end
