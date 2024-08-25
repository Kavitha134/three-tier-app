#! /bin/bash
apt update
apt -y install git
git clone https://github.com/Kavitha134/three-tier-app.git
cd three-tier-app
apt -y install default-mysql-client
apt -y install python3.11-venv
python3 -m venv abc
source abc/bin/activate
python3 -m pip install -r requirements.txt 
python app.py
