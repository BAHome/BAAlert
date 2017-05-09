
/*!
 *  @brief      BAAlert
 *
 *  @author     BAHome
 *  @copyright  Copyright © 2016年 BAHome. All rights reserved.
 *  @version    V1.1.0
 */

#import "BAActionSheet.h"
#import "BAActionSheetCell.h"
#import "CALayer+Animation.h"
#import "BAAlert_OC.h"

static NSString * const kCellID = @"BAActionSheetCell";

@interface BAActionSheet ()
<
    UITableViewDelegate,
    UITableViewDataSource
>
/*! tableView */
@property (strong, nonatomic) UITableView  *tableView;

/*! 数据源 */
@property (strong, nonatomic) NSArray      *dataArray;
/*! 图片数组 */
@property (strong, nonatomic) NSArray      *imageArray;
/*! 标记颜色是红色的那行 */
@property (assign, nonatomic) NSInteger    specialIndex;
/*! 标题 */
@property (copy, nonatomic  ) NSString     *title;
/*! 点击事件回调 */
@property (copy, nonatomic) void(^callback)(NSInteger index);
/*! 自定义样式 */
@property (assign, nonatomic) BAActionSheetStyle viewStyle;

@property (nonatomic, strong) UIWindow *actionSheetWindow;


@end

@implementation BAActionSheet

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
                    clikckButtonIndex:(ButtonActionBlock)clikckButtonIndex
{
    BAActionSheet *actionSheet       = [[self alloc] init];
    actionSheet.dataArray            = contentArray;
    actionSheet.callback             = clikckButtonIndex;
    actionSheet.viewStyle            = style;
    actionSheet.imageArray           = imageArray;
    actionSheet.specialIndex         = redIndex;
    actionSheet.title                = title;
    if (configuration)
    {
        configuration(actionSheet);
    }
    //    [actionSheet.tableView reloadData];
    [actionSheet ba_showBAActionSheet];
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupCommonUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCommonUI];
    }
    return self;
}

- (void)setupCommonUI
{
    self.backgroundColor = BAKit_COLOR_Translucent;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(handleDeviceOrientationRotateAction:) name:UIDeviceOrientationDidChangeNotification object:nil];
}

#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ( 0 == section )
    {
        if ( self.viewStyle == BAActionSheetStyleNormal || self.viewStyle == BAActionSheetStyleImage )
        {
            return self.dataArray.count;
        }
        else
        {
            return self.dataArray.count + 1;
        }
    }
    else
    {
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return (section == 0)?8.f:0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAActionSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID forIndexPath:indexPath];
    cell.selectionStyle = (self.title)?UITableViewCellSelectionStyleNone:UITableViewCellSelectionStyleDefault;
    if ( 0 == indexPath.section )
    {
        if ( indexPath.row == self.specialIndex )
        {
            cell.customTextLabel.textColor = [UIColor redColor];
        }
        
        if ( self.viewStyle == BAActionSheetStyleNormal )
        {
            cell.customTextLabel.text = self.dataArray[indexPath.row];
        }
        else if ( self.viewStyle == BAActionSheetStyleTitle )
        {
            cell.customTextLabel.text = (indexPath.row ==0) ? self.title : self.dataArray[indexPath.row-1];
        }
        else
        {
            
            NSInteger index = (self.title) ? indexPath.row - 1 : indexPath.row;
            if ( index >= 0 )
            {
                cell.customImageView.image = self.imageArray[index];
            }
            
            cell.customTextLabel.text = (indexPath.row == 0) ? self.title : self.dataArray[indexPath.row-1];
        }
    }
    else
    {
        cell.customTextLabel.text = @"取 消";
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( 0 == indexPath.section )
    {
        NSInteger index = 0;
        if ( self.viewStyle == BAActionSheetStyleNormal || self.viewStyle == BAActionSheetStyleImage )
        {
            index = indexPath.row;
        }
        else
        {
            index = indexPath.row - 1;
        }
        if (-1 == index)
        {
            NSLog(@"【 BAActionSheet 】标题不能点击！");
            return;
        }
        self.callback(index);
    }
    else if ( 1 == indexPath.section )
    {
        NSLog(@"【 BAActionSheet 】你点击了取消按钮！");
        [self ba_dismissBAActionSheet];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"触摸了边缘隐藏View！");
    UITouch *touch = [touches anyObject];
    UIView *view = [touch view];
    if (!self.isTouchEdgeHide)
    {
        NSLog(@"触摸了View边缘，但您未开启触摸边缘隐藏方法，请设置 isTouchEdgeHide 属性为 YES 后再使用！");
        return;
    }
    if ([view isKindOfClass:[self class]])
    {
        [self ba_dismissBAActionSheet];
    }
}

