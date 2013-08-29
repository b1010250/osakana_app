//
//  MoleView.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MoleView.h"
#import "PunchViewController.h"
#import "AppDelegate.h"

@implementation MoleView
@synthesize	moleImageView;
@synthesize scoreLabel;


//タッチ判定メソッド
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event { 
	if ( moleImageView.isAnimating )
	{
        [self addScore];        //addScore呼び出し
        [moleImageView stopAnimating];      //アニメーション停止
        //printf("touch"); test用
	}
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)addScore { 
    AppDelegate *appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    appDelegate.scoreLabel++;       //scoreLabelに追加
}


//パンチセットアップメソッド
- (void)setup {

    //アニメーション処理
    moleImageView = [[UIImageView alloc] init];
    moleImageView.frame = self.bounds;//画像を表示するためのクラスであるUIImageViewを作成
    [self addSubview:moleImageView];//UIImageViewの表示領域を設定
    moleImageView.animationImages = 
    [NSArray arrayWithObjects:[UIImage imageNamed:@"punchs.png"],//画像の読み込み
     [UIImage imageNamed:@"punchm.png"],
     [UIImage imageNamed:@"punchb.png"],
     [UIImage imageNamed:@"punchs.png"],nil];
    
    moleImageView.animationDuration = 0.4;//0.4がいい
    // [moleImageView startAnimating];//アニメーションスタート
    moleImageView.animationRepeatCount = 1; // アニメーションが一回で終わるようにするためのセット
}





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end