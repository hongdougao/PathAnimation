//
//  UIButton+MSPathAnimation.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UIButton+MSPathAnimation.h"

@implementation UIButton (MSPathAnimation)

-(void)turnAroundSelfWithFromValue:(CGFloat)fromValue andToValue:(CGFloat  )toValue andRotation:(CGFloat)rotation andDuration:(CFTimeInterval)duration{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        animation.duration = duration;
        animation.repeatCount = 1;
        
        animation.fromValue = [NSNumber numberWithFloat: fromValue];
        animation.toValue = [NSNumber numberWithFloat:toValue];
        
        
        
        [animation setValue:@"turnAroundBtn" forKey:@"name"];
        [animation setValue:self forKey:@"animationObj"];
        [self.layer addAnimation:animation forKey:nil];
        [self  setTransform:CGAffineTransformMakeRotation(rotation)];
    }


@end
