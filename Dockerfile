
FROM centos:7
MAINTAINER Nicolas BOUCHARD

ENV OTRS_VERSION=5.0.26-01

RUN yum update -y

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]

RUN yum install -y http://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-${OTRS_VERSION}.noarch.rpm
RUN systemctl enable httpd.service

RUN yum install -y epel-release
RUN yum install -y "perl(Crypt::Eksblowfish::Bcrypt)" \
		"perl(DBD::mysql)" "perl(DBD::Pg)" \
		"perl(Encode::HanExtra)" "perl(JSON::XS)" \
		"perl(Mail::IMAPClient)" \
		"perl(Authen::NTLM)" \
		"perl(ModPerl::Util)" \
		"perl(Text::CSV_XS)" \
		"perl(YAML::XS)"

EXPOSE "80"
