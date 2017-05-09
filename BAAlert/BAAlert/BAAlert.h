
/*!
 *  @brief      BAAlert
 *
 *  @author     BAHome
 *  @copyright  Copyright © 2016年 BAHome. All rights reserved.
 *  @version    V1.1.0
 */


#import <UIKit/UIKit.h>

/*! 背景高斯模糊枚举 默认：1 */
typedef NS_ENUM(NSInteger, BAAlertBlurEffectStyle) {
    /*! 较亮的白色模糊 */
    BAAlertBlurEffectStyleExtraLight = 1,
    /*! 一般亮的白色模糊 */
    BAAlertBlurEffectStyleLight,
    /*! 深色背景模糊 */
    BAAlertBlurEffectStyleDark
} NS_ENUM_AVAILABLE_IOS(7_0);

/*! 进出场动画枚举 默认：1 */
typedef NS_ENUM(NSUInteger, BAAlertAnimatingStyle) {
    /*! 缩放显示动画 */
    BAAlertAnimatingStyleScale = 1,
    /*! 晃动动画 */
    BAAlertAnimatingStyleShake,
    /*! 天上掉下动画 / 上升动画 */
    BAAlertAnimatingStyleFall,
};

@interface BAAlert : UIView

/*! 背景颜色 默认：半透明*/
@property (nonatomic, strong) UIColor *bgColor;

/*! 是否开启边缘触摸隐藏 alert 默认：NO */
@property (nonatomic, assign) BOOL isTouchEdgeHide;

/*! 背景图片名字 默认：没有图片*/
@property (nonatomic, strong) NSString *bgImageName;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
@property (nonatomic, assign, getter=isShowAnimate) BOOL showAnimate;

/*! 进出场动画枚举 默认：1 ，并且默认开启动画开关 */
@property (nonatomic, assign) BAAlertAnimatingStyle animatingStyle;

/*! 背景高斯模糊枚举 默认：1 */
@property (nonatomic, assign) BAAlertBlurEffectStyle blurEffectStyle;

/*!
 * 按钮点击事件回调
 */
@property (strong, nonatomic) void (^buttonActionBlock)(NSInteger index);


/*!
 *  创建一个完全自定义的 alertView，注意：【自定义 alert 只适用于竖屏状态！】
 *
 *  @param customView    自定义 View
 *  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
 */
+ (void)ba_showCustomView:(UIView *)customView
            configuration:(void (^)(BAAlert *tempView)) configuration;

/*!
 *  创建一个类似于系统的alert
 *
 *  @param title         标题：可空
 *  @param message       消息内容：可空
 *  @param image         图片：可空
 *  @param buttonTitles  按钮标题：不可空
 *  @param buttonTitlesColor  按钮标题颜色：可空，默认蓝色
 *  @param configuration 属性配置：如 bgColor、buttonTitleColor、isTouchEdgeHide...
 *  @param action        按钮的点击事件处理
 */
+ (void)ba_showAlertWithTitle:(NSString *)title
                      message:(NSString *)message
                        image:(UIImage *)image
                 buttonTitles:(NSArray *)buttonTitles
            buttonTitlesColor:(NSArray <UIColor *>*)buttonTitlesColor
                configuration:(void (^)(BAAlert *tempView)) configuration
                  actionClick:(void (^)(NSInteger index)) action;

/*!
 *  视图显示
 */
- (void)ba_showAlertView;

/*!
 *  视图消失
 */
- (void)ba_dismissAlertView;


@end
