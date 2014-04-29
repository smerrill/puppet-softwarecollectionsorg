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
#   The URL to the release package for the Software Collection. This should be
#   automatically calculated based on the name of the Software Collection.
#
define softwarecollectionsorg (
  $scl_url = undef,
) {
  case $::osfamily {
    'RedHat': {
    }
    default: {
      fail("Software Collections from softwarecollections.org cannot be installed on ${::operatingsystem}.")
    }
  }

  if $scl_url == undef {
    $scl_url = "https://www.softwarecollections.org/repos/rhscl/${title}/epel-6-x86_64"
  }

  yumrepo { "rhscl-${title}-epel-6-x86_64":
    descr    => "${title} epel-6-x86_64",
    baseurl  => $scl_url,
    enabled  => 1,
    gpgcheck => 0,
  }
}
