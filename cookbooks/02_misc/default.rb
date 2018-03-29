node.validate! do
  {
    users_to_add: array_of({
      name: string,
    }),
    misc: {
      timezone: string,
    },
  }
end

# Timezone
execute "timedatectl set-timezone #{node.misc.timezone}" do
  user "root"
  not_if "timedatectl status | grep 'Time zone' | grep '#{node.misc.timezone}'"
end

# Vimrc
remote_file "/root/.vimrc" do
  owner "root"
  group "root"
  mode "644"
end

# Aliases
remote_file "/root/.bash_aliases" do
  owner "root"
  group "root"
  mode "644"
end

# Bashrc
remote_file "/root/.bashrc" do
  owner "root"
  group "root"
  mode "644"
end

node.users_to_add.each do |u|
  # Vimrc
  remote_file "/home/#{u.name}/.vimrc" do
    owner u.name
    group u.name
    mode "644"
  end

  # Aliases
  remote_file "/home/#{u.name}/.bash_aliases" do
    owner u.name
    group u.name
    mode "644"
  end

  # Bashrc
  remote_file "/home/#{u.name}/.bashrc" do
    owner u.name
    group u.name
    mode "644"
  end
end
