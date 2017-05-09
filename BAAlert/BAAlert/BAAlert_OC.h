
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加ios开发技术群 479663605 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客    : http://boaihome.com
 
 *********************************************************************************
 
 */

/*!
 *********************************************************************************
 ************************************ 更新说明 ************************************
 *********************************************************************************
 
 #### version 1.1.3
 
 最新更新时间：2017-05-09 【倒叙】 <br>
 最新Version：【Version：1.1.3】 <br>
 更新内容： <br>
 1.1.3.1、pod 更新xib 文件 <br>
 
 
 最新更新时间：2017-05-08 【倒叙】
 最新Version：【Version：1.1.0】
 更新内容：
 1.1.0.1、优化方法名命名规范
 1.1.0.2、新增键盘内部处理
 1.1.0.3、用原生 autoLayout 重构，自定义 alert 的布局再也不是问题了
 1.1.0.4、优化代码结构，修复内在隐藏内存泄漏
 1.1.0.5、新增 BAAlert_OC.h 文件，只需导入 BAAlert_OC.h 一个文件就可以使用 alert 和 actionSheet 了
 1.1.0.6、删除了部分代码和属性，具体见源码 和 demo
 
 */


#ifndef BAAlert_OC_h
#define BAAlert_OC_h

#import "BAAlert.h"
#import "BAActionSheet.h"

#define SCREENWIDTH    [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT   [UIScreen mainScreen].bounds.size.height

#pragma mark - weak / strong
#define BAKit_WeakSelf        @BAKit_Weakify(self);
#define BAKit_StrongSelf      @BAKit_Strongify(self);

/*! RGB色值 */
#define BAKit_COLOR(R, G, B, A)       [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define BAKit_COLOR_Translucent       [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.3f]


/*！
 * 强弱引用转换，用于解决代码块（block）与强引用self之间的循环引用问题
 * 调用方式: `@BAKit_Weakify`实现弱引用转换，`@BAKit_Strongify`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify
 * [obj block:^{
 * @strongify_self
 * self.property = something;
 * }];
 */
#ifndef BAKit_Weakify
#if DEBUG
#if __has_feature(objc_arc)
#define BAKit_Weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;
#else
#define BAKit_Weakify(object) autoreleasepool{} __block __typeof__(object) block##_##object = object;
#endif
#else
#if __has_feature(objc_arc)
#define BAKit_Weakify(object) try{} @finally{} {} __weak __typeof__(object) weak##_##object = object;
#else
#define BAKit_Weakify(object) try{} @finally{} {} __block __typeof__(object) block##_##object = object;
#endif
#endif
#endif

/*！
 * 强弱引用转换，用于解决代码块（block）与强引用对象之间的循环引用问题
 * 调用方式: `@BAKit_Weakify(object)`实现弱引用转换，`@BAKit_Strongify(object)`实现强引用转换
 *
 * 示例：
 * @BAKit_Weakify(object)
 * [obj block:^{
 * @BAKit_Strongify(object)
 * strong_object = something;
 * }];
 */
#ifndef BAKit_Strongify
#if DEBUG
#if __has_feature(objc_arc)
#define BAKit_Strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;
#else
#define BAKit_Strongify(object) autoreleasepool{} __typeof__(object) object = block##_##object;
#endif
#else
#if __has_feature(objc_arc)
#define BAKit_Strongify(object) try{} @finally{} __typeof__(object) object = weak##_##object;
#else
#define BAKit_Strongify(object) try{} @finally{} __typeof__(object) object = block##_##object;
#endif
#endif
#endif

#ifndef __OPTIMIZE__
#define NSLog(...) NSLog(__VA_ARGS__)
#else
#define NSLog(...){}
#endif

#endif /* BAAlert_OC_h */
