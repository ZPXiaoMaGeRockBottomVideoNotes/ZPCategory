//
//  ZPPerson+ZPEat.m
//  Category
//
//  Created by 赵鹏 on 2020/2/25.
//  Copyright © 2020 赵鹏. All rights reserved.
//

#import "ZPPerson+ZPEat.h"

@implementation ZPPerson (ZPEat)

- (void)run
{
    NSLog(@"ZPPerson+ZPEat - run");
}

+ (void)jump
{
    NSLog(@"ZPPerson+ZPEat + jump");
}

- (void)eat
{
    NSLog(@"eat");
}

+ (void)classMethod
{
    NSLog(@"classMethod");
}

@end
