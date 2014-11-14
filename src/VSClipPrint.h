//
//  VSClipPrint.h
//  Utility for either sending text to the clipboard or sending it to an AirPrint printer
//
//  Created by Jason Hinkle on 11/14/14.
//  License: LGPL
//

#import <Foundation/Foundation.h>

@interface VSClipPrint : NSObject <UIActionSheetDelegate,UIPrintInteractionControllerDelegate>
{
	NSString *textContent;
}

- (void) showInView:(UIView *)view withTitle: (NSString *)title forTextContent:(NSString *)content;
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end
