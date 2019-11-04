extern print_line
global strlen:function
global strchr:function
global str_equals:function
global strcpy:function
global str_to_int:function
global print_strlines:function

section .text

; Description: returns the length of a string
; @arg: char[] s - the string to be analyzed
; Return value: int length
strlen:
    push   ebp
    mov    ebp,esp
    mov    edi,DWORD [ebp+0x8]
    xor    eax,eax
    jmp    strlen_l2
strlen_l1:
    inc    eax
    inc    edi
strlen_l2:
    cmp    BYTE [edi],0
    jnz    strlen_l1
    leave  
    ret 

; Description: returns the position of a character in a string
; @arg1: char[] s - the string in which it searches the char
; @arg2: char c - the searched character
; Return value: int position if found, -1 otherwise
strchr:
    push   ebp
    mov    ebp,esp
    mov    edi,DWORD [ebp+0x8]
    mov    dl,BYTE [edi]
    mov    eax,0xffffffff
    test   dl,dl
    jz     strchr_l2
    xor    eax,eax
    mov    dl,BYTE [ebp+0xc]
strchr_l1:
    mov    dh,BYTE [edi]
    xor    dh,dl
    je     strchr_l2
    inc    eax
    inc    edi
    jmp    strchr_l1
strchr_l2:
    leave  
    ret 

; Description: checks if two strings are identical on a given length
; @arg1: char[] s1 - the first string
; @arg2: char[] s2 - the second string
; @arg3: int length - the given length
; Return value: 0 if identical, 1 otherwise
str_equals:
    push   ebp
    mov    ebp,esp
    mov    edi,DWORD [ebp+0x8]
    mov    edx,DWORD [ebp+0xc]
    mov    ecx,DWORD [ebp+0x10]
    mov    eax,0x1
str_equals_l1:
    mov    bl,BYTE [edi]
    mov    bh,BYTE [edx]
    xor    bl,bh
    jne    str_equals_l2
    inc    edi
    inc    edx
    dec    ecx
    jnz    str_equals_l1
    xor    eax,eax
str_equals_l2:
    leave  
    ret  

; Description: copies length characters from source string to destination string
; @arg1: char[] s1 - destination string
; @arg2: char[] s2 - source string
; @arg3: int length - the given length
; Return value: void
strcpy:
    push   ebp
    mov    ebp,esp
    mov    eax,DWORD [ebp+0x8]
    mov    ebx,DWORD [ebp+0xc]
    mov    ecx,DWORD [ebp+0x10]
strcpy_l1:
    mov    dl,BYTE [ebx]
    mov    BYTE [eax],dl
    inc    eax
    inc    ebx
    dec    ecx
    jnz    strcpy_l1
    leave  
    ret    

; Description: converts, if possible, a string to the corresponding integer
; @arg: int a - the integer to be converted
; Return value: int converted value, -1 otherwise
str_to_int:
    push   ebp
    mov    ebp,esp
    xor    eax,eax
    xor    ebx,ebx
    xor    esi,esi
    mov    esi,0xa
    mov    edi,DWORD [ebp+0x8]
    mov    bl,BYTE [edi]
str_to_int_l1:
    cmp    bl,0x30
    jl     str_to_int_l3
    cmp    bl,0x39
    jg     str_to_int_l3
    sub    bl,0x30
    mul    esi
    add    eax,ebx
    inc    edi
    mov    bl,BYTE [edi]
    test   bl,bl
    jnz    str_to_int_l1
    jmp    str_to_int_l2
str_to_int_l3:
    mov    eax,0xffffffff
str_to_int_l2:
    leave  
    ret

; Description: prints from text lines which contain a given string
; @arg1: char[] text - the text in which we search for the string
; @arg2: int start - the text position where we begin the search
; @arg3: int end - the text position where we end the search
; @arg4: char[] string - the string we search for
; Return value: void
print_strlines:
    push   ebp
    mov    ebp,esp
    mov    edx,DWORD [ebp+0x14]
    sub    esp,0x4
    mov    esi,DWORD [ebp+0xc]
    dec    esi
    mov    edi,DWORD [ebp+0x8]
    mov    eax,DWORD [ebp+0x10]
    mov    ebx,esi
print_strlines_l2:
    inc    ebx
    cmp    ebx,eax
    jae    print_strlines_l1
    cmp    BYTE [edi+ebx],0xa
    jne    print_strlines_l2
    xor    eax,eax
    inc    esi
    mov    DWORD [ebp-0x4],esi
print_strlines_l3:
    mov    cl,BYTE [edi+esi]
    cmp    cl,0xa
    je     print_strlines_l4
    cmp    cl,BYTE [edx+eax]
    jne    print_strlines_l5
    inc    esi
    inc    eax
    cmp    BYTE [edx+eax],0
    jne    print_strlines_l3
    mov    esi,DWORD [ebp-0x4]
    push   edx
    push   edi
    add    edi,esi
    push   edi
    call   print_line
    add    esp,0x4
    pop    edi
    pop    edx
print_strlines_l4:
    mov    esi,ebx
    mov    eax,DWORD [ebp+0x10]
    jmp    print_strlines_l2
print_strlines_l5:
    xor    eax,eax
    inc    esi
    jmp    print_strlines_l3
print_strlines_l1:
    leave  
    ret
