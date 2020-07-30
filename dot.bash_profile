#
# Dot.Bash_Profile   written by taniguti
#
if [ -f ~/.systeminfo ];           then . ~/.systeminfo                      ; fi
if [ -x /sw/bin/init.sh ];         then . /sw/bin/init.sh                    ; fi
if [ -d "$HOME/.cargo/bin" ];      then export PATH="$HOME/.cargo/bin:$PATH" ; fi
if [ -f ~/.bash_profile_by_host ]; then . ~/.bash_profile_by_host            ; fi
if [ -f ~/.bashrc ];               then . ~/.bashrc                          ; fi
