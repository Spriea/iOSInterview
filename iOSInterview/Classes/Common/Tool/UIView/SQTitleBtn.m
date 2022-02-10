//
//  SQTitleBtn.m
//  SQPuzzleClub
//
//  Created by Somer.King on 2020/7/3.
//  Copyright © 2020 Somer.King. All rights reserved.
//

#import "SQTitleBtn.h"

@implementation SQTitleBtn

- (void)setHighlighted:(BOOL)highlighted{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    if (self.imageView.sk_centerX <  self.titleLabel.sk_centerX) {
        self.imageView.frame = CGRectMake(0, self.imgY, self.imgSize.width, self.imgSize.height);
        self.imageView.sk_centerX  = self.frame.size.width * 0.5;
        
        [self.titleLabel sizeToFit];
        self.titleLabel.sk_centerX = self.frame.size.width * 0.5;
        self.titleLabel.sk_y = CGRectGetMaxY(self.imageView.frame)+self.titleTopMar;
    }
}

@end
