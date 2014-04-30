//
//  FontView.h
//  CustomFont
//
//  Created by bshn on 14-4-28.
//  Copyright (c) 2014年 bshn. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FontStatus) {
    FontStatusUndownloaded = 0,
    FontStatusDownloading = 1,
    FontStatusDownloaded = 2,
    FontStatusSelected = 3,
    FontStatusUnselected = 4,
};

@interface FontView : UIView

@property (nonatomic , strong) UIImageView * downloadImage;     //下载图片
@property (nonatomic , strong) UIImageView * fontImage;         //字体图片
@property (nonatomic , strong) UIProgressView * Progress;       //进度条
@property (nonatomic) enum FontStatus fontStatus;               //进度条状态

@end
