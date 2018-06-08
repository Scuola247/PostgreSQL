dir .\%1 /s/B >%tmp%\fol.txt
for /F "tokens=*" %%A in (%tmp%\fol.txt) do type %%A >>%tmp%\fol.sql