
/*!
 *  @brief      BAAlert
 *
 *  @author     BAHome
 *  @copyright  Copyright © 2016年 BAHome. All rights reserved.
 *  @version    V1.1.0
 */


#import <UIKit/UIKit.h>

static NSString *BAActionSheetCellID = @"BAActionSheetCell";

@interface BAActionSheetCell : UITableViewCell

/*! 自定义图片 */
@property (weak, nonatomic) IBOutlet UIImageView  *customImageView;
/*! 自定义title */
@property (weak, nonatomic) IBOutlet UILabel      *customTextLabel;


@end
