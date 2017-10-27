//
//  AddReceiptViewController.m
//  Receipts
//
//  Created by Andrew on 2017-10-27.
//  Copyright © 2017 hearthedge. All rights reserved.
//

#import "AddReceiptViewController.h"

@interface AddReceiptViewController ()
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (strong, nonatomic) UIDatePicker *datePicker;
- (IBAction)addTagButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender;
- (IBAction)clearInputButton:(UIButton *)sender;


// TODO: Add tag picker

@end

@implementation AddReceiptViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self setupDatePicker];
    
}

- (void)setupDatePicker {
    self.datePicker = [UIDatePicker new];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    //self.datePicker
    
    self.dateTextField.inputView = self.datePicker;
    
    // TODO: Set delegate
}


-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"Picker View Called");
    
    
    // TODO: update self.dateTextField.text with input
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tagCell"];
    
    cell.textLabel.text = @"Tag, you're it";
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (IBAction)addTagButtonPressed:(UIBarButtonItem *)sender {
}

- (IBAction)doneButtonPressed:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)clearInputButton:(UIButton *)sender {
    [self.view endEditing:YES];
}
@end
