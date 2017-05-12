
/*!
 *  @brief      BAAlert-OC
 *
 *  @author     DS-Team
 *  @copyright  Copyright © 2016年 DS-Team. All rights reserved.
 *  @version    V1.1.0
 */


#import "ViewController.h"

#import "ViewController2.h"
#import "VerCodeAlertView.h"

/*! 使用方法一：文件夹拖入 */
#import "BAAlert_OC.h"

///*! 使用方法二：pod */
//#import <BAAlert_OC.h>

static NSString * const titleMsg0 = @"欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，从里到外重新构想。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。\n对于 MacBook，我们给自己设定了一个几乎不可能实现的目标：在有史以来最为轻盈纤薄的 Mac 笔记本电脑上，打造全尺寸的使用体验。这就要求每个元素都必须重新构想，不仅令其更为纤薄轻巧，还要更加出色。最终我们带来的，不仅是一部新款的笔记本电脑，更是一种对笔记本电脑的前瞻性思考。现在，有了第六代 Intel 处理器、提升的图形处理性能、高速闪存和最长可达 10 小时的电池使用时间*，MacBook 的强大更进一步。\n欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，从里到外重新构想。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。\n对于 MacBook，我们给自己设定了一个几乎不可能实现的目标：在有史以来最为轻盈纤薄的 Mac 笔记本电脑上，打造全尺寸的使用体验。这就要求每个元素都必须重新构想，不仅令其更为纤薄轻巧，还要更加出色。最终我们带来的，不仅是一部新款的笔记本电脑，更是一种对笔记本电脑的前瞻性思考。现在，有了第六代 Intel 处理器、提升的图形处理性能、高速闪存和最长可达 10 小时的电池使用时间*，MacBook 的强大更进一步。";

static NSString * const titleMsg1 = @"欢迎使用 iPhone SE，迄今最高性能的 4 英寸 iPhone。在打造这款手机时，我们在深得人心的 4 英寸设计基础上，从里到外重新构想。它所采用的 A9 芯片，正是在 iPhone 6s 上使用的先进芯片。1200 万像素的摄像头能拍出令人叹为观止的精彩照片和 4K 视频，而 Live Photos 则会让你的照片栩栩如生。这一切，成就了一款外形小巧却异常强大的 iPhone。";
static NSString * const titleMsg2 = @"对于 MacBook，我们给自己设定了一个几乎不可能实现的目标：在有史以来最为轻盈纤薄的 Mac 笔记本电脑上，打造全尺寸的使用体验。这就要求每个元素都必须重新构想，不仅令其更为纤薄轻巧，还要更加出色。最终我们带来的，不仅是一部新款的笔记本电脑，更是一种对笔记本电脑的前瞻性思考。现在，有了第六代 Intel 处理器、提升的图形处理性能、高速闪存和最长可达 10 小时的电池使用时间*，MacBook 的强大更进一步。";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView  *tableView;

@property (nonatomic, strong) BAAlert        *alertView1;
@property (nonatomic, strong) BAAlert        *alertView2;
@property (nonatomic, strong) BAAlert        *alertView3;
@property (nonatomic, strong) BAAlert        *alertView4;
@property (nonatomic, strong) BAAlert        *alertView5;

@property (nonatomic, strong) BAActionSheet  *actionSheet1;
@property (nonatomic, strong) BAActionSheet  *actionSheet2;
@property (nonatomic, strong) BAActionSheet  *actionSheet3;

@property (nonatomic, strong) UIView         *viewPwdBgView;
@property (nonatomic, strong) UITextField    *pwdTextField;
@property (nonatomic,strong ) UIButton       *chooseBtn;
@property (nonatomic,strong ) UILabel        *titleLabel;

@property (strong, nonatomic) NSArray        *dataArray;

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.estimatedRowHeight = 44.f;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.title = @"BAAlert-OC";
}

