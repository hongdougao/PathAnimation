//
//  BtnAnimationView.h
//  PathAnimation
//
//  Created by Yangyue on 15/6/4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BtnAnimationView : UIView

@property (nonatomic,copy)void(^menuPushBlock)(void);

 @property (retain, nonatomic)UIView *blackView;


@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;

@property (nonatomic)BOOL btnPush;
+ (BtnAnimationView *)creatBtnAnimationView;
@end
