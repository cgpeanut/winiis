
# Getting started with puppet Modules:
  - a module in puppet is a collection of puppet code that helps us configure an end state. i Example create a module thta installs, configures and start MySQL service.

- Login to puppet server:
1. ssh cloud_user@PUBLIC_IP_ADDRESS
- Create an Installation Class:
1. Generate the mysql module:
    - cd /etc/puppetlabs/code/environments/production/moddles
    - sudo pdk new module mysql

    - Puppet Forge username: clouduser
    - Who wrote this module?: Enter your name at the prompt
    - What license does this module code fall under?: Apache-2.0
    - What operating systems does this module support?: RedHat based Linux, Debian based Linux
    - Metadata will be generated based on this information: Yes
2. Generate the open the install.pp manifest:
    - $ cd mysql
    - $ sudo pdk new class install
    - $ sudo vim manifests/install.pp
3. Review the class declaration — this provides Puppet with a unique name reference for the class we're creating:
class mysql::install {
}

4. Set the resource type with a resource name:
class mysql::install {
  package { 'mysql-server-5.7':
  }
}

- We're using the package resource because we are installing and otherwise managing a package. mysql-server-5.7 is the package name, which can also be supplied in the body of the resource declaration with the name attribute.

5. Speaking of attributes, let's ensure we're actually downloading the package by supplying the ensure attribute. Attributes are ways of detailing the specifics of our resource. In this case, we just have to state that we want the package installed with the present value:

class mysql::install {
  package { 'mysql-server-5.7':
    ensure => 'present',
  }
}

6. Save and exit. We can now check for syntax errors with:

-  sudo puppet parser validate manifests/install.pp

# Create a Service Class

1. Finally, we want to make sure the mysqld service is started, enabled to start at boot, and is set to restart whenever there are changes made to our config file. Let's first create the manifest and define our resource type:

$ sudo pdk new class service
$ sudo vim manifests/service.pp

class mysql::service {
  service { 'mysql':
  }
}

2. Next, we want to supply our attributes. The ensure and enable attributes are fairly self-explanatory:

class mysql::service {
  service { 'mysql':
    ensure => 'running',
    enable => true,
  }
}

5. We now need to tie our module together with an init.pp class. Generate the class:

$ sudo pdk new class mysql

6. Then use the class as a wrapper to contain our other classes:

$ sudo vim manifests/init.pp

class mysql {
  include mysql::install
  include mysql::config
  include mysql::service
}

# Test the Module
1. Log in to the Ubuntu node and bootstrap it to use Puppet:

$ curl -k https://puppet.ec2.internal:8140/packages/current/install.bash | sudo bash

Note: It may not show it, but this command will prompt for a password.

2. Approve the node on the master:

$ sudo puppetserver ca sign --all

3. We now need to map our mysql module to our node1 node. First, let's open up the main manifest — or where we perform all these mappings:

$ sudo vim /etc/puppetlabs/code/environments/production/manifests/site.pp

4. Next, let's add a node definition and assign our module:

Note: Add the following at the bottom of the file.

node node1.ec2.internal {
  include mysql
}

Save and exit.

5. Return to the node1 node and test the module:

$ sudo puppet agent -t


 # HIERA -
- Puppet datastore, which let's you store key value pairs in a heirarchy of directories
- Set in two different ways:
    - modules specific key value pairs, example go into the module and set if ngix is enabled or not. override this further with node or role specific hiera data. 
- To setup module specific Hiera data which will contain our Hiera datangs like whether nginx is installed or not,  service enabled, allow for restarts

Provide Node specific key value pairs
