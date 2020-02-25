//
//  ViewController.m
//  Category
//
//  Created by 赵鹏 on 2020/2/25.
//  Copyright © 2020 赵鹏. All rights reserved.
//

/**
 ·分类的实现原理分为以下的三个步骤：
 1、程序编译时：在终端中输入命令行语句，把分类文件编译为.cpp文件可知，可以看到分类会在程序编译结束的时候变为以下的数据结构（分类的底层结构）：
 struct _category_t {
     const char *name;
     struct _class_t *cls;
     const struct _method_list_t *instance_methods;
     const struct _method_list_t *class_methods;
     const struct _protocol_list_t *protocols;
     const struct _prop_list_t *properties;
 };
 其中分类中的实例方法会存储到上面的结构体中的"const struct _method_list_t *instance_methods"中，类方法会存储到上面的构体中的"const struct _method_list_t *class_methods"中，如果分类中有协议的话，会存储到上面的结构体中的"const struct _protocol_list_t *protocols"中，如果分类中写了属性的话，会存储到上面的结构体中的"const struct _prop_list_t *properties"中；
 2、程序运行时：然后在程序运行的时候会利用Runtime运行时机制，把上述结构体中存储的分类中的实例方法合并到原类的class对象中去，把上述结构体中存储的分类的类方法合并到原类的meta-class对象中去。所以说分类是Runtime运行时机制的又一重大的应用；
 3、原类的实例对象调用分类中的实例方法时：当原类的instance对象调用分类中的实例方法"[person eat];"的时候，系统首先会根据原类的instance对象里面的isa指针找到原类的class对象，然后在这个class对象里面的实例方法列表中查找那个分类的实例方法"eat"，根据上面2所述，在程序运行的时候，Runtime运行时机制会把分类中的实例方法合并到原类的class对象里面，所以系统在原类的class对象里面能够查找到这个分类的实例方法，然后再进行调用，整个调用过程结束。
 4、原类的类对象调用分类中的类方法时：当原类的class对象调用分类中的类方法"[ZPPerson classMethod];"的时候，系统首先会根据原类的class对象中的isa指针找到它的meta-class对象，然后在这个meta-class对象中的类方法列表中查找那个分类的类方法"classMethod"，根据上面2所述，在程序运行的时候，Runtime运行时机制会把分类中的类方法合并到原类的meta-class对象里面，所以系统在原类的meta-class对象里面能够查找到这个分类的类方法，然后再进行调用，整个调用过程结束。
 以上就是分类的实现原理。
 备注：不存在分类的class对象，也不存在分类的meta-class对象。类的class对象和meta-class对象各只有唯一的一份。

 ·原类和分类中方法的调用顺序：
 1、当原类只有一个分类，并且原类和分类中都有相同名称的实例方法或者类方法的时候，不管原类和分类的编译顺序，都会执行分类中的实例方法或者类方法，然后整个调用过程结束；
 2、当一个原类有多个分类的时候，并且原类和这些分类中都有相同名称的实例方法或者类方法的时候，当调用这些方法的时候，系统的调用顺序符合下面的两个原则：
 ①不管原类是先编译的还是后编译的，永远执行分类中的实例方法或者类方法，然后整个调用过程结束；
 ②系统总是先执行后编译的分类里面的实例方法或者类方法，然后整个调用过程结束。
 从上面可以看出，分类里面的方法会覆盖原类里面的方法。
 
 ·分类和类拓展的区别：
 分类是在程序运行的时候才会把相应的东西合并到原类的class对象中去的，而类扩展是在程序编译的时候就会把相应的东西合并到原类的class对象中去的。
 */

#import "ViewController.h"
#import "ZPPerson.h"
#import "ZPPerson+ZPTest.h"
#import "ZPPerson+ZPEat.h"
#include <objc/message.h>

@interface ViewController ()

@end

@implementation ViewController

#pragma mark ---------- 生命周期 ----------
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ZPPerson *person = [[ZPPerson alloc] init];
    
    //原类的实例对象调用分类中的实例方法
//    [person test];
    
    //原类的类对象调用分类中的类方法
//    [ZPPerson classMethod];
    
    //分类和原类中都有相同名称的实例方法，原类的实例对象调用这个实例方法
    [person run];
    
    //分类和原类中都有相同名称的类方法，类对象调用这个类方法
//    [ZPPerson jump];
}

@end
