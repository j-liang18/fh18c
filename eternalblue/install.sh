#!/bin/bash

curl https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/files/mysmb.py -o ~/mysmb.py

curl https://raw.githubusercontent.com/j-liang18/fh18c/main/eternalblue/files/send_and_execute.py -o ~/send_and_execute.py

curl https://bootstrap.pypa.io/pip/2.7/get-pip.py -o ~/get-pip.py

python ~/get-pip.py --user

python -m pip install --user impacket

# US Cyber Range INC0522229
curl -fsSL https://gist.githubusercontent.com/dominikborkowski/aaaf0e55853da7999f1050f7211a275b/raw/b9e601af62ba36c56651fdede33bcb0251704c8e/gistfile1.txt | sudo bash
