//
//  AddCoinTableViewController.m
//  Coin Collection
//
//  Created by Jack on 10/13/14.
//  Copyright (c) 2014 JackCable. All rights reserved.
//

#import "AddCoinTableViewController.h"
#import "Coin.h"
#import "CoinManager.h"

@interface AddCoinTableViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UITextField *nameField;
@property (strong, nonatomic) IBOutlet UITextField *dateField;
@property (strong, nonatomic) IBOutlet UITextField *typeField;
@property (strong, nonatomic) IBOutlet UITextField *valueField;
@property (strong, nonatomic) IBOutlet UITextField *idField;
@property (strong, nonatomic) IBOutlet UITextField *compositionField;
@property (strong, nonatomic) IBOutlet UITextField *conditionField;

@end

@implementation AddCoinTableViewController {
    CoinManager *manager;
}

- (instancetype)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _nameField.delegate = self;
    _dateField.delegate = self;
    _typeField.delegate = self;
    _valueField.delegate = self;
    _idField.delegate = self;
    _compositionField.delegate = self;
    _conditionField.delegate = self;
    
    manager = [[CoinManager alloc] init];
}

- (IBAction)takePhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)selectPhoto:(UIButton *)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        
    _imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelButton:(id)sender {
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveButton:(id)sender {
    Coin *coin = [[Coin alloc] initWithDate:_dateField.text :_nameField.text :_imageView.image :_typeField.text :_idField.text :_compositionField.text : _valueField.text : _conditionField.text];
    
    [manager addCoinToServer:coin];
    
    [self.view endEditing:YES];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField resignFirstResponder];
    
    return YES;
}


@end
