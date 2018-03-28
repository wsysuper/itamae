# Group 'Development Tools'
execute "yum groupinstall 'Development Tools' -y" do
  user "root"
  not_if "yum grouplist 'Development Tools' | grep 'Installed Groups'"
end

# Other packages
node.packages.each do |p|
  package p
end
