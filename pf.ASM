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
mult1000        DW 1000
mult100         DW 100
mult10          DW 10 
mult64          DW 64

; codigo para graphviz a partir de aqui
graphMeta       DB 'graph familia node[fontsize = 32.0, style=bold, labelloc=b, fontcolor=white]', 59, 10, '$'
graphMeta1      DB 'edge [style=bold, fontsize=18]', 59, 10, '$'
dotBuffer       DB 1000 DUP ('$')     

;structs
STRUC   Miembro
        nombre    DB 16 DUP (0)
        image     DB 64 DUP (0)
        pareja    DW 0
        hijo      DW 0
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
floatBuffer     DB 4 DUP ('$')
floatValue      DW 0
auxBuffer       DB 6 DUP ('$')
arg1            DW 0
arg2            DW 0
resultado       DW 0
operador        DB 0
grayValue       DW 0
brightValue     DW 0
positionState   DB 0        ; del 0 al 7
colorState      DB 0        ; del 0 al 3

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
                cmp     [oneByte], 34d
                je      Any
                mov     dl, [oneByte]
    DLowify:    mov     [fileBuffer + si], dl                       
                inc     si
                jmp     Load
    Any:        mov     dl, [oneByte]
                mov     [fileBuffer + si], dl
                inc     si
                mov     ah, 3Fh
                mov     bx, [Handle]
                mov     cx, 1
                mov     dx, offset oneByte
                int     21h
                cmp     [oneByte], 34d
                jne     Any
                mov     dl, [oneByte]
                mov     [fileBuffer + si], dl
                inc     si
                jmp     Load
    StopR:      mov     bx, [Handle]
                mov     ah, 3Eh
                int     21h
                call ProcessContent
                ret
ENDP            LoadContent

PROC            ProcessContent
                mov     [currentMember], 00h
                mov     si, 00h
                mov     di, 00h
                mov     bx, offset arbol
    CleanArray: mov     [byte bx + si], 00h
                inc     si
                cmp     si, 84d
                jne     CleanArray
                inc     di
                mov     si, 00h
                cmp     di, 50d
                je      Filter
                add     bx, 84d
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
                add     bx, 84d
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
    SPareja:    mov     di, 50h
                call    Resolver
                jmp     CheckOut
    SHijo:      mov     di, 52h
                call    Resolver
    CheckOut:   cmp     [fileBuffer + si + 1], 125d
                jne     CleanAB
                add     si, 02h
                ret     
ENDP            ProcessAttributes

PROC            Resolver
                ; no tocar bx
                push    di
                push    bx
                add     si, 02h
                mov     cx, 00h
    Screen:     cmp     [fileBuffer + si], 20h
                jne     Useful
                inc     si
                jmp     Screen
    Useful:     cmp     [fileBuffer + si], '+'
                je      Emp
                cmp     [fileBuffer + si], '-'
                je      Emp
                cmp     [fileBuffer + si], '/'
                je      Emp
                cmp     [fileBuffer + si], '*'
                jne     Comp
    Emp:        jmp     Empujar
    Comp:       cmp     [fileBuffer + si], 34d
                je      Release
    Nerify:     mov     di, 00h
                mov     [auxBuffer], '$'
                mov     [auxBuffer + 1], '$'
                mov     [auxBuffer + 2], '$'
                mov     [auxBuffer + 3], '$'
                mov     [auxBuffer + 4], '$'
                mov     [auxBuffer + 5], '$'
    Net:        mov     ah, [fileBuffer + si]
                mov     [auxBuffer + di], ah
                inc     di
                inc     si
                cmp     [fileBuffer + si], 32d
                je      SaveN
                cmp     [fileBuffer + si], 34d
                jne     Net
    SaveN:      call    GuardarNumero
                mov     ax, [floatValue]
                push    ax
                inc     cx
                cmp     cx, 02h
                je      Operar
                jmp     Screen
    Operar:     pop     ax
                mov     [arg2], ax
                pop     ax
                mov     [arg1], ax
                xor     ax, ax
                pop     ax              ; aqui esta guardado el tipo de operacion
                mov     [operador], al
                call    OperacionAritmetica
                pop     cx
                mov     ax, [resultado]
                push    ax
                inc     cx
                cmp     cx, 02h
                je      Operar
                jmp     Screen
    Empujar:    push    cx
                mov     cx, 00h
                mov     ah, 00h
                mov     al, [fileBuffer + si]
                push    ax
                inc     si
                jmp     Screen 
    Release:    pop     ax
                mov     [floatValue], ax
                pop     bx
                pop     di
                mov     [byte bx + di], al
                mov     [byte bx + di + 1], ah
                ret
