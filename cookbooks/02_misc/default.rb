# Timezone
execute "timedatectl set-timezone #{node.misc.timezone}" do
  user "root"
  not_if "timedatectl status | grep 'Time zone' | grep '#{node.misc.timezone}'"
end

node.users_to_add.each do |u|
  # Vimrc
  remote_file "/home/#{u.name}/.vimrc" do
    user "root"
    owner u.name
  end
  # Aliases
  remote_file "/home/#{u.name}/.bash_aliases" do
    user "root"
    owner u.name
  end
end
