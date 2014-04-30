//
//  CustomFontView.m
//  CustomFont
//
//  Created by bshn on 14-4-28.
//  Copyright (c) 2014年 bshn. All rights reserved.
//

#import "CustomFontView.h"
#import "FontView.h"

#define FontViewWidth 70
#define FontViewHeight 55

#pragma mark - Screen Info
#define IS_SCREEN_568H ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define SCREEN_WIDTH 320
#define SCREEN_HEIGHT (IS_SCREEN_568H ? 568 : 480)

@interface CustomFontView ()


@end

@implementation CustomFontView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.8;
        [self initArray];
        [self cerateScrollView];
    }
    return self;
}

-(void)initArray{
    self.fontNameArray = [[NSArray alloc] initWithObjects:@"text_font_thumbnail1",@"text_font_thumbnail2",@"text_font_thumbnail3",@"text_font_thumbnail4",@"text_font_thumbnail5",@"text_font_thumbnail6",@"text_font_thumbnail7",@"text_font_thumbnail8",nil];
    
    self.fontStatusDictionary = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@(FontStatusUndownloaded),@"text_font_thumbnail1",@(FontStatusUndownloaded),@"text_font_thumbnail2",@(FontStatusUndownloaded),@"text_font_thumbnail3",@(FontStatusUndownloaded),@"text_font_thumbnail4",@(FontStatusUndownloaded),@"text_font_thumbnail5",@(FontStatusUndownloaded),@"text_font_thumbnail6",@(FontStatusUndownloaded),@"text_font_thumbnail7",@(FontStatusUndownloaded),@"text_font_thumbnail8", nil];
    
    
}

#pragma mark -  scrolleView
-(void)cerateScrollView{
    self.fontScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    self.fontScrollView.backgroundColor = [UIColor clearColor];
    self.fontScrollView.delegate = self;
    self.fontScrollView.scrollEnabled = YES;
    //    self.fontScrollView.pagingEnabled = YES;
    self.fontScrollView.showsHorizontalScrollIndicator=YES;
    [self addSubview:self.fontScrollView];
    [self scrollViewContentSize];
    
}

#pragma mark -  scrolleView底片
-(void)scrollViewContentSize{
    CGFloat width = self.fontNameArray.count * FontViewWidth;
    self.fontScrollView.contentSize=CGSizeMake(width, self.fontScrollView.bounds.size.height);//计算ScroollView需要的大小
    [self createFontView];
}

#pragma mark -  FontView
-(void)createFontView{
    
    for (int i = 0; i < self.fontNameArray.count; i++) {
        //字体View
        FontView* fontView  = [[FontView alloc] initWithFrame:CGRectMake(0+i*FontViewWidth, 0, FontViewWidth, 55)];
        [fontView setTag:i];
        NSString* fontName = self.fontNameArray[i];
        NSString * imageNameStr = [NSString stringWithFormat:@"%@.png",fontName];
        [fontView.fontImage setImage:[UIImage imageNamed:imageNameStr]];
        
        fontView.fontStatus = [(NSNumber*)[self.fontStatusDictionary objectForKey:fontName] intValue];
        
        [self.fontScrollView addSubview:fontView];
        
        //手势
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [fontView addGestureRecognizer:tap];
        
        //判断fontView状态
        //未下载
        NSLog(@"字典的Value  ===  %d", fontView.fontStatus);
        
        if (fontView.fontStatus == FontStatusUndownloaded) {
            
        }
        //下载中
        else if (fontView.fontStatus == FontStatusDownloading){
            //fontView.downloadImage.hidden = YES;
            /*
             *  下载进度条
             */
        }
        //已下载
        else if (fontView.fontStatus == FontStatusDownloaded){
            fontView.downloadImage.hidden = YES;
            
        }
        
        if (fontView.tag == 0) {
            [fontView.Progress setHidden:NO];
        }else{
            [fontView.Progress setHidden:YES];
        }
    }
}

#pragma mark - 响应手势
-(void)tapAction:(UITapGestureRecognizer *)sender{
    [self.delegate fontToSNS:sender.view.tag];
    int32_t tag = (int32_t)sender.view.tag;
    if ([self.fontScrollView.subviews[tag] isKindOfClass:[FontView class]]) {
        FontView* fontView = (FontView*) self.fontScrollView.subviews[tag];
        [fontView.Progress setHidden:NO];
        NSLog(@"当前偏移量 %f",self.fontScrollView.contentOffset.x);
        NSLog(@"点击View的X == %f",fontView.frame.origin.x);
        NSLog(@"我点击的 == %f",fontView.frame.origin.x - self.fontScrollView.bounds.origin.x);
        int32_t p = fontView.frame.origin.x - self.fontScrollView.bounds.origin.x;
        if ((fontView.frame.origin.x - self.fontScrollView.bounds.origin.x) < 70) {
            if (tag == 0) {
                [fontView.Progress setHidden:NO];
                [self.fontScrollView setContentOffset:CGPointMake(0 , 0) animated:YES];
            }else{
                FontView* fontViewBefore = (FontView*) self.fontScrollView.subviews[tag-1];
                NSLog(@"我点击的前一个View== == %f",fontViewBefore.frame.origin.x);
                [self.fontScrollView setContentOffset:CGPointMake(fontViewBefore.frame.origin.x, 0) animated:YES];
            }
        }else if ((fontView.frame.origin.x - self.fontScrollView.bounds.origin.x) > 180){
            if (tag == self.fontNameArray.count-1) {
                [fontView.Progress setHidden:NO];
                [self.fontScrollView setContentOffset:CGPointMake(self.fontScrollView.contentOffset.x+(FontViewWidth-(320-p)) , 0) animated:YES];
            }else{
                NSLog(@"180以后");
                FontView* fontViewAfter = (FontView*) self.fontScrollView.subviews[tag+1];
                NSLog(@"我点击的后一个View== == %f",fontViewAfter.frame.origin.x);
                if ((fontView.frame.origin.x - self.fontScrollView.bounds.origin.x) == 250) {
                    int32_t i = (FontViewWidth-(fontViewAfter.frame.origin.x-320));
                    NSLog(@"lololololo == %d",i );
                    [self.fontScrollView setContentOffset:CGPointMake(self.fontScrollView.contentOffset.x+FontViewWidth, 0) animated:YES];
                }else{
                    int32_t i = (FontViewWidth-(320-(p+FontViewWidth)));
                    NSLog(@"ooooooo == %d",i );
                    [self.fontScrollView setContentOffset:CGPointMake(self.fontScrollView.contentOffset.x+i, 0) animated:YES];
                }
            }
        }
    }
    
    for (UIView* v in self.fontScrollView.subviews) {
        if ([v isKindOfClass:[FontView class]]) {
            FontView* fv = (FontView*) v;
            if (fv.tag != tag) {
                [fv.Progress setHidden:YES];
            }
        }
    }
    
}


#pragma mark - Show and dismiss
-(void) show {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [self setFrame:CGRectMake(0, self.superview.bounds.size.height-30-self.frame.size.height, self.superview.bounds.size.width, FontViewHeight)];
    [UIView commitAnimations];
}

-(void) dismiss {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    [self setFrame:CGRectMake(0, self.superview.bounds.size.height, self.superview.bounds.size.width, FontViewHeight)];
    [UIView commitAnimations];
}

-(FontView*) getClickedFontView:(NSInteger)index {
    FontView* fv = nil;
    
    if ([self.fontScrollView.subviews[index] isKindOfClass:[FontView class]]) {
        fv = (FontView*) self.fontScrollView.subviews[index];
    }
    
    return fv;
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
