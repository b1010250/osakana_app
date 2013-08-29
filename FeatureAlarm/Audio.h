//
//  Audio.h
//  FeatureAlarm
//
//  Created by techcamp on 12/09/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AudioToolbox/AudioToolBox.h>
#import <AudioToolbox/AudioServices.h>


@interface Audio : NSObject
+(id) initAudio;
-(id)init;
-(void)setSound;
-(void)punchi01;
-(void)punchi02;
-(void)pi;
-(void)seikai;
-(void)vibration;
-(void)miss;
//-(void)buzzer;

@end