ENDP            Resolver

PROC            OperacionAritmetica
                mov     [resultado], 0000h
                cmp     [operador], '+'
                je      Sumar
                cmp     [operador], '-'
                je      Restar
                cmp     [operador], '*'
                je      Mult
    Dividir:    xor     ax, ax
                xor     dx, dx
                mov     ax, [arg1]
                mul     [mult100]
                div     [arg2]
                mov     [resultado], ax
                jmp     Retorno
    Sumar:      xor     ax, ax
                add     ax, [arg1]
                add     ax, [arg2]
                mov     [resultado], ax
                jmp     Retorno
    Restar:     xor     ax, ax
                mov     ax, [arg1]
                sub     ax, [arg2]
                mov     [resultado], ax
                jmp     Retorno
    Mult:       xor     ax, ax
                xor     dx, dx
                mov     ax, [arg1]
                mul     [arg2]
                div     [mult100]
                mov     [resultado], ax
    Retorno:    ret
ENDP            OperacionAritmetica

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
                add     bx, 84d
                inc     di
                mov     si, 00h
                jmp     Over
    GAddress:   add     bx, 10h
                mov     si, 00h
    CatAddress: mov     ah, [bx + si]
                mov     [imageAddress + si], ah
                inc     si
                ;cmp     [byte bx + si], 0
                ;jne     CatAddress
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
    Reta:       call    OpenImage
                call    ReadHeader
                call    ReadPalette
                call    NormalPalette
                call    UpView
                mov     [positionState], 00h
                mov     [colorState], 00h
    Freeze:     mov     ah, 07h
                int     21h
                cmp     al, 'M'
                je      NineRight
                cmp     al, 'K'
                je      NineLeft
                cmp     al, 'H'
                je      OneEighty
                cmp     al, 0Bh
                je      HMirror
                cmp     al, 'P'
                je      VMirror
                cmp     al, 'a'
                je      Normalize
                cmp     al, 'g'
                je      Grayify
                cmp     al, 'b'
                je      Brightify
                cmp     al, 'n'
                je      Negatify
                cmp     al, 1Bh
                je      Unfreeze
                jmp     Freeze
    NineRight:  call    Ninety
                jmp     Freeze
    NineLeft:   call    ANinety
                jmp     Freeze
    OneEighty:  call    HalfTwist
                jmp     Freeze
    HMirror:    call    HorizontalMirror
                jmp     Freeze
    VMirror:    call    VerticalMirror
                jmp     Freeze
    Normalize:  call    ApplyNormal
                jmp     Freeze
    Grayify:    call    ApplyGray
                jmp     Freeze
    Brightify:  call    ApplyBright
                jmp     Freeze
    Negatify:   call    ApplyNigga
                jmp     Freeze
    Unfreeze:   mov     ax, 0003h
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

PROC            NormalPalette
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
ENDP            NormalPalette

PROC            GrayPalette
                mov     [grayValue], 00h
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
    GrayLoop:   mov     al, [si + 2]        
                shr     al, 1               ; escala de grises se suman los tres colores y se dividen dentro de tres y se mandan 3 outs
                shr     al, 1
                mov     [byte grayValue], al
                mov     al, [si + 1]
                shr     al, 1
                shr     al, 1
                add     [byte grayValue], al
                mov     al, [si]
                shr     al, 1
                shr     al, 1
                add     [byte grayValue], al
                mov     ah, 00h
                mov     ax, [grayValue]
                mov     bh, 03h 
                div     bh  
                xor     ah, ah            
                out     dx, ax
                out     dx, ax
                out     dx, ax

                add     si, 4
                loop    GrayLoop
                ret
ENDP            GrayPalette

