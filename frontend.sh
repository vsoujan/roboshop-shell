source common.sh

echo -e "\e[33m>>>>>>>>>>>>>>>> Installing the Nginx service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
yum install nginx -y &>>{log}
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Creating a reverse proxy service  <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cp nginx-roboshop.conf /etc/nginx/default.d/roboshop.conf &>>{log}
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Removing the default content in Nginx <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
rm -rf /usr/share/nginx/html/* &>>{log}
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Downloading the App Content <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend.zip &>>{log}
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Extracting the App content <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
cd /usr/share/nginx/html/ &>>{log}
unzip /tmp/frontend.zip &>>{log}
func_status_check

echo -e "\e[33m>>>>>>>>>>>>>>>> Restarting the Nginx service <<<<<<<<<<<<<<<\e[0m" | tee -a ${log}
systemctl enable nginx &>>{log}
systemctl restart nginx &>>{log}
func_status_check

