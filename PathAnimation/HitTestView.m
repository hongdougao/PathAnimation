//
//  hitTestView.m
//  PathAnimation
//
//  Created by Yangyue on 15/6/5.
//  Copyright (c) 2015年 mac. All rights reserved.
//

#import "HitTestView.h"

#import "UITableView+MSWave.h"

@interface HitTestView()<UITableViewDataSource,UITableViewDelegate>{

}
@property (strong, nonatomic)  UITableView *aTB;

@property (strong,nonatomic)UIScrollView *sv;
@end
@implementation HitTestView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)afterMenuBtnPush{

    [self.sv scrollRectToVisible:CGRectMake(0, 0, 320,444 ) animated:YES];
    [self.aTB msTbWaving];


}
-(instancetype)init{
   self =  [super init];
    [self addSubview:self.sv];
     return self;

}



-(UITableView *)aTB{

    if (!_aTB) {
        _aTB = [[UITableView alloc]initWithFrame: CGRectMake(0, 0, 320, 444) ];
        _aTB.delegate = self;
        _aTB.dataSource = self;
    }
    return _aTB;
}
-(UIScrollView *)sv{
    if (!_sv) {
        _sv = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 50, 320, 444)];
        _sv.delegate = self;
        _sv.pagingEnabled = YES;
        [_sv setContentSize:CGSizeMake(320 *3, 444)];
         self.aTB .frame =CGRectMake(0, 0, 320, 444);
        [_sv addSubview:self.aTB];
        
    }
    return _sv;
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
    [cell setBackgroundColor:[UIColor lightGrayColor]];
     cell.textLabel.text = [NSString stringWithFormat:@"第%ld 行",(long)indexPath.row+1];
    return cell;
}

@end
