format PE console
include '%fasminc%/win32wxp.inc'
entry start

section '.data' data readable writeable
a dd 5 dup (?)
Value dd ?
ResValue dd ?
Spec db '%hhu', 0
Count dd 5
Ent2 db ' ', 0x0D, 0x0A, 0x0D, 0x0A, 0
Space dd ' ', 0

Please db 'Please, enter 5 unsigned decimal numbers from 0 to 255 inclusively:', 0x0D, 0x0A, 0
Entered db 'Entered numbers (decimal):', 0x0D, 0x0A, 0
Result db 'Result (decimal):', 0x0D, 0x0A, 0
Press db 'Press any key...', 0x0D, 0x0A, 0

section '.text' code readable executable
start:
        cinvoke printf, Please
        xor ebx, ebx
        entry_cycle:
                cmp ebx, [Count]
                je print_entry_settings
                cinvoke scanf, Spec, Value
                mov eax, [Value]
                mov [a+ebx], eax
                inc ebx
        jmp entry_cycle


        print_entry_settings:
                cinvoke printf, Ent2
                cinvoke printf, Entered
                cld
                mov esi, a
                xor ebx, ebx
        print_entry_cycle:
                cmp ebx, [Count]
                je change_settings
                lodsb
                mov [Value], eax
                cinvoke printf, Spec, [Value]
                cinvoke printf, Space
                inc ebx
        jmp print_entry_cycle


        change_settings:
                cld
                mov esi, a
                mov edi, a
                xor ebx, ebx
        change_print_cycle:
                cmp ebx, [Count]
                je print_result_settings
                lodsb
                mov ecx, eax
                xor ecx, 0x4D
                mov edx, ebx
                add edx, 0x5A
                and ecx, edx
                mov eax, ecx
                stosb
                inc ebx
        jmp change_print_cycle


        print_result_settings:
                cinvoke printf, Ent2
                cinvoke printf, Result
                cld
                mov esi, a
                xor ebx, ebx
        print_result_cycle:
                cmp ebx, [Count]
                je exit
                lodsb
                mov [Value], eax
                cinvoke printf, Spec, [Value]
                cinvoke printf, Space
                inc ebx
        jmp print_result_cycle


exit:
        cinvoke printf, Ent2
        cinvoke printf, Press
        cinvoke _getch
        invoke ExitProcess, dword 0


section '.idata' import data readable writeable
library kernel32 , 'KERNEL32.DLL', msvcrt, 'MSVCRT.DLL'
import kernel32, ExitProcess, 'ExitProcess'
import msvcrt, scanf, 'scanf', printf, 'printf', _getch, '_getch'

