#

import hashlib
import json
import os

from datetime import datetime


TEMPLATE = r'''sed -i -e '/"path": "{name}"/,+6 s/"sha256":.*$/"sha256": "{vdata}",/g' {filename}'''
UPDATE_TIME = r'''sed -i -e 's/"build_time": .*$/"build_time:": "{time}",/g' {filename}'''

def make_hash256(filename):
    with open(filename) as f:
        cfg = json.load(f)

    for p in cfg['platforms']:
        libfile = os.path.join(p['path'], p['filename'])
        with open(libfile, 'rb') as f:
            p['sha256'] = hashlib.sha256(f.read()).hexdigest()
        cmd = TEMPLATE.format(name=p['path'].replace('/', r'\/'),
                              vdata=p['sha256'], filename=filename)
        print(cmd)
        os.system(cmd)

    # with open(filename, 'w') as f:
    #     json.dump(cfg, f, indent=2)
    # print(json.dumps(cfg, indent=2))


if __name__ == '__main__':
    filename = 'index.json'
    make_hash256(filename)

    cmd = UPDATE_TIME.format(time=datetime.today().strftime('%Y-%m-%d %H:%M:%S'),
                             filename=filename)
    print(cmd)
    os.system(cmd)
