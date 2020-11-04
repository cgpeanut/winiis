class download_sqlserver2012r2 {

  file {
    [
      'c:\temp',
    ]:
      ensure => directory,
      owner => 'Administrators',
      group => 'BUILTIN\Administrators',
  }

  Exec { timeout => 0, }

  file {"cp-mssql2012r2.iso":
    path     => 'C:\temp\en_sql_server_2012_enterprise_edition_with_sp1_x64_dvd_1227976.iso',
    source   => "puppet:///modules/download_sqlserver2012r2/en_sql_server_2012_enterprise_edition_with_sp1_x64_dvd_1227976.iso",
    ensure   => file,
    recurse  => "true",
    provider => 'windows',
    owner    => 'Administrators',
    group    => 'BUILTIN\Administrators',
  }

  download_file { "Download DiaWeb DB Installer" :
    url => 'https://chirondata.com/downloads/diaweb/diaweb.db.installer.exe',
    destination_directory => 'C:\temp'
  }

  mount_iso { 'C:\temp\en_sql_server_2012_enterprise_edition_with_sp1_x64_dvd_1227976.iso':
    drive_letter => 'H',
  }

}
