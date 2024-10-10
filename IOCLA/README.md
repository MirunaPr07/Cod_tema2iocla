Task 1:
Retin de la inceput in eax valoarea parametrului n trimis functiei, iar in ebx adresa la care trebuie sa pun rezultatul(daca furnica respectiva are permisiunile corespunzatoare dorintelor).
Pentru a nu modifica valoarea din eax, pun aceeasi valoare in ecx. Fac o shiftare la dreapta cu 24 de biti (3 octeti) pe valoarea din ecx, astfel incat ultimul octet din acesta sa corespunda numarului furnicii.
Aplic pe ecx si o operatie and cu 0xFF, corespunzatoare valorii ce are pe toti bitii ultimului octet 1 ca sa ma asigur ca in ecx nu am alte valori in restul octetilor.
Avand in vedere ca in vectorul ant_permissions declarat in constants.h am valori reprezentate pe 4 octeti, pentru a extrage in edx valoarea din vector de la indexul corespunzator numarului furnicii, trebuie sa retin in edx o valoare de 4 octeti (DWORD), ce incepe la adresa vectorului, la care adaug valoarea din ecx inmultita cu 4.
Presupun ca dorintele si permisiunile corespund, asa ca initial imi pun la adresa din ebx valoarea 1.
Primul octet din edx contine numai zerouri si nu ma intereseaza, iar primul octet din eax reprezinta numarul furnicii, pe care deja l am folosit, asa ca din ambele ma intereseaza doar ultimii 3 octeti.
De aceea, aplic o shiftare la stanga cu 8 biti pe ambele valori din registre.
Trebuie sa verific ca permisiuni & dorinte == dorinte. Adica, nu exista permisiune la care sa am bitul egal cu 0 pe care furnica sa si o doreasca.
Retin in edx valoarea edx & eax. Practic, pun bitii din eax peste cei din ebx, iar dupa verific ca and-ul logic dintre acestea sa corespunda bitilor din eax(dorintelor).
Daca nu sunt egale, sar la eticheta "nu_gas", la care pun 0 in valoarea de la care pointeaza ebx, iar mai apoi trece direct la partea de sfarsit.
Altfel, sar direct la sfarsit, fara sa mai fac valoarea la care pointeaza ebx 0.

Task 3:

treyfer_crypt:
In registrul esi, retin textul initial, adica un char *. In registrul edi retin adresa la care incepe cheia, deci tot char *.
De valoarea din ecx ma folosesc ca sa aplic algoritmul de cryptare pe tot sirul de 10 ori. Dupa algoritmul de cryptare, fac verificarea daca valoarea din ecx (pe care o incrementez la fiecare pas) a ajuns 11. Daca nu a ajuns, ma intorc la eticheta ten, ca sa aplic cryptarea pe tot sirul din nou.
De fiecare data cand aplic cryptarea, folosesc valoarea din edx ca sa parcurg sirul, de la indexul 0 la 6. Pentru indexul 7, fac pasul separat, dupa repetitiva.
Retin in registrul al caracterul curent (tip byte), corespunzator t-ului initial. In registrul bl, retin caracterul corespunzator indexului curent din cheie. Pentru primul pas de criptare a lui t, retin in t (al) rezultatul and-ului logic intre valoarea sirului si cea a cheii.
Pentru a putea retine in t valoarea lui sbox[t], trebuie sa extind valoarea din al la 4 octeti, pentru a l putea folosi ca index. Dupa aceasta extindere a lui al la eax, pot pune in t (al) valoarea din sbox de la indexul eax.
Pentru pasul 3, il refolosesc pe bl, retinand in el valoarea urmatoare din sir. Adaug la t valoarea retinuta in bl.
Pentru pasul 4, ii aplic valorii din al o rotire la stanga pe biti.
Pentru pasul 5, imi pun in valoarea urmatoare a sirului valoarea calculata in al pana acum.
Pentru a nu face o verificare separata ca indexul curent e 7, caz in care trebuie sa ma folosesc de valoarea de pe indexul 0 a sirului ((i + 1) % 8 == 0), fac acest caz separat, dupa for-ul simulat in continuarea etichetei "repetitiva".

