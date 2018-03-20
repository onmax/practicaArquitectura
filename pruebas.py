import re

titulo_pruebas = []
for a in range(1,59):
    if a < 10:
        a = "0" + str(a)
    titulo = "pr" + str(a) + "es_int"
    titulo_pruebas.append(titulo)

p = open("corrector.txt","r")
fp = p.read()
for elem in titulo_pruebas:  
    if (re.search(elem,fp)):
        print ("Fallas en " + elem)
        titulo_pruebas.remove(elem)
for elem in titulo_pruebas:
    print("Has pasado " + elem)
