perl -ne 'print "$. $_" if m/[\x00-\x08\x0E-\x1F\x80-\xFF]/' $1
