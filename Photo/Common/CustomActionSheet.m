//
//  CustomActionSheet.m
//  Photo
//
//  Created by malin  on 2017/7/24.
//  Copyright © 2017年 malin . All rights reserved.
//

#import "CustomActionSheet.h"

@implementation CustomActionSheet

+ (CustomActionSheet *)createShareActionSheet {
    NSDictionary *weixinFriend = @{};
    NSDictionary *weixinShare = @{};
//    if ([WeChatAPIAdapter isAppInstalled] && [WeChatAPIAdapter isSupportSSO]) {
     weixinFriend = [NSDictionary dictionaryWithObjectsAndKeys:@"微信朋友圈",@"title",[UIImage imageNamed:@"common_share_friend_wechat_normal"],@"normal",nil];
//        weixinShare = [NSDictionary dictionaryWithObjectsAndKeys:@"朋友圈",[UIImage imageNamed:@"common_share_wechat_normal"],nil];
//    }
    CustomActionSheet *action = [[CustomActionSheet alloc] iniWithTitle:nil withBtnInfo:
                                 weixinShare,
                                 weixinFriend,
                                 nil];
                            
    return action;
}

- (id)iniWithTitle:(NSString *)title withBtnInfo:(NSDictionary *)btnInfo,...
{
    _actionViewBg = [[UIImageView alloc] init];
    _actionViewBg.userInteractionEnabled = YES;
    [self addSubview:_actionViewBg];

    va_list argList;
    va_start(argList, btnInfo);
    _count = 0;
    int tag = -1;
    do {
        ++tag;
        if (btnInfo.count <= 0) {
            continue;
        }
        UIButton *actionBtn = [[UIButton alloc] initWithFrame:CGRectMake(_count%3 * [[UIScreen mainScreen] bounds].size.width/3, _count/3 * 80 , [[UIScreen mainScreen] bounds].size.width/3, 80 - 20)];
        actionBtn.tag = 1000 + tag;
        actionBtn.backgroundColor = [UIColor whiteColor];
        [actionBtn addTarget:self action:@selector(clickActionBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *normalImage = [btnInfo valueForKey:@"normalImage"];
        [actionBtn setImage:normalImage forState:UIControlStateNormal];
        NSString *title = [btnInfo valueForKey:@"title"];
        CGSize size = [title sizeWithAttributes:@{ NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake((actionBtn.frame.size.width - size.width)/2, 80 - 20, size.width, size.height)];
        lblTitle.text = title;
        lblTitle.font = [UIFont systemFontOfSize:13];
        [actionBtn addSubview:lblTitle];
        lblTitle.textAlignment = UITextAlignmentCenter;
        lblTitle.backgroundColor = [UIColor whiteColor];
        [_actionViewBg addSubview:actionBtn];
        _count++;
    } while ((btnInfo = va_arg(argList, NSDictionary*)));
    va_end(argList);
    NSInteger row = 0;
    if (_count % 3 == 0) {
        row = _count/3;
    } else {
        row = _count/3 + 1;
    }
    _actionViewBg.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height, [[UIScreen mainScreen] bounds].size.width, row * 80);
    _actionViewBg.backgroundColor = [UIColor whiteColor];
    return self;
}

-(void)showCustomActionSheet
{
    
//    [pengPengDelegate.window addSubview:self];
//    LogVerbose(@"----------show custom actionSheet view and keyWindow = %@ and self frame = {x = %f y = %f w = %f h = %f}",[UIApplication sharedApplication].keyWindow,self.frame.origin.x,self.frame.origin.y,self.frame.size.width,self.frame.size.height);
    
//    [UIView animateWithDuration:0.25 animations:^{
//        _actionViewBg.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height - _actionViewBg.frame.size.height, _actionViewBg.frame.size.width, _actionViewBg.frame.size.height);
////        _backgroundView.alpha = 0.5;
//    } completion:^(BOOL finished) {
//    }];
    if ([self.delegate respondsToSelector:@selector(showActionSheet)]) {
        [self.delegate showActionSheet];
    }
    
}
@end
