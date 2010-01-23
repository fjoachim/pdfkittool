//
//  LoadAction.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import "LoadAction.h"


@implementation LoadAction

+ (BOOL)isLoadableParameter:(NSString *)parameter
{
	NSFileManager *manager = [NSFileManager defaultManager];
	return [manager fileExistsAtPath:parameter];
}

- (BOOL)run
{
	NSString *inFilePath = [self.parameters objectAtIndex:0];
	if (![LoadAction isLoadableParameter:inFilePath]) {
		NSLog(@"Input File '%@' does not exist", inFilePath);
		return NO;
	}

	NSURL *documentURL = [NSURL fileURLWithPath:inFilePath];
	PDFDocument *document = [[PDFDocument alloc] initWithURL:documentURL];
	if (document) {
		[self.processor addDocument:document];
		[document release];
	} else {
		NSLog(@"Unable to load input file '%@'", inFilePath);
		return NO;
	}

	return YES;
}

- (NSUInteger)requiredParameterCount:(NSArray *)lookaheadArguments
{
	return 1;
}


@end
