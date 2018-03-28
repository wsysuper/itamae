execute "timedatectl set-timezone #{node.misc.timezone}" do
  user "root"
  not_if "timedatectl status | grep 'Time zone' | grep '#{node.misc.timezone}'"
end
