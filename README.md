VSClipPrint
===========

iOS utility class for sending text to the clipboard or AirPrint printer.
With one line of code your app will display an action sheet with an
option to copy text to the clipboard, or send it to and AirPrint printer.

![Screenshot](https://raw.github.com/jasonhinkle/vsclipprint/master/img/screenshot.png)

Usage
-----

```
VSClipPrint *clipPrint = [[VSClipPrint alloc] init];

[clipPrint showInView: self.view
			withTitle: @"Title"
		forTextContent: @"The text to copy/print"];

// note that clipPrint should be made either a singleton or a property
// of your controller because if it goes out of scope while the Action Sheet
// is in view, the delegate won't fire
```

License
-------

Free for personal and commercial usage under the terms of LGPL