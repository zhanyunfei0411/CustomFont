//
//  ViewController.m
//  CustomFont
//
//  Created by bshn on 14-4-28.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "CustomFontView.h"

@interface ViewController ()<CustomFontViewDelegate>

@property (nonatomic , strong) CustomFontView * customFontView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    self.customFontView = [[CustomFontView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 55)];
    self.customFontView.delegate = self;
    [self.view addSubview:self.customFontView];
    
    
}

// test



#pragma mark -- 动画
- (IBAction)fontButtonAction:(id)sender {
    [self.customFontView show];
}

#pragma mark - CustomFont View Delegate
-(void)fontToSNS:(NSInteger)tag{
    
    
    
    NSLog(@"type == %d", (int)tag);

    
    FontView* clickedFontView = [self.customFontView getClickedFontView:tag];
    
    if (clickedFontView.fontStatus == FontStatusUndownloaded) {
        //[self.customFontView.fontStatusDictionary setObject:@(FontStatusDownloading) forKey:fontName];
        clickedFontView.fontStatus = FontStatusDownloading;
        clickedFontView.Progress.progress = 0;
        NSDictionary* dic = @{@"FontView" : clickedFontView};
        [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(downloadingFont:) userInfo:dic repeats:YES];
    }
    
    
    
}

-(void)downloadingFont:(NSTimer*)sender {
    NSLog(@"downloading...");
    FontView* fv = (FontView*)[sender.userInfo objectForKey:@"FontView"];
    if (fv.Progress.progress < 1.0) {
        fv.Progress.progress += 0.2;
    }
    else {
        [sender invalidate];
        sender = nil;
        
        fv.fontStatus = FontStatusDownloaded;
    }
    
}

- (IBAction)dismiss:(id)sender {
    [self.customFontView dismiss];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
