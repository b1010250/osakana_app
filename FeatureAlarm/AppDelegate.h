//
//  AppDelegate.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSInteger scoreLabel;
}

@property (nonatomic,assign) NSInteger scoreLabel;
@property (strong, nonatomic) UIWindow *window;

@end
