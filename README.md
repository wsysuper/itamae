# itamae
Currently, this only supports CentOS 7.

## Before You Start
If you have ruby installed, you can easily install itame by executing below in this project's base directory.
```
$ bundle
```
Or install it yourself as (for root):
```
$ sudo gem install itamae
```

Itamae reference [here](https://github.com/itamae-kitchen/itamae/wiki/Getting-Started#installation).

## Execute Server Initialization Recipes

You can choose one or more recipes from below, using command like:
```
itamae ssh -h hostname -u username -y config.yml cookbooks/03_docker/default.rb
```
for remote server initialization, or
```
sudo itamae local -y config.yml cookbooks/03_docker/default.rb
```
for local execution.

Available recipes are:
* 00_users (only support root user to execute)
* 01_packages
* 02_misc
* 03_docker
* 04_python

You can also run all the recipes from 01~04 at once, just execute something like:
```
itamae ssh -h hostname -u username -y config.yml recipe.rb
```

Ofcourse you can also configure the `config.yml` file for you own purpose.

Have fun with CentOS server building!
