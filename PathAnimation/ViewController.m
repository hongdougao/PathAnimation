//
//  ViewController.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"

#import "UIButton+MSPathAnimation.h"

#import "BtnAnimationView.h"
#import "HitTestView.h"
#define  BTN_TAG 1000
@interface ViewController (){
    BOOL btnPush;
}



@property (strong,nonatomic)     BtnAnimationView *btnAniView;
@property (strong,nonatomic)    HitTestView *hitTestView;
@end

@implementation ViewController
- (BtnAnimationView *)btnAniView{
    if (!_btnAniView) {
        _btnAniView = [ BtnAnimationView creatBtnAnimationView];
         _btnAniView .frame  = self.view.bounds;
    }
    return _btnAniView;
}
- (HitTestView *)hitTestView{
    if (!_hitTestView) {
        _hitTestView = [[HitTestView alloc]init];
        _hitTestView.frame = CGRectMake(0, 50, 320, 444);
    }
    return _hitTestView;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
    [self.view addSubview:self.btnAniView];
    [self.btnAniView addSubview:self.hitTestView];
     [self.btnAniView insertSubview:self.hitTestView belowSubview:self.btnAniView.blackView];
    
    self.btnAniView.blackView.frame = self.view.frame;
    __weak typeof (&*self)weakSelf=self;
    
    
   
    
    [self.btnAniView setMenuPushBlock:^{
       
        [weakSelf.hitTestView afterMenuBtnPush];
 
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