- (void)handleDeviceOrientationRotateAction:(NSNotification *)noti
{
    [self ba_layoutSubViews];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)ba_layoutSubViews
{
    self.frame = self.window.bounds;
    self.actionSheetWindow.frame = self.window.bounds;
    
    CGFloat min_x = 0;
    CGFloat min_y = 0;
    CGFloat min_w = 0;
    CGFloat min_h = 0;
    
    min_x = 0;
    min_h = MIN(SCREENHEIGHT - 64.f, self.tableView.contentSize.height);
    min_y = SCREENHEIGHT - min_h;
    min_w = SCREENWIDTH;
    self.tableView.frame = CGRectMake(min_x, min_y, min_w, min_h);
}

- (void)ba_showBAActionSheet
{
    [self.actionSheetWindow addSubview:self];
    
    [self ba_layoutSubViews];
    
    /*! 设置默认样式为： */
    if (self.isShowAnimate)
    {
        _animatingStyle = BAActionSheetAnimatingStyleScale;
    }
    /*! 如果没有开启动画，就直接默认第一个动画样式 */
    else if (!self.isShowAnimate && self.animatingStyle)
    {
        self.showAnimate = YES;
    }
    else
    {
        NSLog(@"您没有开启动画，也没有设置动画样式，默认为没有动画！");
    }
    
    if (self.isShowAnimate)
    {
        [self showAnimationWithView:self.tableView];
    }
    else
    {
        
    }
}

- (void)ba_dismissBAActionSheet
{
    if (self.isShowAnimate)
    {
        [self dismissAnimationView:self.tableView];
    }
    else
    {
        [self ba_removeSelf];
    }
}

#pragma mark - 进场动画
- (void )showAnimationWithView:(UIView *)animationView
{
    if (self.animatingStyle == BAActionSheetAnimatingStyleScale)
    {
        [animationView scaleAnimationShowFinishAnimation:^{
        }];
    }
    else if (self.animatingStyle == BAActionSheetAnimatingStyleShake)
    {
        [animationView.layer shakeAnimationWithDuration:1.0 shakeRadius:16.0 repeat:1 finishAnimation:^{
        }];
    }
    else if (self.animatingStyle == BAActionSheetAnimatingStyleFall)
    {
        [animationView.layer fallAnimationWithDuration:0.35 finishAnimation:^{
        }];
    }
}

#pragma mark - 出场动画
- (void )dismissAnimationView:(UIView *)animationView
{
    BAKit_WeakSelf;
    if (self.animatingStyle == BAActionSheetAnimatingStyleScale)
    {
        [animationView scaleAnimationDismissFinishAnimation:^{
            BAKit_StrongSelf
            [self performSelector:@selector(ba_removeSelf)];
        }];
    }
    else if (self.animatingStyle == BAActionSheetAnimatingStyleShake)
    {
        [animationView.layer floatAnimationWithDuration:0.35f finishAnimation:^{
            BAKit_StrongSelf
            [self performSelector:@selector(ba_removeSelf)];
        }];
    }
    else if (self.animatingStyle == BAActionSheetAnimatingStyleFall)
    {
        [animationView.layer floatAnimationWithDuration:0.35f finishAnimation:^{
            BAKit_StrongSelf
            [self performSelector:@selector(ba_removeSelf)];
        }];
    }
    else
    {
        NSLog(@"您没有选择出场动画样式：animatingStyle，默认为没有动画样式！");
        [self performSelector:@selector(ba_removeSelf)];
    }
}


- (void)ba_removeSelf
{
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - lazy
- (UITableView *)tableView
{
    if ( !_tableView )
    {
        _tableView                 = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate        = self;
        _tableView.dataSource      = self;
        _tableView.scrollEnabled   = NO;
        _tableView.separatorStyle  = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.f];
        self.backgroundColor = BAKit_COLOR_Translucent;
        [self addSubview:_tableView];
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([BAActionSheetCell class]) bundle:nil] forCellReuseIdentifier:kCellID];
    }
    return _tableView;
}

- (UIWindow *)actionSheetWindow
{
    if (!_actionSheetWindow)
    {
        _actionSheetWindow = [UIApplication sharedApplication].keyWindow;
        self.actionSheetWindow.backgroundColor = BAKit_COLOR_Translucent;
    }
    return _actionSheetWindow;
}

- (void)setIsTouchEdgeHide:(BOOL)isTouchEdgeHide
{
    _isTouchEdgeHide = isTouchEdgeHide;
}

- (void)setShowAnimate:(BOOL)showAnimate
{
    _showAnimate = showAnimate;
}

- (void)setAnimatingStyle:(BAActionSheetAnimatingStyle)animatingStyle
{
    _animatingStyle = animatingStyle;
}

@end
