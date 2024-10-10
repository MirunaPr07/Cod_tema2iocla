%include "../include/io.mac"

extern printf
extern position
global solve_labyrinth

; you can declare any helper variables in .data or .bss

section .text

; void solve_labyrinth(int *out_line, int *out_col, int m, int n, char **labyrinth);
solve_labyrinth:
	;; DO NOT MODIFY
	push    ebp
	mov     ebp, esp
	pusha

	mov     eax, [ebp + 8]  ; unsigned int *out_line, pointer to structure containing exit position
	mov     ebx, [ebp + 12] ; unsigned int *out_col, pointer to structure containing exit position
	mov     ecx, [ebp + 16] ; unsigned int m, number of lines in the labyrinth
	mov     edx, [ebp + 20] ; unsigned int n, number of colons in the labyrinth
	mov     esi, [ebp + 24] ; char **a, matrix represantation of the labyrinth
	;; DO NOT MODIFY
   
	;; Freestyle starts here
	; pun in eax si ebx linia si coloana la care sunt
	; mai pot folosi si edi daca e nevoie
	dec     ecx
	dec     edx ; scad valorile din ecx si edx ca sa merg cu indicii
	; matricei pana la m - 1 si n - 1
	mov     eax, 0
	mov     ebx, 0 ; pornesc cu indicii de la 0, 0
	; ii stric pe eax si ebx ca sa pot retine direct indicii in ei,
	; nu pointeri catre indici

	repetitiva:
		; pun linia in edi
		mov     edi, [esi + 4 * eax] ; val din edi e de tip char *
		; fiecare linie e de tip char *(pointer ul are dim de 4 octeti)
		mov     byte [edi + ebx], 49 ; pun 1 la pozitia la care sunt
		; (codul ascii al lui 1 e 49)
		cmp     eax, 0 ; daca sunt pe prima linie nu exista sus
		je stanga ; atunci sar direct la urm verificare
		; ajung aici doar daca exista sus
		mov     edi, [esi + 4 * (eax - 1)] ; retin linia anterioara
		cmp     byte [edi + ebx], 48 ; daca am 0 in sus
		jne stanga
		dec     eax ; ma mut sus daca e liber
		jmp final ; daca am mers in sus sar peste celelalte verificari

		stanga:
			cmp     ebx, 0 ; daca nr coloanei e 0
			je dreapta
			; exista stanga
			mov     edi, [esi + 4 * eax] ; pun iar in edi linia curenta
			; (sa fiu sigura ca nu s a modif)
			cmp     byte [edi + ebx - 1], 48 ; daca am 0 la stanga
			jne dreapta
			dec     ebx ; ma mut in stanga
			jmp final ; sar peste ceilalti pasi

		dreapta:
			mov     edi, [esi + 4 * eax] ; retin linia curenta
			cmp     byte [edi + ebx + 1], 48 ; daca in draepta am 0(liber)
			jne jos
			inc     ebx ; ma mut in dreapta
			jmp final

		jos:
			inc     eax ; aici nu mai am nicio verificare
			; dc am ajuns aici inseamna ca sigur tb sa ma mut in jos

		final:
			cmp     eax, ecx
			je end
			cmp     ebx, edx ; daca am ajuns cu valoarea din eax la m - 1
			; sau cu cea din ebx la n - 1
			je end
			jmp repetitiva ; ajung aici doar daca nu am ajuns cu eax sau ebx la sfarsit
	;; Freestyle ends here
end:
	mov     ecx, eax ; nu ma mai folosesc de val din ecx si edx
	mov     edx, ebx ; pot sa le folosesc ca sa retin valorile liniei si coloanei
	mov     eax, [ebp + 8]
	mov     ebx, [ebp + 12] ; pun adresele ca la inceput in eax si ebx
	mov     DWORD [eax], ecx 
	mov     DWORD [ebx], edx ; pun valorile retinute in ecx si edx la adresele
	; din eax si ebx
	;; DO NOT MODIFY

	popa
	leave
	ret
	
	;; DO NOT MODIFY
