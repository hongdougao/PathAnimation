//
//  UITableView+MSWave.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "UITableView+MSWave.h"

@implementation UITableView (MSWave)

- (void)msTbWaving{
    [self setContentOffset:self.contentOffset animated:NO];
    [UIView animateWithDuration:.2 delay:0 usingSpringWithDamping:0.2 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
        self.hidden = YES;
        [self reloadData];
    } completion:^(BOOL finished) {
        self.hidden = NO;
        [self visibleRowPrepearToWaving];
    }];


}

- (void)visibleRowPrepearToWaving{

    NSArray *arr = [self indexPathsForVisibleRows];
    
    for (int i = 0; i < [arr count]; i ++) {
        NSIndexPath *path = arr[i];
         NSArray *ar = @[path, [NSNumber numberWithInt:i]];
        [self performSelector:@selector(startWaingAnimation:) withObject:ar];
    }
}

- (void) startWaingAnimation:(NSArray *)arr{
    
    NSIndexPath *path = arr[0];
    
    UITableViewCell *cell = [self cellForRowAtIndexPath:path];
    CGPoint originPoint = cell.center;
 
                          [UIView animateWithDuration:.5 + [arr[1] intValue] *0.2
                                               delay:0
                              usingSpringWithDamping:6
                               initialSpringVelocity:0.0
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              cell.center = CGPointMake(originPoint.x + 10 * [arr[1] intValue] , originPoint.y);
                                          } completion:^(BOOL finished) {
                                          
                                          }];
    [UIView animateWithDuration:.5+ [arr[1] intValue] *0.2
                          delay:0.5
         usingSpringWithDamping:60
          initialSpringVelocity:0.0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         cell.center =originPoint;
                     } completion:^(BOOL finished) {
                         
                     }];
 
}
@end