#pragma mark - UITableViewDataSource / UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if ( !cell )
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.numberOfLines = 0;
        
        cell.accessoryType = 0 == indexPath.section?UITableViewCellAccessoryDisclosureIndicator:UITableViewCellAccessoryNone;
        cell.selectionStyle = 0 == indexPath.section?UITableViewCellSelectionStyleDefault:UITableViewCellSelectionStyleNone;
    }
    NSArray *tempArray = self.dataArray[indexPath.section];
    cell.textLabel.text = tempArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BAKit_WeakSelf
    if ( 0 == indexPath.section )
    {
        [self showAlertAction:indexPath.row + 1];
    }else if ( 1 == indexPath.section )
    {
        switch ( indexPath.row ) {
            case 0:
            {
                [BAActionSheet ba_showBAActionSheetWithStyle:BAActionSheetStyleNormal
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:nil
                                                  redIndex:1
                                                     title:nil
                                             configuration:^(BAActionSheet *tempView) {
                                                 BAKit_StrongSelf
                                                 self.actionSheet1 = tempView;
                                                 self.actionSheet1.isTouchEdgeHide = YES;
                                             } clikckButtonIndex:^(NSInteger index) {
                                                 BAKit_StrongSelf
                                                 NSLog(@"你点击了第 %ld 行！",(long)index);
                                                 [self.actionSheet1 ba_dismissBAActionSheet];
                                             }];
            }
                break;
            case 1:
            {
                [BAActionSheet ba_showBAActionSheetWithStyle:BAActionSheetStyleTitle
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:nil
                                                  redIndex:1
                                                     title:@"测试带标题的ActionSheet"
                                             configuration:^(BAActionSheet *tempView) {
                                                 BAKit_StrongSelf
                                                 self.actionSheet1 = tempView;
                                             } clikckButtonIndex:^(NSInteger index) {
                                                 BAKit_StrongSelf
                                                 NSLog(@"你点击了第 %ld 行！",(long)index);
                                                 [self.actionSheet1 ba_dismissBAActionSheet];
                                             }];
            }
                break;
            case 2:
            {
                [BAActionSheet ba_showBAActionSheetWithStyle:BAActionSheetStyleImageAndTitle
                                              contentArray:@[@"测试1",@"测试2",@"测试3"]
                                                imageArray:@[[UIImage imageNamed:@"123.png"],[UIImage imageNamed:@"背景.jpg"],[UIImage imageNamed:@"美女.jpg"]]
                                                  redIndex:1
                                                     title:@"测试带标题和图片的ActionSheet"
                                             configuration:^(BAActionSheet *tempView) {
                                                 BAKit_StrongSelf
                                                 self.actionSheet1 = tempView;
                                             } clikckButtonIndex:^(NSInteger index) {
                                                 BAKit_StrongSelf
                                                 NSLog(@"你点击了第 %ld 行！",(long)index);
                                                 [self.actionSheet1 ba_dismissBAActionSheet];
                                             }];
            }
                break;
            default:
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [UIView new];
    
    UILabel *headerTitle = [UILabel new];
    headerTitle.font = [UIFont systemFontOfSize:14];
    headerTitle.textColor = [UIColor redColor];
    headerTitle.numberOfLines = 0;
    [headerView addSubview:headerTitle];
    
    if (0 == section)
    {
        headerTitle.frame = CGRectMake(20, 0, SCREENWIDTH - 40, 40);
        headerTitle.text = @"BAAlert 的几种日常用法，高斯模糊、炫酷动画，应有尽有！";
    }
    else if (1 == section)
    {
        headerTitle.frame = CGRectMake(20, 0, SCREENWIDTH - 40, 20);
        headerTitle.text = @"BAActionSheet";
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (0 == section) ? 40 : 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return FLT_MIN;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 点击事件
- (void)showAlertAction:(NSInteger)index
{
    switch (index) {
        case 1:
            [self performSelector:@selector(alert1)];
            break;
        case 2:
            [self performSelector:@selector(alert2)];
            break;
        case 3:
            [self performSelector:@selector(alert3)];
            break;
        case 4:
            [self performSelector:@selector(alert4)];
            break;
        case 5:
            [self performSelector:@selector(alert5)];
            break;
        
        default:
            break;
    }
}

- (void)alert1
{
    BAKit_WeakSelf
    /*! 第一种封装使用示例 */
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg0 image:nil buttonTitles:@[@"取消",@"确定",@"确定2",@"确定3"] buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor], [UIColor grayColor], [UIColor purpleColor]] configuration:^(BAAlert *temp) {
        
        BAKit_StrongSelf
        //        temp.bgColor       = [UIColor colorWithRed:0 green:1.0 blue:0 alpha:0.3];
        /*! 开启边缘触摸隐藏alertView */
        temp.isTouchEdgeHide = NO;
        /*! 添加高斯模糊的样式 */
        temp.blurEffectStyle = BAAlertBlurEffectStyleLight;
        /*! 开启动画 */
        //        temp.isShowAnimate   = YES;
        //        /*! 进出场动画样式 默认为：1 */
        //        temp.animatingStyle  = 1;
        
        self.alertView1 = temp;
    }actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        [self.alertView1 ba_dismissAlertView];
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView1 ba_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert1";
            [self.navigationController pushViewController:vc2 animated:YES];
        }
    }];

}

