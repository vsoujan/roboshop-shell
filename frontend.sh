echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Nginx service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install nginx -y
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a reverse proxy service  <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Removing the default content in Nginx <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
rm -rf /usr/share/nginx/html/*
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading the App Content <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Extracting the App content <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cd /usr/share/nginx/html/
unzip /tmp/frontend.zip
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Restarting the Nginx service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
systemctl enable nginx
systemctl restart nginx
func_status_check

