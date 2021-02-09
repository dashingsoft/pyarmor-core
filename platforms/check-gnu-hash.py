import os
import struct
import sys
from glob import glob


def check_gnu_hash_section(filename):
    with open(filename, 'rb') as f:
        data = f.read()

    n = 0x200
    fmt = 'I' * n
    arr = struct.unpack(fmt, data[:n*4])

    i = 0
    while True:
        for key in (0xe746a6ab, 0xb4239787, 0xb4270e0b):
            try:
                i = arr.index(key, i)
                kx = 2 if key == 0xb4270e0b else 0
                break
            except Exception:
                pass
        else:
            return

        k = i + kx
        if arr[k-12] == 3 and arr[k-10] == 1 and arr[k-9] == 6:
            return i * 4
        elif arr[k-11] == 3 and arr[k-9] == 1 and arr[k-8] == 5:
            return i * 4
        i += 1


def main(path=''):
    filelist1 = glob('linux.*.11.py*/*.so') + glob('musl.*.11.py*/*.so')
    filelist2 = glob('darwin.*.11.py*/*.so') + glob('ios.*.11.py*/*.so')

    for filename in filelist1:
        found = check_gnu_hash_section(filename)
        print('%s found at %s' % (os.path.dirname(filename), found))
        if found is None:
            print('Error: no found hash key')
            sys.exit(1)

    for filename in filelist2:
        found = check_gnu_hash_section(filename)
        if found is not None:
            print('%s found at %s' % (os.path.dirname(filename), found))
            print('Error: found key in non-linux platform')
            sys.exit(1)

    print('Check section .gnu.hash OK')

if __name__ == '__main__':
    main()
