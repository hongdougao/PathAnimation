//
//  ViewController.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"
#define  BTN_TAG 1000
@interface ViewController ()
{
    BOOL btnPush;
}

@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
@property (weak, nonatomic) IBOutlet UIButton *btnA;
@property (weak, nonatomic) IBOutlet UIButton *btnB;
@property (weak, nonatomic) IBOutlet UIButton *btnC;
@property (weak, nonatomic) IBOutlet UIButton *btnD;
@property (weak, nonatomic) IBOutlet UIButton *btnE;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btnPush = NO;
    
    _btnA.layer.cornerRadius = 8;
    _btnB.layer.cornerRadius = 8;
    _btnC.layer.cornerRadius = 8;
    _btnD.layer.cornerRadius = 8;
    _btnE.layer.cornerRadius = 8;
    
    _btnA.tag = BTN_TAG + 1;
    _btnB.tag = BTN_TAG + 2;
    _btnC.tag = BTN_TAG + 3;
    _btnD.tag = BTN_TAG + 4;
    _btnE.tag = BTN_TAG + 5;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuBtnPush:(id)sender {
    [_bottomBtn setEnabled:NO];
    

    
    CGFloat fromFloat ;
    CGFloat toValue;
    CGFloat rotation;
    if (btnPush) {

        [self moveToOrigin:_btnA];
        [self moveToOrigin:_btnB];
        [self moveToOrigin:_btnC];
        [self moveToOrigin:_btnD];
        [self moveToOrigin:_btnE];
        
 
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.6 *NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [_bottomBtn setEnabled:YES];
            
        });
       
        fromFloat = 0.0;
        toValue = M_PI / 4;
        rotation = - M_PI / 4;
        
    }else{
  
        [self MoveToTop:_btnA];
        [self MoveToTop:_btnB];
        [self MoveToTop:_btnC];
        [self MoveToTop:_btnD];
        [self MoveToTop:_btnE];

     
        dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 *NSEC_PER_SEC));
        dispatch_after(delayTime, dispatch_get_main_queue(), ^{
            [_bottomBtn setEnabled:YES];
            
        });
        
        fromFloat = M_PI / 4;
        toValue = 0.0;
        rotation = 0;

    }
    
    [self turnAroundBtn:sender WithFromValue:fromFloat andToValue:toValue andRotation:rotation andDuration:0.1];

    btnPush = !btnPush;
    
    
 }


- (void)MoveToTop:(UIButton *)btn{
    
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    [group setBeginTime:CACurrentMediaTime()  ];
    [group setDuration:0.1];
    [group setFillMode:kCAFillModeBackwards];
    [group setDelegate:self];
    
    CABasicAnimation *animationTop = [CABasicAnimation animationWithKeyPath:@"position"];
    [animationTop setFromValue:[NSValue valueWithCGPoint:_bottomBtn.center]];
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
    
    [animationTop setToValue:[NSValue valueWithCGPoint:CGPointMake( CGRectGetMaxX(_bottomBtn.frame) + positionX, CGRectGetMaxY(_bottomBtn.frame)  +positionY) ]];
    
 
    CABasicAnimation *animationAppear = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [animationAppear setFromValue:[NSNumber numberWithDouble:0.0]];
    [animationAppear setToValue:[NSNumber numberWithDouble:1.0]];
    
    group.animations = @[animationTop ,
                         animationAppear
                         ];
    [group setValue:@"topAnimation" forKey:@"name"];
    [group setValue:btn forKey:@"animationObj"];
    
    [btn.layer addAnimation:group forKey:nil];
    btn.frame = CGRectMake(CGRectGetMaxX(btn.frame) + positionX - 30/2, CGRectGetMaxY(btn.frame)  +positionY - 30/2, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
}

- (void)moveToOrigin:(UIButton *)btn{

        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            [self turnAroundBtn:btn WithFromValue:0.0 andToValue:M_PI * 1  andRotation:0 andDuration:0.3];
        } completion:^(BOOL finished) {
            if (finished) {
                [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
                     [btn setCenter:_bottomBtn.center];
                } completion:^(BOOL finished) {
                    
                    [self.view setBackgroundColor:[UIColor whiteColor]];

                }];
            }
      
        }];
 

}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    if ([anim valueForKey:@"name"]) {
        NSString *name = [anim valueForKey:@"name"];
        if ( [name isEqualToString:@"topAnimation"]) {
            
            UIButton *btn = (UIButton *)[anim valueForKey:@"animationObj"];
            [self turnAroundBtn:btn WithFromValue:- M_PI / 2 andToValue:M_PI * 1 andRotation:0 andDuration:0.3];

            
        }else if ([name isEqualToString:@"turnAroundBtn"] ){
            if (![[anim valueForKey:@"animationObj"] isEqual:_bottomBtn]) {
                NSLog(@"turnAroundBtn finished");
            }
        
        }
     }
}

- (void)turnAroundBtn:(UIButton *)btn WithFromValue:(CGFloat)fromValue andToValue:(CGFloat  )toValue andRotation:(CGFloat)rotation andDuration:(CFTimeInterval)duration{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.duration = duration;
    animation.repeatCount = 1;
    
    animation.fromValue = [NSNumber numberWithFloat: fromValue];
    animation.toValue = [NSNumber numberWithFloat:toValue];
    
    
    
    [animation setValue:@"turnAroundBtn" forKey:@"name"];
    [animation setValue:btn forKey:@"animationObj"];
    [btn.layer addAnimation:animation forKey:nil];
    [btn  setTransform:CGAffineTransformMakeRotation(rotation)];
    
    if (![btn isEqual:_bottomBtn]) {
       
        [self.view setBackgroundColor:[UIColor lightGrayColor]];
        

    }
    

}

@end
