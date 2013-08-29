//
//  Audio.m
//  FeatureAlarm
//
//  Created by techcamp on 12/09/20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Audio.h"

@implementation Audio{
    CFURLRef soundURL1;
    CFURLRef soundURL2;
    CFURLRef soundURL3;
    CFURLRef soundURL4;
    CFURLRef soundURL5;
    CFURLRef soundURL6;
    
    SystemSoundID soundID1;
    SystemSoundID soundID2;
    SystemSoundID soundID3;
    SystemSoundID soundID4;
    SystemSoundID soundID5;
    SystemSoundID soundID6;
}

-(void)setSound{
    CFBundleRef mainBundle = CFBundleGetMainBundle();
    soundURL1 = CFBundleCopyResourceURL(mainBundle, CFSTR("sen_ge_panchi06"),CFSTR("mp3"), nil);
    soundURL2 = CFBundleCopyResourceURL(mainBundle, CFSTR("sen_ge_panchi12"),CFSTR("mp3"), nil);
    soundURL3 = CFBundleCopyResourceURL(mainBundle, CFSTR("ta_ta_pi03"),CFSTR("mp3"), nil);
    soundURL4 = CFBundleCopyResourceURL(mainBundle, CFSTR("seikai0104"),CFSTR("mp3"), nil);
    soundURL5 = CFBundleCopyResourceURL(mainBundle, CFSTR("se_quizmistake_1"),CFSTR("mp3"), nil);
    //soundURL6 = CFBundleCopyResourceURL(mainBundle, CFSTR("buzzer"),CFSTR("mp3"), nil);
    AudioServicesCreateSystemSoundID(soundURL1, &soundID1);
    AudioServicesCreateSystemSoundID(soundURL2, &soundID2);
    AudioServicesCreateSystemSoundID(soundURL3, &soundID3);
    AudioServicesCreateSystemSoundID(soundURL4, &soundID4);
    AudioServicesCreateSystemSoundID(soundURL5, &soundID5);
    AudioServicesCreateSystemSoundID(soundURL6, &soundID6);
}

-(void)punchi01{
    AudioServicesPlaySystemSound(soundID1);
}

-(void)punchi02{
    AudioServicesPlaySystemSound(soundID2);
}

-(void)pi{
    AudioServicesPlaySystemSound(soundID3);
}
-(void)vibration{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}
-(void)seikai{
    AudioServicesPlaySystemSound(soundID4);
}

-(void)miss{
    AudioServicesPlaySystemSound(soundID5);
}
/*
-(void)buzzer{
    AudioServicesPlaySystemSound(soundID6);
}
*/

+(id)initAudio{
    return [[self alloc]init];
}

-(id)init{
    self = [super init];
    [self setSound];
    return self;
}

@end