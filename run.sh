#!/bin/bash

# 设置账户密码
echo "root:$USER_PASSWD" | chpasswd

# 设置JupyterLab密码
echo c.ServerApp.password =\'`python3 -c "from jupyter_server.auth import passwd; print(passwd('$USER_PASSWD'),end='')"`\' >> /root/.jupyter/config/jupyter_lab_config.py

# 设置VNC密码
echo $USER_PASSWD | vncpasswd -f > ~/.vnc/passwd

# 启动VNC、SSH、JupyterLab
vncserver -geometry 1920x1080 -localhost no -PasswordFile ~/.vnc/passwd
nohup jupyter lab &
/usr/sbin/sshd -D
