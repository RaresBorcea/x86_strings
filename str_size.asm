extern print_line
global mystery1:function
global mystery2:function
global mystery3:function
global mystery4:function
global mystery7:function
global mystery9:function

section .text
; MYSTERY1
; Description: returns the length of a string
; @arg: char[] s - the string to be analyzed
; Return value: int length
; Suggested name: strlen
mystery1:
    push   ebp
    mov    ebp,esp
    mov    al, 0
    mov    edi,DWORD [ebp+0x8]
    sub    ecx,ecx
    sub    al,al
    not    ecx
    repne  scasb
    not    ecx
    dec    ecx
    mov    eax,ecx
    leave  
    ret 

; MYSTERY2
; Description: returns the position of a character in a string
; @arg1: char[] s - the string in which it searches the char
; @arg2: char c - the searched character
; Return value: int position if found, -1 otherwise
; Suggested name: strchr
mystery2:
    push   ebp
    mov    ebp,esp
    mov    edi,DWORD [ebp+0x8]
    mov    dl,BYTE [edi]
    mov    eax,0xffffffff
    test   dl,dl
    jz     mystery2_l2
    mov    al,BYTE [ebp+0xc]
    sub    ecx,ecx
    not    ecx
    repne  scasb
    not    ecx
    dec    ecx
    mov    eax,ecx
mystery2_l2:
    leave  
    ret 

; MYSTERY3
; Description: checks if two strings are identical on a given length
; @arg1: char[] s1 - the first string
; @arg2: char[] s2 - the second string
; @arg3: int length - the given length
; Return value: 0 if identical, 1 otherwise
; Suggested name: str_equals
mystery3:
    push   ebp
    mov    ebp,esp
    mov    eax,0x1
    mov    esi,DWORD [ebp+0x8]
    mov    edi,DWORD [ebp+0xc]
    mov    ecx,DWORD [ebp+0x10]
    repe   cmpsb
    jnz    mystery3_l2
    sub    eax,eax
mystery3_l2:
    leave  
    ret  

; MYSTERY4
; Description: copies length characters from source string to destination string
; @arg1: char[] s1 - destination string
; @arg2: char[] s2 - source string
; @arg3: int length - the given length
; Return value: void
; Suggested name: strcpy
mystery4:
    push   ebp
    mov    ebp,esp
    mov    edi,DWORD [ebp+0x8]
    mov    esi,DWORD [ebp+0xc]
    mov    ecx,DWORD [ebp+0x10]
    rep    movsb
    leave  
    ret   

; MYSTERY7
; Description: converts, if possible, a string to the corresponding integer
; @arg: int a - the integer to be converted
; Return value: int converted value, -1 otherwise
; Suggested name: str_to_int
mystery7:
    push   ebp
    mov    ebp,esp
    sub    eax,eax
    sub    ebx,ebx
    sub    esi,esi
    mov    esi,0xa
    mov    edi,DWORD [ebp+0x8]
    mov    bl,BYTE [edi]
mystery7_l1:
    cmp    bl,0x30
    jl     mystery7_l3
    cmp    bl,0x39
    jg     mystery7_l3
    sub    bl,0x30
    mul    esi
    add    eax,ebx
    inc    edi
    mov    bl,BYTE [edi]
    test   bl,bl
    jnz    mystery7_l1
    jmp    mystery7_l2
mystery7_l3:
    mov    eax,0xffffffff
mystery7_l2:
    leave  
    ret

; MYSTERY9
; Description: prints from text lines which contain a given string
; @arg1: char[] text - the text in which we search for the string
; @arg2: int start - the text position where we begin the search
; @arg3: int end - the text position where we end the search
; @arg4: char[] string - the string we search for
; Return value: void
; Suggested name: print_strlines
mystery9:
    push   ebp
    mov    ebp,esp
    mov    edx,DWORD [ebp+0x14]
    sub    esp,0x4
    mov    esi,DWORD [ebp+0xc]
    dec    esi
    mov    edi,DWORD [ebp+0x8]
    mov    ebx,esi
mystery9_l2:
    inc    ebx
    cmp    ebx,DWORD [ebp+0x10]
    jae    mystery9_l1
    cmp    BYTE [edi+ebx],0xa
    jne    mystery9_l2
    sub    eax,eax
    inc    esi
    mov    DWORD [ebp-0x4],esi
mystery9_l3:
    mov    cl,BYTE [edi+esi]
    cmp    cl,0xa
    je     mystery9_l4
    cmp    cl,BYTE [edx+eax]
    jne    mystery9_l5
    inc    esi
    inc    eax
    cmp    BYTE [edx+eax],0
    jne    mystery9_l3
    mov    esi,DWORD [ebp-0x4]
    push   edx
    push   edi
    add    edi,esi
    push   edi
    call   print_line
    pop    edi
    pop    edi
    pop    edx
mystery9_l4:
    mov    esi,ebx
    jmp    mystery9_l2
mystery9_l5:
    sub    eax,eax
    inc    esi
    jmp    mystery9_l3
mystery9_l1:
    leave  
    ret