#!/bin/bash
# run cpan to install bioperl and many perl modules
# script called by container to setup bioperl
# could be used by ubuntu or centos container
 

export TZ="America/Denver"
export DEBIAN_FRONTEND=noninteractive
# below were only needed in centos-8:
export LANG=C
export LC_ALL=C


    # commands orig in Dockerfile.bioperl :

    touch _TOP_DIR_OF_CONTAINER_ ;

    echo '==================================================================' ;
    echo "installing perl/cpan packages"  | tee -a _TOP_DIR_OF_CONTAINER_     ;  
    date | TZ=PST8PDT tee -a                       _TOP_DIR_OF_CONTAINER_     ;  
    echo '==================================================================' ;
    export PERL_MM_USE_DEFAULT=1                                              ;
    # cpan -f is force, -i is install.  Bio::Perl is a beast and won't install :(
    PERL_MM_USE_DEFAULT=1 cpan -fi Digest::SHA1                               ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Log::Log4perl                              ;
    PERL_MM_USE_DEFAULT=1 cpan -fi XML::DOM                                   ;
    PERL_MM_USE_DEFAULT=1 cpan -fi XML::XPathEngine                           ;
    # below are listed in AnanthharamanLab/Metabolic
    PERL_MM_USE_DEFAULT=1 cpan -fi Data::Dumper                               ;
    PERL_MM_USE_DEFAULT=1 perl -MCPAN -e cpann "install POSIX qw(strftime)"   ;  
    PERL_MM_USE_DEFAULT=1 cpan -fi Excel::Writer::XLSX ;    
    PERL_MM_USE_DEFAULT=1 cpan -fi Getopt::Long ;    
    PERL_MM_USE_DEFAULT=1 cpan -fi Statistics::Descriptive ;
    PERL_MM_USE_DEFAULT=1 perl -MCPAN -e cpann "Array::Split qw(split_by split_into)" ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Bio::SeqIO ;
    # found these dependencies when tried to run METABOLIC-G.pl
    PERL_MM_USE_DEFAULT=1 cpan -fi Array/Split.pm ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Data/OptList.pm  ;  
    PERL_MM_USE_DEFAULT=1 cpan -fi Parallel/ForkManager.pm  ;  

    echo '==================================================================' ;
    echo '==================================================================' ;
    echo "installing Bio::Perl packages"  | tee -a _TOP_DIR_OF_CONTAINER_     ;  
    echo '==================================================================' ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Bio::Perl  ;  
    echo $? > bioperl.exit.code ;
    echo '==================================================================' ;
    echo "done install Bio::Perl packages"  | tee -a _TOP_DIR_OF_CONTAINER_   ;  
    echo '==================================================================' ;
    echo '==================================================================' ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Bio::Tools::CodonTable ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Carp ;
    PERL_MM_USE_DEFAULT=1 cpan -fi Text::Levenshtein::XS Text::Levenshtein::Damerau::XS Text::Levenshtein Text::Levenshtein::Damerau::PP ;
    echo $? > cpan.exit.code ;
    #PERL_MM_USE_DEFAULT=1 cpan -i perldoc ;
    #perldoc -t perllocal    ;
    cpan -a > cpan.list.out ;
    # last count = 1565, but no match for Bio
    # with -f count = 1900+, many match Bio
    echo 'Ending.  Last line of RUN block in Dockerbuild without continuation :)'

