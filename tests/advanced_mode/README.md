# Advanced Mode

How to verify that Python interpreter works in advanced mode?

Assume Python version is 2.7, and run in linux_x86_64 platform.

If Python version is not 2.7, please download `foo-XY.py` as the corresponding Python version other than `foo-27.py`.

1.Download the following files

    https://github.com/dashingsoft/pyarmor-core/tree/v5.3.0/tests/advanced_mode/foo-27.py
    https://github.com/dashingsoft/pyarmor-core/tree/v5.3.0/tests/advanced_mode/pytransform.py
    https://github.com/dashingsoft/pyarmor-core/tree/v5.3.0/tests/advanced_mode/pytransform.key
    https://github.com/dashingsoft/pyarmor-core/tree/v5.3.0/tests/advanced_mode/license.lic

2.Download the corresponding dynamic library by platform::

    https://github.com/dashingsoft/pyarmor-core/tree/v5.3.0/tests/platforms/linux_x86_64/_pytransform.so

Here are all available platforms

    https://github.com/dashingsoft/pyarmor-core/tree/v5.3.0/tests/platforms

3.Run test scripts::

    python foo-27.py

In Windows, if it reports this error::

    [Error 5] Access is denied

It could be solved by granting the executable permission to the dynamic library `_pytransform.dll`.
