dir .\%1 /s/B >%tmp%\fol.txt
for /F "tokens=*" %%A in (%tmp%\fol.txt) do psql -h 192.168.56.2 -d scuola247 -U postgres -c "\encoding utf8" -f %%A 