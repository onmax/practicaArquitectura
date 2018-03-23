import re

titulo_pruebas = []
for a in range(1,59):
    if a < 10:
        a = "0" + str(a)
    titulo = "pr" + str(a) + "es_int"
    titulo_pruebas.append(titulo)

p = open("corrector.txt","r")
fp = p.read()
cont = 0
for elem in titulo_pruebas:  
    if (re.search(elem,fp)):
        print ("Fallas en " + elem)
        titulo_pruebas.remove(elem)
        cont += 1
        
print ("Fallas en total " + str(cont) + " de " + str(60))
print (str(cont*100/60) + " %")