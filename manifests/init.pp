# == Class: softwarecollectionsorg
#
# A class to make it easy to install Software Collections from
# https://softwarecollections.org/.
#
# === Parameters
#
# [*title*]
#   The name of the Software Collection to install.
# [*scl_url*]
#   The URL to the repository for the Software Collection. This can be
#   automatically calculated based on the name of the Software Collection.
# [*epel_version*]
#   The version of EPEL (6 or 7) that this SCL should be used with. This
#   parameter defaults to the value of the 'operatingsystemmajrelease' fact.
#
define softwarecollectionsorg (
  $scl_url = undef,
  $epel_version = $::operatingsystemmajrelease,
) {
  case $::osfamily {
    'RedHat': {
    }
    default: {
      fail("Software Collections from softwarecollections.org cannot be installed on ${::operatingsystem}.")
    }
  }

  case $::architecture {
    'x86_64': {
    }
    default: {
      fail("Software Collections from softwarecollections.org cannot be installed on ${::architecture}.")
    }
  }

  case $::operatingsystemmajrelease {
    undef: {
      fail("The release of RHEL/CentOS you are on is unknown to Puppet. Please set the 'epel_version' parameter.")
    }
  }

  if $scl_url == undef {
    $baseurl = "https://www.softwarecollections.org/repos/rhscl/${title}/epel-${epel_version}-x86_64"
  }
  else {
    $baseurl = $scl_url
  }

  yumrepo { "rhscl-${title}-epel-${epel_version}-x86_64":
    descr    => "${title} epel-${epel_version}-x86_64",
    baseurl  => $baseurl,
    enabled  => 1,
    gpgcheck => 0,
  }
}
