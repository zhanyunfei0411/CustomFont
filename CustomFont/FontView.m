//
//  FontView.m
//  CustomFont
//
//  Created by bshn on 14-4-28.
//  Copyright (c) 2014年 bshn. All rights reserved.
//

#import "FontView.h"
@interface FontView ()
@property(nonatomic , strong) NSArray * fontArray;




@end

@implementation FontView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.backgroundColor = [UIColor orangeColor];
        [self createView];
        
        
    }
    return self;
}


-(void)createView{
    
    self.downloadImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 30, 15)];
    [self.downloadImage setImage:[UIImage imageNamed:@"icon_download_tips.png"]];
    [self addSubview:self.downloadImage];
    
    self.fontImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, self.downloadImage.frame.origin.y+self.downloadImage.frame.size.height, 60, 20)];
    [self addSubview:self.fontImage];
    
    self.Progress = [[UIProgressView alloc] initWithFrame:CGRectMake(15, self.fontImage.frame.origin.y+self.fontImage.frame.size.height+5, 40, 10)];
    self.Progress.progressViewStyle = UIProgressViewStyleDefault;
    self.Progress.trackTintColor = [UIColor blueColor];
    [self addSubview:self.Progress];
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end