PROC            BrightPalette
                mov     [brightValue], 00h
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
    BLoop:      mov     al, [si + 2]        
                shr     al, 1               
                shr     al, 1               ; sumarle un numero como 100 y verificar que no se pase de 255
                mov     [byte brightValue], al
                add     [brightValue], 50d
                cmp     [brightValue], 255d
                jbe     PrintB
                mov     [brightValue], 255d
    PrintB:     mov     ah, 00h
                mov     ax, [brightValue]
                out     dx, al

                mov     al, [si + 1]
                shr     al, 1
                shr     al, 1                
                mov     [byte brightValue], al
                add     [brightValue], 50d
                cmp     [brightValue], 255d
                jbe     PrintB2
                mov     [brightValue], 255d
    PrintB2:    mov     ah, 00h
                mov     ax, [brightValue]
                out     dx, al

                mov     al, [si]
                shr     al, 1
                shr     al, 1
                mov     [byte brightValue], al
                add     [brightValue], 50d
                cmp     [brightValue], 255d
                jbe     PrintB3
                mov     [brightValue], 255d
    PrintB3:    mov     ah, 00h
                mov     ax, [brightValue]
                out     dx, al

                add     si, 4
                loop    BLoop
                ret
ENDP            BrightPalette

PROC            NegativePalette
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
    NLoop:      mov     al, [si + 2]        ; el invertido es 255 - [al]
                shr     al, 1               
                shr     al, 1
                mov     ah, 255d
                sub     ah, al
                mov     al, ah               
                out     dx, al

                mov     al, [si + 1]
                shr     al, 1
                shr     al, 1
                mov     ah, 255d
                sub     ah, al
                mov     al, ah                
                out     dx, al

                mov     al, [si]
                shr     al, 1
                shr     al, 1
                mov     ah, 255d
                sub     ah, al
                mov     al, ah
                out     dx, al

                add     si, 4
                loop    NLoop
                ret
ENDP            NegativePalette

PROC            UpView
                mov     cx, [fileHeight]

    BMPLoop:    push    cx
                mov     di, cx
                mov     ax, cx
                mul     [mult64]
                mov     cx, ax
                mov     ax, di
                mul     [mult64]
                mov     di, ax
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
ENDP            UpView

PROC            UpMirrorView
                mov     cx, [fileHeight]

    HLoop:      push    cx
                mov     di, cx
                mov     ax, cx
                mul     [mult64]
                mov     cx, ax
                mov     ax, di
                mul     [mult64]
                mov     di, ax
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
                add     si, cx
                push    ax
                xor     ax, ax
    InsideL:    movsb
                sub     si, 02h
                dec     cx
                cmp     cx, 00h
                jne     InsideL
                pop     ax

                pop     cx
                loop    HLoop

                mov     ah, 3Eh
                int     21h
                ret
ENDP            UpMirrorView

PROC            DownView
                mov     cx, 00h

    OELoop:     push    cx
                mov     di, cx
                mov     ax, cx
                mul     [mult64]
                mov     cx, ax
                mov     ax, di
                mul     [mult64]
                mov     di, ax
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
                add     si, cx
                ;push    ax
                ;xor     ax, ax
    InLoop:     movsb
                sub     si, 02h
                dec     cx
                cmp     cx, 00h
                jne     InLoop
                ;pop     ax

                pop     cx
                inc     cx
                cmp     cx, [fileHeight]
                jne     OELoop

                mov     ah, 3Eh
                int     21h
                ret
ENDP            DownView

PROC            DownMirrorView
                mov     cx, 00h

    DMLoop:     push    cx
                mov     di, cx
                mov     ax, cx
                mul     [mult64]
                mov     cx, ax
                mov     ax, di
                mul     [mult64]
                mov     di, ax
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
                inc     cx
                cmp     cx, [fileHeight]
                jne     DMLoop

                mov     ah, 3Eh
                int     21h
                ret
ENDP            DownMirrorView

