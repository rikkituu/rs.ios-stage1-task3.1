#import "ViewController.h"
@interface ViewController() {
    UILabel *myColorLabel;
    UIView *myColorView;
    UILabel *redColorLabel;
    UITextField *redColorTextField;
    UILabel *greenColorLabel;
    UITextField *greenColorTextField;
    UILabel *blueColorLabel;
    UITextField *blueColorTextField;
    UIButton *processButton;
    UIColor *color;
}

@end

@implementation ViewController

#pragma mark -

- (void)viewDidLoad {
    [super viewDidLoad];

    myColorLabel = [[UILabel alloc]initWithFrame: CGRectMake(25, 70, 100, 30)];
    myColorLabel.textColor = [UIColor blackColor];
    myColorLabel.text = @"Color";
    [self.view addSubview:myColorLabel];
    
    myColorView =[[UIView alloc]initWithFrame: CGRectMake(135, 65, 235, 40)];
    [self.view addSubview:myColorView];
    
    redColorLabel = [[UILabel alloc]initWithFrame: CGRectMake(25, 130, 100, 30)];
    redColorLabel.textColor = [UIColor blackColor];
    redColorLabel.text = @"RED";
    [self.view addSubview:redColorLabel];
    
    redColorTextField =[[UITextField alloc]initWithFrame: CGRectMake(115, 125, 255, 40)];
    redColorTextField.placeholder = @"0..255";
    redColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    redColorTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [redColorTextField setFont:[UIFont boldSystemFontOfSize:14]];
    redColorTextField.keyboardType = UIKeyboardTypeNumberPad;
    [redColorTextField addTarget:self action:@selector(textFieldInFocus) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:redColorTextField];
    
    greenColorLabel = [[UILabel alloc]initWithFrame: CGRectMake(25, 190, 100, 30)];
    greenColorLabel.textColor = [UIColor blackColor];
    greenColorLabel.text = @"GREEN";
    [self.view addSubview:greenColorLabel];
    
    greenColorTextField =[[UITextField alloc]initWithFrame: CGRectMake(115, 185, 255, 40)];
    greenColorTextField.placeholder = @"0..255";
    greenColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    greenColorTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [greenColorTextField setFont:[UIFont boldSystemFontOfSize:14]];
    greenColorTextField.keyboardType = UIKeyboardTypeNumberPad;
    [greenColorTextField addTarget:self action:@selector(textFieldInFocus) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:greenColorTextField];
    
    blueColorLabel = [[UILabel alloc]initWithFrame: CGRectMake(25, 250, 100, 30)];
    blueColorLabel.textColor = [UIColor blackColor];
    blueColorLabel.text = @"BLUE";
    [self.view addSubview:blueColorLabel];
    
    blueColorTextField =[[UITextField alloc]initWithFrame: CGRectMake(115, 245, 255, 40)];
    blueColorTextField.placeholder = @"0..255";
    blueColorTextField.borderStyle = UITextBorderStyleRoundedRect;
    blueColorTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    [blueColorTextField setFont:[UIFont boldSystemFontOfSize:14]];
    blueColorTextField.keyboardType = UIKeyboardTypeNumberPad;
    [blueColorTextField addTarget:self action:@selector(textFieldInFocus) forControlEvents:UIControlEventEditingDidBegin];
    [self.view addSubview:blueColorTextField];
    
    
    processButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [processButton setTitle:@"Process" forState:UIControlStateNormal];
    [processButton sizeToFit];
    CGFloat x = (self.view.frame.size.width - processButton.frame.size.width)/2;
    [processButton setFrame:CGRectMake(x, 350, processButton.frame.size.width, processButton.frame.size.height)];
    [processButton addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:processButton];
    
    
    self.view.accessibilityIdentifier = @"mainView";
    redColorTextField.accessibilityIdentifier = @"textFieldRed";
    greenColorTextField.accessibilityIdentifier = @"textFieldGreen";
    blueColorTextField.accessibilityIdentifier = @"textFieldBlue";
    processButton.accessibilityIdentifier = @"buttonProcess";
    redColorLabel.accessibilityIdentifier = @"labelRed";
    greenColorLabel.accessibilityIdentifier = @"labelGreen";
    blueColorLabel.accessibilityIdentifier = @"labelBlue";
    myColorLabel.accessibilityIdentifier = @"labelResultColor";
    myColorView.accessibilityIdentifier = @"viewResultColor";
}
- (void)buttonClick {
    [self.view endEditing:YES];
    
    CGFloat redColorValue = [redColorTextField.text doubleValue];
    CGFloat greenColorValue = [greenColorTextField.text doubleValue];
    CGFloat blueColorValue = [blueColorTextField.text doubleValue];
    
    BOOL colorCheck = (redColorValue <= 255 && blueColorValue <= 255 && greenColorValue <= 255);
    BOOL textCheck = [self isStringNumeric:redColorTextField.text] && [self isStringNumeric:greenColorTextField.text] && [self isStringNumeric:blueColorTextField.text];
    BOOL isStringNotEmpty = [self isStringNotEmpty:redColorTextField.text] && [self isStringNotEmpty:greenColorTextField.text] && [self isStringNotEmpty:blueColorTextField.text];
    
    if (colorCheck && textCheck && isStringNotEmpty) {
        myColorView.backgroundColor = [UIColor colorWithRed:(redColorValue/255) green:(greenColorValue/255) blue:(blueColorValue/255) alpha:1];
        myColorLabel.text = [self hexStringForColor:myColorView.backgroundColor];
        redColorTextField.text = @"";
        greenColorTextField.text = @"";
        blueColorTextField.text = @"";
        
    } else {
        myColorLabel.text = @"Error";
        myColorView.backgroundColor = [UIColor whiteColor];
    }
}
- (NSString *)hexStringForColor:(UIColor*)color {
      const CGFloat *components = CGColorGetComponents(color.CGColor);
      CGFloat r = components[0];
      CGFloat g = components[1];
      CGFloat b = components[2];
      NSString *hexString=[NSString stringWithFormat:@"0x%02X%02X%02X", (int)(r * 255), (int)(g * 255), (int)(b * 255)];
      return hexString;
}

- (void)textFieldInFocus {
    if (![myColorLabel.text isEqualToString: @"Color"]) {
        redColorTextField.text = @"";
        greenColorTextField.text = @"";
        blueColorTextField.text = @"";
        myColorLabel.text = @"Color";
        myColorView.backgroundColor = [UIColor whiteColor];
    }
}

- (BOOL)isStringNumeric:(NSString *)text {
    NSCharacterSet *alphaNums = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *inStringSet = [NSCharacterSet characterSetWithCharactersInString:text];
    return [alphaNums isSupersetOfSet:inStringSet];
}
- (BOOL)isStringNotEmpty:(NSString *)text {
    NSUInteger length = text.length;
    return length > 0;
}

@end
