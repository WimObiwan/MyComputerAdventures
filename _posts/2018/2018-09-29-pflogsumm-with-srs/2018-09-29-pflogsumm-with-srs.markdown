---
title: "pflogsumm"
tags: [postfix, mail]
image: postfix.jpeg
---

pflogsumm is a great tool to generate a (daily) report on Postfix logs.  SRS-rewrites invalidate the From-addresses, but the log files can be preprocessed as a workaround.

<!--more-->

More information on pflogsumm can be found in [this man-page](https://linux.die.net/man/1/pflogsumm)

If you configured SRS on your Postfix mailserver, From-addresses get rewritten to 

    SRS0=HHH=TT=booking.com=mailing@foxinnovations.be

To allow correct reporting on From-addresses and From-domains by pflogsumm, you can replace the SRS-addresses by there original counterparts by running this script:

    cat /var/log/mail.log.1 /var/log/mail.log \
    	| sed 's/<SRS0=[^=]*=[^=]*=\([^=]*\)=\([^@]*\)@.*>/<\2@\1>/g' \
    	| sed 's/<SRS1=[^=]*=[^=]*==[^=]*=[^=]*=\([^=]*\)=\([^@]*\)@.*>/<\2@\1>/g'

For example, to mail a report about yesterday, this script can be run:

    cat /var/log/mail.log.1 /var/log/mail.log \
    	| sed 's/<SRS0=[^=]*=[^=]*=\([^=]*\)=\([^@]*\)@.*>/<\2@\1>/g' \
    	| sed 's/<SRS1=[^=]*=[^=]*==[^=]*=[^=]*=\([^=]*\)=\([^@]*\)@.*>/<\2@\1>/g' \
    	| /usr/sbin/pflogsumm -d yesterday > /tmp/mail 2>&1
    cat /tmp/mail | mail -aFrom:myserver@example.com -s "[Mon] Mail stats" me@example.com

You can call this script from your crontab, e.g. every day, a few minutes after midnight.