PROC            RightView
                mov     cx, 00h
	RVLoop:     push    cx
	            mov     di, 0
	            add     di, cx
	            mov     ah, 3Fh
	            mov     bx, [imageHandle]
	            mov     cx, [fileWidth]
	            mov     dx, offset scrLine
	            int     21h
	            cld
	            mov     cx, [fileWidth]
	            mov     si, offset scrLine
	SecLoop:	movsb
		        dec     di
		        add     di, 320
		        dec     cx
		        cmp     cx, 00h
		        jne     SecLoop 
	            pop cx
		        inc cx
		        cmp     cx, [fileHeight]
		        jne RVLoop
                ret
ENDP            RightView

PROC            RightMirrorView
                ret
ENDP            RightMirrorView

PROC            LeftView
                mov     cx, [fileHeight]
	LVLoop:     push    cx
	            mov     di, 0
	            add     di, cx
	            mov     ah, 3Fh
	            mov     bx, [imageHandle]
	            mov     cx, [fileWidth]
	            mov     dx, offset scrLine
	            int     21h
	            cld
	            mov     si, offset scrLine
                add     si, cx
	TecLoop:	movsb
		        sub     si, 02h
                dec     di
		        add     di, 320
		        dec     cx
		        cmp     cx, 00h
		        jne     TecLoop 
	            pop cx
		        loop LVLoop
                ret
ENDP            LeftView

PROC            LeftMirrorView
                ret
ENDP            LeftMirrorView

PROC            Ninety
                call    OpenImage
                call    ReadHeader
                call    ReadPalette

                ; decidimos el filtro que queremos en base a la variable anterior
                cmp     [colorState], 00h   ; normal
                je      Normal
                cmp     [colorState], 01h   ; gris
                je      Gris
                cmp     [colorState], 02h   ; brillante
                je      Brillante
                cmp     [colorState], 03h   ; negativo
                je      Negativo
    Normal:     call    NormalPalette
                jmp     DefPos
    Gris:       call    GrayPalette
                jmp     DefPos
    Brillante:  call    BrightPalette
                jmp     DefPos
    Negativo:   call    NegativePalette

                ; decidimos la posicion en base a la variable de posicion
    DefPos:     cmp     [positionState], 00h
                je      Right
                cmp     [positionState], 01h
                je      Down
                cmp     [positionState], 02h
                je      Left
                cmp     [positionState], 03h
                je      Up
                jmp     Close
    Right:      call    RightView
                mov     [positionState], 01h
                jmp     FP
    Down:       call    DownView
                mov     [positionState], 02h
                jmp     FP
    Left:       call    LeftView
                mov     [positionState], 03h
                jmp     FP
    Up:         call    UpView
                mov     [positionState], 00h
                jmp     FP
    Close:      mov     ah, 3Eh
                int     21h
    FP:         ret
ENDP            Ninety

PROC            ANinety
                call    OpenImage
                call    ReadHeader
                call    ReadPalette

                ; decidimos el filtro que queremos en base a la variable anterior
                cmp     [colorState], 00h   ; normal
                je      Normal1
                cmp     [colorState], 01h   ; gris
                je      Gris1
                cmp     [colorState], 02h   ; brillante
                je      Brillante1
                cmp     [colorState], 03h   ; negativo
                je      Negativo1
    Normal1:    call    NormalPalette
                jmp     DefPos1
    Gris1:      call    GrayPalette
                jmp     DefPos1
    Brillante1: call    BrightPalette
                jmp     DefPos1
    Negativo1:  call    NegativePalette

                ; decidimos la posicion en base a la variable de posicion
    DefPos1:    cmp     [positionState], 00h
                je      Left1
                cmp     [positionState], 01h
                je      Up1
                cmp     [positionState], 02h
                je      Right1
                cmp     [positionState], 03h
                je      Down1
                jmp     Close1
    Right1:     call    RightView
                mov     [positionState], 01h
                jmp     FP1
    Down1:      call    DownView
                mov     [positionState], 02h
                jmp     FP1
    Left1:      call    LeftView
                mov     [positionState], 03h
                jmp     FP1
    Up1:        call    UpView
                mov     [positionState], 00h
                jmp     FP1
    Close1:     mov     ah, 3Eh
                int     21h
    FP1:        ret
ENDP            ANinety

