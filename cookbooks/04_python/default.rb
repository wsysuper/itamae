# validate the config file
node.validate! do
  {
    python3: {
      ius_repo: {
        repo_id: string,
        url: string,
        gpg_key: string,
      },
      package: string,
      bin_name: string,
    },
  }
end

# add the ius repo
package node.python3.ius_repo.url do
  not_if "yum repolist | grep #{node.python3.ius_repo.repo_id}"
end

# import the ius repo's gpg key
execute "rpm --import #{node.python3.ius_repo.gpg_key}" do
  action :nothing
  subscribes :run, "package[#{node.python3.ius_repo.url}]", :immediately
end

# add the python3 package
package node.python3.package

# make the python3 link
link "python3" do
  action :nothing
  subscribes :create, "package[#{node.python3.package}]"
  force true
  cwd "/usr/bin"
  to node.python3.bin_name
end

# upgrade pip
execute "pip install --upgrade pip" do
  action :nothing
  subscribes :run, "package[#{node.python3.package}]"
end

# add pip.conf to avoid pip list warning
remote_file "/etc/pip.conf" do
  owner "root"
  group "root"
  mode "644"
end
