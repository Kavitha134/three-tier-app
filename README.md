# Three-Tier Python Web Application on Google Compute Engine and CloudSQL

#steps to execute this project
1. Create a VM instance and SSH into the instance
2. Install git using "apt -y install git"
3. Install the mysql client to connect the VM instance and the mysql using the command "apt -y install default-mysql-client"
4. Clone the repository using the command "git clone https://github.com/Kavitha134/three-tier-app.git"
5. Modify the config.py according to your mysql database connections.
6. Add the IP address of your VM instance to the mysql autorised connections
7. Install the neccessary pacakages using the command "python3 -m pip install -r requirements.txt "
8. Run "python app.py" 