PROC            HalfTwist
                call    OpenImage
                call    ReadHeader
                call    ReadPalette

                ; decidimos el filtro que queremos en base a la variable anterior
                cmp     [colorState], 00h   ; normal
                je      Normal2
                cmp     [colorState], 01h   ; gris
                je      Gris2
                cmp     [colorState], 02h   ; brillante
                je      Brillante2
                cmp     [colorState], 03h   ; negativo
                je      Negativo2
    Normal2:    call    NormalPalette
                jmp     DefPos2
    Gris2:      call    GrayPalette
                jmp     DefPos2
    Brillante2: call    BrightPalette
                jmp     DefPos2
    Negativo2:  call    NegativePalette

                ; decidimos la posicion en base a la variable de posicion
    DefPos2:    cmp     [positionState], 00h
                je      Down2
                cmp     [positionState], 01h
                je      Left2
                cmp     [positionState], 02h
                je      Up2
                cmp     [positionState], 03h
                je      Right2
                cmp     [positionState], 04h
                je      DownM2
                cmp     [positionState], 06h
                je      UpM2
                jmp     Close2
    Right2:     call    RightView
                mov     [positionState], 01h
                jmp     FP2
    Down2:      call    DownView
                mov     [positionState], 02h
                jmp     FP2
    Left2:      call    LeftView
                mov     [positionState], 03h
                jmp     FP2
    Up2:        call    UpView
                mov     [positionState], 00h
                jmp     FP2
    DownM2:     call    DownMirrorView
                mov     [positionState], 06h
                jmp     FP2
    UpM2:       call    UpMirrorView
                mov     [positionState], 04h
                jmp     FP2
    Close2:     mov     ah, 3Eh
                int     21h
    FP2:        ret    
ENDP            HalfTwist

PROC            HorizontalMirror
                call    OpenImage
                call    ReadHeader
                call    ReadPalette

                ; decidimos el filtro que queremos en base a la variable anterior
                cmp     [colorState], 00h   ; normal
                je      Normal3
                cmp     [colorState], 01h   ; gris
                je      Gris3
                cmp     [colorState], 02h   ; brillante
                je      Brillante3
                cmp     [colorState], 03h   ; negativo
                je      Negativo3
    Normal3:    call    NormalPalette
                jmp     DefPos3
    Gris3:      call    GrayPalette
                jmp     DefPos3
    Brillante3: call    BrightPalette
                jmp     DefPos3
    Negativo3:  call    NegativePalette

                ; decidimos la posicion en base a la variable de posicion
    DefPos3:    cmp     [positionState], 00h
                je      UpM3
                cmp     [positionState], 02h
                je      DownM3
                cmp     [positionState], 04h
                je      Up3
                cmp     [positionState], 06h
                je      Down3
                jmp     Close3
    UpM3:       call    UpMirrorView
                mov     [positionState], 04h
                jmp     FP3
    Down3:      call    DownView
                mov     [positionState], 02h
                jmp     FP3
    DownM3:     call    DownMirrorView
                mov     [positionState], 06h
                jmp     FP3
    Up3:        call    UpView
                mov     [positionState], 00h
                jmp     FP3
    Close3:     mov     ah, 3Eh
                int     21h
    FP3:        ret
ENDP            HorizontalMirror

PROC            VerticalMirror
                call    OpenImage
                call    ReadHeader
                call    ReadPalette

                ; decidimos el filtro que queremos en base a la variable anterior
                cmp     [colorState], 00h   ; normal
                je      Normal4
                cmp     [colorState], 01h   ; gris
                je      Gris4
                cmp     [colorState], 02h   ; brillante
                je      Brillante4
                cmp     [colorState], 03h   ; negativo
                je      Negativo4
    Normal4:    call    NormalPalette
                jmp     DefPos4
    Gris4:      call    GrayPalette
                jmp     DefPos4
    Brillante4: call    BrightPalette
                jmp     DefPos4
    Negativo4:  call    NegativePalette

                ; decidimos la posicion en base a la variable de posicion
    DefPos4:    cmp     [positionState], 00h
                je      DownM4
                cmp     [positionState], 02h
                je      UpM4
                cmp     [positionState], 04h
                je      Down4
                cmp     [positionState], 06h
                je      Up4
                jmp     Close4
    UpM4:       call    UpMirrorView
                mov     [positionState], 04h
                jmp     FP4
    Down4:      call    DownView
                mov     [positionState], 02h
                jmp     FP4
    DownM4:     call    DownMirrorView
                mov     [positionState], 06h
                jmp     FP4
    Up4:        call    UpView
                mov     [positionState], 00h
                jmp     FP4
    Close4:     mov     ah, 3Eh
                int     21h
    FP4:        ret
