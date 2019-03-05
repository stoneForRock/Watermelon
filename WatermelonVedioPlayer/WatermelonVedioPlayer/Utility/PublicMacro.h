//
//  PublicMacro.h
//  WatermelonVedioPlayer
//
//  Created by shichuang on 2019/1/17.
//  Copyright © 2019 VedioPlayer. All rights reserved.
//

#ifndef PublicMacro_h
#define PublicMacro_h

#define kPageSize 20

// Tools
#define Weak(x) __weak __typeof__(x) __weak_##x##__ = x;
#define Strong(x) __typeof__(x) x = __weak_##x##__;

#define dispatch_main_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define INSTANCE_XIB_H +(instancetype)instanceFromXib;
#define INSTANCE_XIB_M(s,c) \
+ (instancetype)instanceFromXib {\
return [[UIStoryboard storyboardWithName:s bundle:nil] instantiateViewControllerWithIdentifier:NSStringFromClass([c class])];\
}

//系统
#ifndef kSystemVersion
#define kSystemVersion [UIDevice currentDevice].systemVersion.doubleValue
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif

#ifndef kiOS10Later
#define kiOS10Later (kSystemVersion >= 10)
#endif

#ifndef kiOS11Later
#define kiOS11Later (kSystemVersion >= 11)
#endif

//尺寸
#define ScreenBounds [[UIScreen mainScreen] bounds]     //屏幕
#define ScreenFullHeight [[UIScreen mainScreen] bounds].size.height //屏幕高度
#define ScreenFullWidth [[UIScreen mainScreen] bounds].size.width   //屏幕宽度
#define StatusBarHeight 20.0        //状态栏高度
#define NavigationBarHeight 44.0    //导航栏高度
#define TabBarHeight 49.0           //标签栏高度
#define ToolBarHeight 44.0          //工具栏高度
#define NumKeyboardHeight 216.0      //键盘高度
#define SearchAreaHeight 54.0        //搜索框高度
#define MainHeight ScreenFullHeight - StatusBarHeight //主屏幕高度

//使用RGBA值构建Color,其中RGB值分别除以255
#define COLORWITHRGBADIVIDE255(_RED,_GREEN,_BLUE,_ALPHA) [UIColor colorWithRed:_RED/255.0 green:_GREEN/255.0 blue:_BLUE/255.0 alpha:_ALPHA]

#define COLORWITHRGBA(rgbValue, alphaValue)        [UIColor colorWithRed:((float)(((rgbValue) & 0xFF0000) >> 16))/255.0 \
green:((float)(((rgbValue) & 0x00FF00) >> 8))/255.0 \
blue:((float)((rgbValue) & 0x0000FF))/255.0 \
alpha:(alphaValue)]

#if DEBUG
#define Assert(condition, desc) NSAssert(condition, desc);
#define Assert1(condition, desc, arg1) NSAssert1(condition, desc, arg1);
#define Assert2(condition, desc, arg1, arg2) NSAssert2(condition, desc, arg1, arg2);
#define Assert3(condition, desc, arg1, arg2, arg3) NSAssert3(condition, desc, arg1, arg2, arg3);
#define Assert4(condition, desc, arg1, arg2, arg3, arg4) NSAssert4(condition, desc, arg1, arg2, arg3, arg4);
#define Assert5(condition, desc, arg1, arg2, arg3, arg4, arg5) NSAssert5(condition, desc, arg1, arg2, arg3, arg4, arg5);
#else
#define Assert(condition, desc)
#define Assert1(condition, desc, arg1)
#define Assert2(condition, desc, arg1, arg2)
#define Assert3(condition, desc, arg1, arg2, arg3)
#define Assert4(condition, desc, arg1, arg2, arg3, arg4)
#define Assert5(condition, desc, arg1, arg2, arg3, arg4, arg5)
#endif

#endif /* PublicMacro_h */
