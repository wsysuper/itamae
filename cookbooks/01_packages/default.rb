# validate the config file
node.validate! do
  {
    packages: array_of(string),
  }
end

# Yum update only if 3 million seconds past
execute "yum update -y" do
  user "root"
  not_if %!test $(($(date +%s)-$(date +%s --date="$(grep Update /var/log/yum.log|tail -1|awk '{print $1, $2}')"))) -lt 3000000!
end

# Group 'Development Tools'
execute "yum groupinstall 'Development Tools' -y" do
  user "root"
  not_if "yum grouplist 'Development Tools' | grep 'Installed Groups'"
end

# Other packages
node.packages.each do |p|
  package p
end