ENDP            VerticalMirror

PROC            ApplyNormal
                call    OpenImage
                call    ReadHeader
                call    ReadPalette
                call    NormalPalette
                mov     [colorState], 00h

                ; decidimos la posicion en base a la variable de posicion
                cmp     [positionState], 00h
                je      Up5
                cmp     [positionState], 01h
                je      Right5
                cmp     [positionState], 02h
                je      Down5
                cmp     [positionState], 03h
                je      Left5
                cmp     [positionState], 04h
                je      UpM5
                cmp     [positionState], 05h
                je      RightM5
                cmp     [positionState], 06h
                je      DownM5
                cmp     [positionState], 07h
                je      LeftM5
    Up5:        call    UpView
                jmp     FP5
    Right5:     call    RightView
                jmp     FP5
    Down5:      call    DownView
                jmp     FP5
    Left5:      call    LeftView
                jmp     FP5
    UpM5:       call    UpMirrorView
                jmp     FP5
    DownM5:     call    DownMirrorView
                jmp     FP5
    LeftM5:     call    LeftView
                jmp     FP5
    RightM5:    call    RightView
    FP5:        ret
ENDP            ApplyNormal

PROC            ApplyGray
                call    OpenImage
                call    ReadHeader
                call    ReadPalette
                call    GrayPalette
                mov     [colorState], 01h

                ; decidimos la posicion en base a la variable de posicion
                cmp     [positionState], 00h
                je      Up6
                cmp     [positionState], 01h
                je      Right6
                cmp     [positionState], 02h
                je      Down6
                cmp     [positionState], 03h
                je      Left6
                cmp     [positionState], 04h
                je      UpM6
                cmp     [positionState], 05h
                je      RightM6
                cmp     [positionState], 06h
                je      DownM6
                cmp     [positionState], 07h
                je      LeftM6
    Up6:        call    UpView
                jmp     FP6
    Right6:     call    RightView
                jmp     FP6
    Down6:      call    DownView
                jmp     FP6
    Left6:      call    LeftView
                jmp     FP6
    UpM6:       call    UpMirrorView
                jmp     FP6
    DownM6:     call    DownMirrorView
                jmp     FP6
    LeftM6:     call    LeftView
                jmp     FP6
    RightM6:    call    RightView
    FP6:        ret
ENDP            ApplyGray

PROC            ApplyBright
                call    OpenImage
                call    ReadHeader
                call    ReadPalette
                call    BrightPalette
                mov     [colorState], 02h

                ; decidimos la posicion en base a la variable de posicion
                cmp     [positionState], 00h
                je      Up7
                cmp     [positionState], 01h
                je      Right7
                cmp     [positionState], 02h
                je      Down7
                cmp     [positionState], 03h
                je      Left7
                cmp     [positionState], 04h
                je      UpM7
                cmp     [positionState], 05h
                je      RightM7
                cmp     [positionState], 06h
                je      DownM7
                cmp     [positionState], 07h
                je      LeftM7
    Up7:        call    UpView
                jmp     FP7
    Right7:     call    RightView
                jmp     FP7
    Down7:      call    DownView
                jmp     FP7
    Left7:      call    LeftView
                jmp     FP7
    UpM7:       call    UpMirrorView
                jmp     FP7
    DownM7:     call    DownMirrorView
                jmp     FP7
    LeftM7:     call    LeftView
                jmp     FP7
    RightM7:    call    RightView
    FP7:        ret
ENDP            ApplyBright

