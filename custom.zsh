######################### Directory jumping #########################

alias govim="cd ~/.config/nvim/"

alias d="cd ~ && cd \$(find ./ -type d | fzf )"

alias f="cd ~ && nvim \$(find ./ -type f | fzf )"

alias sd="cd \$(find ./ -type d | fzf )"

alias sf="nvim \$(find ./ -type f | fzf )"

alias ed="cd .. && cd \$(find ./ -type d | fzf )"

alias ef="cd .. && nvim \$(find ./ -type f | fzf )"

######################### OTHER #########################

alias lca='colorls -lA --sd --gs'

alias lc='colorls -A --sd --gs'

alias nv="nvim ."

alias helpme="cat ~/projects/dotfiles/custom.zsh | sed 's/alias//'| sed 's/=/ ---> /' | sed 's/) /) ---> /' | sed 's/[\"'\'']//g' "

alias srb='source ~/.zshrc'

alias als='nvim ~/projects/dotfiles/custom.zsh'

alias tms='tmux ls'

pro() { PS1="($1) ${PS1}" ;}

vopen() {
    echo -e "Decrypting the archive...\n"
    gpg "$1"
    tarName="${1//\.gpg/}"
    echo -e "Archive name: $tarName"
    echo -e "Unpacking the archive...\n"
    tar xzf "$tarName"
    dirName="${tarName//\.tar\.gz/}"
    echo "Directory name: $dirname"
    echo -e "Deleting decrypted archive...\n"
    rm -rf "$tarName"
    echo -e "Done!\n"
    ls
}

vclose() {
    echo -e "Deleting old encrypted archive...\n"
    rm -rf "$1.tar.gz.gpg"
    echo -e "Creating new unencrypted archive...\n"
    tar -czf "$1.tar.gz" "$1"
    echo -e "Deleting unencrypted directory...\n"
    rm -rf "$1"
    echo -e "Encrypting new archive...\n"
    gpg -c "$1.tar.gz"
    echo -e "Deleting unencrypted archive...\n"
    rm -rf "$1.tar.gz"
    echo -e "Done:\n"
    ls
}

mig() {
    git remote set-url origin $1
    git push
    cd ..
}

######################### VARS ######################

export MAIN_DIR=~/projects

# export GIT_USER=fr-EDD1E

#cd $MAIN_DIR && ls -d */ > $MAIN_DIR/dotfiles/git-repos.txt && cd ~


######################### GIT STUFF ######################

gsa() {
    cd ~/projects/
    prev=$(pwd)
    repos=($(ls -d */))
    for i in ${repos[@]}
    do
        cd $MAIN_DIR/"$i" 
        echo -e "-------------> ${i}		"
        git status -b -s
        echo -e "<-------------"
        sleep 0.1
        echo -e "\n\n"
    done
    cd $prev
}

gpa() {
    cd ~/projects/
    prev=$(pwd)
    repos=($(ls -d */))
    for i in ${repos[@]}
    do
        cd $MAIN_DIR/"$i" 
        echo -e "-------------> ${i}		"
        git pull
        echo -e "<-------------"
        sleep 0.1
        echo -e "\n\n"
    done
    cd $prev
}

alias gp='git push'
alias gt='git pull'
alias ga='git add .'

gc() { git commit -am "$1" ;} 

acp() { git add . ; git commit -am "$1"; git push ;}

alias gca='git commit -a --amend  --no-edit'

alias gl='git log --oneline --graph --decorate'

alias gt='git status -b -s'

alias glv='git log --graph --decorate'


######################### C STUFF ######################

cb() {
    arg="$1"
    name="${arg//\.c/}"
    echo $name
    gcc "$1" -o "$name"
}

cr() {
    arg="$1"
    name="${arg//\.c/}"
    echo $name
    gcc "$1" -o "$name"
    ./"$name"
}


######################### WORK STUFF ######################

mpi() {
    mosquitto_pub -h ils-warsaw.ubudu.com -t "$1" -m "$2"
}


msi() {

    mosquitto_sub -h ils-warsaw.ubudu.com -t "$1" -v
}

msread() {
    mosquitto_sub -h ils-warsaw.ubudu.com -t gw/"$1"/dev/"$2"/serial/read -v
}

mswrite() {
    mosquitto_sub -h ils-warsaw.ubudu.com -t gw/"$1"/dev/"$2"/serial/write -v
}

pco() {

    picocom /dev/tty$1 --b 115200

}

tma() {

    tmux a $1

}

bmq() {
    ~/Downloads//ble_v2_dev_monitor-linux --mqtt-host ils-warsaw.ubudu.com --mqtt-port 1883 --mqtt-topic "$1"
}

flash() { nrfjprog --recover && nrfjprog --program "$1" --sectorerase && nrfjprog -r ;}

# export -f gs
# export -f cb
# export -f cr
# export -f mpi
# export -f vclose
# export -f vopen

