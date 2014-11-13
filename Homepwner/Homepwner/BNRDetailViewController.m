//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by Роман Солях on 12.11.14.
//  Copyright (c) 2014 Big Nerd Ranch. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRImageStore.h"
#import "BNRItem.h"

@interface BNRDetailViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueFileld;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController

-(void)setItem:(BNRItem *)item
{
    _item = item;
    self.navigationItem.title = item.info;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *barItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deletePicture:)];
    
    NSMutableArray *items = [self.toolbar.items mutableCopy];
    [items addObject:barItem];
    
    [self.toolbar setItems:items animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    BNRItem *item = self.item;
    
    self.nameField.text = item.info;
    self.serialNumberField.text = item.serialNumber;
    self.valueFileld.text = [NSString stringWithFormat:@"%d", item.price];
    
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter)
    {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateIntervalFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateIntervalFormatterNoStyle;
    }
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
    
    self.imageView.image = [[BNRImageStore sharedStore] imageForKey:item.itemKey];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
    BNRItem *item = self.item;
    
    item.info = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.price = [self.valueFileld.text integerValue];
}

#pragma mark - Actions and Outlets

- (IBAction)viewTouched:(id)sender
{
    [self.view endEditing:YES];
}

- (IBAction)takePicture:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    imagePicker.allowsEditing = YES;
    imagePicker.delegate = self;
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)deletePicture:(id)sender
{
    if(!self.imageView.image)
        return;
    
    self.imageView.image = nil;
    [[BNRImageStore sharedStore] deleteImageForKey:self.item.itemKey];
}

#pragma mark - UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    self.imageView.image = image;
    
    [[BNRImageStore sharedStore] setImage:image forKey:self.item.itemKey];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
