//
//  BtnAnimationView.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/4.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "BtnAnimationView.h"
#import "UIButton+MSPathAnimation.h"
#define  BTN_TAG 1000

@interface BtnAnimationView(){
//    BOOL btnPush;
}
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnD;
@property (weak, nonatomic) IBOutlet UIButton *btnE;


@end
@implementation BtnAnimationView


+ (BtnAnimationView *)creatBtnAnimationView{
    BtnAnimationView *view = [[NSBundle mainBundle]loadNibNamed:@"BtnAnimationView" owner:nil options:nil][0];
    [view giveTagAndRadius];
    [view setBtnPush:NO];
    view.blackView.alpha = 0.0;
    return view;
}

- (void)giveTagAndRadius{
    NSArray *btnArr = @[_btnA,_btnB,_btnC,_btnD,_btnE];
    for (int i = 0; i < btnArr.count ; i++) {
        UIButton *btn = btnArr[i];
        btn.layer.cornerRadius = 8;
        btn.tag = BTN_TAG + 1 + i;
    }
    
}
-(BlackView *)blackView{
    if (!_blackView) {
        _blackView = [[BlackView alloc]initWithFrame:self. frame];
        [_blackView setBackgroundColor:[UIColor blackColor]];
        
         
        [self  addSubview:_blackView];
        [self sendSubviewToBack:_blackView];
    }
    return _blackView;
}
-(void)btnAnimationViewOriginal{
    [self.blackView setAlpha:0.0];
 }

- (IBAction)menuBtnPush:(id)sender {
    if (self.menuPushBlock  ) {
        self.menuPushBlock();
    }
    CGFloat fromFloat ;
    CGFloat toValue;
    CGFloat rotation;
    
    int64_t delayInSecond ;
    if (_btnPush) {
        
        [self moveToOrigin ];
        
        delayInSecond =1;
        
        fromFloat = 0.0;
        toValue = M_PI / 4;
        rotation = - M_PI / 4;
        
    }else{
        
        [self MoveToTop ];
        
        delayInSecond = 1;
        
        fromFloat = M_PI / 4;
        toValue = 0.0;
        rotation = 0;
        
    }
    
    [sender turnAroundSelfWithFromValue:fromFloat
                             andToValue:toValue
                            andRotation:rotation
                            andDuration:0.1];
    
    _btnPush = !_btnPush;
    
}

 


- (void)MoveToTop {
    NSArray *btnArr = @[_btnA,_btnB,_btnC,_btnD,_btnE];
    for (int i = 0; i < btnArr.count ; i++) {
        UIButton *btn = btnArr[i];
        
        int positionX;
        int positionY;
        switch (btn.tag  - BTN_TAG) {
            case 1:
                positionX =   -39;
                positionY =  -100;
                break;
            case 2:
                positionX =   -80;
                positionY =   -80;
                break;
            case 3:
                positionX =   0;
                positionY =   -112;
                break;
            case 4:
                positionX =   80;
                positionY =  -80;
                break;
            case 5:
                positionX =   39;
                positionY =   -100;
                break;
                
            default:
                break;
        }
        
        
        
        [UIView animateWithDuration:0.2
                              delay:0.0
             usingSpringWithDamping:0.6
              initialSpringVelocity:0.0
                            options: UIViewAnimationOptionTransitionNone
                         animations:^{
            btn.frame = CGRectMake(CGRectGetMaxX(btn.frame) + positionX - 30/2, CGRectGetMaxY(btn.frame)  +positionY - 30/2, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
            [btn turnAroundSelfWithFromValue:0.0 andToValue:M_PI * 2 andRotation:0 andDuration:0.3];
            
            
        } completion:^(BOOL finished) {
        }];
        
        [self changeBlackView];
        
        
    }
}
-(void)changeBlackView {
    float alphaNow = self.blackView.alpha;
    float alphaAfter = alphaNow == 0 ? 0.8 :0;
    
    CABasicAnimation *animationAppear = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animationAppear setFromValue:[NSNumber numberWithDouble:alphaNow]];
    [animationAppear setToValue:[NSNumber numberWithDouble:alphaAfter]];
    [animationAppear setDuration:0.5];
    
    [self.blackView.layer addAnimation:animationAppear forKey:nil];
    [self.blackView setAlpha:alphaAfter];
}
- (void)moveToOrigin {
    NSArray *btnArr = @[_btnA,_btnB,_btnC,_btnD,_btnE];
    for (int i = 0; i < btnArr.count ; i++) {
        UIButton *btn = btnArr[i];
        [UIView animateWithDuration:0.6
                              delay:0.0
                            options:UIViewAnimationOptionTransitionNone
                         animations:^{
            [btn turnAroundSelfWithFromValue:0.0
                                  andToValue:M_PI * 1
                                 andRotation:0
                                 andDuration:0.3];
        } completion:^(BOOL finished) {}];
        
        
        [UIView animateWithDuration:0.1
                              delay:0.3
                            options:UIViewAnimationOptionCurveEaseOut animations:^{
            [btn setCenter:_bottomBtn.center];
        } completion:^(BOOL finished) {
            [self changeBlackView];
        }];
        
        
    }
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim valueForKey:@"name"]) {
        NSString *name = [anim valueForKey:@"name"];
        if ( [name isEqualToString:@"topAnimation"]) {
            
            UIButton *btn = (UIButton *)[anim valueForKey:@"animationObj"];
            [btn turnAroundSelfWithFromValue:- M_PI / 2 andToValue:M_PI * 1 andRotation:0 andDuration:0.3];
            
        }
    }
}

@end
