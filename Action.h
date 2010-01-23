//
//  Action.h
//  PDFKitTool
//
//  Created by Joachim Fornallaz on 23.01.10.
//  Copyright 2010 Joachim Fornallaz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PDFDocumentManager.h"


@interface Action : NSObject {
	NSArray *parameters;
	PDFDocumentManager *processor;
}

@property(nonatomic, copy) NSArray *parameters;
@property(nonatomic, retain) PDFDocumentManager *processor;

+ (Action *)actionForKey:(NSString *)key;
- (NSUInteger)requiredParameterCount:(NSArray *)lookaheadArguments;
- (BOOL)runWithParameters:(NSArray *)inParameters processor:(PDFDocumentManager *)inProcessor;
- (BOOL)run;

@end
