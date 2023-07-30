log=/tmp/${component}.log

func_appreq() {

  echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a roboshop user <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  useradd roboshop &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Deleting content in app folder <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  rm -rf /app &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a Application folder <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  mkdir /app &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading a Application code <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Unzipping the Application code <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  cd /app
  unzip /tmp/${component}.zip &>>${log}
}

func_system() {

  echo -e "\e[33m>>>>>>>>>>>>>>>> Daemon service loading <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  systemctl daemon-reload &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Catalogue service enabled <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  systemctl enable ${component} &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Catalogue service restart <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  systemctl restart ${component} &>>${log}
}

func_nodejs() {

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a ${component} service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a Mongodb repo <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp mongodb.repo /etc/yum.repos.d/mongodb.repo &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading a Nodejs <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing a Nodejs <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install nodejs -y &>>${log}

func_appreq()

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Application Dependencies <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
npm install &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Mongodb client <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install mongodb-org-shell -y &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Loading the mongodb schema <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
mongo --host mongodb.soujandevops.online </app/schema/${component}.js &>>${log}

func_system()

}

func_java() {

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a ${component} service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp ${component}.service /etc/systemd/system/${component}.service &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a ${component} service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp mysql.repo  /etc/yum.repos.d/mysql.repo &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing a maven <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install maven -y &>>${log}

func_appreq()

echo -e "\e[33m>>>>>>>>>>>>>>>> Cleaning the maven package <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
mvn clean package &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Moving the application files <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
mv target/${component}-1.0.jar ${component}.jar &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Mysql client <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install mysql -y &>>${log}

echo -e "\e[33m>>>>>>>>>>>>>>>> Loading the mysql schema <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
mysql -h mysql.soujandevops.online -uroot -pRoboShop@1 < /app/schema/${component}.sql &>>${log}

 func_system()

}

func_appreq() {

  echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a roboshop user <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  useradd roboshop &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Deleting content in app folder <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  rm -rf /app &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a Application folder <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  mkdir /app &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading a Application code <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  curl -o /tmp/${component}.zip https://roboshop-artifacts.s3.amazonaws.com/${component}.zip &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Unzipping the Application code <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  cd /app
  unzip /tmp/${component}.zip &>>${log}
}

func_system() {

  echo -e "\e[33m>>>>>>>>>>>>>>>> Daemon service loading <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  systemctl daemon-reload &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Catalogue service enabled <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  systemctl enable ${component} &>>${log}

  echo -e "\e[33m>>>>>>>>>>>>>>>> Catalogue service restart <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
  systemctl restart ${component} &>>${log}
}


