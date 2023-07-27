echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a catalogue service <<<<<<<<<<<<<<<\e[0m"
cp catalogue.service /etc/systemd/system/catalogue.service

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a Mongodb repo <<<<<<<<<<<<<<<\e[0m"
cp mongodb.repo /etc/yum.repos.d/mongodb.repo

echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading a Nodejs <<<<<<<<<<<<<<<\e[0m"
curl -sL https://rpm.nodesource.com/setup_lts.x | bash

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing a Nodejs <<<<<<<<<<<<<<<\e[0m"
yum install nodejs -y

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a roboshop user <<<<<<<<<<<<<<<\e[0m"
useradd roboshop

echo -e "\e[33m>>>>>>>>>>>>>>>> Deleting content in app folder <<<<<<<<<<<<<<<\e[0m"
rm -rf /app

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a Application folder <<<<<<<<<<<<<<<\e[0m"
mkdir /app

echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading a Application code <<<<<<<<<<<<<<<\e[0m"
curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue.zip

echo -e "\e[33m>>>>>>>>>>>>>>>> Unzipping the Application code <<<<<<<<<<<<<<<\e[0m"
cd /app
unzip /tmp/catalogue.zip

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Application Dependencies <<<<<<<<<<<<<<<\e[0m"
npm install

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Mongodb client <<<<<<<<<<<<<<<\e[0m"
yum install mongodb-org-shell -y

echo -e "\e[33m>>>>>>>>>>>>>>>> Loading the mongodb schema <<<<<<<<<<<<<<<\e[0m"
mongo --host mongodb.soujandevops.online </app/schema/catalogue.js

echo -e "\e[33m>>>>>>>>>>>>>>>> Daemon service loading <<<<<<<<<<<<<<<\e[0m"
systemctl daemon-reload

echo -e "\e[33m>>>>>>>>>>>>>>>> Catalogue service enabled <<<<<<<<<<<<<<<\e[0m"
systemctl enable catalogue

echo -e "\e[33m>>>>>>>>>>>>>>>> Catalogue service restart <<<<<<<<<<<<<<<\e[0m"
systemctl restart catalogue