treyfer_dcrypt:
La fel ca la cryptare, folosesc valoarea din ecx ca sa aplic pe sir algoritmul de decryptare de 10 ori, for-ul fiind simulat de eticheta "repeta". Pentru ca la fiecare pas se modifica valoarea din sir corespunzatoare valorii de la index + 1, fac modificarile corespunzatoare decryptarii separat pentru indexul egal cu 7.
In restul cazurilor (index = 6,0), aplic pe fiecare valoare a sirului, extrasa in interiorul for-ului simulat de eticheta "repeta", algoritmul de decryptare.
Pentru primul pas al decryptarii, retin in registrul al caracterul curent din sirul cryptat, iar in bl caracterul corespunzator din cheie, si adaug in al valoarea din bl (al e corespunzator t-ului).
Pentru al doilea pas, extind valoarea din al la 4 octeti (in eax), pentru a o putea folosi drept index, iar in registrul ah retin valoarea din vectorul sbox de la indexul calculat mai sus in eax. Aceasta valoare corespunde variabilei top descrise in enunt.
In registrul bh retin caracterul din sirul cryptat de la indexul urmator, iar acestei valori ii aplic o rotire la dreapta, pe biti. Acum, in bh am corespondentul variabilei bottom descrise.
Acum, calculez diferenta dintre valoarea lui bh si cea din ah (bottom - top).
La final, adaug in sir la indexul urmator valoarea corespunzatoare diferentei bottom - top, retinute in bh.
La fiecare pas, incrementez valoarea din ecx, iar cand aceasta ajunge egala cu 11, ies din repetitiva "zece".

Task 4:

labyrinth:
Initial, in eax retin un pointer catre valoarea in care trebuie sa retin nr liniei, iar in ebx pointerul catre valoarea in care tb sa retin nr coloanei. In ecx retin valoarea lui m, iar in edx vaoarea lui n. In esi am un char **, matricea cu elemente de tip char (valori de 0 si 1).
Scad valorile din ecx si edx cu 1, pentru ca merg cu indicii de la 0 la m - 1, respectiv de la 0 la n - 1.
Pentru ca nu mai am destule registre pe care sa le pot folosi, le folosesc pe eax si ecx ca indici, urmand ca la final sa pun din nou in ele pointerii doriti.
Astfel, initializez valorile din eax si ebx cu 0. Valoarea din eax corespunde liniei la care sunt, iar val din ebx coloanei la care sunt.
Repetitiva mea e simulata prin eticheta "repetitiva", din care ies in momentul in care am ajuns pe ultima linie sau ultima coloana.
Retin in registrul edi linia curenta din matrice (valoarea din edi e de tip char *). Pentru a nu ma incurca, pun in valoarea din edi la indexul corespunzator valorii din ebx codul ascii corespunzator lui 1 (49).
Daca sunt pe prima linie (valoarea din eax == 0), nu ma pot muta in sus, asa ca sar direct la eticheta corespunzatoare mutarii in stanga. Altfel, retin in edi linia anterioara si verific daca valoarea din edi de la indexul coresp. lui ebx e 0. Daca e, ma mut in sus (il scad pe eax), altfel sar la eticheta "stanga".
Daca am ajuns la stanga, verific daca exista coloana din stanga. Daca nu, adica numarul coloanei (ebx) e 0, sar direct la eticheta pt dreapta. Daca exista coloana stanga, verific daca valoarea de pe aceeasi linie si de pe coloana coresp. lui ebx - 1 e 0. Daca e, ma mut la stanga (decrementez ebx), iar daca nu sar la eticheta "dreapta".
Daca am ajuns la dreapta, verific daca valoarea de pe linia curenta si coloana urmatoare este 0. Daca e, ma mut la dreapta (incrementez ebx), iar daca nu, sar la eticheta "jos".
Daca am ajuns la jos, nu mai am nicio verificare (nu s au executat pasii anteriori, deci clar singura directie in care pot sa ma mut e jos).
Pentru fiecare verificare, daca am gasit directia in care tb sa ma duc, dupa ce modific indicii (eax si ebx), sar la eticheta "final", nu mai fac verificarea si pt celelalte directii.
In final, verific daca indicii au ajuns egali cu m - 1, resp n - 1, iar daca nu, ma intorc la eticheta "repetitiva".
Dupa for-ul simulat, nu mai am nevoie de valorile din ecx si edx, asa ca retin in acestea valorile din eax si edx (indicii de iesire).
Imi pun, la fel ca la inceput, in eax si ebx, pointerii catre valorile la care tb sa pun valorile indicilor (le preiau din stiva).
Mai apoi, imi pun la valoarea catre care pointeaza eax valoarea din ecx, iar la cea catre care pointeaza ebx, valoarea din edx.