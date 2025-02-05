# Functions declaration

function get_os() {
	local MYRELEASE
	MYRELEASE=$(grep ^NAME= /etc/os-release|cut -d '"' -f2|awk '{print $1}')
	if [[ "${MYRELEASE}" != "" ]]	
	then
		echo ${MYRELEASE}
		return 0
	else
		return 1
	fi
}

function docker_cmd() {
	local MYRELEASE
	MYRELEASE=$(get_os)
	case ${MYRELEASE} in
		CentOS*)
			if [[ -f /etc/systemd/system/docker@.service ]]
			then
				echo "docker -H unix:///var/run/docker-$(whoami).sock"
			else
				echo "docker"
			fi
			;;
		AlmaLinux*|Ubuntu*)
			echo "podman"
			;;
		*)
			;;
	esac
}
