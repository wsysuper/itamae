execute "yum update -y" do
  user "root"
end

execute "yum groupinstall 'Development Tools' -y" do
  user "root"
  not_if "yum grouplist 'Development Tools' | grep 'Installed Groups'"
end

node.packages.each do |p|
  package p
end
