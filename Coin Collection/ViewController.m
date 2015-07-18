//
//  ViewController.m
//  Coin Collection
//
//  Created by Jack on 10/11/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "ViewController.h"
#import "CoinManager.h"
#import "Coin.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *userIDField;

@end

@implementation ViewController {
    CoinManager *manager;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    manager = [[CoinManager alloc] init];
    _dateField.delegate = self;
    _nameField.delegate = self;
    _userIDField.delegate = self;
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)buttonPressed:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setValue:_userIDField.text forKey:@"userID"];
    
    [manager addCoinToServer: [[Coin alloc] initWithDate:_dateField.text :_nameField.text]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
