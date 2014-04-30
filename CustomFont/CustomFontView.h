//
//  CustomFontView.h
//  CustomFont
//
//  Created by bshn on 14-4-28.
//  Copyright (c) 2014年 bshn. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FontView.h"



@protocol CustomFontViewDelegate <NSObject>

@optional
-(void)fontToSNS:(NSInteger)tag;
@end

@interface CustomFontView : UIView<UIScrollViewDelegate>

@property (assign) id<CustomFontViewDelegate> delegate;
@property(nonatomic , strong) NSArray * fontNameArray;              //预留接口
@property(nonatomic , strong) NSMutableDictionary * fontStatusDictionary;

@property(nonatomic , strong) UIScrollView * fontScrollView;    //scrollView
-(void) show;                                                   //动画弹出效果
-(void) dismiss;

-(FontView*) getClickedFontView:(NSInteger)index;

@end
