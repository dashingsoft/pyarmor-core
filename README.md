# pyarmor-core

The core of PyArmor is written by C, the prebuilt dynamic libraries include the
common platforms and some embeded platforms.

Here list all the support platforms [platforms/index.json](platforms/index.json)

Contact jondy.zhao@gmail.com if you'd like to run PyArmor in other platform.

## hdinfo

There is a tool `hdinfo` which could be used to query hardware information
without pyarmor. It's useful as generating new license file for obfuscated
scripts.

Here list all the available platforms:

* [platforms/win32/hdinfo.exe](platforms/win32/hdinfo.exe)
* [platforms/win_amd64/hdinfo.exe](platforms/win_amd64/hdinfo.exe)
* [platforms/linux_i386/hdinfo.exe](platforms/linux_i386/hdinfo)
* [platforms/linux_x86_64/hdinfo.exe](platforms/linux_x86_64/hdinfo)
* [platforms/macosx_x86_64/hdinfo.exe](platforms/macosx_x86_64/hdinfo)
