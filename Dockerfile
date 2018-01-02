
FROM centos:7
MAINTAINER Nicolas BOUCHARD

ENV OTRS_VERSION=5.0.26-01

RUN yum update -y
RUN yum install -y http://ftp.otrs.org/pub/otrs/RPMS/rhel/7/otrs-${OTRS_VERSION}.noarch.rpm

RUN yum install -y epel-release
RUN yum install -y "perl(Crypt::Eksblowfish::Bcrypt)" \
		"perl(DBD::mysql)" "perl(DBD::Pg)" \
		"perl(Encode::HanExtra)" "perl(JSON::XS)" \
		"perl(Mail::IMAPClient)" \
		"perl(Authen::NTLM)" \
		"perl(ModPerl::Util)" \
		"perl(Text::CSV_XS)" \
		"perl(YAML::XS)"
