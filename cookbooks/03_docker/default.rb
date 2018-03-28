node.docker.dependencies.each do |p|
  package p
end

execute "yum-config-manager --add-repo #{node.docker.repo}" do
  user "root"
  not_if "yum repolist | grep docker-ce"
end

package "docker-ce"

service "docker" do
  action [:enable, :start]
end