- (void)alert2
{
//    /*! 2、自定义按钮颜色 */
    BAKit_WeakSelf
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg2 image:nil buttonTitles:@[@"取消", @"跳转VC2"] buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor]] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        /*! 自定义按钮文字颜色 */
        //    tempView.buttonTitleColor = [UIColor orangeColor];
        tempView.bgColor = [UIColor colorWithRed:1.0 green:1.0 blue:0 alpha:0.3];
        
        /*! 是否开启进出场动画 默认：NO，如果 YES ，并且同步设置进出场动画枚举为默认值：1 */
        tempView.showAnimate = YES;
        tempView.animatingStyle  = BAAlertAnimatingStyleShake;

        self.alertView2 = tempView;

    } actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        [self.alertView2 ba_dismissAlertView];
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert2";
            [self.navigationController pushViewController:vc2 animated:YES];
        }
    }];
}

- (void)alert3
{
    /*! 3、自定义背景图片 */
    BAKit_WeakSelf
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg1 image:nil buttonTitles:@[@"取消", @"确定"] buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor]] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        /*! 自定义按钮文字颜色 */
        //    tempView.buttonTitleColor = [UIColor orangeColor];
        /*! 自定义alert的背景图片 */
        tempView.bgImageName      = @"背景.jpg";
        /*! 开启动画，并且设置动画样式，默认：1 */
//        tempView.showAnimate = YES;
        
        /*! 没有开启动画，直接进出场动画样式，默认开启动画 */
        tempView.animatingStyle  = BAAlertAnimatingStyleFall;
        
        self.alertView3 = tempView;
    } actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        [self.alertView3 ba_dismissAlertView];
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            /*! 隐藏alert */
            //            [weakSelf.alertView3 ba_dismissAlertView];
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert3";
            [self.navigationController pushViewController:vc2 animated:YES];
            /*! 隐藏alert */
            //            [weakSelf.alertView3 ba_dismissAlertView];
        }
    }];
}

- (void)alert4
{
    /*! 4、内置图片和文字，可滑动查看 */
    BAKit_WeakSelf
    [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:titleMsg1 image:[UIImage imageNamed:@"美女.jpg"] buttonTitles:@[@"取消", @"跳转VC2"]  buttonTitlesColor:@[[UIColor redColor], [UIColor greenColor]] configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        /*! 自定义按钮文字颜色 */
        //    tempView.buttonTitleColor = [UIColor orangeColor];
        /*! 自定义alert的背景图片 */
        tempView.bgImageName      = @"背景.jpg";
        /*! 是否显示动画效果 */
        tempView.showAnimate    = YES;
        self.alertView4 = tempView;
    } actionClick:^(NSInteger index) {
        BAKit_StrongSelf
        [self.alertView4 ba_dismissAlertView];
        if (index == 0)
        {
            NSLog(@"点击了取消按钮！");
            
        }
        else if (index == 1)
        {
            NSLog(@"点击了确定按钮！");
            ViewController2 *vc2 = [ViewController2 new];
            vc2.title = @"alert4";
            [self.navigationController pushViewController:vc2 animated:YES];
        }
    }];
}

- (void)alert5
{
    /*! 5、完全自定义alert */
    
    BAKit_WeakSelf
    [self setViewPwdBgView];
    
    [BAAlert ba_showCustomView:self.viewPwdBgView configuration:^(BAAlert *tempView) {
        BAKit_StrongSelf
        tempView.isTouchEdgeHide = YES;
        tempView.animatingStyle = BAAlertAnimatingStyleScale;
        self.alertView5 = tempView;
    }];
}

