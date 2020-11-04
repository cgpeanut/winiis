class diawebappserver {

$timestamp              = generate('/bin/date', '+%Y%d%m_%H:%M:%S')

  group { "Administrators":
    ensure => present,
  }

  user { 'localsqladmins':
    ensure   => present,
    comment  => 'localsqladmins',
    groups   => ['Users','Administrators'],
    password => 'move19along23!',
  } 
  
# create required directories & exit if dirs already exists
 
  file {
    [
      'F:\temp',
      'F:\temp\DiaWebSetup',
      'C:\Program Files (x86)\Healthways',
      'C:\Program Files (x86)\Healthways\DiaWebProd',
    ]:
      ensure  => directory,
      owner   => 'Administrators',
      group   => 'BUILTIN\Administrators',
  }

  notify {'** Required directories created. **': }
  
# push ReportViewer.exe from puppet server to client 
  
  file {"push-ReportViewer.exe" :
    path     => 'F:\temp\ReportViewer.exe',
    source   => "puppet:///modules/diawebappserver/ReportViewer.exe",
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
  }

  notify {'** push ReportViewer completed. **': }

# push zipit.bat from puppet server to client  
  
  file {"push-zipit.bat" :
    path     => 'F:\zipit.bat',
    source   => "puppet:///modules/diawebappserver/zipit.bat",
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
  }

  notify {'** push zipit completed. **': }

# Download diawebsetup-4.4.51367 via url
  #download_file { "diawebsetup-4.4.51367" :
    #url                   => 'https://chirondata.com/Downloads/DiaWEB/4.4.51367/diawebsetup-4.4.51367.zip',
    #destination_directory => 'F:\temp',
  #}

# push ReportViewer.exe from puppet server
  
  file {"push-diawebsetup-4.4.51367.zip":
    path     => 'F:\temp\diawebsetup-4.4.51367.zip',
    source   => "puppet:///modules/diawebappserver/diawebsetup-4.4.51367.zip",
    ensure   => present,
    recurse  => true,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
  }

  notify {'** push of diawebsetup-4.4.51367.zip done **': }

# Download file DiaWebSetup.zip
  
  download_file { "Download Diaweb Setup" :
    url => 'https://chirondata.com/Downloads/DiaWEB/4.3.1/50209/DiaWeb.Setup.zip',
    destination_directory => 'F:\temp'
  }

# push 7za920.exe from puppet server to client 

  file {"push-7za920.exe":
    path     => 'F:\temp\7za920.zip',
    source   => "puppet:///modules/diawebappserver/7za920.zip",
    ensure   => present,
    recurse  => true,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
  }

  notify {'** push of 7za920.zip done **': }

# extract diawebsetup-4.4.51367.zip

   unzip { "DiaWebProd":
    source  => 'F:\temp\diawebsetup-4.4.51367.zip',
    creates => "C:\Program Files (x86)\Healthways\DiaWebProd\extract",
  }

# extract DiaWebSetup.zip

  unzip { "DiaWebSetup":
    source  => 'F:\temp\DiaWeb.Setup.zip',
    creates => 'F:\temp\DiaWebSetup\extract',
  }

# install MS ReportViewer.exe 

  package { 'Microsoft Report Viewer':
    ensure          	=> installed,
    source          	=> 'F:\temp\ReportViewer.exe',
    provider        	=> 'windows', 
    install_options 	=> [ '/q', '/norestart', '/s', ]
  }

  notify {'** MS ReportViewer Installed. **': }

# extract 7za920.zip command line version 

  unzip { "7za920.zip":
    source  => 'F:\temp\7za920.zip',
    creates => 'C:\Windows\System32\extract',
  }

  notify {'** 7za920 command line Installed. **': }

# copy DiaWEB.Data.Migrations.dll from bin to App_Data folder of DiaWebProd

  file { "cp-DiaWebProd-DiaWEB.Data.Migrations.dll":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\App_Data\DiaWEB.Data.Migrations.dll",
    #ensure   => present,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
    source   => "C:\Program Files (x86)\Healthways\DiaWebProd\bin\DiaWEB.Data.Migrations.dll",
  }

  notify {'** copy of DiaWEB.Data.Migrations.dll from done **': }

# push db.config from puppet server to DiaWebProd App_Data folder

  file {"push-DiaWebProd-db.config":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\App_Data\db.config",
    #ensure   => present,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
    source   => "puppet:///modules/diawebappserversetup/db.config",
  }

# push Web.config from puppet server to DiaWebProd root folder

  file {"push-DiaWebProd-Web.config":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\Web.config",
    source   => "puppet:///modules/diawebappserversetup/Web.config",
    #ensure   => present,
    recurse  => "true",
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
  }

  notify {'** push of Web.config done. **': }

# copy F:\temp\DiaWebSetup\App_Data\Errors.sdf to DiaWebProd App_Data

  file { "cp-DiaWebProd-Errors.sdf":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\App_Data\Errors.sdf",
    #ensure   => present,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
    source   => 'F:\temp\DiaWebSetup\App_Data\Errors.sdf',
  }

  notify {'** copy of DiaWebProd-Errors.sdf done. **': }

# copy F:\temp\DiaWebSetup\App_Data\Migrator.exe to DiaWebProd App_Data

  file { "cp-DiaWebProd-Migrator.exe":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\App_Data\Migrator.exe",
    #ensure   => present,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
    source   => 'F:\temp\DiaWebSetup\App_Data\Migrator.exe',
  }

  notify {'** copy of Migrator.exe done. **': }

# copy F:\temp\DiaWebSetup\App_Data\Migrator.exe.config to DiaWebProd App_Data 

  file { "cp-DiaWebProd-migrator.config":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\App_Data\Migrator.exe.config",
    #ensure   => present,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
    source   => 'F:\temp\DiaWebSetup\App_Data\Migrator.exe.config',
  }

  notify {'** copy of Migrator.exe.config done. **': }

# copy F:\temp\DiaWebSetup\App_Data\updateschema.bat to DiaWebProd App_Data

  file { "cp-DiaWebProdf-updateschema.bat":
    path     => "C:\Program Files (x86)\Healthways\DiaWebProd\App_Data\updateschema.bat",
    #ensure   => present,
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
    source   => 'F:\temp\DiaWebSetup\App_Data\updateschema.bat',
  }

  notify {'** copy of updateschema.bat done. **': }

# enable windows features for IIS 

  windowsfeature { 'IIS':
    feature_name => [
     # Web Server 
     'Web-Server',
     'Web-Static-Content',
     'Web-Default-Doc',
     'Web-Dir-Browsing',
     'Web-Http-Errors',
     # Web Health
     'Web-Health',
     'Web-HTTP-Logging',
     'Web-Custom-Logging',
     'Web-Log-Libraries',
     'Web-Request-Monitor',
     'Web-Http-Tracing',
     # Web App Dev 
     'Web-App-Dev',
     'Web-Net-Ext',
     'Web-Net-Ext45',
     'Web-Asp-Net',
     'Web-Asp-Net45',
     'Web-ISAPI-Ext',
     'Web-ISAPI-Filter',
     # Web Mgmt Tools
     'Web-Mgmt-Tools',
     'Web-Scripting-Tools',
     'Web-Mgmt-Console',
     'Web-Mgmt-Compat',
     'Web-Metabase',
     'Web-Lgcy-Scripting',
     'Web-WMI',
     # Web Security
     'Web-Security',
     'Web-Filtering',
     'Web-Basic-Auth',
     'Web-Windows-Auth',
     'Web-Digest-Auth',
     # Web Performance
     'Web-Performance',
     'Web-Stat-Compression',
     'Web-Dyn-Compression',
     # 
     'NET-Framework-45-Features',
     'NET-Framework-45-Core',
     'NET-Framework-45-ASPNET',
     'NET-WCF-Services45',
     'NET-WCF-HTTP-Activation45',
     #
     'WAS',
     'WAS-Process-Model',
     'WAS-NET-Environment',
     'WAS-Config-APIs'
    ]
  }

# execute updateschema.bat

  exec { 'updateschema':
    command  => 'updateschema.bat',
    path     => "C:/Program Files (x86)/Healthways/DiaWebProd/App_Data/",
    provider => 'windows',
  }

# -- backup here --

# execute zip.bat to compress previous diaweb version

  exec { 'zipit':
    command  => 'F:\zipit.bat', 
    provider => powershell,
  }

# add the timestamp to the newly created compress diaweb version

  file { 'rn-diawebprod.7z': 
    ensure  => present,
    path    => "C:\Program Files (x86)\Healthways\DiaWebProd_$timestamp.7z",
    recurse => true,
    force   => true,
    source  => "C:\Program Files (x86)\Healthways\DiaWebProd.7z", 
  }

# delete the duplicate compressed DiaWebProd.7z

  tidy { 'C:\Program Files (x86)\Healthways\DiaWebProd.7z':
    recurse => true,
    matches => [ 'DiaWebProd.7z' ],
    rmdirs  => false,
  }

}
