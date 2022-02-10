//
//  SKBaseSelectCell.m
//  EduCare for Parents
//
//  Created by Somer.King on 2018/2/12.
//  Copyright © 2018年 Somer.King. All rights reserved.
//

#import "SKBaseSelectCell.h"

@implementation SKBaseSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectedBackgroundView.backgroundColor = kSelectCellColor;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
       self.selectedBackgroundView.backgroundColor = kSelectCellColor;
    }
    return self;
}
@end
