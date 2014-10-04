
class bootstrap::params {

    case $::osfamily {

        /(Debian)/: {
            $vim_pkg    = "vim"
            $git_pkg    = "git-core"
            $pys_pkg    = "python-setuptools"
            $pip_pkg    = "python-pip"
            $tzd_pkg    = "tzdata"
            $tzLocale   = "/etc/timezone"
            $ltLocale   = "/etc/localtime"
            $flushRepos = "apt-get clean && apt-get update && apt-get upgrade -y"
        }


        default: {
            fail( "Bootstrapping ${ ::osfamliy } based distributions is not currently supported." )
        }

    }
}
