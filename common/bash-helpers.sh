# Get Current DNS IP.
dns-current() {
	networksetup -getdnsservers Wi-Fi;
}

# Flush dns cache.
flushdns() {
	sudo killall -HUP mDNSResponder;sudo killall mDNSResponderHelper;sudo dscacheutil -flushcache
}

# Clear dns server ips.
cleardns() {
	networksetup -setdnsservers Wi-Fi empty;
	flushdns
	networksetup -getdnsservers Wi-Fi;
}

# Replace current dns with google dns.
dns-google() {
	networksetup -setdnsservers Wi-Fi 8.8.8.8 8.8.4.4;
	flushdns
	networksetup -getdnsservers Wi-Fi;
}

# Replace current dns with cloudflare dns.
dns-cloudflare() {
	networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001;
	flushdns
	networksetup -getdnsservers Wi-Fi;
}

# Create random dummy file with random file size.
dummyfile(){
	if [ -n "$1" ]
	 then
	    echo "Please add file name."
	 else
	    head -c 100000 /dev/urandom > $1
	fi
}

# Get faulty plugin using bash+wp cli command.
faultyplugin() {
	plugins=( $(wp --skip-plugins plugin list --status=active --field=name) );

	for plugin in $plugins; do
		active_plugin=$plugin;

		for skip_plugin in $plugins; do
			skip_plugins=(${plugins[@]/$active_plugin});
		done;

		skip_plugins=$(IFS=, ; echo "${skip_plugins[*]}");
		echo "Activate Plugin : $active_plugin";
		echo "Test :: wp --skip-plugins=$skip_plugins post list"
    wp --skip-plugins=$skip_plugins post list
	done
}

# Docker stop/remove all containers.
dockerstopcontainer() {
	docker stop $(docker ps -a -q)
	docker rm $(docker ps -a -q)
}

# Cleanup docker container+volume+network.
docker-cleanup() {
  docker rm -f $(docker ps -aq)
  docker volume prune -f
  docker network prune -f
}

10up_docker_update() {
	npm i -g wp-local-docker
	10updocker image update
	10updocker configure
	10updocker upgrade
}

# Add user to all sub sites.
10up_add_multisite_user() {
  USER_NAME=$1
  ROLE=$2
  DIR=$(pwd)

  if [ -z "$USER_NAME" ] || [ -z "$ROLE" ]
  then
    echo "Please provide username and user role both, i.e 10up_add_multisite_user <username> <user_role>";
    return;
  fi

  echo "Adding user $USER_NAME as $ROLE to all sites"
  SITES=( $(cd $DIR && 10updocker wp site list --field=url --format=csv) )

  for site in $SITES
  do
    echo "Adding user to $site"
    10updocker wp user set-role $USER_NAME $ROLE --url=$site
  done
}

10up_docker_restart() {
	10updocker stop all && 10updocker start tmobile-the-signal-test && 10updocker start tmobileadmin-test && 10updocker start hiltonadmin-test && 10updocker start tmobile-dialed-in-test && 10updocker start about-crunchbase-test && 10updocker start news-crunchbase-test
}

# nvm config
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# Fix for Local WP Path fixes.
if [[ -z $PHPRC ]]; then
  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="$HOME/bin:/usr/local/bin:$PATH"
  export PATH="/Applications/Local.app/Contents/Resources/extraResources/bin/wp-cli/posix:$PATH"
  # export PATH="/opt/homebrew/opt/php@7.4/bin:$PATH"
  # export PATH="/opt/homebrew/opt/php@7.4/sbin:$PATH"
  # export PATH="/opt/homebrew/opt/php@8.0/bin:$PATH"
  # export PATH="/opt/homebrew/opt/php@8.0/sbin:$PATH"
  # export PATH="/opt/homebrew/opt/php@8.1/bin:$PATH"
  # export PATH="/opt/homebrew/opt/php@8.1/sbin:$PATH"
else
   export PATH=$(echo $PATH | sed -e "s/\/opt\/homebrew\/bin://")
   export PATH=$(echo $PATH | sed -e "s/\/opt\/homebrew\/sbin://")
   export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin"
fi


# Remove Duplicate PATH in $PATH
export PATH=$(echo -n $PATH | awk -v RS=: '!($0 in a) {a[$0]; printf("%s%s", length(a) > 1 ? ":" : "", $0)}')

export WPVULNDB_API_TOKEN="XXslod9CaicLZF83ESfSYTCI67QjhXncypetOW2yCDo"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
