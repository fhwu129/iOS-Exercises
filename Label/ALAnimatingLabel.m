#import "ALAnimatingLabel.h"

@interface ALAnimatingLabel()

// nonatomic - multi threading and saftey
// strong how pointer is attached to string
@property (nonatomic, strong) UILabel *label;

@end

@implementation ALAnimatingLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame: frame];
    if ( self )
    {
        self.label = [[UILabel alloc] initWithFrame: frame];
        [self addSubview: self.label];
    }
    
    return self;
}

- (void)setText:(NSString *)text
{
    /**
     Update the UNDERLYING iVar ... basically "@property"s r just syntactic sugar that automatically creates setts and getters for you in the bg...
     
     like `@property (nonatomic, copy) NSString *text;`
     
     generates the setters and getters for yoU:
     
     - (void)setText:(NSString *)text // setter
     {
     _text = text;
     }
     
     and
     
     - (NSString *)text // getter
     {
     return _text;
     }
     
     we override the getter or setter if we want to add some custom functionalnity, like in our case, if the user sets `text` on the `ALAnimatingLabel` instance, we wanna override it to also set the text for our underlyin label.
     */
    _text = text;
    
    // Set the text for the underlying label
    self.label.text = text;

    CGFloat expectedWidth = [self calculateExpectedWidth];
    if ( expectedWidth > self.label.frame.size.width )
    {
        CGRect updatedFrame = self.label.frame;
        updatedFrame.size.width = [self calculateExpectedWidth];
        self.label.frame = updatedFrame;
        [self animateTextOverflow];
    }
    
    NSLog(@"The expected width for the text \"%@\" is %f", text, [self calculateExpectedWidth]);
}

//- (void)didMoveToWindow
//{
//    [self didMoveToWindow];
//    NSLog(@"%s", __PRETTY_FUNCTION__);
//}

- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

// TODO: Abstract into category ;) - we can do it end of proj
/**
 * Calculate the expected width of the underlying label and its text.
 */
- (CGFloat)calculateExpectedWidth
{
    // TODO: There might be a better way to do this nowadays, cuz it feels kinda hacky
    CGSize maxSize = CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.label.frame));
    
    // TODO: `-[NSString sizeWithFont:constrainedToSize:lineBreakMode:]` has been deprecated - wtf are we supposed to use nowadays?
//    CGSize expectedSize = [self.label.text
//                           sizeWithFont: self.label.font
//                           constrainedToSize: maxSize
//                           lineBreakMode: self.label.lineBreakMode];
    
    CGRect boundingRect = [self.label.text
                           boundingRectWithSize: maxSize
                           options: ( NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin )
                           attributes: @{ NSFontAttributeName:self.label.font }
                           context:nil];
    
    return ceil(boundingRect.size.width);
}

/**
 *  Animate text
 */
- (void)animateTextOverflow
{
    [UIView animateWithDuration:10
         delay:0.25
       options: UIViewAnimationOptionRepeat | UIViewAnimationOptionCurveEaseInOut
    animations:^{
        self.label.frame = CGRectMake((self.frame.size.width - ([self calculateExpectedWidth])), self.label.frame.origin.y, CGRectGetWidth(self.label.frame), CGRectGetHeight(self.label.frame));
    }
    completion:NULL];
}

@end
