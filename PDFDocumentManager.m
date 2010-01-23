//
//  PDFDocumentProcessor.m
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import "PDFDocumentManager.h"

@interface PDFDocumentManager (Private)

+ (NSString *)pathWithFormat:(NSString *)format number:(NSUInteger)number;
+ (NSString *)filename:(NSString *)filename withSuffix:(NSString *)suffix;

@end


@implementation PDFDocumentManager

#pragma mark private methods

+ (NSString *)pathWithFormat:(NSString *)format number:(NSUInteger)number
{
	BOOL isFormatStringWithOnePlaceholder = ([[format componentsSeparatedByString:@"%"] count] == 2);
	if (isFormatStringWithOnePlaceholder) {
		return [NSString stringWithFormat:format, number];
	} else {
		return [self filename:format withSuffix:[NSString stringWithFormat:@"_%03d", number]];
	}
}

+ (NSString *)filename:(NSString *)filename withSuffix:(NSString *)suffix
{
	NSString *extension = [filename pathExtension];
	NSString *filebase = [filename stringByDeletingPathExtension];
	return [[filebase stringByAppendingString:suffix] stringByAppendingPathExtension:extension];
}

#pragma mark class methods

+ (PDFDocumentManager *)processor 
{
	return [[[PDFDocumentManager alloc] init] autorelease];
}

+ (void)burst:(NSString *)fileName
{
	NSString *path = [[NSFileManager defaultManager] currentDirectoryPath];
	NSString *filePath = [path stringByAppendingPathComponent:fileName];
	NSURL *fileURL = [NSURL fileURLWithPath:filePath];
	NSLog(@"fileURL: %@", fileURL);
	
	PDFDocument *document = [[PDFDocument alloc] initWithURL:fileURL];
	PDFPage *page = [document pageAtIndex:0];
	NSLog(@"document: %@", document);
	
	PDFDocument *newDocument = [[PDFDocument alloc] init];
	[newDocument insertPage:[page copy] atIndex:0];
	NSLog(@"newDocument: %@", newDocument);
	
	NSString *extension = [fileName pathExtension];
	NSString *fileBase = [fileName stringByDeletingPathExtension];
	NSString *pageFile = [[fileBase stringByAppendingFormat:@"_%.3d", 1] stringByAppendingPathExtension:extension];
	[newDocument writeToFile:pageFile];
	NSLog(@"pageFile: %@", pageFile);
}

#pragma mark NSObject overwritten methods

- (id)init
{
	self = [super init];
	if (self != nil) {
		inputDocuments = [[NSMutableArray alloc] initWithCapacity:1];
	}
	return self;
}

- (void)dealloc
{
	[inputDocuments release];
	[super dealloc];
}

#pragma mark Instance methods

- (void)addDocument:(PDFDocument *)aDocument
{
	[inputDocuments addObject:aDocument];
}

- (NSUInteger)documentCount
{
	return [inputDocuments count];
}

- (BOOL)catDocuments
{
	PDFDocument *mergedDocument = [inputDocuments objectAtIndex:0];
	NSUInteger pageIndex = [mergedDocument pageCount];
	for (NSUInteger i = 1; i < [inputDocuments count]; i++) {
		PDFDocument *mergee = [inputDocuments objectAtIndex:i];
		for (NSUInteger j = 0; j < [mergee pageCount]; j++) {
			PDFPage *page = [mergee pageAtIndex:j];
			[mergedDocument insertPage:page atIndex:pageIndex++];
		}
	}
	while ([inputDocuments count] > 1) {
		[inputDocuments removeObjectAtIndex:1];
	}
	return YES;
}

- (BOOL)burstDocuments
{
	NSArray *originalDocuments = [NSArray arrayWithArray:inputDocuments];
	NSUInteger documentIndex = 0;
	for (PDFDocument *document in originalDocuments) {
		documentIndex++;
		while ([document pageCount] > 1) {
			PDFPage *page = [[document pageAtIndex:1] copy];
			PDFDocument *pageDocument = [[PDFDocument alloc] init];
			[pageDocument insertPage:page atIndex:0];
			[inputDocuments insertObject:pageDocument atIndex:documentIndex++];
		//	[pageDocument release];
		//	[page release];
			[document removePageAtIndex:1];
		}
	}
	NSLog(@"inputDocuments: %@", inputDocuments);
	return YES;
}

- (BOOL)writeDocumentsToFile:(NSString *)path
{
	for (NSUInteger i = 0; i < [inputDocuments count]; i++) {
		NSString *filepath = ([inputDocuments count] == 1) ? path : [[self class] pathWithFormat:path number:i+1];
		PDFDocument *document = [inputDocuments objectAtIndex:i];
		BOOL success = [document writeToFile:filepath];
		if (!success) {
			fprintf(stderr, "[error] PDF could not be written to '%s'\n", [filepath UTF8String]);
			return NO;
		}
	}
	return YES;
}

@end
