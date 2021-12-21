#!/bin/sh
function get_colour()
{
	red="\e[0;31m"
	cyan="\e[1;36m"
	blue="\e[0;94m"
	green="\e[0;32m"
	purple="\e[0;35m"

	if [ -d /etc/dpkg ]; then
		pkgs=$[$(dpkg -l |wc -l)-6]
		pkgmgr="dpkg"
		colour="$red"

	elif [ -e /etc/pacman.conf ]; then
		pkgs="$(pacman -Qq |wc -l)"
		pkgmgr="pacman"
		colour="$cyan"

	elif [ -d /etc/apk ]; then
		pkgs="$(apk info |wc -l)"
		pkgmgr="apk"
		colour="$blue"

	elif [ -d /etc/dnf ]; then
		pkgs=$[$(dnf list installed |wc -l)-2]
		pkgmgr="dnf"
		colour="$blue"

	elif [ -d /etc/yum ]; then
		pkgs=$[$(yum list installed -q| wc -l)-1]
		pkgmgr="yum"
		colour"$green"

	elif [ -e /etc/xbps.d ]; then
		pkgs="$(xbps-query -l | wc -l)"
		pkgmgr="xbps"
		colour"$green"
	fi
	reset="\e[0m"
}

function get_username()
{
	username="$(whoami)"
	echo "$username"
}

function get_hostname()
{
	hostname="$(hostnamectl hostname)"
	echo "$hostname"
}

function get_title()
{
	get_colour
	echo -e ""$colour"$(get_username)"$reset"@"$colour"$(get_hostname)"$reset
}

function get_os()
{
	os="$(grep "^PRETTY_NAME" /etc/os-release | cut -d"=" -f2 | cut -d'"' -f2) $(uname -m)"
	echo "$os"
}

function get_kernel()
{
	kernel="$(uname -r)"
	echo "$kernel"
}

function get_shell()
{
	shell="$(echo $SHELL)"
	echo "$shell"
}

function get_uptime()
{
	uptime="$(uptime -p | sed 's/up //g')"
	echo "$uptime"
}

function get_ram()
{
	ram="$(free -h | grep Mem | awk '{print $3 "/" $2}' | sed 's/Gi/gb/g' | sed 's/Mi/mb/g')"
	echo "$ram"
}

function get_home()
{
	home="$(df -h /home | grep / | awk '{print $3"/"$2 " ("$5" used)"}')"
	echo "$home"
}

function get_ipv4()
{
	ipv4="$(ip -4 -o -f inet addr | grep /24 | sed 's/\/24//g' | awk '{printf $4 "\n"}')"
	echo $ipv4
}

function get_ipv6()
{
	ipv6="$(ip -6 -o addr | grep /64 | sed 's/\/64//g'| awk '{printf $4 "\n"}')"
	echo "$ipv6"
	
}

function get_privip()
{
	privip="$(hostname -i)"
	echo "$privip"
}

function get_pubip()
{
	public_ip="$(curl -s ipecho.net/plain)"
	echo "$public_ip"
}

function check_net()
{
	if [ "$(get_ipv6)" = "" ]; then
		echo "no network connection :("
		exit 0
	fi
}

function get_default()
{
	get_colour
	get_title
	echo -e ""$colour"os\t\t"$reset"$(get_os)"
	echo -e ""$colour"kernel\t\t"$reset"$(get_kernel)"
	echo -e ""$colour"shell\t\t"$reset"$(get_shell)"
	echo -e ""$colour"uptime\t\t"$reset"$(get_uptime)"
	echo -e ""$colour"packages\t"$reset"$pkgs" "($pkgmgr)"
	echo -e ""$colour"ram\t\t"$reset"$(get_ram)"
	echo -e ""$colour"home part\t"$reset"$(get_home)\n"

}

function get_net()
{
	check_net
	get_colour
	echo -e ""$colour"ipv4\t\t"$reset"$(get_ipv4)"
	echo -e ""$colour"ipv6\t\t"$reset"$(get_ipv6)"
	echo -e ""$colour"private ip\t"$reset"$(get_privip)"
	echo -e ""$colour"public ip\t"$reset"$(get_pubip)\n"
}

function get_all()
{
	echo -e -n "$(get_default)\n"
	get_net
}

function print_help()
{
	echo -e "syntax: sysfetch [option] [option]..."
	echo -e "help\t\t prints this help message"
	echo -e "all\t\t prints everything"
	echo -e "net\t\t prints network info"
	echo -e "username\t user's username"
	echo -e "hostname\t machine's hostname"
	echo -e "title\t\t prints [username]@[hostname]"
	echo -e "os\t\t operating system"
	echo -e "shell\t\t default shell"
	echo -e "uptime\t\t machine's uptime"
	echo -e "pkgs\t\t number of packages installed"
	echo -e "ram\t\t ram usage"
	echo -e "home\t\t home partition usage"
	echo -e "ipv4\t\t ipv4 address"
	echo -e "ipv6\t\t ipv6 address"
	echo -e "privip\t\t private ip address"
	echo -e "pubip\t\t public ip address"
}

if [ "$#" == "0" ]; then
	get_default
else
	for i in "$@"; do
		case "$i" in
			"all") get_all;;
			"default") get_default ;;
			"help") print_help ;;
			"username") get_username ;;
			"hostname") get_hostname ;;
			"title") get_title ;;
			"os") get_os ;;
			"kernel") get_kernel ;;
			"uptime") get_uptime ;;
			"shell") get_shell ;;
			"pkgs") get_colour; echo "$pkgs ($pkgmgr)";;
			"ram") get_ram ;;
			"home") get_home ;;
			"net") get_net ;;
			"ipv4") get_ipv4 ;;
			"ipv6") get_ipv6 ;;
			"privip") get_privip ;;
			"pubip") get_pubip ;;
			*) print_help; exit 0 ;;
		esac
	done
fi
