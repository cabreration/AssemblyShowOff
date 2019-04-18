%TITLE 'Last Chance'

                IDEAL
                MODEL small
                STACK 900h

                DATASEG

menuLine        DB '===================== Menu =====================', 10, 13, '$'
informacion     DB 'UNIVERSIDAD DE SAN CARLOS DE GUATEMALA', 10, 13, 'FACULTAD DE INGENIERIA', 10, 13, 'ESCUELA DE CIENCIAS Y SISTEMAS', 10, 13, '$'
informacion2    DB 'ARQUITECTURA DE COMPUTADOROES Y ENSAMBLADORES 1', 10, 13, 'SECCION A', 10, 13, '$'
informacion3    DB 'NOMBRE: JAVIER ALBERTO CABRERA PUENTE', 10, 13, 'CARNET: 201403905', 10, 13, 'PROYECTO FINAL', 10, 10, 13, '$'
opciones        DB '1) Cargar Archivo', 10, 13, '2) Generar Arbol', 10, 13, '3) Aplicar Filtros', 10, 13, '4) Salir', 10, 10, 13, '$'
warningMes      DB 10, 13, 'Debe elegir una de las opciones listadas', 10, 13, '$'
byeMes          DB 10, 13, 'Mucha suerte en tu vida, toma mucha awa, tkm', 10, 13, '$'
cargaLine       DB 10, 13, '==================== Carga ====================', 10, 13, '$'
ingreso         DB 'Ingrese la ruta del archivo a cargar: ', '$'
extFail         DB 'Extension incorrecta', 10, 13, '$'
fileDust        DB 'El archivo que intenta leer no existe', 10, 13, '$'
fileSuccess     DB 'El archivo fue cargado con exito!', 10, 13, '$'
errorBefOrd     DB 10, 13, 'No hay ningun archivo cargado todavia!', 10, 13, '$'
filterLine      DB 10, 13, '==================== Filtros ====================', '$'
commandLine     DB 10, 13, '>> ', '$'

;structs
STRUC   Miembro
        nombre    DB 16 DUP (0)
        image     DB 64 DUP (0)
        pareja    DB 4 DUP (0)
        hijo      DB 4 DUP (0)
ENDS

;   variables
fileState       DB 0
address         DB 20 DUP (0)
fileBuffer      DB 1024 DUP(0)
handle          DW 0
oneByte         DB 0
currentMember   DB 0
attribute       DB 8 DUP (0)
command         DB 32 DUP (0)

arbol            Miembro 50 DUP (<>)

                CODESEG
Start:          mov     ax, @data
                mov     ds, ax
                mov     es, ax

Menu:           mov     ah, 9
                mov     dx, offset menuLine
                int     21h
                mov     dx, offset informacion
                int     21h
                mov     dx, offset informacion2
                int     21h
                mov     dx, offset informacion3
                int     21h
                mov     dx, offset opciones
                int     21h
                mov     ah, 1
                int     21h
                cmp     al, 49
                je      Cargar
                cmp     al, 50
                je      GenerarArbol
                cmp     al, 51
                je      Filtrar
                cmp     al, 52
                je      Salir
                mov     ah, 9
                mov     dx, offset warningMes
                int     21h
                jmp     Menu

Cargar:         mov     ah, 9
                mov     dx, offset cargaLine
                int     21h
                mov     dx, offset ingreso
                int     21h
                mov     [fileState], 0
                call    ReadAddress
                call    ValidateAddress
                cmp     [fileState], 1
                je      JSFAIL
                ja      DUSTF
                mov     dx, offset fileSuccess
                mov     ah, 9
                int     21h
                jmp     Menu
JSFAIL:         mov     ah, 09h
                mov     dx, offset extFail
                int     21h
                jmp     Cargar
DUSTF:          mov     ah, 09h
                mov     dx, offset fileDust
                int     21h
                jmp     Cargar

GenerarArbol:   call    GraphvizMenu
                jmp     Menu

Filtrar:        call    FiltersMenu
                jmp     Menu

Salir:          mov     ah, 09h
                mov     dx, offset byeMes
                int     21h
                mov     ah, 4Ch
                int     21h

PROC            ReadAddress
                mov     si, 00h
    CleanAd:    mov     [address + si], 0
                inc     si
                cmp     si, 14h
                jb      CleanAd
                mov     si, 00h
                mov     ax, 00h       
    LeerAd:     mov     ah, 01h
                int     21h
                cmp     al, '&'
                je      LeerAd
                cmp     al, 13
                je      FRead
                mov     [address + si], al
                inc     si
                jmp     LeerAd
    FRead:      ret
ENDP            ReadAddress

PROC            ValidateAddress
                mov     si, 00h
    CheckDot:   cmp     [address + si], '.'
                je      VerExt
                inc     si
                cmp     si, 20
                je      ErrorDust
                jmp     CheckDot
    VerExt:     inc     si
                cmp     [address + si ], 'J'
                jne     ErrorJS
                inc     si
                cmp     [address + si], 'S'
                jne     ErrorJS
                mov     dx, offset address
                mov     ah, 03Dh
                mov     al, 0
                int     21h
                jc      ErrorDust
                call    LoadContent
                ret
    ErrorJS:    mov     [fileState], 1
                ret
    ErrorDust:  mov     [fileState], 2
                ret
