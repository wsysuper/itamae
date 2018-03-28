node.groups_to_add.each do |g|
  group g
end

node.users_to_delete.each do |u|
  execute "userdel -r #{u}" do
    only_if "getent passwd | grep '^#{u}:'"
  end
end

node.users_to_add.each do |u|
  user u.name

  if u.groups
    execute "usermod -aG  #{u.groups.join(",")} #{u.name}" do
      not_if u.groups.map { |g| "getent group | grep '^#{g}:' | grep #{u.name}" }.join(" && ")
    end
  end

  if u.authorized_keys
    directory "/home/#{u.name}/.ssh" do
      mode "700"
      owner u.name
      group u.name
    end

    file "/home/#{u.name}/.ssh/authorized_keys" do
      mode "600"
      owner u.name
      group u.name
      content u.authorized_keys.join("\n") + "\n"
    end
  end
end
