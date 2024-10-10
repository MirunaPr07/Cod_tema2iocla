%include "../include/io.mac"

extern ant_permissions

extern printf
global check_permission

section .text

check_permission: ; asta e functia
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp ; ebp pointeaza la inceputul adresei functiei
	pusha ; si il adaug in stiva
	; adaug adresa functiei la inceputul stivei
	mov     eax, [ebp + 8]  ; id and permission -> val la care eax
	; pointeaza devine egala cu val lui n
	mov     ebx, [ebp + 12] ; address to return the result -> ebx retine
	; adresa la care voi face modificarea(dc res va fi 0 sau 1)
	;; DO NOT MODIFY
   
	;; Your code starts here
	; ma folosesc de ecx ca auxiliar ca sa pot extrage cel mai semnificativ octet
	; al lui eax, fara sa il modific pe acesta
	mov     ecx, eax
	shr     ecx, 24
	and     ecx, 0xFF ; am facut astfel incat ultimul octet din ecx sa fie cel mai
	; semnificativ din eax -> numarul furnicii
	mov     edx, DWORD [ant_permissions + ecx * 4] ; acum pot accesa valoarea din
	; vector de la indexul ecx pt ca e un registru de 4 octeti
	; daca retineam intr un registru de un octet valoarea primului octet din eax,
	; ar fi trebuit sa il extind din nou la un registru de 4 octeti
	; acum am retinut in edx elementul din vectorul de permisiuni
	; initializez valoarea de la pointer cu 1
	mov     DWORD [ebx], 1 ; presupun ca imi coresp camerele dorite cu perm.
	
	shl     edx, 8
	shl     eax, 8 ; fac ca si in edx si in eax sa ramana doar ultimii 3 octeti
	; in eax aveam datele furnicii si in edx permisiunile pt ea
	and     edx, eax ; edx devine edx & eax
	cmp     edx, eax ; verific daca permisiuni & dorinte == dorinte
	jne nu_gas ; nu am gasit => val de la pointer devine 0

	jmp sfarsit ; aici ajunge doar daca au corespuns dorintele cu permisiunile

nu_gas:
	mov     DWORD [ebx], 0
;; Your code ends here
sfarsit:
	;; DO NOT MODIFY
	popa
	leave
	ret

;; DO NOT MODIFY
