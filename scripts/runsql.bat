dir .\%1.sql /s/B >%tmp%\%0.txt
for /F "tokens=*" %%A in (%tmp%\%0.txt) do psql -h scuola247 -d scuola247 -U postgres -c "\encoding utf8" -f %%A 
