# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$@"
}

# Start a HTTP server from a directory, optionally specifying a port.
function pyserver() {

  # Get port if specified
  local port="${1:-8000}"

  # Open in a browser.
  # sleep 1 && xdg-open "http://localhost:${port}/"

  # Redefining the default content-type to text/plain instead of the default
  # application/octet-stream allows "unknown" files to be viewable in-browser
  # as text instead of being downloaded.
  #
  # Unfortunately, "python -m SimpleHTTPServer" doesn't allow you to redefine
  # the default content-type, but the SimpleHTTPServer module can be executed
  # manually with just a few lines of code.
  python -c $'import SimpleHTTPServer;\nSimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map[""] = "text/plain";\nSimpleHTTPServer.test();' "$port"
}


# Run `dig` and display the most useful info
function digga() {
  dig +nocmd "$1" any +multiline +noall +answer;
}

# Create a new tmux session with a specified name
function tmuxnew() {
  tmux new -s $1
}

# Attach a tmux session
function tmuxopen() {
  tmux attach -t $1
}

# kill a tmux session
function tmuxkill() {
  tmux kill-session -t $1
}

# create a new tmux session based on the current working directory
function tmuxnew-dir(){
  tmux new -s "basename $PWD"
}

# Simple calculator
function calc() {
  local result=""
  result="$(printf "scale=10;$*\n" | bc --mathlib | tr -d '\\\n')"
  #                                               └─ default (when `--mathlib` is used) is 20

  if [[ "$result" == *.* ]]; then
    # improve the output for decimal numbers
    printf "$result" |
    sed -e 's/^\./0./'-e      ` #add "0" for cases like ".5"` \
        -e 's/^-\./-0./'-0.   ` #add "0" for cases like "-.5"`\
        -e 's/0*$//;s/\.$//';   # remove trailing zeros
  else
    printf "$result"
  fi

  printf "\n"
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi

  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* *
  fi
}

# Create a data url from a file
dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# UTF-8-encode a string of Unicode symbols
function escape() {
  printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo "";  # newline
  fi
}

# Decode \x{ABCD}-style Unicode escape sequences
function unidecode() {
  perl -e "binmode(STDOUT, ':utf8'); print \"$@\""
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
      echo "";  # newline
  fi
}

# Get a character’s Unicode code point
function codepoint() {
  perl -e "use utf8; print sprintf('U+%04X', ord(\"$@\"))"
  # print a newline unless we’re piping the output to another program
  if [ -t 1 ]; then
    echo "";  # newline
  fi
}

# Show all the names (CNs and SANs) listed in the SSL certificate
# for a given domain
function getcertnames() {
	if [ -z "${1}" ]; then
		echo "ERROR: No domain specified."
		return 1
	fi
	local domain="${1}"
	echo "Testing ${domain}…"
	echo ""; # newline
	local tmp=$(echo -e "GET / HTTP/1.0\nEOT" \
		| openssl s_client -connect "${domain}:443" 2>&1)
	if [[ "${tmp}" = *"-----BEGIN CERTIFICATE-----"* ]]; then
		local certText=$(echo "${tmp}" \
			| openssl x509 -text -certopt "no_header, no_serial, no_version, \
			no_signame, no_validity, no_issuer, no_pubkey, no_sigdump, no_aux")
		echo "Common Name:"
		echo ""; # newline
		echo "${certText}" | grep "Subject:" | sed -e "s/^.*CN=//"
		echo ""; # newline
		echo "Subject Alternative Name(s):"
		echo ""; # newline
		echo "${certText}" | grep -A 1 "Subject Alternative Name:" \
			| sed -e "2s/DNS://g" -e "s/ //g" | tr "," "\n" | tail -n +2
		return 0
	else
		echo "ERROR: Certificate not found."
		return 1
	fi
}

# check if uri is up
function isup() {
	local uri=$1
	if curl -s --head  --request GET "$uri" | grep "200 OK" > /dev/null ; then
		notify-send --urgency=critical "$uri is down"
	else
		notify-send --urgency=low "$uri is up"
	fi
}

# Get colors in manual pages
function man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

# Use feh to nicely view images
function openimage() {
	local types='*.jpg *.JPG *.png *.PNG *.gif *.GIF *.jpeg *.JPEG'
	cd $(dirname "$1")
	local file=$(basename "$1")
	feh -q $types --auto-zoom \
		--sort filename --borderless \
		--scale-down --draw-filename \
		--image-bg black \
		--start-at "$file"
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
tre() {
	tree -aC -I '.git' --dirsfirst "$@" | less -FRNX
}

# Call from a local repo to open the repository on github/bitbucket in browser
function repo() {
  local giturl=$(git config --get remote.origin.url | sed 's/git@/\/\//g' | sed 's/.git$//' | sed 's/https://g' | sed 's/:/\//g')
  if [[ $giturl == "" ]]; then
		echo "Not a git repository or no remote.origin.url is set."
	else
		local gitbranch=$(git rev-parse --abbrev-ref HEAD)
		local giturl="http:${giturl}"
		if [[ $gitbranch != "master" ]]; then
			local giturl="${giturl}/tree/${gitbranch}"
		fi
		echo $giturl
		open $giturl
	fi
}

# search command from history
function grepH() {
  history | grep  "$1"
}
