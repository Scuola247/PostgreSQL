import os
old = "IF (_results[array_length(_results,1)]).check_point.status = 'Failed' THEN RETURN; END IF;"
new = "\tIF unit_testing.last_checkpoint_failed(_results) THEN RETURN; END IF;\n"
l = []
a= []

for i in os.listdir(os.getcwd()):
      
      try:
            with open(i+"\\create.sql","r") as x:
                  a = x.readlines()
            
            with open(i+"\\create.sql","w") as p:
                  p.write("")
      
            #with open(i+"\\create.sql","r+") as f:
            with open(i+"\\create.sql","r+") as f:
                  for j in a:
                        print(j)
                        if old in j:
                              l.append(new)
                              
                        else:
                              l.append(j)
      

                  f.writelines(l)
                  l = []
                  a = []
                        
                  
      except:
            print("sory")
            
      