ENDP            ValidateAddress

PROC            LoadContent
                mov     si, 00h
    CleanFB:    mov     [fileBuffer + si], 0
                inc     si
                cmp     si, 1024d
                jb      CleanFB
                mov     [handle], ax
                mov     si, 00h
    Load:       mov     ah, 3Fh
                mov     bx, [Handle]
                mov     cx, 1
                mov     dx, offset oneByte
                int     21h
                or      ax, ax
                jz      StopR
                cmp     [oneByte], 10d
                je      Load
                cmp     [oneByte], 13d
                je      Load
                cmp     [oneByte], 32d
                je      Load
                cmp     [oneByte], 9d
                je      Load
                cmp     [oneByte], 44d
                je      Load
                cmp     [oneByte], 58d
                je      Load
                mov     dl, [oneByte]
                ;cmp     dl, 'A'
                ;jb      DLowify
                ;cmp     dl, 'Z'
                ;ja      DLowify
                ;add     dl, 32
    DLowify:    mov     [fileBuffer + si], dl                       
                inc     si
                jmp     Load
    StopR:      mov     bx, [Handle]
                mov     ah, 3Eh
                int     21h
                call ProcessContent
                ret
ENDP            LoadContent

PROC            ProcessContent
                ; limpiamos el arbol con todos sus elementos y seteamos el elemento actual a 0
                mov     [currentMember], 00h
                mov     si, 00h
                mov     di, 00h
                mov     bx, offset arbol
    CleanArray: mov     [byte bx + si], 00h
                inc     si
                cmp     si, 88d
                jne     CleanArray
                inc     di
                mov     si, 00h
                cmp     di, 50d
                je      Filter
                add     bx, 88d
                jmp     CleanArray
    Filter:     cmp     [fileBuffer + si], 91d
                je      StartArray
                inc     si
                jmp     Filter
    StartArray: inc     si
                cmp     [fileBuffer + si], 93d
                je      FinishP
                call    ProcessMember
                jmp     StartArray
    FinishP:    ret           
ENDP            ProcessContent


PROC            ProcessMember
                cmp     [currentMember], 50d
                je      FinishC
    InitC:      inc     si
                cmp     [fileBuffer + si], 125d
                je      FinishC
                cmp     [fileBuffer + si], 34d
                je      PName
                jmp     InitC
    PName:      mov     bx, offset arbol
                mov     cl, 00h
    FindP:      cmp     cl, [currentMember]
                je      CopyName
                add     bx, 88d
                inc     cl
                jmp     FindP
    CopyName:   mov     di, 00h
    CopyN:      inc     si
                cmp     [fileBuffer + si], 34d
                je      FinishName
                mov     ah, [fileBuffer + si]
                mov     [bx + di], ah
                inc     di
                jmp     CopyN
    FinishName: inc     si
                call    ProcessAttributes
                inc     [currentMember]
    FinishC:    ret
ENDP            ProcessMember

PROC            ProcessAttributes
    CleanAB:    mov     di, 00h
    CAB:        mov     [attribute + di], 00h
                inc     di
                cmp     di, 08h
                jb      CAB
                mov     di, 00h
                add     si, 02h
    FOne:       cmp     [fileBuffer + si], 34d
                je      FinishAN
                mov     ah, [fileBuffer + si]
                mov     [attribute + di], ah
                inc     si
                inc     di
                jmp     FOne
    FinishAN:   cmp     [attribute + 2], 80d
                je      SPareja
                cmp     [attribute + 2], 112d
                je      SPareja
                cmp     [attribute + 2], 72d
                je      SHijo   
                cmp     [attribute + 2], 104d
                je      SHijo
                mov     di, 10h
                add     si, 02h
    FImage:     cmp     [fileBuffer + si], 34d
                je      CheckOut
                mov     ah, [fileBuffer + si]
                mov     [byte bx + di], ah
                inc     si
                inc     di
                jmp     FImage
    SPareja:    nop
    SHijo:      nop
    CheckOut:   cmp     [fileBuffer + si + 1], 125d
                jne     CleanAB
                add     si, 02h
                ret     
ENDP            ProcessAttributes

PROC            FiltersMenu
                mov     ah, 09h
                mov     dx, offset filterLine
                int     21h
    PDash:      mov     ah, 09h
                mov     dx, offset commandLine
                int     21h
                mov     si, 00h
    CleanCom:   mov     [command + si], 0
                inc     si
                cmp     si, 32d
                jb      CleanCom
                mov     si, 00h
                mov     ax, 00h       
    LeerCom:    mov     ah, 01h
                int     21h
                cmp     al, 13
                je      FReadC
                mov     [command + si], al
                inc     si
                jmp     LeerCom
    FReadC:     cmp     [command], 69
                je      ExitF
                cmp     [command], 101
                je      ExitF
                call    ExecuteCommand
                jmp     PDash
    ExitF:      ret
ENDP            FiltersMenu

PROC            ExecuteCommand
                ret
ENDP            ExecuteCommand

PROC            GraphvizMenu
                ret
ENDP            GraphvizMenu

                END Start