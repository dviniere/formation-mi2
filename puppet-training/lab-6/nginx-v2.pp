package { 'nginx':
  ensure => 'present',
}

service { 'nginx':
  ensure => running,
  enable => true,
  subscribe => [ 
    Package['nginx'], 
    File['/usr/share/nginx/html/index.html']
  ],
}

file { '/usr/share/nginx/html/index.html':
  content => "Welcome to nginx-v2.pp By Damien on puppet server\n",
  notify => Service['nginx']
}

