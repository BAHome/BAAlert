
/*!
 *  @brief      BAAlert
 *
 *  @author     BAHome
 *  @copyright  Copyright © 2016年 BAHome. All rights reserved.
 *  @version    V1.1.0
 */


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BAActionSheetStyle) {
    /*!
     *  普通样式
     */
    BAActionSheetStyleNormal = 1,
    /*!
     *  带标题样式
     */
    BAActionSheetStyleTitle,
    /*!
     *  带图片和标题样式
     */
    BAActionSheetStyleImageAndTitle,
    /*!
     *  带图片样式
     */
    BAActionSheetStyleImage,
};

/*! 进出场动画枚举 默认：1 */
typedef NS_ENUM(NSUInteger, BAActionSheetAnimatingStyle) {
    /*! 缩放显示动画 */
    BAActionSheetAnimatingStyleScale = 1,
    /*! 晃动动画 */
    BAActionSheetAnimatingStyleShake,
    /*! 天上掉下动画 / 上升动画 */
    BAActionSheetAnimatingStyleFall,
};

typedef void(^ButtonActionBlock)(NSInteger index);

@interface BAActionSheet : UIView

/*! 是否开启边缘触摸隐藏 alert 默认：NO */
@property (nonatomic, assign) BOOL isTouchEdgeHide;

/*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
@property (nonatomic, assign, getter=isShowAnimate) BOOL showAnimate;

/*! 进出场动画枚举 默认：1 ，并且默认开启动画开关 */
@property (nonatomic, assign) BAActionSheetAnimatingStyle animatingStyle;


/*!
 *
 *  @param style             样式
 *  @param contentArray      选项数组(NSString数组)
 *  @param imageArray        图片数组(UIImage数组)
 *  @param redIndex          特别颜色的下标数组(NSNumber数组)
 *  @param title             标题内容(可空)
 *  @param clikckButtonIndex block回调点击的选项
 */
+ (void)ba_showBAActionSheetWithStyle:(BAActionSheetStyle)style
                         contentArray:(NSArray<NSString *> *)contentArray
                           imageArray:(NSArray<UIImage *> *)imageArray
                             redIndex:(NSInteger)redIndex
                                title:(NSString *)title
                        configuration:(void (^)(BAActionSheet *tempView)) configuration
                    clikckButtonIndex:(ButtonActionBlock)clikckButtonIndex;

/*!
 *  隐藏 BAActionSheet
 */
- (void)ba_dismissBAActionSheet;

@end
