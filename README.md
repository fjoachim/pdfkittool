PDFKitTool
==========

Version 1.0 - Source available on [GitHub](http://github.com/fjoachim/pdfkittool).

Copyright 2010 Joachim Fornallaz. All rights reserved.


Introduction
------------

This tool is used to manipulate PDF documents. It can combine several documents
into one or burst multipage documents into multiple single-paged documents.


Requirements
------------

PDFKitTool requires Mac OS X Leopard (v10.5) or later und runs on Intel and PPC Macs.


Installation
------------

PDFKitTool consists of a single file which can be installed anywhere, preferably
in /usr/local/bin or ~/bin - make sure the file is executable.


Usage
-----

PDFKitTool is a command line tool which is invoked like this:

    ./PDFKitTool action parameters [action parameters]

There can be multiple action/parameters sequences in a command line.
The actions are executed in the order in which they appear on the command line.

The supported actions are:

* `load`

    Loads a PDF document from a path on disk. 
    Expects one parameter: The file path.
    As a shortcut, you can omit the 'load' action and just provide a file path.

* `cat`

    Combines all loaded documents into one.
    No parameters expected.

* `burst`

    Splits all documents having more than one page into several one-page documents.
    No parameters expected.

* `output`

    Stores all documents to disk to the provided path. 
    Expects one parameter: The file path.
    When storing multiple documents, PDFKitTool adds a suffix like _001 to the file name.


Examples
--------


Combining multiple documents and storing the result to disk:

    ./PDFKitTool load one.pdf load two.pdf cat output combined.pdf
    
Alternative notation (pdftk-compatible):

    ./PDFKitTool one.pdf two.pdf cat output combined.pdf


Bursting a multipage document into multiple single-paged documents:

    ./PDFKitTool load multipage.pdf burst output bursted.pdf
    
Given multipage.pdf has 4 pages, PDFKitTool will create following files:
    
    bursted_001.pdf bursted_002.pdf bursted_003.pdf bursted_004.pdf


Additional Information
----------------------

Depending on the PDFs used with PDFKitTool, you will see many messages like this:

    PDFKitTool(14100,0x7fff70779be0) malloc: reference count underflow for 0x2000c4060, break on auto_refcount_underflow_error to debug.
    
This is a bug in Apple's PDF Kit Framework, which will hopefully be fixed one day.
In order not to crash because of that bug, PDFKitTool might consume more memory than actually needed.


Acknowledgements
----------------

Thanks to Marc Liyanage for his [CoreImageTool](http://github.com/liyanage/coreimagetool) which was a great starting point
for PDFKitTool, the CommandLineDriver class rocks! 