PROC            ApplyNigga
                call    OpenImage
                call    ReadHeader
                call    ReadPalette
                call    NegativePalette
                mov     [colorState], 03h

                ; decidimos la posicion en base a la variable de posicion
                cmp     [positionState], 00h
                je      Up8
                cmp     [positionState], 01h
                je      Right8
                cmp     [positionState], 02h
                je      Down8
                cmp     [positionState], 03h
                je      Left8
                cmp     [positionState], 04h
                je      UpM8
                cmp     [positionState], 05h
                je      RightM8
                cmp     [positionState], 06h
                je      DownM8
                cmp     [positionState], 07h
                je      LeftM8
    Up8:        call    UpView
                jmp     FP8
    Right8:     call    RightView
                jmp     FP8
    Down8:      call    DownView
                jmp     FP8
    Left8:      call    LeftView
                jmp     FP8
    UpM8:       call    UpMirrorView
                jmp     FP8
    DownM8:     call    DownMirrorView
                jmp     FP8
    LeftM8:     call    LeftView
                jmp     FP8
    RightM8:    call    RightView
    FP8:        ret
ENDP            ApplyNigga

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

PROC            GuardarNumero
                push    di
                mov     [floatBuffer], 00h
                mov     [floatBuffer + 1], 00h
                mov     [floatBuffer + 2], 00h
                mov     [floatBuffer + 3], 00h
                ; buscar si hay punto, esa es la primera division
    Dot:        cmp     [auxBuffer], 46d
                je      FloatingC
                cmp     [auxBuffer + 1], 46d
                je      FloatingO
                cmp     [auxBuffer + 2], 46d
                je      FloatingT
    Entero:     cmp     [auxBuffer + 1], '$'
                je      Cent
                mov     ah, [auxBuffer]
                sub     ah, 30h
                mov     [floatBuffer], ah
                mov     ah, [auxBuffer + 1]
                sub     ah, 30h
                mov     [floatBuffer + 1], ah
                jmp     Yump
    Cent:       mov     ah, [auxBuffer]
                sub     ah, 30h
                mov     [floatBuffer + 1], ah
    Yump:       jmp     Transform
    FloatingC:  mov     ah, [auxBuffer + 1]
                sub     ah, 30h
                mov     [floatBuffer + 2], ah
                cmp     [auxBuffer + 2], '$'
                je      Transform
                mov     ah, [auxBuffer + 2]
                sub     ah, 30h
                mov     [floatBuffer + 3], ah
                jmp     Transform
    FloatingO:  mov     ah, [auxBuffer]
                sub     ah, 30h
                mov     [floatBuffer + 1], ah
                mov     ah, [auxBuffer + 2]
                sub     ah, 30h
                mov     [floatBuffer + 2], ah
                cmp     [auxBuffer + 3], '$'
                je      Transform
                mov     ah, [auxBuffer + 3]
                sub     ah, 30h
                mov     [floatBuffer + 3], ah
                jmp     Transform
    FloatingT:  mov     ah, [auxBuffer]
                sub     ah, 30h
                mov     [floatBuffer], ah
                mov     ah, [auxBuffer + 1]
                sub     ah, 30h
                mov     [floatBuffer + 1], ah
                mov     ah, [auxBuffer + 3]
                sub     ah, 30h
                mov     [floatBuffer + 2], ah
                cmp     [auxBuffer + 4], '$'
                je      Transform
                mov     ah, [auxBuffer + 4]
                sub     ah, 30h
                mov     [floatBuffer + 3], ah 
    Transform:  call    Numberify
                pop     di
                ret
ENDP            GuardarNumero

PROC            Numberify
                mov     [floatValue], 00h
                mov     ah, 00h
                mov     al, [floatBuffer]
                ;sub     ax, 30h
                mul     [mult1000]
                mov     [floatValue], ax
                mov     ax, 00h
                mov     al, [floatBuffer + 1]
                ;sub     al, 30h
                mov     bl, 100d
                mul     bl
                add     [floatValue], ax
                mov     ax, 00h
                mov     al, [floatBuffer + 2]
                ;sub     al, 30h
                mov     bl, 10d
                mul     bl
                add     [floatValue], ax
                mov     ax, 00h
                mov     al, [floatBuffer + 3]
                ;sub     al, 30h
                add     [floatValue], ax
                ret
ENDP            Numberify

                END Start