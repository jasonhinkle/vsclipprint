//
//  VSClipPrint.m
//  Utility for either sending text to the clipboard or sending it to an AirPrint printer
//
//  Created by Jason Hinkle on 11/14/14.
//  License: LGPL
//

#import "VSClipPrint.h"

@implementation VSClipPrint

// show an action sheet prompting the user to copy to clipboard or print.  NOTE: the caller
// must persist the reference to VSClipPrint, otherwise the VSClipPrint will be garbage collected
// before the action sheet delegate has fired
- (void) showInView:(UIView *)view withTitle: (NSString *)title forTextContent:(NSString *)content
{
	
	textContent = content;
	
	// don't bother prompting if air print is not available
	if ([UIPrintInteractionController isPrintingAvailable])
	{
		UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:title
																 delegate:self
														cancelButtonTitle:@"Cancel"
												   destructiveButtonTitle:nil
														otherButtonTitles:@"Copy To Clipboard", @"Send to AirPrint", nil];
		[actionSheet showInView:view];
	} else {
		[self doCopyToClipboard];
	}
	

}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0) [self doCopyToClipboard];
	
	if (buttonIndex == 1) [self doSendToAirPrint];

}

- (void)doCopyToClipboard
{
	UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
	pasteboard.string = textContent;
	
	[self showAlertWithMessage:@"Copied to Clipboard"];
}

-(void)doSendToAirPrint
{
	UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
	pic.delegate = self;
	
	UIPrintInfo *printInfo = [UIPrintInfo printInfo];
	printInfo.outputType = UIPrintInfoOutputGeneral;
	printInfo.jobName = @"Master Tour Mobile";
	pic.printInfo = printInfo;
	
	UISimpleTextPrintFormatter *textFormatter = [[UISimpleTextPrintFormatter alloc] initWithText:textContent];
	textFormatter.startPage = 0;
	textFormatter.contentInsets = UIEdgeInsetsMake(36.0, 36.0, 36.0, 36.0); // 1/2 inch margins
	textFormatter.maximumContentWidth = 7 * 72.0; // 8 inch paper - 1/2 inch margin margin = 7 inches
	pic.printFormatter = textFormatter;
	pic.showsPageRange = YES;
	
	void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) =
	^(UIPrintInteractionController *printController, BOOL completed, NSError *error) {
		
		if (!completed && error) {
			[self showAlertWithMessage: [NSString stringWithFormat:@"Unable to print: %@",error] ];
		}
		else {
			// TODO: confirmation alert might be annoying?
			// [self showAlertWithMessage:@"Print successful"];
		}
	};
	
	[pic presentAnimated:YES completionHandler:completionHandler];

}

-(void)showAlertWithMessage:(NSString *)message
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
													message:message
												   delegate:self
										  cancelButtonTitle:@"OK"
										  otherButtonTitles:nil];
	[alert show];
}

@end
