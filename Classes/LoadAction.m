//
//  LoadAction.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz.
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
