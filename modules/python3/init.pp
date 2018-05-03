class python3 {

  package {
    ['zlib-devel', 'python34-pip', 'libXrender']:
      ensure  => installed,
      require => Yumrepo['epel'],
  }

  exec {'install_dependency':
    command => '/bin/yum -y groupinstall "Development Tools"',
    before  => Exec['copy_python3_source'],
  }

  exec {'copy_python3_source':
    command => '/bin/wget "https://aetn.bintray.com/Python-3.6.4/Python-3.6.4.tar.xz" -P /opt/python3/',
    unless  => '/bin/ls /opt/python3/',
    before  => Exec['decompress_python3_source'],
  }

  exec {'decompress_python3_source':
    cwd     => '/opt/python3',
    command => '/bin/tar --strip-components=1 -xvf /opt/python3/Python-3.6.4.tar.xz -C /opt/python3/',
    unless  => '/bin/ls /opt/python3/Python',
    before  => Exec['install_python3'],
  }

  exec {'install_python3':
    cwd     => '/opt/python3',
    command => '/opt/python3/configure && /bin/make && /bin/make install',
    unless  => '/bin/which python3',
    before  => File['/usr/bin/python3'],
  }

  file { '/usr/bin/python3':
    ensure => 'link',
    target => '/usr/local/bin/python3',
  }
}