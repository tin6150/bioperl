#!/bin/bash
# run cpan to install bioperl and many perl modules
# script called by container to setup bioperl
# could be used by ubuntu or centos container
 
# ubuntu build somehow taking more than 240 min in docker hub
# so split into 2: setup_prereq.sh and setup_bioperl.sh
# hoping it can be cached and reduce build time
# centos only took ~90 min.

export TZ="America/Denver"
export DEBIAN_FRONTEND=noninteractive
# below were only needed in centos-8:
export LANG=C
export LC_ALL=C


# commands orig in Dockerfile.bioperl :
install_bioperl() {

    touch _TOP_DIR_OF_CONTAINER_ ;

    export PERL_MM_USE_DEFAULT=1                                              ;
    # cpan -f is force, -i is install.  Bio::Perl is a beast and won't install :(
    # now have 2017 modules installed
    echo '==================================================================' ;
    echo '==================================================================' ;
    echo "installing Bio::Perl packages"  | tee -a _TOP_DIR_OF_CONTAINER_     ;  
    date | TZ=PST8PDT tee -a                       _TOP_DIR_OF_CONTAINER_     ;  
    echo '==================================================================' ;
    echo '==================================================================' ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Bio::Perl   Bio::Tools::CodonTable  Bio::DB::EMBL Bio::DB::GenBank Bio::DB::GenPept Bio::DB::RefSeq Bio::DB::SwissProt Bio::Tools::Run::RemoteBlast Bio::SeqIO::entrezgene Bio::Cluster::SequenceFamily Bio::Variation::SNP Bio::DB::GenBank Bio::Variation::SNP  ;
    echo $? | tee  bioperl.exit.code ;
    echo '==================================================================' ;
    echo "done install Bio::Perl packages"  | tee -a _TOP_DIR_OF_CONTAINER_   ;  
    echo '==================================================================' ;
    #PERL_MM_USE_DEFAULT=1 cpan -i perldoc ;
    #perldoc -t perllocal    ;
    cpan -a | tee cpan.list.afterBioPerl.out ;
    wc -l cpan.list.afterBioPerl.out ;
    # last count = 2017
}

install_bioperl


