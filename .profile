PS1="\h:\[\e[0;32m\]\w\[\e[m\] "

####################################################################
# Add the current Git branch
####################################################################
parse_git_branch() {
   git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
export PS1="\[\033[00m\]\u@\h\[\033[01;34m\] \w \[\033[31m\]\$(parse_git_branch) \[\033[00m\]$\[\033[00m\] "

####################################################################
# Add line with current time between commands
####################################################################
fill="--- "

reset_style='\[\033[00m\]'
status_style=$reset_style'\[\033[0;90m\]' # gray color; use 0;37m for lighter color
prompt_style=$reset_style
# command_style=$reset_style'\[\033[1;29m\]' # bold black
# Prompt variable:

OLD_PS1="$PS1"
PS1="$status_style"'$fill \t\n'"$prompt_style$OLD_PS1$command_style"

# Reset color for command output
# (this one is invoked every time before a command is executed):
# trap 'echo -ne "\e[0m"' DEBUG


function prompt_command {

    # create a $fill of all screen width minus the time string and a space:
    let fillsize=${COLUMNS}-9
    fill=""
    while [ "$fillsize" -gt "0" ]
    do
        fill="-${fill}" # fill with underscores to work on 
        let fillsize=${fillsize}-1
    done

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
    xterm*|rxvt*)
        bname=`basename "${PWD/$HOME/~}"`
        echo -ne "\033]0;${bname}: ${USER}@${HOSTNAME}: ${PWD/$HOME/~}\007"
        ;;
    *)
        ;;
    esac
  
}
PROMPT_COMMAND=prompt_command

####################################################################
# Add cs command to ls when you cd
####################################################################
cs ()
{
	cd "$@";
	ls
}

####################################################################
# include some aliases
####################################################################
. ~/dots/aliases

##
# Your previous /Users/Matt/.profile file was backed up as /Users/Matt/.profile.macports-saved_2012-01-01_at_20:03:19
##

# MacPorts Installer addition on 2012-01-01_at_20:03:19: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