#pragma mark - 自定义视图
- (void)setViewPwdBgView
{
    _viewPwdBgView                         = [UIView new];
    _viewPwdBgView.frame                   = CGRectMake(30, 300, SCREENWIDTH - 60, 160);
    
    _viewPwdBgView.backgroundColor         = [UIColor whiteColor];
    _viewPwdBgView.layer.masksToBounds     = YES;
    _viewPwdBgView.layer.cornerRadius      = 10.0f;
    
    CGFloat buttonWith                     = (SCREENWIDTH - 60)/2 - 0.5;
    CGFloat buttonHeight                   = 40;
    
    UILabel *titleLabel                    = [UILabel new];
    titleLabel.frame                       = CGRectMake(0, 0, _viewPwdBgView.frame.size.width, buttonHeight);
    titleLabel.textAlignment               = NSTextAlignmentCenter;
    titleLabel.font                        = [UIFont systemFontOfSize:18];
    titleLabel.text                        = @"请补全好友姓名，确保信息安全";
    //
    UIView *lineView1                      = [UIView new];
    lineView1.frame                        = CGRectMake(0, CGRectGetMaxY(titleLabel.frame), _viewPwdBgView.frame.size.width, 1);
    lineView1.backgroundColor              = [UIColor lightGrayColor];
    
    _pwdTextField                          = [UITextField new];
    _pwdTextField.frame                    = CGRectMake(_viewPwdBgView.frame.size.width/4, CGRectGetMaxY(lineView1.frame) + 20,  100, buttonHeight);
    _pwdTextField.borderStyle              = UITextBorderStyleRoundedRect;
    _pwdTextField.textAlignment            = NSTextAlignmentCenter;
    _pwdTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    
    UILabel *textView                      = [UILabel new];
    textView.font                          = [UIFont boldSystemFontOfSize:18];
    textView.frame                         = CGRectMake(CGRectGetMaxX(_pwdTextField.frame), _pwdTextField.frame.origin.y, _viewPwdBgView.frame.size.width - _pwdTextField.frame.origin.x - 15, buttonHeight);
    //
    UIView *lineView2                      = [UIView new];
    lineView2.frame                        = CGRectMake(0, _viewPwdBgView.frame.size.height - 41, _viewPwdBgView.frame.size.width, 1);
    lineView2.backgroundColor              = [UIColor lightGrayColor];
    
    UIButton *cancleButton                 = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), buttonWith, buttonHeight)];
    [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancleButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView3                      = [UIView new];
    lineView3.frame                        = CGRectMake(buttonWith, CGRectGetMinY(cancleButton.frame), 1, buttonHeight);
    lineView3.backgroundColor              = [UIColor lightGrayColor];
    
    UIButton *sureButton                   = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineView3.frame), CGRectGetMinY(cancleButton.frame), buttonWith, buttonHeight)];
    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    [sureButton setBackgroundColor:[UIColor clearColor]];
    [sureButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    cancleButton.tag                       = 1;
    sureButton.tag                         = 2;
    
    [_viewPwdBgView addSubview:titleLabel];
    [_viewPwdBgView addSubview:lineView1];
    [_viewPwdBgView addSubview:_pwdTextField];
    [_viewPwdBgView addSubview:textView];
    [_viewPwdBgView addSubview:lineView2];
    [_viewPwdBgView addSubview:cancleButton];
    [_viewPwdBgView addSubview:lineView3];
    [_viewPwdBgView addSubview:sureButton];
    
}

- (void)cancleButtonAction:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        NSLog(@"点击了取消按钮！");
        /*! 隐藏alert */
        [_alertView5 ba_dismissAlertView];
        [_pwdTextField resignFirstResponder];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [_pwdTextField resignFirstResponder];
        NSLog(@"点击了确定按钮！密码：%@", _pwdTextField.text);
        
        //        WEAKSELF;
        if (_pwdTextField.text.length < 4 || _pwdTextField.text.length > 8 )
        {
            self.pwdTextField.text = @"";
            [BAAlert ba_showAlertWithTitle:@"温馨提示：" message:@"请输入正确的密码！" image:nil buttonTitles:@[@"确定"] buttonTitlesColor:@[[UIColor redColor], [UIColor cyanColor]] configuration:^(BAAlert *tempView) {
                //                weakSelf.alert2 = tempView;
            } actionClick:^(NSInteger index) {
                if (1 == index)
                {
                    return;
                }
            }];
            return;
        }
        [_pwdTextField resignFirstResponder];
    }
}

- (BOOL)prefersStatusBarHidden {
    return false;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.tableView.frame = self.view.bounds;
}

#pragma mark - setter / getter

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}


- (NSArray *)dataArray
{
    if ( !_dataArray )
    {
        _dataArray = [NSArray arrayWithObjects:@[@"1、类似系统alert【加边缘手势消失】",
                                                 @"2、自定义按钮颜色",
                                                 @"3、自定义背景图片",
                                                 @"4、内置图片和文字，可滑动查看",
                                                 @"5、完全自定义alert"
                                                 ],
                      @[@"1、actionsheet",
                        @"2、actionsheet带标题",
                        @"3、actionsheet带标题带图片"],
                      @[@"BAAlert特点：\n1、手势触摸隐藏开关，可随时开关\n2、可以自定义背景图片、背景颜色、按钮颜色\n3、可以添加文字和图片，且可以滑动查看！\n4、横竖屏适配完美\n5、有各种炫酷动画展示你的alert\n6、可以自定义按钮颜色\n7、理论完全兼容现有所有 iOS 系统版本"
                        ], nil];
    }
    return _dataArray;
}

@end
