//
//  ViewController.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/3.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "ViewController.h"

#import "UIButton+MSPathAnimation.h"
#import "UITableView+MSWave.h"

#import "BtnAnimationView.h"

#define  BTN_TAG 1000
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL btnPush;
}
@property (weak, nonatomic) IBOutlet UITableView *aTB;

@property (retain,nonatomic)UIScrollView *sv;
//
//@property (weak, nonatomic) IBOutlet UIButton *bottomBtn;
//@property (weak, nonatomic) IBOutlet UIButton *btnA;
//@property (weak, nonatomic) IBOutlet UIButton *btnB;
//@property (weak, nonatomic) IBOutlet UIButton *btnC;
//@property (weak, nonatomic) IBOutlet UIButton *btnD;
//@property (weak, nonatomic) IBOutlet UIButton *btnE;

@property (strong,nonatomic)     BtnAnimationView *btnAniView;

@end

@implementation ViewController
- (BtnAnimationView *)btnAniView{
    if (!_btnAniView) {
        _btnAniView = [ BtnAnimationView creatBtnAnimationView];
     
        _btnAniView .frame  = self.view.bounds;
    }
    return _btnAniView;
}
-(UIScrollView *)sv{
    if (!_sv) {
        _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, 320, 444)];
        _sv.delegate = self;
       
        [_sv setContentSize:CGSizeMake(320 *3, 444)];
        [_aTB removeFromSuperview];
        
        _aTB.frame =CGRectMake(0, 0, 320, 444);
        [_sv addSubview:self.aTB];
        
 
        
    }
    return _sv;
}
 
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    btnPush = NO;
    
    [self.view addSubview:self.btnAniView];
    self.btnAniView.btnPush = btnPush;
    __weak typeof (&*self)weakSelf=self;
    [self.btnAniView setMenuPushBlock:^{
        [weakSelf.sv scrollRectToVisible:CGRectMake(0, 0, 320, 444) animated:YES];
        [weakSelf.aTB msTbWaving];
    }];
//    [self.btnAniView evaluateBtnA:self.btnA andB:self.btnB andC:self.btnC andD:self.btnD andBottomBtn:self.bottomBtn];
    
//    self.btnAniView.bottomBtn = self.bottomBtn;
//    [self.btnAniView.bottomBtn addTarget:self action:@selector(menuBtnPush:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview: self.sv];
    
    self.aTB.delegate = self;
    self.aTB.dataSource = self;

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 20;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"tableviewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld 行",(long)indexPath.row+1];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)menuBtnPush:(id)sender {

}
//    CGFloat fromFloat ;
//    CGFloat toValue;
//    CGFloat rotation;
//    
//    int64_t delayInSecond ;
//    if (btnPush) {
//
//        [self moveToOrigin ];
//        
//        delayInSecond =1;
//       
//        fromFloat = 0.0;
//        toValue = M_PI / 4;
//        rotation = - M_PI / 4;
//        
//    }else{
//
//        [self MoveToTop ];
//        
//        delayInSecond = 1;
//
//        fromFloat = M_PI / 4;
//        toValue = 0.0;
//        rotation = 0;
//
//    }
//    
//    [sender turnAroundSelfWithFromValue:fromFloat andToValue:toValue andRotation:rotation andDuration:0.1];
// 
//    btnPush = !btnPush;
//    
//    
// }
//
//
//- (void)MoveToTop {
//    NSArray *btnArr = @[_btnA,_btnB,_btnC,_btnD,_btnE];
//    for (int i = 0; i < btnArr.count ; i++) {
//        UIButton *btn = btnArr[i];
// 
//    int positionX;
//    int positionY;
//    switch (btn.tag  - BTN_TAG) {
//        case 1:
//            positionX =   -39;
//            positionY =  -100;
//            break;
//        case 2:
//            positionX =   -80;
//            positionY =   -80;
//            break;
//        case 3:
//            positionX =   0;
//            positionY =   -112;
//            break;
//        case 4:
//            positionX =   80;
//            positionY =  -80;
//            break;
//        case 5:
//            positionX =   39;
//            positionY =   -100;
//            break;
//
//        default:
//            break;
//    }
//    
// 
//      
//        [UIView animateWithDuration:0.2 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options: UIViewAnimationOptionTransitionNone animations:^{
//                btn.frame = CGRectMake(CGRectGetMaxX(btn.frame) + positionX - 30/2, CGRectGetMaxY(btn.frame)  +positionY - 30/2, CGRectGetWidth(btn.frame), CGRectGetHeight(btn.frame));
//            [btn turnAroundSelfWithFromValue:0.0 andToValue:M_PI * 2 andRotation:0 andDuration:0.3];
//
//        
//        } completion:^(BOOL finished) {
//         }];
//        
//        [self changeBlackView];
//
//        
//          }
//}
//-(void)changeBlackView {
//    float alphaNow = self.blackView.alpha;
//    float alphaAfter = alphaNow == 0 ? 0.8 :0;
//    
//    CABasicAnimation *animationAppear = [CABasicAnimation animationWithKeyPath:@"opacity"];
//    [animationAppear setFromValue:[NSNumber numberWithDouble:alphaNow]];
//    [animationAppear setToValue:[NSNumber numberWithDouble:alphaAfter]];
//    [animationAppear setDuration:0.5];
//    
//    [self.blackView.layer addAnimation:animationAppear forKey:nil];
//    [self.blackView setAlpha:alphaAfter];
//}
//- (void)moveToOrigin {
//    NSArray *btnArr = @[_btnA,_btnB,_btnC,_btnD,_btnE];
//    for (int i = 0; i < btnArr.count ; i++) {
//        UIButton *btn = btnArr[i];
//        [UIView animateWithDuration:0.6 delay:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
//            [btn turnAroundSelfWithFromValue:0.0 andToValue:M_PI * 1  andRotation:0 andDuration:0.3];
//        } completion:^(BOOL finished) {}];
//        
// 
//        [UIView animateWithDuration:0.1 delay:0.3 options:UIViewAnimationOptionCurveEaseOut animations:^{
//            [btn setCenter:_bottomBtn.center];
//        } completion:^(BOOL finished) {
//            [self changeBlackView];
//        }];
//
// 
//    }
//}
//
//-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
//    if ([anim valueForKey:@"name"]) {
//        NSString *name = [anim valueForKey:@"name"];
//        if ( [name isEqualToString:@"topAnimation"]) {
//            
//            UIButton *btn = (UIButton *)[anim valueForKey:@"animationObj"];
//            [btn turnAroundSelfWithFromValue:- M_PI / 2 andToValue:M_PI * 1 andRotation:0 andDuration:0.3];
//
//        }
//    }
//}



@end
