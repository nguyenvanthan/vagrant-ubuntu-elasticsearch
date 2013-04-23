class elasticsearch {
  
  require java::openjre
  require sysconfig::misc
  
  file { '/etc/elasticsearch':
    ensure => directory,
    owner => 'root',
    group => 'root',
    mode => '0644'
  }
  exec { 'wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.6.tar.gz':
    cwd => '/etc/elasticsearch',
    unless => 'ls /etc/elasticsearch/bin/elasticsearch'
  }
  -> exec { 'tar -xzvf elasticsearch-0.20.6.tar.gz':
    cwd => '/etc/elasticsearch',
    unless => 'ls /etc/elasticsearch/bin/elasticsearch'
  }
  -> exec { 'mv elasticsearch-0.20.6/* . && rm -rf elasticsearch-0.20.6.tar.gz':
    cwd => '/etc/elasticsearch',
    unless => 'ls /etc/elasticsearch/bin/elasticsearch'
  }
  -> exec { 'plugin -install elasticsearch/elasticsearch-analysis-icu/1.7.0 .':
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/etc/elasticsearch/bin" ],
    cwd => '/etc/elasticsearch/bin',
    unless => 'ls /etc/elasticsearch/plugins/analysis-icu'
  }
  -> exec { 'plugin -install elasticsearch/elasticsearch-lang-javascript/1.2.0 .':
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/etc/elasticsearch/bin" ],
    cwd => '/etc/elasticsearch/bin',
    unless => 'ls /etc/elasticsearch/plugins/lang-javascript'
  }
  -> exec { 'plugin -install elasticsearch/elasticsearch-river-couchdb/1.1.0 .':
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/etc/elasticsearch/bin" ],
    cwd => '/etc/elasticsearch/bin',
    unless => 'ls /etc/elasticsearch/plugins/river-couchdb'
  }
  -> exec { 'plugin -install mobz/elasticsearch-head .':
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/etc/elasticsearch/bin" ],
    cwd => '/etc/elasticsearch/bin',
    unless => 'ls /etc/elasticsearch/plugins/head'
  }
  -> exec { 'elasticsearch':
    path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/", "/etc/elasticsearch/bin" ],
    cwd => '/etc/elasticsearch/bin',
    unless => 'curl localhost:9200'
  }
}
