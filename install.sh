#!/usr/bin/env bash
#
# install dotfiles.

# dotfiles path
DOTFILES=$(pwd -P)
FDIR=$HOME/.local/share/fonts

set -e

echo ''
echo ' Start installing...'
echo ''

# print log
info() {
	printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
	printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
	printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
	printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
	echo ''
	exit
}

# Install Fonts
install_fonts() {
	info 'Install fonts...'
	[[ ! -d "$FDIR" ]] && mkdir -p "$FDIR"
	cp -rf $DOTFILES/fonts/* "$FDIR"
	success 'Done.'
	info '...'
}

# set git config
set_gitconfig() {
	if ! [ -f git/gitconfig.symlink ]; then
		info 'Configure git'

		git_credential='store'
		if [ "$(uname -s)" == "Darwin" ]; then
			git_credential='osxkeychain'
		fi

		user ' - What is your github author name?'
		read -e git_authorname
		user ' - What is your github author email?'
		read -e git_authoremail

		sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.symlink.example >git/gitconfig.symlink

		success 'Successfully set gitconfig.'
		info '...'
	fi
}

# make soft link
link_file() {
	local src=$1 dst=$2

	local overwrite= backup= skip=
	local action=

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

		if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then

			local currentSrc="$(readlink $dst)"

			if [ "$currentSrc" == "$src" ]; then

				skip=true

			else

				user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
         [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				read -n 1 action

				case "$action" in
				s)
					skip=true
					;;
				S)
					skip_all=true
					;;
				o)
					overwrite=true
					;;
				O)
					overwrite_all=true
					;;
				b)
					backup=true
					;;
				B)
					backup_all=true
					;;
				*) ;;
				esac

			fi

		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [ "$overwrite" == "true" ]; then
			rm -rf "$dst"
			success "removed $dst"
		fi

		if [ "$backup" == "true" ]; then
			mv "$dst" "${dst}.backup"
			success "moved $dst to ${dst}.backup"
		fi

		if [ "$skip" == "true" ]; then
			success "skipped $src"
		fi

	fi

	if [ "$skip" != "true" ]; then
		ln -s "$1" "$2"
		success "linked $1 to $2"
	fi
}

# install
install_dotfiles() {
	local overwrite_all=false backup_all=false skip_all=false

	# git config
	info 'Install git config...'
	for src in $(find -H "$DOTFILES/git" -maxdepth 1 -name '*.symlink'); do
		dst="$HOME/.$(basename "${src%.*}")"
		cp "$src" "$dst"
	done

	# home dotfiles
	info '...'
	info 'Install $HOME dotfiles...'
	for src in $(find -H "$DOTFILES" -maxdepth 1 \( -name 'vim' -o -name 'zsh' \)); do
		bname="$(basename "${src}")"
		dst="$HOME/.$bname"
		link_file "$src" "$dst"
		srcf="$src/${bname}rc"
		dstf="$HOME/.${bname}rc"
		link_file "$srcf" "$dstf"
	done

	# home/.config dotfiles
	info '...'
	info 'Install $HOME/.config dotfiles...'
	for src in $(find -H "$DOTFILES/config" -maxdepth 1 -name '*' -not -path "$DOTFILES/config"); do
		dst="$HOME/.config/$(basename "${src}")"
		link_file "$src" "$dst"
	done
}

install_fonts
set_gitconfig
install_dotfiles

echo ''
echo ' All installed!'
