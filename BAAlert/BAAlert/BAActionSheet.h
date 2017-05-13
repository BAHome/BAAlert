
/*!
 *  @brief      BAAlert
 *
 *  @author     BAHome
 *  @copyright  Copyright © 2016年 BAHome. All rights reserved.
 *  @version    V1.1.0
 */


#import <UIKit/UIKit.h>
#import "BAAlert_Config.h"

@class BAActionSheet;

typedef void(^BAActionSheet_ConfigBlock)(BAActionSheet *tempView);


@interface BAActionSheet : UIView

/*! 是否开启边缘触摸隐藏 alert 默认：NO */
@property (nonatomic, assign) BOOL isTouchEdgeHide;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
@property (nonatomic, assign, getter=isShowAnimate) BOOL showAnimate;

/*! 进出场动画枚举 默认：1 ，并且默认开启动画开关 */
@property (nonatomic, assign) BAAlertAnimatingStyle animatingStyle;

/*!
 *
 *  @param title             标题内容(可空)
 *  @param style             样式
 *  @param contentArray      选项数组(NSString数组)
 *  @param imageArray        图片数组(UIImage数组)
 *  @param contentColorArray 内容颜色数组
 *  @param titleColor    titleColor
 *  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
 *  @param actionBlock  block回调点击的选项
 */
+ (void)ba_actionSheetShowWithTitle:(NSString *)title
                              style:(BAActionSheetStyle)style
                       contentArray:(NSArray <NSString *> *)contentArray
                         imageArray:(NSArray <UIImage *> *)imageArray
                         titleColor:(UIColor *)titleColor
                  contentColorArray:(NSArray <UIColor *> *)contentColorArray
                      configuration:(BAActionSheet_ConfigBlock)configuration
                        actionBlock:(BAAlert_ButtonActionBlock)actionBlock;

/*!
 *  隐藏 BAActionSheet
 */
- (void)ba_actionSheetHidden;

@end
