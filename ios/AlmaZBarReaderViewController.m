//
//  AlmaZBarReaderViewController.m
//  BarCodeMix
//
//  Created by eCompliance on 23/01/15.

#import "AlmaZBarReaderViewController.h"
#import "CsZbar.h"

@interface AlmaZBarReaderViewController ()

@end

@implementation AlmaZBarReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    //[button setTitle:@"Flash" forState:UIControlStateNormal];
    [button sizeToFit];
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //[button setContentEdgeInsets:UIEdgeInsetsMake(20, 30, 20, 30)];
    CGRect frame;
    
    if (screenRect.size.height > (screenRect.size.width)) {
        //frame = CGRectMake(0,0, screenRect.size.width*(0.15), screenRect.size.height*0.15);
		frame = CGRectMake(0,0, 0, 0);
    }else{
        //frame = CGRectMake(0,0, screenRect.size.width*(0.10), screenRect.size.height*0.20);
		frame = CGRectMake(0,0, 0, 0);
    }
    
    button.frame =frame;
    //button.layer.cornerRadius = 10;
    button.clipsToBounds = YES;
    
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
	
	
	
	//test cancel
	
	 // // UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    // // //[button setTitle:@"Flash" forState:UIControlStateNormal];
    // // [button sizeToFit];
    // // CGRect screenRect2 = [[UIScreen mainScreen] bounds];
    // // //[button setContentEdgeInsets:UIEdgeInsetsMake(20, 30, 20, 30)];
    // // CGRect frame2;
    
    // // if (screenRect2.size.height > (screenRect.size.width)) {
        // // frame2 = CGRectMake(0,0, screenRect.size.width*(0.15), screenRect.size.height*0.15);
		// // //frame = CGRectMake(0,0, 0, 0);
    // // }else{
        // // frame2 = CGRectMake(0,0, screenRect.size.width*(0.10), screenRect.size.height*0.20);
		// // //frame = CGRectMake(0,0, 0, 0);
    // // }
    
    // // buttonCancel.frame2 =frame2;
    // // //button.layer.cornerRadius = 10;
    // // buttonCancel.clipsToBounds = YES;
    
    // // [buttonCancel addTarget:self action:@selector(buttonCancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    // // [self.view addSubview:buttonCancel];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Techedge Changes NSS fase 2
- (void)buttonPressed: (UIButton *) button {
    CsZBar *obj = [[CsZBar alloc] init];
    
    [obj toggleflash];
}

// - (void)buttonCancelPressed: (UIButton *) buttonCancel {
     // [self.view presentViewController:self.scanReader animated:YES completion:nil]; // dismiss the current view controller

// }

- (BOOL)shouldAutorotate{
    return NO;
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation) fromInterfaceOrientation {
    // AlmaZBarReaderViewController.scanner.scanner.cameraOverlayView = poli
    // NSDictionary *params = (NSDictionary*) [command argumentAtIndex:0];
    BOOL drawSight = true;//[params objectForKey:@"drawSight"] ? [[params objectForKey:@"drawSight"] boolValue] : true;

    if (drawSight) {
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        CGFloat dim = screenWidth < screenHeight ? screenWidth / 1.5 : screenHeight / 1.5;

		UIView *polygonView = [[UIView alloc] initWithFrame: CGRectMake ( (screenWidth/2) - (dim/2), (dim/2), dim, dim)];
        // polygonView.center = self.scanReader.view.center;
        polygonView.layer.borderColor = [UIColor whiteColor].CGColor;
        polygonView.layer.borderWidth = 2.0f;
		polygonView.layer.cornerRadius = 2.0f;
		polygonView.layer.masksToBounds = YES;

        // UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0,dim / 2, dim, 1)];
        // lineView.backgroundColor = [UIColor orangeColor];
        // [polygonView addSubview:lineView];
        self.cameraOverlayView = polygonView;
    }
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    UIToolbar* toolbar = [[controls subviews] firstObject];
    if (![toolbar isKindOfClass:UIToolbar.class])
        return;

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 110000
    // HACK to hide the Info button
    for (UIBarButtonItem* item in [toolbar items]) {
        UIButton* button = [item customView];
        if ([button isKindOfClass:UIButton.class]) {
            UIButtonType buttonType = [button buttonType];
            if (buttonType == UIButtonTypeInfoDark || buttonType == UIButtonTypeInfoLight) {
                [button setHidden:YES];
            }
        }
    }

#endif
}

@end