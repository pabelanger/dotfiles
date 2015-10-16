# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
export EDITOR=vim

# Let us interface to gerrit
gerrit() {
    if [ "X$1" = "Xwip" ]; then
        local commit=`git rev-parse HEAD`
        gerrit review $commit --workflow -1
        return $?
    fi
    if ! [ -f .gitreview ]; then
        echo "Unable to find .gitreview"
        return 1
    fi
    local host=`awk -F '=' '/host/ {print $2}' .gitreview`
    local port=`awk -F '=' '/port/ {print $2}' .gitreview`
    ssh $host -p $port gerrit $*
}

export -f gerrit
