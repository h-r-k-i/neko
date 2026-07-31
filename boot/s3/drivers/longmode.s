%if 0
 FILENAME:      ./boot/s3/drivers/longmode.s
 NAME:          NekoDOS Bootloader, Stage 3, Long Mode Driver
 DESCRIPTION:   Includes various functions to support
                the transition into Long Mode and
                the execution of 64-bit code.
                Why use 64-bit code? Why go to the Moon?
 AUTHOR:        Haruki Tokumei, Haruki Media Group
 DATE:          29 July 2026
 COPYRIGHT:     Haruki Media Group
 LICENSE:       MIT License (./LICENSE)
%endif

bits 32

global checkCPUID
global queryLongMode
global disablePaging
global enableLongMode

EFLAGS_ID equ 1 << 21
CPUID_EXTENSIONS equ 0x80000000
CPUID_EXT_FEATURES equ 0x80000001
CPUID_EDT_EXT_FEAT_LM equ 1 << 29

CR0_PG equ 1 << 31
CR4_PAE_ENABLE equ 1 << 5

EFER_MSR equ 0xC0000080
EFER_LM_ENABLE equ 1 << 8

CR0_PM_ENABLE_JIC equ 1 << 0 ; yes we're calling it that
CR0_PG_ENABLE equ 1 << 31

GDT_LOC_64 equ 0x900

PML4T_ADDR equ 0x93000

; Checks if CPUID is supported (which means the CPU may support Long Mode)
; If CPUID is supported, the function returns 1 in EAX, otherwise it returns 0
; 
checkCPUID:
    pushfd
    pop eax

    ; just save the original eflags value
    mov ecx, eax
    xor eax, EFLAGS_ID

    ; store eflags then retriving it shows if it flipped
    push eax
    popfd
    pushfd
    pop eax

    ; restore the original eflags
    push ecx
    popfd

    ; if eax was flipped then CPUID is supported
    xor eax, ecx
    jnz supported

    ; not supported
    mov ax, 0
    ret

    supported:
        mov ax, 1
        ret


; Queries the CPU for Long Mode support.
; If it can't be determined, presumably because too old, the function returns -1
; If it absolutely does not fucking support Long Mode, the function returns 1
; If it does support Long Mode, the function returns 0
queryLongMode:
    mov eax, CPUID_EXTENSIONS ; fun fact cpuid implicitly uses eax as a param <:(
    cpuid
    cmp eax, CPUID_EXT_FEATURES ; another fun fact for some reason osdev uses CPUID_FEATURES instead of CPUID_EXT_FEATURES despite not declaring a CPUID_FEATURES so idfk
    jb noSupport

    mov eax, CPUID_EXT_FEATURES
    cpuid
    test edx, CPUID_EDT_EXT_FEAT_LM
    jz noLongMode

    mov ax, 0
    ret

    noSupport:
        mov ax, -1
        ret
    
    noLongMode:
        mov ax, 1
        ret

; Disables paging by clearing the PG bit in CR0
disablePaging:
    mov eax, cr0
    and eax, ~CR0_PG
    mov cr0, eax
    ret

; Does the Long Mode shit.
enableLongMode: ; extern void enableLongMode(int64_t * PML4_LOCATION);

    ; Load PML4 in CR3
    mov eax, [esp + 4] ; get the PML4_LOCATION arg
    mov cr3, eax

    ; Enable PAE in CR4
    mov eax, cr4
    or eax, CR4_PAE_ENABLE
    mov cr4, eax

    ; Set Long Mode bit
    mov ecx, EFER_MSR
    rdmsr
    or eax, EFER_LM_ENABLE
    wrmsr

    ; Enable paging and protected mode (we should be in
    ; protected mode already but I am also copypasting from
    ; osdev lol)
    mov eax, cr0
    or eax, CR0_PM_ENABLE_JIC | CR0_PG_ENABLE
    mov cr0, eax

    ; Jump to 64-bit code
    jmp 0x08:eLongMode

bits 64 ; im scared
global eLongMode
extern _start64

eLongMode:
    cli
    
    ; Set up segment registers for 64-bit mode
    mov ax, 0x10
    mov ds, ax
    mov es, ax
    mov fs, ax
    mov gs, ax
    mov ss, ax

    ; Grab the arguments for _start64 from the stack
    mov rdi, [rsp + 16] ; magic numbers
    mov rsi, [rsp + 24] ; information
    mov rdx, [rsp + 32] ; i gen still got no fucking clue

    ; realign stack pointer to 16-byte boundary
    mov rsp, stack_top
    and rsp, -16

    ; jump to initial kernel code
    call _start64

hang:
    cli
    hlt
    jmp hang

section .bss
    align 16
    stack_bottom:
    resb 0x4000 ; 16 KiB stack
    stack_top: