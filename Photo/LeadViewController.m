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
    if (screeHieght == 480) {
        array = @[@"lead4-1",@"lead4-2",@"lead4-3",@"lead4-4"];
    }else if(screeHieght == 568){
        array = @[@"lead5-1",@"lead5-2",@"lead5-3",@"lead5-4"];
    }else{
        array = @[@"lead6-1",@"lead6-2",@"lead6-3",@"lead6-4"];
    }
    self.scrollview.contentSize = CGSizeMake(screenWidth*4, screeHieght);
    for (int i=0; i<4; i++) {
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(i*screenWidth, 0, screenWidth, screeHieght)];
        imageview.image = [UIImage imageNamed:array[i]];
        [self.scrollview addSubview:imageview];
    }
    
    [self.view addSubview:self.btn];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%f",scrollView.contentOffset.x/screenWidth);
    if (scrollView.contentOffset.x/screenWidth==0) {
        _btn.userInteractionEnabled=NO;
        [_btn setImage:[UIImage imageNamed:@"di1"] forState:0];
    }else if (scrollView.contentOffset.x/screenWidth==1){
        _btn.userInteractionEnabled=NO;
        [_btn setImage:[UIImage imageNamed:@"di2"] forState:0];
    }else if (scrollView.contentOffset.x/screenWidth==2){
        _btn.userInteractionEnabled=NO;
        [_btn setImage:[UIImage imageNamed:@"di3"] forState:0];
    }else if (scrollView.contentOffset.x/screenWidth==3){
        _btn.userInteractionEnabled=YES;
        [_btn setImage:[UIImage imageNamed:@"di4"] forState:0];
    }
}

#pragma mark 懒加载
- (UIScrollView *)scrollview{
    
    if (_scrollview == nil) {
        
        _scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, screeHieght)];
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
        
        _btn = [[UIButton alloc]initWithFrame:CGRectMake(screenWidth/2-50*SCALEW, screeHieght-76*SCALEH, 100*SCALEW, 36*SCALEW)];
        _btn.userInteractionEnabled = NO;
        [_btn setImage:[UIImage imageNamed:@"di1"] forState:0];
        [_btn addTarget:self action:@selector(btnPush) forControlEvents:UIControlEventTouchUpInside];
        _btn.backgroundColor = [UIColor clearColor];
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
