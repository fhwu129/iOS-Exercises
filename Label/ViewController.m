//
//  ViewController.m
//  Label
//

#import "ViewController.h"
#import "ALAnimatingLabel.h"

@interface ViewController ()

@property (nonatomic, strong) ALAnimatingLabel *alObj;

// @Property directive is used to configure how an object is exposed
@property (weak, nonatomic) IBOutlet UILabel *testLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // create al label
    self.alObj = [[ALAnimatingLabel alloc]initWithFrame: CGRectMake(100, 50, 100, 50)];
    [self.alObj setText: @"Some text that is way too long!"];
    [self.view addSubview: self.alObj];
    
}




@end
