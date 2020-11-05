
# Getting started with puppet Modules:
  - a module in puppet is a collection of puppet code that helps us configure an end state. i Example create a module thta installs, configures and start MySQL service.

- Login to puppet server:
1. ssh cloud_user@PUBLIC_IP_ADDRESS
- Create an Installation Class:
1. Generate the mysql module:
    - cd /etc/puppetlabs/code/environments/production/modules
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
    - class mysql::install {
    - }
4. Set the resource type with a resource name:
    - class mysql::install {
    - package { 'mysql-server-5.7':
    -  }
    - }
- We're using the package resource because we are installing and otherwise managing a package. mysql-server-5.7 is the package name, which can also be supplied in the body of the resource declaration with the name attribute.









































 # HIERA -
- Puppet datastore, which let's you store key value pairs in a heirarchy of directories
- Set in two different ways:
    - modules specific key value pairs, example go into the module and set if ngix is enabled or not. override this further with node or role specific hiera data. 
- To setup module specific Hiera data which will contain our Hiera datangs like whether nginx is installed or not,  service enabled, allow for restarts

Provide Node specific key value pairs
