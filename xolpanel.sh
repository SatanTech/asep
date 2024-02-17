#!/bin/bash
ipsaya=$(curl -s -4 icanhazip.com)
red() { echo -e "\\033[32;1m${*}\\033[0m"; }
data_server=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
date_list=$(date +"%Y-%m-%d" -d "$data_server")
data_ip="https://raw.githubusercontent.com/SatanTech/permission/main/ip"
checking_sc() {
    useexp=$(curl -sS $data_ip | grep $ipsaya | awk '{print $3}')
    if [[ $date_list < $useexp ]]; then
        echo -ne
    else
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "$COLOR1 ${NC} ${COLBG1}          ${WH}• AUTOSCRIPT PREMIUM •               ${NC} $COLOR1 $NC"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
        echo -e "            ${RED}PERMISSION DENIED !${NC}"
        echo -e "   \033[0;33mYour VPS${NC} $ipsaya \033[0;33mHas been Banned${NC}"
        echo -e "     \033[0;33mBuy access permissions for scripts${NC}"
        echo -e "             \033[0;33mContact Your Admin ${NC}"
        echo -e "     \033[0;36mTelegram${NC}: https://t.me/abecasdee"
        echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
        exit
    fi
}
checking_sc

domain=$(cat /etc/xray/domain)
#color
grenbo="\e[92;1m"
NC='\e[0m'
WH='\033[1;37m'
#install
function install-bot(){
apt update -y && apt upgrade -y
apt install python3 python3-pip git speedtest-cli -y
sudo apt-get install -y p7zip-full
cd /root/sf
clear
wget https://raw.githubusercontent.com/SatanTech/janda/main/sf.zip
unzip sf.zip
pip3 install -r sf/requirements.txt
clear
chmod +x *
mv -f * /root/sf
rm -rf /root/sf/*.zip
mv tmb /usr/local/bin
cd
rm -rf /etc/tele

clear
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "$COLOR1 ${NC} ${COLBG1}                ${WH}• BOT PANEL •                  ${NC} $COLOR1 $NC"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
echo -e "$COLOR1╭═════════════════════════════════════════════════╮${NC}"
echo -e "${grenbo}Tutorial Creat Bot and ID Telegram${NC}"
echo -e "${grenbo}[*] Creat Bot and Token Bot : @BotFather${NC}"
echo -e "${grenbo}[*] Info Id Telegram : @MissRose_bot , perintah /info${NC}"
echo -e "$COLOR1╰═════════════════════════════════════════════════╯${NC}"
rm -rf /root/sf/ddsdswl.session
rm -rf /root/sf/var.txt
rm -rf /root/sf/database.db
echo -e ""
read -e -p "[*] Input your Bot Token : " bottoken
read -e -p "[*] Input Your Id Telegram :" admin

cat >/root/sf/var.txt <<EOF
BOT_TOKEN="$bottoken"
ADMIN="$admin"
DOMAIN="$domain"
EOF

echo 'TEXT=$'"(cat /etc/notiftele)"'' > /etc/tele
echo "TIMES=10" >> /etc/tele
echo 'KEY=$'"(cat /etc/per/token)"'' >> /etc/tele

echo "$bottoken" > /etc/per/token
echo "$admin" > /etc/per/id
echo "$bottoken" > /root/sf/token
echo "$admin" > /root/sf/idchat
echo "$bottoken" > /etc/perlogin/token
echo "$admin" > /etc/perlogin/id
clear

echo "SHELL=/bin/sh" >/etc/cron.d/cekbot
echo "PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/root/sf" >>/etc/cron.d/cekbot
echo "*/1 * * * * root /root/sf/cekbot" >>/etc/cron.d/cekbot

cat > /root/sf/cekbot << END
nginx=$( systemctl status sf | grep Active | awk '{print $3}' | sed 's/(//g' | sed 's/)//g' )
if [[ $nginx == "running" ]]; then
    echo -ne
else
    systemctl restart sf
    systemctl start sf
fi

sf=$( systemctl status sf | grep "TERM" | wc -l )
if [[ $sf == "0" ]]; then
echo -ne
else
    systemctl restart sf
    systemctl start sf
fi
END

cat > /etc/systemd/system/sf.service << END
[Unit]
Description=Adminsf
After=syslog.target network-online.target

[Service]
WorkingDirectory=/root/sf
ExecStart=/root/sf/python3 -m sf
Restart=on-failure

[Install]
WantedBy=multi-user.target
END

systemctl daemon-reload &> /dev/null
systemctl enable sf &> /dev/null
systemctl start sf &> /dev/null
systemctl restart sf &> /dev/null

echo "Done"
echo " Installations complete, type /menu on your bot"
read -n 1 -s -r -p "Press any key to back on menu"
menu
}
cd
if [ -e /root/sf ]; then
echo -ne
else
install-bot
fi
