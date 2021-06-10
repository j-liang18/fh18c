#!/bin/bash

curl https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/files/mysmb.py -o ~/mysmb.py

curl https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/files/send_and_execute.py -o ~/send_and_execute.py

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o ~/get-pip.py

python ~/get-pip.py --user

python -m pip install --user impacket
