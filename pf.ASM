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
filterLine      DB 10, 13, '==================== Filtros ====================', 10, 13, '$'
commandLine     DB '>> ', '$'
notSupported    DB '-- El comando ingresado no es soportado por el sistema', 10, 13, '$'
detailS         DB 'detalles'
showS           DB 'mostrar'
detailLine      DB 10, 13, '-------------------- Detalles --------------------', 10, 13, '$'
showLine        DB '-------------------- Mostrars --------------------', 10, 13, '$'
direccion       DB 'LAMBO.BMP', 0
bytes           DB ' bytes', 10, 13, '$'
pix             DB ' pixeles', 10, 13, '$'
tam             DB 'Tamanio de la imagen: ', '$'
alt             DB 'Alto de la imagen: ', '$'
anc             DB 'Ancho de la imagen: ', '$'

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
bufferComando   DB 7 DUP (0)
bufferId        DB 16 DUP (0)
imageAddress    DB 64 DUP (0)
nombreActual    DB 16 DUP (0)
worked          DB 0
number          DB 4 DUP (0)
printNumber     DB '$$$$$$$$$$$$$$$'
pOrB            DB 0

;variables para la prueba de carga
header          DB 54 DUP (0)
imageHandle     DW 0
palette         DB 1024 DUP ('P')
scrLine         DB 320 DUP (0)
palSize         DW 0
fileWidth       DW 0
fileHeight      DW 0
fileSize        DB 4 DUP (0)

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
                cmp     ah, 'z'
                ja      DontUp
                cmp     ah, 'a'
                jb      DontUp
                sub     ah, 32
    DontUp:     mov     [byte bx + di], ah
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
                cmp     [fileBuffer], 00h
                jne     ML
                mov     dx, offset errorBefOrd
                mov     ah, 09h
                int     21h
                jmp     ExitF
    ML:         mov     ah, 09h
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
                mov     ax, ds
                mov     es, ax
                mov     si, 00h
    CleanBC:    cmp     si, 07h
                je      CleanBIZ
                mov     [bufferComando + si], 00h
                inc     si
                jmp     CleanBC
    CleanBIZ:   mov     si, 00h
    CleanBI:    cmp     si, 16d
                je      MoveCom
                mov     [bufferId + si], 00h
                inc     si
                jmp     CleanBI
    MoveCom:    mov     si, 00h
    MoveComY:   cmp     [command + si], 32d
                je      CopyId
                mov     ah, [command + si]
                cmp     ah, 'A'
                jb      DLow
                cmp     ah, 'Z'
                ja      DLow
                add     ah, 32
    DLow:       mov     [bufferComando + si], ah
                inc     si
                jmp     MoveComY            
    CopyId:     inc     si
                mov     di, 00h
    CopyIdY:    cmp     [command + si], 00h
                je      Decide
                mov     ah, [command + si]
                mov     [bufferId + di], ah
                inc     si
                inc     di
                jmp     CopyIdY
    Decide:     cld
                mov     si, offset bufferComando
                mov     di, offset showS
                mov     cx, 07h
                repe    cmpsb
                je      ShowI
                cld 
                mov     si, offset bufferComando
                mov     di, offset detailS
                mov     cx, 07h
                repe    cmpsb
                je      DetailI
                mov     ah, 09h
                mov     dx, offset notSupported
                int     21h
                ret     
    ShowI:      call    GetImageAddress
                cmp     [imageAddress], 0
                je      Wasnt
                call    ShowOriginalImage
                ret
    DetailI:    call    GetImageAddress
                cmp     [imageAddress], 0
                je      Wasnt
                mov     ah, 09h
                mov     dx, offset detailLine
                int     21h
                call    DetailImage
                ret
    Wasnt:      mov     ah, 09h
                mov     dx, offset fileDust
                int     21h
                ret
ENDP            ExecuteCommand

