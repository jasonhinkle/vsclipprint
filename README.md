VSClipPrint
===========

iOS utility class for sending text to the clipboard or AirPrint printer.
With one line of code your app will display an action sheet with an
option to copy text to the clipboard, or send it to and AirPrint printer.

![Screenshot](https://raw.github.com/jasonhinkle/vsclipprint/master/img/screenshot.png)

Usage
-----

```
[VSClipPrint showInView: self.view
			  withTitle: @"Title"
		 forTextContent: @"The text to copy/print"];
```

License
-------

Free for personal and commercial usage under the terms of LGPL