#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 * A custom 1-line label class which animates text that otherwise would have been truncated.
 */
@interface ALAnimatingLabel : UIView

/**
 * The text for the underlying label. If wider than what can fit in the frame, will automatically animate horizontally.
 */
@property (nonatomic, copy) NSString *text;

@end

NS_ASSUME_NONNULL_END
