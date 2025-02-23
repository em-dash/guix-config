#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


if [ $(command -v fish) ] ; then
    exec fish
fi