PROC            GetImageAddress
                mov     ax, ds
                mov     es, ax
                mov     si, 00h
    CleanIA:    mov     [imageAddress + si], 00h
                inc     si
                cmp     si, 40h
                jb      CleanIA
                call    CleanCurrentName
                mov     si, 00h
                mov     di, 00h
                mov     bx, offset arbol
    Over:       call    CleanCurrentName
                cmp     [byte bx + si], 0
                je      NotDeh
                cmp     di, 50
                je      NotDeh
    CatName:    mov     ah, [bx + si]
                mov     [nombreActual + si], ah
                inc     si
                cmp     [byte bx + si], 0
                jne     CatName
                cld 
                mov     si, offset bufferId
                mov     di, offset nombreActual
                mov     cx, 10h
                repe    cmpsb
                je      GAddress
                add     bx, 88d
                inc     di
                mov     si, 00h
                jmp     Over
    GAddress:   add     bx, 10h
                mov     si, 00h
    CatAddress: mov     ah, [bx + si]
                mov     [imageAddress + si], ah
                inc     si
                cmp     [byte bx + si], 0
                jne     CatAddress
                cmp     si, 64d
                jne     CatAddress
    NotDeh:     ret
ENDP            GetImageAddress

PROC            CleanCurrentName
                push    si
                mov     si, 00h
    CleanNA:    mov     [nombreActual + si], 00h
                inc     si
                cmp     si, 16d
                jb      CleanNA
                pop     si
                ret
ENDP            CleanCurrentName

PROC            DetailImage
                call    OpenImage
                cmp     [worked], 00h
                jne     Reth
                ret
    Reth:       call    ReadHeader
                ; copiamos el tamanio del archivo
                mov     ah, [header + 2]
                mov     [number + 3], ah
                mov     ah, [header + 3]
                mov     [number + 2], ah
                mov     ah, [header + 4]
                mov     [number + 1], ah
                mov     ah, [header + 5]
                mov     [number], ah
                mov     [pOrB], 00h
                call    ToString
                mov     ah, 09h
                mov     dx, offset tam
                int     21h
                mov     dx, offset printNumber
                int     21h
                mov     dx, offset bytes
                int     21h  
                ; copiamos el largo de la imagen
                mov     ah, [header + 18]
                mov     [number + 3], ah
                mov     ah, [header + 19]
                mov     [number + 2], ah
                mov     ah, [header + 20]
                mov     [number + 1], ah
                mov     ah, [header + 21]
                mov     [number], ah
                mov     [pOrB], 01h
                call    ToString
                mov     ah, 09h
                mov     dx, offset anc
                int     21h
                mov     dx, offset printNumber
                int     21h
                mov     dx, offset pix
                int     21h 
                ; copiamos el alto de la imagen
                mov     ah, [header + 22]
                mov     [number + 3], ah
                mov     ah, [header + 23]
                mov     [number + 2], ah
                mov     ah, [header + 24]
                mov     [number + 1], ah
                mov     ah, [header + 25]
                mov     [number], ah
                mov     [pOrB], 01h
                call    ToString
                mov     ah, 09h
                mov     dx, offset alt
                int     21h
                mov     dx, offset printNumber
                int     21h
                mov     dx, offset pix
                int     21h
                mov     dx, offset detailLine
                int     21h
                mov     ah, 3Eh
                int     21h
                ret 
ENDP            DetailImage

PROC            ShowOriginalImage
                push    es
                call    OpenImage
                cmp     [worked], 00h
                jne     Reta
                pop     es
                ret
    Reta:       call    ReadHeader
                call    ReadPalette
                call    CopyPalette
                call    CopyBitMap
    Freeze:     mov     ah, 10h
                int     16h
                cmp     al, 1Bh
                jne     Freeze
                mov     ax, 0003h
                int     10h
                pop     es
                ret
ENDP            ShowOriginalImage

PROC            OpenImage
                mov     [worked], 00h
                mov     [imageHandle], 0
                mov     ah, 3Dh
                xor     al, al
                mov     dx, offset imageAddress
                int     21h
                jc      ImageError
                mov     [imageHandle], ax
                mov     [worked], 01h
                ret

    ImageError: mov     dx, offset fileDust
                mov     ah, 09h
                int     21h
                ret
ENDP            OpenImage

