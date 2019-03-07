//
//  UniqueIdentificationTool.m
//  DGroupBusiness
//
//  Created by shichuang on 16/5/20.
//  Copyright © 2016年 Dachen Tech. All rights reserved.
//

#import "UniqueIdentificationTool.h"


static NSString * const KEY_IN_KEYCHAIN = @"com.VedioPlayer.WatermelonVedioPlayer";
static NSString * const KEY_UIID = @"com.VedioPlayer.WatermelonVedioPlayer.UIID";

@implementation UniqueIdentificationTool

+ (void)saveUIID {
    NSMutableDictionary *uiidKVPairs = [NSMutableDictionary dictionary];
    [uiidKVPairs setObject:[[[UIDevice currentDevice] identifierForVendor] UUIDString] forKey:KEY_UIID];
    [DGBKeyChain save:KEY_IN_KEYCHAIN data:uiidKVPairs];
}

+ (id)readUIID {
    NSMutableDictionary *uiidKVPairs = (NSMutableDictionary *)[DGBKeyChain load:KEY_IN_KEYCHAIN];
    return [uiidKVPairs objectForKey:KEY_UIID]?[uiidKVPairs objectForKey:KEY_UIID]:nil;
}

+ (void)deleteUIID {
    [DGBKeyChain delete:KEY_IN_KEYCHAIN];
}

@end
