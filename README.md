TitaniumAppFramework
====================

A simple coffeescript app framework built upon appcelerator titanium



Titanium Symlink Fix:
---------------------

Titanium SDK donesn't support symlinks by default. To fix, compiler.py should be modified as follows:

  /Library/Application Support/Titanium/mobilesdk/osx/[Version]/iphone/compiler.py

  Change the method 'add_compiled_resources':
  from:
    for root, dirs, files in os.walk(source):
  to:
    for root, dirs, files in os.walk(source, True, None, True):