PROC            ReadHeader
                mov     si, 00h
    CleanHead:  mov     [header + si], 00h
                inc     si
                cmp     si, 54d
                jb      CleanHead            
                mov     ah, 3Fh
                mov     bx, [imageHandle]
                mov     cx, 54
                mov     dx, offset header
                int     21h
                mov     ch, [header + 11]
                mov     cl, [header + 10]
                sub     cx, 54
                shr     cx, 1
                shr     cx, 1
                mov     [palSize], cx
                mov     cl, [header + 18]
                mov     ch, [header + 19]
                mov     [fileWidth], cx
                mov     cl, [header + 22]
                mov     ch, [header + 23]
                mov     [fileHeight], cx
                ret
ENDP            ReadHeader

PROC            ReadPalette
                mov     si, 00h
    CleanPal:   mov     [palette + si], 'P'
                inc     si
                cmp     si, 400h
                jb      CleanPal
                mov     ah, 3fh
                mov     bx, [imageHandle]
                mov     cx, [palSize]
                shl     cx, 1
                shl     cx, 1
                mov     dx, offset palette
                int     21h
                ret
ENDP            ReadPalette

PROC            CopyPalette
                mov     ax, 13h
                int     10h
                mov     ax, 0A000h
                mov     es, ax
                mov     si, offset palette
                mov     cx, [palSize]
                mov     dx, 3C8h
                mov     al, 0

                out     dx, al
                inc     dx
    PalLoop:    mov     al, [si + 2]
                shr     al, 1
                shr     al, 1
                out     dx, al

                mov     al, [si + 1]
                shr     al, 1
                shr     al, 1                
                out     dx, al

                mov     al, [si]
                shr     al, 1
                shr     al, 1
                out     dx, al

                add     si, 4
                loop    PalLoop
                ret
ENDP            CopyPalette

PROC            CopyBitMap
                mov     cx, [fileHeight]

    BMPLoop:    push    cx
                mov     di, cx
                shl     cx, 1
                shl     cx, 1
                shl     cx, 1
                shl     cx, 1
                shl     cx, 1
                shl     cx, 1
                shl     di, 1
                shl     di, 1
                shl     di, 1
                shl     di, 1
                shl     di, 1
                shl     di, 1
                shl     di, 1
                shl     di, 1
                add     di, cx

                mov     ah, 3Fh
                mov     cx, [fileWidth]
                mov     dx, offset scrLine
                mov     bx, [imageHandle]
                int     21h

                cld

                mov     cx, [fileWidth]
                mov     si, offset scrLine
                rep     movsb

                pop     cx
                loop    BMPLoop

                mov     ah, 3Eh
                int     21h
                ret
ENDP            CopyBitMap

PROC            GraphvizMenu
                ret
ENDP            GraphvizMenu

PROC            ToString
                mov     si, 00h
    CleanPN:    mov     [printNumber + si], '$'
                inc     si
                cmp     si, 15d
                jb      CleanPN
                cmp     [pOrB], 01h
                je      SimpleP
                mov     si, 00h
                mov     di, 00h
    ForBy:      mov     ah, 00h
                mov     al, [number + si]
                mov     cl, 10h
                div     cl
                mov     [printNumber + di], al
                cmp     [printNumber + di], 09h
                ja      OverFive
                add     [printNumber + di], 30h
                jmp     NS
    OverFive:   add     [printNumber + di], 55d
    NS:         inc     di
                mov     [printNumber + di], ah
                cmp     [printNumber + di], 09h
                ja      OverFive2
                add     [printNumber + di], 30h
                jmp     NSS
    OverFive2:  add     [printNumber + di], 55d
    NSS:        inc     di
    NestByte:   inc     si
                cmp     si, 04h
                jb      ForBy
                ret

    SimpleP:    mov     ah, [number + 2]
                mov     al, [number + 3]
                mov     cl, 10d
                div     cl
                cmp     al, 09h
                ja      AgainT
                mov     [printNumber], al
                add     [printNumber], 30h
                mov     [printNumber + 1], ah
                add     [printNumber + 1], 30h
                ret
    AgainT:     mov     [printNumber + 2], ah
                add     [printNumber + 2], 30h
                mov     ah, 00h
                mov     cl, 10d
                div     cl
                mov     [printNumber + 1], ah
                add     [printNumber + 1], 30h
                mov     [printNumber], al
                add     [printNumber], 30h
                ret
ENDP            ToString

                END Start