//
//  AppCodeCheck.h
//  asdfaesfe
//
//  Created by heqin on 16/12/28.
//  Copyright © 2016年 heqin. All rights reserved.
//

#import <Foundation/Foundation.h>

// 之所以会重签名，是因为想要修改资源或者代码，但是重签名的ＩＤＰ的开发者证书ＩＤ是不会相同的。
// 所以根据重签名的ID来操作，应该是可以避免一部分人的重签名操作
// 先把打包使用的开发者的ＩＤ值存储下来，最好使用多个宏来存储，然后再拼在一起使用，这样在一定程度上加大了重签的难度



// 精友的企业ＩＤＰ发布证书的ＩＤ值：358B5J757A
// Heqin个人开发证书ID值：RHMZ543ANZ
// Heqin个人发布证书ID值：9U5ZW6T67V

// 下面分成几部分内容来存放，会增加破解的难度，理论上讲， 下面两部分应该存在不同的文件中，会更安全
#define IdpId0 @"358B5"
#define IdpId1 @"J757A"

// 是否进行重签名检查
#define AppCodeSignCheck NO


@interface AppCodeCheck : NSObject

// 进行IDP的id值比较，该值是一个10位的大写字母与数字混合的值
+ (BOOL)appPassResignCheck;

@end
