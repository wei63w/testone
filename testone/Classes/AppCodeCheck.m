//
//  AppCodeCheck.m
//  asdfaesfe
//
//  Created by heqin on 16/12/28.
//  Copyright © 2016年 heqin. All rights reserved.
//

#import "AppCodeCheck.h"

@implementation AppCodeCheck

+ (BOOL)appPassResignCheck {
#if DEBUG
    return YES;     // DEBUG场景下生成的app不会带mobileprovision文件，所以不做校验
#endif
    
    if (AppCodeSignCheck) {
        return [self checkCodesignPass:[NSString stringWithFormat:@"%@%@", IdpId0, IdpId1]];
    }else {
        return YES;     // 免签名检查
    }
}

+ (BOOL)checkCodesignPass:(NSString *)paramIdpId {
    
    // 描述文件路径
    NSString *embeddedPath = [[NSBundle mainBundle] pathForResource:@"embedded" ofType:@"mobileprovision"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:embeddedPath]) {
        
        // 读取application-identifier
        NSString *embeddedProvisioning = [NSString stringWithContentsOfFile:embeddedPath encoding:NSASCIIStringEncoding error:nil];
        NSArray *embeddedProvisioningLines = [embeddedProvisioning componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
        
        for (int i = 0; i < [embeddedProvisioningLines count]; i++) {
            if ([[embeddedProvisioningLines objectAtIndex:i] rangeOfString:@"application-identifier"].location != NSNotFound) {
                
                NSInteger fromPosition = [[embeddedProvisioningLines objectAtIndex:i+1] rangeOfString:@"<string>"].location+8;
                
                NSInteger toPosition = [[embeddedProvisioningLines objectAtIndex:i+1] rangeOfString:@"</string>"].location;
                
                NSRange range;
                range.location = fromPosition;
                range.length = toPosition - fromPosition;
                
                NSString *fullIdentifier = [[embeddedProvisioningLines objectAtIndex:i+1] substringWithRange:range];
                
                //                NSLog(@"%@", fullIdentifier);
                
                NSArray *identifierComponents = [fullIdentifier componentsSeparatedByString:@"."];
                NSString *appIdentifier = [identifierComponents firstObject];
                
                // 对比签名ID
                if ([appIdentifier compare:paramIdpId options:NSCaseInsensitiveSearch] == NSOrderedSame) {
                    NSLog(@"App code resign check pass");
                    return YES;
                }
                break;
            }
        }
    }
    
    NSLog(@"App code resign check fail");
    return NO;
}


@end
