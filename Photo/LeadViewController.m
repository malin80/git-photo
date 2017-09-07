//
//  LeadViewController.m
//  Xiufenqi2.0
//
//  Created by 不丕 on 16/11/8.
//  Copyright © 2016年 艾蒂尔文化传媒有限公司. All rights reserved.
//

#import "LeadViewController.h"

@interface LeadViewController ()

@end

@implementation LeadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollview];
    NSArray *array;
    if (ScreenHieght == 480) {
        array = @[@"lead_1_1.jpg",@"lead_2_1.jpg",@"lead_2_1.jpg"];
    }else if(ScreenHieght == 568){
        array = @[@"lead_1_2.jpg",@"lead_2_2.jpg",@"lead_3_2.jpg"];
    }else{
        array = @[@"lead_1_3.jpg",@"lead_2_3.jpg",@"lead_3_3.jpg"];
    }
    self.scrollview.contentSize = CGSizeMake(ScreenWidth*3, ScreenHieght);
    for (int i=0; i<3; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*ScreenWidth, 0, ScreenWidth, ScreenHieght)];
        imageview.image = [UIImage imageNamed:array[i]];
        [self.scrollview addSubview:imageview];
    }
    [self.view addSubview:self.btn];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x/ScreenWidth);
    if (scrollView.contentOffset.x/ScreenWidth==0) {
        _btn.userInteractionEnabled=NO;
        [_btn setImage:[UIImage imageNamed:@"di1"] forState:0];
    }else if (scrollView.contentOffset.x/ScreenWidth==1){
        _btn.userInteractionEnabled=NO;
        [_btn setImage:[UIImage imageNamed:@"di2"] forState:0];
    }else if (scrollView.contentOffset.x/ScreenWidth==2){
        _btn.userInteractionEnabled = YES;
        [_btn setImage:[UIImage imageNamed:@"di3"] forState:0];
        _btn.hidden = NO;
    }
}

#pragma mark 懒加载
- (UIScrollView *)scrollview{
    if (_scrollview == nil) {
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHieght)];
        _scrollview.showsHorizontalScrollIndicator = NO;
        _scrollview.delegate = self;
        _scrollview.bounces = NO;
        _scrollview.pagingEnabled = YES;
        _scrollview.backgroundColor = [UIColor clearColor];
    }
    return _scrollview;
}
- (UIButton *)btn{
    if (_btn == nil) {
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth/2-50*SCALEW, ScreenHieght-76*SCALEH, 100*SCALEW, 36*SCALEW)];
        _btn.userInteractionEnabled = NO;
        [_btn setImage:[UIImage imageNamed:@"di1"] forState:0];
        [_btn addTarget:self action:@selector(btnPush) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = [UIColor redColor];
        _btn.hidden = YES;
    }
    return _btn;
}

-(void)btnPush{
    self.block();
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
