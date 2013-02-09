name             'torquebox'
maintainer       'Erwan Arzur'
maintainer_email 'earzur@gmail.com'
license          'WTFPL - http://www.wtfpl.net'
description      'Installs/Configures torquebox - see http://torquebox.org/documentation/2.3.0/installation.html'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

%w(centos amazon redhat).each do |os|
  supports os
end

depends 'logrotate'