//
//  BlackView.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BlackView.h"

@implementation BlackView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 */

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
     UIView *hitView = [super hitTest:point withEvent:event];
     
     if (hitView == self ) {
         NSLog(@"self");
         return nil;
         
     }else {
         NSLog(@"hitView");
         return hitView;
     }
 }
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    
    return CGRectContainsPoint(self.bounds,point);
}

@end
