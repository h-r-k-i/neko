
./boot.bin:     file format binary


Disassembly of section .data:

00000000 <.data>:
       0:	fa                   	cli
       1:	ea 06 7c 00 00       	jmp    0x0:0x7c06
       6:	88 16 9b 7c          	mov    BYTE PTR ds:0x7c9b,dl
       a:	31 c0                	xor    ax,ax
       c:	8e d8                	mov    ds,ax
       e:	8e c0                	mov    es,ax
      10:	8e e0                	mov    fs,ax
      12:	8e e8                	mov    gs,ax
      14:	8e d0                	mov    ss,ax
      16:	be 9d 7c             	mov    si,0x7c9d
      19:	bc 00 70             	mov    sp,0x7000
      1c:	fb                   	sti
      1d:	30 db                	xor    bl,bl
      1f:	b4 00                	mov    ah,0x0
      21:	8a 16 9b 7c          	mov    dl,BYTE PTR ds:0x7c9b
      25:	cd 13                	int    0x13
      27:	b4 41                	mov    ah,0x41
      29:	bb aa 55             	mov    bx,0x55aa
      2c:	8a 16 9b 7c          	mov    dl,BYTE PTR ds:0x7c9b
      30:	cd 13                	int    0x13
      32:	72 1f                	jb     0x53
      34:	81 fb 55 aa          	cmp    bx,0xaa55
      38:	75 19                	jne    0x53
      3a:	f7 c1 01 00          	test   cx,0x1
      3e:	74 13                	je     0x53
      40:	ba 43 53             	mov    dx,0x5343
      43:	52                   	push   dx
      44:	be 9d 7c             	mov    si,0x7c9d
      47:	b4 42                	mov    ah,0x42
      49:	8a 16 9b 7c          	mov    dl,BYTE PTR ds:0x7c9b
      4d:	cd 13                	int    0x13
      4f:	72 02                	jb     0x53
      51:	eb 2a                	jmp    0x7d
      53:	ba 4c 46             	mov    dx,0x464c
      56:	52                   	push   dx
      57:	b4 02                	mov    ah,0x2
      59:	b0 11                	mov    al,0x11
      5b:	b5 00                	mov    ch,0x0
      5d:	b1 02                	mov    cl,0x2
      5f:	b6 00                	mov    dh,0x0
      61:	8a 16 9b 7c          	mov    dl,BYTE PTR ds:0x7c9b
      65:	bb 00 01             	mov    bx,0x100
      68:	8e c3                	mov    es,bx
      6a:	31 db                	xor    bx,bx
      6c:	cd 13                	int    0x13
      6e:	73 0d                	jae    0x7d
      70:	fe 06 9c 7c          	inc    BYTE PTR ds:0x7c9c
      74:	80 3e 9c 7c 03       	cmp    BYTE PTR ds:0x7c9c,0x3
      79:	73 0b                	jae    0x86
      7b:	eb d6                	jmp    0x53
      7d:	8a 16 9b 7c          	mov    dl,BYTE PTR ds:0x7c9b
      81:	ea 00 10 00 00       	jmp    0x0:0x1000
      86:	fa                   	cli
      87:	90                   	nop
      88:	b4 0e                	mov    ah,0xe
      8a:	90                   	nop
      8b:	b0 3f                	mov    al,0x3f
      8d:	90                   	nop
      8e:	b7 00                	mov    bh,0x0
      90:	90                   	nop
      91:	b3 07                	mov    bl,0x7
      93:	cd 10                	int    0x10
      95:	f4                   	hlt
      96:	eb ee                	jmp    0x86
      98:	f4                   	hlt
      99:	eb fd                	jmp    0x98
      9b:	00 00                	add    BYTE PTR [bx+si],al
      9d:	10 00                	adc    BYTE PTR [bx+si],al
      9f:	11 00                	adc    WORD PTR [bx+si],ax
      a1:	00 10                	add    BYTE PTR [bx+si],dl
      a3:	00 00                	add    BYTE PTR [bx+si],al
      a5:	01 00                	add    WORD PTR [bx+si],ax
	...
     1fb:	00 00                	add    BYTE PTR [bx+si],al
     1fd:	00 55 aa             	add    BYTE PTR [di-0x56],dl
     200:	fa                   	cli
     201:	31 c0                	xor    ax,ax
     203:	8e d0                	mov    ss,ax
     205:	fb                   	sti
     206:	88 16 ea 12          	mov    BYTE PTR ds:0x12ea,dl
     20a:	8a 16 ea 12          	mov    dl,BYTE PTR ds:0x12ea
     20e:	bd ea 12             	mov    bp,0x12ea
     211:	5a                   	pop    dx
     212:	89 16 ec 12          	mov    WORD PTR ds:0x12ec,dx
     216:	31 d2                	xor    dx,dx
     218:	fa                   	cli
     219:	31 c0                	xor    ax,ax
     21b:	31 db                	xor    bx,bx
     21d:	31 c9                	xor    cx,cx
     21f:	30 f6                	xor    dh,dh
     221:	be ff 6f             	mov    si,0x6fff
     224:	31 ff                	xor    di,di
     226:	31 c5                	xor    bp,ax
     228:	8e d8                	mov    ds,ax
     22a:	8e c0                	mov    es,ax
     22c:	8e e0                	mov    fs,ax
     22e:	8e e8                	mov    gs,ax
     230:	8e d0                	mov    ss,ax
     232:	bc ff 6f             	mov    sp,0x6fff
     235:	fb                   	sti
     236:	b4 13                	mov    ah,0x13
     238:	31 d2                	xor    dx,dx
     23a:	b0 01                	mov    al,0x1
     23c:	b7 00                	mov    bh,0x0
     23e:	b3 07                	mov    bl,0x7
     240:	b9 1d 00             	mov    cx,0x1d
     243:	1e                   	push   ds
     244:	07                   	pop    es
     245:	bd ef 12             	mov    bp,0x12ef
     248:	cd 10                	int    0x10
     24a:	fe c6                	inc    dh
     24c:	88 36 eb 12          	mov    BYTE PTR ds:0x12eb,dh
     250:	31 d2                	xor    dx,dx
     252:	8a 16 ea 12          	mov    dl,BYTE PTR ds:0x12ea
     256:	31 c0                	xor    ax,ax
     258:	8e c0                	mov    es,ax
     25a:	66 b8 20 e8 00 00    	mov    eax,0xe820
     260:	66 31 db             	xor    ebx,ebx
     263:	66 b9 18 00 00 00    	mov    ecx,0x18
     269:	66 ba 50 41 4d 53    	mov    edx,0x534d4150
     26f:	bf 04 70             	mov    di,0x7004
     272:	cd 15                	int    0x15
     274:	72 71                	jb     0x2e7
     276:	66 3d 50 41 4d 53    	cmp    eax,0x534d4150
     27c:	75 69                	jne    0x2e7
     27e:	66 83 fb 00          	cmp    ebx,0x0
     282:	0f 84 a1 00          	je     0x327
     286:	8b 16 00 70          	mov    dx,WORD PTR ds:0x7000
     28a:	42                   	inc    dx
     28b:	89 16 00 70          	mov    WORD PTR ds:0x7000,dx
     28f:	83 c7 18             	add    di,0x18
     292:	66 b8 20 e8 00 00    	mov    eax,0xe820
     298:	66 b9 18 00 00 00    	mov    ecx,0x18
     29e:	66 ba 50 41 4d 53    	mov    edx,0x534d4150
     2a4:	cd 15                	int    0x15
     2a6:	72 3f                	jb     0x2e7
     2a8:	66 3d 50 41 4d 53    	cmp    eax,0x534d4150
     2ae:	75 37                	jne    0x2e7
     2b0:	66 85 db             	test   ebx,ebx
     2b3:	74 72                	je     0x327
     2b5:	8b 16 00 70          	mov    dx,WORD PTR ds:0x7000
     2b9:	42                   	inc    dx
     2ba:	89 16 00 70          	mov    WORD PTR ds:0x7000,dx
     2be:	83 c7 18             	add    di,0x18
     2c1:	81 ff e8 7f          	cmp    di,0x7fe8
     2c5:	73 02                	jae    0x2c9
     2c7:	eb c9                	jmp    0x292
     2c9:	b4 13                	mov    ah,0x13
     2cb:	b0 01                	mov    al,0x1
     2cd:	b7 00                	mov    bh,0x0
     2cf:	b3 07                	mov    bl,0x7
     2d1:	8a 36 eb 12          	mov    dh,BYTE PTR ds:0x12eb
     2d5:	30 d2                	xor    dl,dl
     2d7:	b9 4a 00             	mov    cx,0x4a
     2da:	1e                   	push   ds
     2db:	07                   	pop    es
     2dc:	bd b6 13             	mov    bp,0x13b6
     2df:	cd 10                	int    0x10
     2e1:	fe c6                	inc    dh
     2e3:	88 36 eb 12          	mov    BYTE PTR ds:0x12eb,dh
     2e7:	b4 13                	mov    ah,0x13
     2e9:	b0 01                	mov    al,0x1
     2eb:	b7 00                	mov    bh,0x0
     2ed:	b3 07                	mov    bl,0x7
     2ef:	8a 36 eb 12          	mov    dh,BYTE PTR ds:0x12eb
     2f3:	30 d2                	xor    dl,dl
     2f5:	b9 2d 00             	mov    cx,0x2d
     2f8:	1e                   	push   ds
     2f9:	07                   	pop    es
     2fa:	bd 3f 13             	mov    bp,0x133f
     2fd:	cd 10                	int    0x10
     2ff:	fe c6                	inc    dh
     301:	88 36 eb 12          	mov    BYTE PTR ds:0x12eb,dh
     305:	b8 01 e8             	mov    ax,0xe801
     308:	cd 15                	int    0x15
     30a:	0f 82 64 01          	jb     0x472
     30e:	83 f9 00             	cmp    cx,0x0
     311:	0f 84 5d 01          	je     0x472
     315:	89 0e 02 70          	mov    WORD PTR ds:0x7002,cx
     319:	89 16 04 70          	mov    WORD PTR ds:0x7004,dx
     31d:	31 c0                	xor    ax,ax
     31f:	b8 01 e8             	mov    ax,0xe801
     322:	a3 00 70             	mov    ds:0x7000,ax
     325:	eb 00                	jmp    0x327
     327:	30 db                	xor    bl,bl
     329:	b4 00                	mov    ah,0x0
     32b:	31 d2                	xor    dx,dx
     32d:	8a 16 ea 12          	mov    dl,BYTE PTR ds:0x12ea
     331:	cd 13                	int    0x13
     333:	8b 16 ec 12          	mov    dx,WORD PTR ds:0x12ec
     337:	81 fa 4c 46          	cmp    dx,0x464c
     33b:	74 19                	je     0x356
     33d:	81 fa 43 53          	cmp    dx,0x5343
     341:	0f 85 05 01          	jne    0x44a
     345:	0e                   	push   cs
     346:	1f                   	pop    ds
     347:	be 16 15             	mov    si,0x1516
     34a:	b4 42                	mov    ah,0x42
     34c:	8a 16 ea 12          	mov    dl,BYTE PTR ds:0x12ea
     350:	cd 13                	int    0x13
     352:	72 02                	jb     0x356
     354:	eb 23                	jmp    0x379
     356:	b4 13                	mov    ah,0x13
     358:	b0 01                	mov    al,0x1
     35a:	b7 00                	mov    bh,0x0
     35c:	b3 07                	mov    bl,0x7
     35e:	8a 36 eb 12          	mov    dh,BYTE PTR ds:0x12eb
     362:	30 d2                	xor    dl,dl
     364:	b9 52 00             	mov    cx,0x52
     367:	1e                   	push   ds
     368:	07                   	pop    es
     369:	bd 00 14             	mov    bp,0x1400
     36c:	cd 10                	int    0x10
     36e:	fe c6                	inc    dh
     370:	88 36 eb 12          	mov    BYTE PTR ds:0x12eb,dh
     374:	31 d2                	xor    dx,dx
     376:	f4                   	hlt
     377:	eb fd                	jmp    0x376
     379:	90                   	nop
     37a:	eb 00                	jmp    0x37c
     37c:	eb 00                	jmp    0x37e
     37e:	b4 13                	mov    ah,0x13
     380:	b0 01                	mov    al,0x1
     382:	b7 00                	mov    bh,0x0
     384:	b3 07                	mov    bl,0x7
     386:	8a 36 eb 12          	mov    dh,BYTE PTR ds:0x12eb
     38a:	30 d2                	xor    dl,dl
     38c:	b9 10 00             	mov    cx,0x10
     38f:	1e                   	push   ds
     390:	07                   	pop    es
     391:	bd 89 14             	mov    bp,0x1489
     394:	cd 10                	int    0x10
     396:	fe c6                	inc    dh
     398:	88 36 eb 12          	mov    BYTE PTR ds:0x12eb,dh
     39c:	e4 92                	in     al,0x92
     39e:	a8 02                	test   al,0x2
     3a0:	75 09                	jne    0x3ab
     3a2:	0c 02                	or     al,0x2
     3a4:	24 fe                	and    al,0xfe
     3a6:	e6 92                	out    0x92,al
     3a8:	e8 f2 00             	call   0x49d
     3ab:	eb 00                	jmp    0x3ad
     3ad:	90                   	nop
     3ae:	fa                   	cli
     3af:	eb 00                	jmp    0x3b1
     3b1:	0f 01 16 3e 15       	lgdtw  ds:0x153e
     3b6:	b4 00                	mov    ah,0x0
     3b8:	b0 03                	mov    al,0x3
     3ba:	cd 10                	int    0x10
     3bc:	31 d2                	xor    dx,dx
     3be:	8a 16 ea 12          	mov    dl,BYTE PTR ds:0x12ea
     3c2:	66 b9 00 01 00 00    	mov    ecx,0x100
     3c8:	66 8d 3e 44 15       	lea    edi,ds:0x1544
     3cd:	66 b8 e9 12 00 00    	mov    eax,0x12e9
     3d3:	67 89 07             	mov    WORD PTR [edi],ax
     3d6:	67 c7 47 02 08 00    	mov    WORD PTR [edi+0x2],0x8
     3dc:	67 c6 47 04 00       	mov    BYTE PTR [edi+0x4],0x0
     3e1:	67 c6 47 05 8e       	mov    BYTE PTR [edi+0x5],0x8e
     3e6:	66 c1 e8 10          	shr    eax,0x10
     3ea:	67 89 47 06          	mov    WORD PTR [edi+0x6],ax
     3ee:	66 83 c7 08          	add    edi,0x8
     3f2:	66 49                	dec    ecx
     3f4:	75 d7                	jne    0x3cd
     3f6:	eb 00                	jmp    0x3f8
     3f8:	fa                   	cli
     3f9:	0f 01 16 3e 15       	lgdtw  ds:0x153e
     3fe:	e4 70                	in     al,0x70
     400:	0c 80                	or     al,0x80
     402:	e6 70                	out    0x70,al
     404:	0f 20 c0             	mov    eax,cr0
     407:	0c 01                	or     al,0x1
     409:	0f 22 c0             	mov    cr0,eax
     40c:	ea 11 12 08 00       	jmp    0x8:0x1211
     411:	66 b8 10 00 8e d8    	mov    eax,0xd88e0010
     417:	8e d0                	mov    ss,ax
     419:	8e c0                	mov    es,ax
     41b:	8e e0                	mov    fs,ax
     41d:	8e e8                	mov    gs,ax
     41f:	0f 01 1d             	lidtw  [di]
     422:	44                   	inc    sp
     423:	1d 00 00             	sbb    ax,0x0
     426:	e4 80                	in     al,0x80
     428:	24 7f                	and    al,0x7f
     42a:	e6 70                	out    0x70,al
     42c:	b0 ff                	mov    al,0xff
     42e:	e6 a1                	out    0xa1,al
     430:	e6 21                	out    0x21,al
     432:	fb                   	sti
     433:	fa                   	cli
     434:	bc ff 6f             	mov    sp,0x6fff
     437:	00 00                	add    BYTE PTR [bx+si],al
     439:	bb 00 70             	mov    bx,0x7000
     43c:	00 00                	add    BYTE PTR [bx+si],al
     43e:	b8 4e 45             	mov    ax,0x454e
     441:	4b                   	dec    bx
     442:	4f                   	dec    di
     443:	ea 00 80 00 00       	jmp    0x0:0x8000
     448:	08 00                	or     BYTE PTR [bx+si],al
     44a:	fa                   	cli
     44b:	b4 13                	mov    ah,0x13
     44d:	b0 01                	mov    al,0x1
     44f:	b7 00                	mov    bh,0x0
     451:	b3 07                	mov    bl,0x7
     453:	8a 35                	mov    dh,BYTE PTR [di]
     455:	eb 12                	jmp    0x469
     457:	00 00                	add    BYTE PTR [bx+si],al
     459:	30 d2                	xor    dl,dl
     45b:	66 b9 33 00 1e 07    	mov    ecx,0x71e0033
     461:	66 bd 0c 13 cd 10    	mov    ebp,0x10cd130c
     467:	fe c6                	inc    dh
     469:	88 35                	mov    BYTE PTR [di],dh
     46b:	eb 12                	jmp    0x47f
     46d:	00 00                	add    BYTE PTR [bx+si],al
     46f:	f4                   	hlt
     470:	eb d8                	jmp    0x44a
     472:	fa                   	cli
     473:	b4 13                	mov    ah,0x13
     475:	b0 01                	mov    al,0x1
     477:	b7 00                	mov    bh,0x0
     479:	b3 07                	mov    bl,0x7
     47b:	8a 35                	mov    dh,BYTE PTR [di]
     47d:	eb 12                	jmp    0x491
     47f:	00 00                	add    BYTE PTR [bx+si],al
     481:	30 d2                	xor    dl,dl
     483:	66 b9 4a 00 1e 07    	mov    ecx,0x71e004a
     489:	66 bd 6c 13 cd 10    	mov    ebp,0x10cd136c
     48f:	fe c6                	inc    dh
     491:	88 35                	mov    BYTE PTR [di],dh
     493:	eb 12                	jmp    0x4a7
     495:	00 00                	add    BYTE PTR [bx+si],al
     497:	f4                   	hlt
     498:	e9 d9 fe             	jmp    0x374
     49b:	ff                   	(bad)
     49c:	ff                   	(bad)
     49d:	fa                   	cli
     49e:	e8 35 00             	call   0x4d6
     4a1:	00 00                	add    BYTE PTR [bx+si],al
     4a3:	b0 ad                	mov    al,0xad
     4a5:	e6 64                	out    0x64,al
     4a7:	e8 2c 00             	call   0x4d6
     4aa:	00 00                	add    BYTE PTR [bx+si],al
     4ac:	b0 d0                	mov    al,0xd0
     4ae:	e6 64                	out    0x64,al
     4b0:	e8 2a 00             	call   0x4dd
     4b3:	00 00                	add    BYTE PTR [bx+si],al
     4b5:	e4 60                	in     al,0x60
     4b7:	66 50                	push   eax
     4b9:	e8 1a 00             	call   0x4d6
     4bc:	00 00                	add    BYTE PTR [bx+si],al
     4be:	b0 d1                	mov    al,0xd1
     4c0:	e6 64                	out    0x64,al
     4c2:	e8 11 00             	call   0x4d6
     4c5:	00 00                	add    BYTE PTR [bx+si],al
     4c7:	66 58                	pop    eax
     4c9:	0c 02                	or     al,0x2
     4cb:	e6 60                	out    0x60,al
     4cd:	e8 06 00             	call   0x4d6
     4d0:	00 00                	add    BYTE PTR [bx+si],al
     4d2:	b0 ae                	mov    al,0xae
     4d4:	e6 64                	out    0x64,al
     4d6:	fb                   	sti
     4d7:	c3                   	ret
     4d8:	e4 64                	in     al,0x64
     4da:	a8 02                	test   al,0x2
     4dc:	75 fa                	jne    0x4d8
     4de:	c3                   	ret
     4df:	e4 64                	in     al,0x64
     4e1:	a8 01                	test   al,0x1
     4e3:	74 fa                	je     0x4df
     4e5:	c3                   	ret
     4e6:	f4                   	hlt
     4e7:	eb fd                	jmp    0x4e6
     4e9:	cf                   	iret
     4ea:	00 00                	add    BYTE PTR [bx+si],al
     4ec:	00 00                	add    BYTE PTR [bx+si],al
     4ee:	00 4c 6f             	add    BYTE PTR [si+0x6f],cl
     4f1:	61                   	popa
     4f2:	64 69 6e 67 20 66    	imul   bp,WORD PTR fs:[bp+0x67],0x6620
     4f8:	72 6f                	jb     0x569
     4fa:	6d                   	ins    WORD PTR es:[di],dx
     4fb:	20 68 61             	and    BYTE PTR [bx+si+0x61],ch
     4fe:	72 64                	jb     0x564
     500:	20 64 72             	and    BYTE PTR [si+0x72],ah
     503:	69 76 65 2e 2e       	imul   si,WORD PTR [bp+0x65],0x2e2e
     508:	2e 0a 0d             	or     cl,BYTE PTR cs:[di]
     50b:	00 45 3a             	add    BYTE PTR [di+0x3a],al
     50e:	20 53 6f             	and    BYTE PTR [bp+di+0x6f],dl
     511:	6d                   	ins    WORD PTR es:[di],dx
     512:	65 74 68             	gs je  0x57d
     515:	69 6e 67 20 68       	imul   bp,WORD PTR [bp+0x67],0x6820
     51a:	61                   	popa
     51b:	70 70                	jo     0x58d
     51d:	65 6e                	outs   dx,BYTE PTR gs:[si]
     51f:	65 64 2e 20 50 6c    	gs fs and BYTE PTR cs:[bx+si+0x6c],dl
     525:	65 61                	gs popa
     527:	73 65                	jae    0x58e
     529:	20 63 68             	and    BYTE PTR [bp+di+0x68],ah
     52c:	65 63 6b 20          	arpl   WORD PTR gs:[bp+di+0x20],bp
     530:	64 72 69             	fs jb  0x59c
     533:	76 65                	jbe    0x59a
     535:	20 73 74             	and    BYTE PTR [bp+di+0x74],dh
     538:	61                   	popa
     539:	74 65                	je     0x5a0
     53b:	2e 0a 0d             	or     cl,BYTE PTR cs:[di]
     53e:	00 46 61             	add    BYTE PTR [bp+0x61],al
     541:	6c                   	ins    BYTE PTR es:[di],dx
     542:	6c                   	ins    BYTE PTR es:[di],dx
     543:	69 6e 67 20 62       	imul   bp,WORD PTR [bp+0x67],0x6220
     548:	61                   	popa
     549:	63 6b 20             	arpl   WORD PTR [bp+di+0x20],bp
     54c:	74 6f                	je     0x5bd
     54e:	20 6c 65             	and    BYTE PTR [si+0x65],ch
     551:	67 61                	addr32 popa
     553:	63 79 20             	arpl   WORD PTR [bx+di+0x20],di
     556:	6d                   	ins    WORD PTR es:[di],dx
     557:	65 6d                	gs ins WORD PTR es:[di],dx
     559:	6f                   	outs   dx,WORD PTR ds:[si]
     55a:	72 79                	jb     0x5d5
     55c:	20 64 65             	and    BYTE PTR [si+0x65],ah
     55f:	74 65                	je     0x5c6
     561:	63 74 69             	arpl   WORD PTR [si+0x69],si
     564:	6f                   	outs   dx,WORD PTR ds:[si]
     565:	6e                   	outs   dx,BYTE PTR ds:[si]
     566:	2e 2e 2e 0a 0d       	cs cs or cl,BYTE PTR cs:[di]
     56b:	00 45 3a             	add    BYTE PTR [di+0x3a],al
     56e:	20 66 61             	and    BYTE PTR [bp+0x61],ah
     571:	69 6c 65 64 20       	imul   bp,WORD PTR [si+0x65],0x2064
     576:	74 6f                	je     0x5e7
     578:	20 67 65             	and    BYTE PTR [bx+0x65],ah
     57b:	74 20                	je     0x59d
     57d:	6d                   	ins    WORD PTR es:[di],dx
     57e:	65 6d                	gs ins WORD PTR es:[di],dx
     580:	6f                   	outs   dx,WORD PTR ds:[si]
     581:	72 79                	jb     0x5fc
     583:	20 73 69             	and    BYTE PTR [bp+di+0x69],dh
     586:	7a 65                	jp     0x5ed
     588:	20 28                	and    BYTE PTR [bx+si],ch
     58a:	63 6f 6e             	arpl   WORD PTR [bx+0x6e],bp
     58d:	73 69                	jae    0x5f8
     58f:	64 65 72 20          	fs gs jb 0x5b3
     593:	75 70                	jne    0x605
     595:	67 72 61             	addr32 jb 0x5f9
     598:	64 69 6e 67 20 79    	imul   bp,WORD PTR fs:[bp+0x67],0x7920
     59e:	6f                   	outs   dx,WORD PTR ds:[si]
     59f:	75 72                	jne    0x613
     5a1:	20 64 65             	and    BYTE PTR [si+0x65],ah
     5a4:	76 69                	jbe    0x60f
     5a6:	63 65 20             	arpl   WORD PTR [di+0x20],sp
     5a9:	70 61                	jo     0x60c
     5ab:	73 74                	jae    0x621
     5ad:	20 31                	and    BYTE PTR [bx+di],dh
     5af:	39 39                	cmp    WORD PTR [bx+di],di
     5b1:	34 29                	xor    al,0x29
     5b3:	0a 0d                	or     cl,BYTE PTR [di]
     5b5:	00 57 3a             	add    BYTE PTR [bx+0x3a],dl
     5b8:	20 42 49             	and    BYTE PTR [bp+si+0x49],al
     5bb:	4f                   	dec    di
     5bc:	53                   	push   bx
     5bd:	20 6d 61             	and    BYTE PTR [di+0x61],ch
     5c0:	79 20                	jns    0x5e2
     5c2:	62 65 20             	bound  sp,DWORD PTR [di+0x20]
     5c5:	63 6f 72             	arpl   WORD PTR [bx+0x72],bp
     5c8:	72 75                	jb     0x63f
     5ca:	70 74                	jo     0x640
     5cc:	2c 20                	sub    al,0x20
     5ce:	64 65 63 69 64       	fs arpl WORD PTR gs:[bx+di+0x64],bp
     5d3:	69 6e 67 20 74       	imul   bp,WORD PTR [bp+0x67],0x7420
     5d8:	68 69 73             	push   0x7369
     5db:	20 69 73             	and    BYTE PTR [bx+di+0x73],ch
     5de:	20 65 6e             	and    BYTE PTR [di+0x6e],ah
     5e1:	6f                   	outs   dx,WORD PTR ds:[si]
     5e2:	75 67                	jne    0x64b
     5e4:	68 20 65             	push   0x6520
     5e7:	6e                   	outs   dx,BYTE PTR ds:[si]
     5e8:	6f                   	outs   dx,WORD PTR ds:[si]
     5e9:	75 67                	jne    0x652
     5eb:	68 20 6d             	push   0x6d20
     5ee:	65 6d                	gs ins WORD PTR es:[di],dx
     5f0:	6f                   	outs   dx,WORD PTR ds:[si]
     5f1:	72 79                	jb     0x66c
     5f3:	20 74 6f             	and    BYTE PTR [si+0x6f],dh
     5f6:	20 6d 61             	and    BYTE PTR [di+0x61],ch
     5f9:	70 2e                	jo     0x629
     5fb:	2e 2e 0a 0d          	cs or  cl,BYTE PTR cs:[di]
     5ff:	00 45 3a             	add    BYTE PTR [di+0x3a],al
     602:	20 43 6f             	and    BYTE PTR [bp+di+0x6f],al
     605:	75 6c                	jne    0x673
     607:	64 20 6e 6f          	and    BYTE PTR fs:[bp+0x6f],ch
     60b:	74 20                	je     0x62d
     60d:	75 73                	jne    0x682
     60f:	65 20 4c 42          	and    BYTE PTR gs:[si+0x42],cl
     613:	41                   	inc    cx
     614:	20 72 65             	and    BYTE PTR [bp+si+0x65],dh
     617:	61                   	popa
     618:	64 69 6e 67 2c 20    	imul   bp,WORD PTR fs:[bp+0x67],0x202c
     61e:	71 75                	jno    0x695
     620:	69 74 74 69 6e       	imul   si,WORD PTR [si+0x74],0x6e69
     625:	67 21 20             	and    WORD PTR [eax],sp
     628:	28 67 65             	sub    BYTE PTR [bx+0x65],ah
     62b:	74 20                	je     0x64d
     62d:	61                   	popa
     62e:	20 50 43             	and    BYTE PTR [bx+si+0x43],dl
     631:	20 66 72             	and    BYTE PTR [bp+0x72],ah
     634:	6f                   	outs   dx,WORD PTR ds:[si]
     635:	6d                   	ins    WORD PTR es:[di],dx
     636:	20 74 68             	and    BYTE PTR [si+0x68],dh
     639:	69 73 20 6d 69       	imul   si,WORD PTR [bp+di+0x20],0x696d
     63e:	6c                   	ins    BYTE PTR es:[di],dx
     63f:	6c                   	ins    BYTE PTR es:[di],dx
     640:	65 6e                	outs   dx,BYTE PTR gs:[si]
     642:	69 75 6d 2c 20       	imul   si,WORD PTR [di+0x6d],0x202c
     647:	61                   	popa
     648:	73 73                	jae    0x6bd
     64a:	68 6f 6c             	push   0x6c6f
     64d:	65 29 0a             	sub    WORD PTR gs:[bp+si],cx
     650:	0d 00 49             	or     ax,0x4900
     653:	3a 20                	cmp    ah,BYTE PTR [bx+si]
     655:	41                   	inc    cx
     656:	32 30                	xor    dh,BYTE PTR [bx+si]
     658:	20 70 72             	and    BYTE PTR [bx+si+0x72],dh
     65b:	65 2d 65 6e          	gs sub ax,0x6e65
     65f:	61                   	popa
     660:	62 6c 65             	bound  bp,DWORD PTR [si+0x65]
     663:	64 21 20             	and    WORD PTR fs:[bx+si],sp
     666:	28 54 68             	sub    BYTE PTR [si+0x68],dl
     669:	69 73 20 4f 53       	imul   si,WORD PTR [bp+di+0x20],0x534f
     66e:	20 6d 61             	and    BYTE PTR [di+0x61],ch
     671:	79 20                	jns    0x693
     673:	62 65 20             	bound  sp,DWORD PTR [di+0x20]
     676:	6f                   	outs   dx,WORD PTR ds:[si]
     677:	6e                   	outs   dx,BYTE PTR ds:[si]
     678:	20 61 6e             	and    BYTE PTR [bx+di+0x6e],ah
     67b:	20 65 6d             	and    BYTE PTR [di+0x6d],ah
     67e:	75 6c                	jne    0x6ec
     680:	61                   	popa
     681:	74 6f                	je     0x6f2
     683:	72 21                	jb     0x6a6
     685:	29 0a                	sub    WORD PTR [bp+si],cx
     687:	0d 00 45             	or     ax,0x4500
     68a:	6e                   	outs   dx,BYTE PTR ds:[si]
     68b:	61                   	popa
     68c:	62 6c 69             	bound  bp,DWORD PTR [si+0x69]
     68f:	6e                   	outs   dx,BYTE PTR ds:[si]
     690:	67 20 41 32          	and    BYTE PTR [ecx+0x32],al
     694:	30 21                	xor    BYTE PTR [bx+di],ah
     696:	0a 0d                	or     cl,BYTE PTR [di]
     698:	00 45 3a             	add    BYTE PTR [di+0x3a],al
     69b:	20 49 20             	and    BYTE PTR [bx+di+0x20],cl
     69e:	64 6f                	outs   dx,WORD PTR fs:[si]
     6a0:	6e                   	outs   dx,BYTE PTR ds:[si]
     6a1:	27                   	daa
     6a2:	74 20                	je     0x6c4
     6a4:	65 76 65             	gs jbe 0x70c
     6a7:	6e                   	outs   dx,BYTE PTR ds:[si]
     6a8:	20 6b 6e             	and    BYTE PTR [bp+di+0x6e],ch
     6ab:	6f                   	outs   dx,WORD PTR ds:[si]
     6ac:	77 20                	ja     0x6ce
     6ae:	68 6f 77             	push   0x776f
     6b1:	20 74 68             	and    BYTE PTR [si+0x68],dh
     6b4:	69 73 20 68 61       	imul   si,WORD PTR [bp+di+0x20],0x6168
     6b9:	70 70                	jo     0x72b
     6bb:	65 6e                	outs   dx,BYTE PTR gs:[si]
     6bd:	73 20                	jae    0x6df
     6bf:	62 75 74             	bound  si,DWORD PTR [di+0x74]
     6c2:	20 79 6f             	and    BYTE PTR [bx+di+0x6f],bh
     6c5:	75 72                	jne    0x739
     6c7:	20 6d 65             	and    BYTE PTR [di+0x65],ch
     6ca:	6d                   	ins    WORD PTR es:[di],dx
     6cb:	6f                   	outs   dx,WORD PTR ds:[si]
     6cc:	72 79                	jb     0x747
     6ce:	20 69 73             	and    BYTE PTR [bx+di+0x73],ch
     6d1:	20 6a 75             	and    BYTE PTR [bp+si+0x75],ch
     6d4:	73 74                	jae    0x74a
     6d6:	20 66 75             	and    BYTE PTR [bp+0x75],ah
     6d9:	63 6b 65             	arpl   WORD PTR [bp+di+0x65],bp
     6dc:	64 2e 0a 0d          	fs or  cl,BYTE PTR cs:[di]
     6e0:	00 45 3a             	add    BYTE PTR [di+0x3a],al
     6e3:	20 64 61             	and    BYTE PTR [si+0x61],ah
     6e6:	77 67                	ja     0x74f
     6e8:	20 79 6f             	and    BYTE PTR [bx+di+0x6f],bh
     6eb:	75 20                	jne    0x70d
     6ed:	63 61 6e             	arpl   WORD PTR [bx+di+0x6e],sp
     6f0:	27                   	daa
     6f1:	74 20                	je     0x713
     6f3:	65 76 65             	gs jbe 0x75b
     6f6:	6e                   	outs   dx,BYTE PTR ds:[si]
     6f7:	20 61 63             	and    BYTE PTR [bx+di+0x63],ah
     6fa:	63 65 73             	arpl   WORD PTR [di+0x73],sp
     6fd:	73 20                	jae    0x71f
     6ff:	41                   	inc    cx
     700:	32 30                	xor    dh,BYTE PTR [bx+si]
     702:	20 6f 6e             	and    BYTE PTR [bx+0x6e],ch
     705:	20 74 68             	and    BYTE PTR [si+0x68],dh
     708:	69 73 20 73 68       	imul   si,WORD PTR [bp+di+0x20],0x6873
     70d:	69 74 20 6b 65       	imul   si,WORD PTR [si+0x20],0x656b
     712:	6b 0a 0d             	imul   cx,WORD PTR [bp+si],0xd
     715:	00 10                	add    BYTE PTR [bx+si],dl
     717:	00 24                	add    BYTE PTR [si],ah
     719:	00 00                	add    BYTE PTR [bx+si],al
     71b:	80 00 00             	add    BYTE PTR [bx+si],0x0
     71e:	12 00                	adc    al,BYTE PTR [bx+si]
	...
     72c:	00 00                	add    BYTE PTR [bx+si],al
     72e:	ff                   	(bad)
     72f:	ff 00                	inc    WORD PTR [bx+si]
     731:	00 00                	add    BYTE PTR [bx+si],al
     733:	9a cf 00 ff ff       	call   0xffff:0xcf
     738:	00 00                	add    BYTE PTR [bx+si],al
     73a:	00 92 cf 00          	add    BYTE PTR [bp+si+0xcf],dl
     73e:	17                   	pop    ss
     73f:	00 26 15 00          	add    BYTE PTR ds:0x15,ah
	...
     f43:	00 ff                	add    bh,bh
     f45:	07                   	pop    es
     f46:	44                   	inc    sp
     f47:	15 00 00             	adc    ax,0x0
	...
    23fe:	ab                   	stos   WORD PTR es:[di],ax
    23ff:	ab                   	stos   WORD PTR es:[di],ax
    2400:	fa                   	cli
    2401:	fc                   	cld
    2402:	a3 4c 99             	mov    ds:0x994c,ax
    2405:	00 00                	add    BYTE PTR [bx+si],al
    2407:	89 1d                	mov    WORD PTR [di],bx
    2409:	50                   	push   ax
    240a:	99                   	cwd
    240b:	00 00                	add    BYTE PTR [bx+si],al
    240d:	81 e2 ff 00          	and    dx,0xff
    2411:	00 00                	add    BYTE PTR [bx+si],al
    2413:	89 15                	mov    WORD PTR [di],dx
    2415:	54                   	push   sp
    2416:	99                   	cwd
    2417:	00 00                	add    BYTE PTR [bx+si],al
    2419:	66 b8 10 00 8e d8    	mov    eax,0xd88e0010
    241f:	8e c0                	mov    es,ax
    2421:	8e e0                	mov    fs,ax
    2423:	8e e8                	mov    gs,ax
    2425:	8e d0                	mov    ss,ax
    2427:	bc ff ef             	mov    sp,0xefff
    242a:	00 00                	add    BYTE PTR [bx+si],al
    242c:	ff 35                	push   WORD PTR [di]
    242e:	54                   	push   sp
    242f:	99                   	cwd
    2430:	00 00                	add    BYTE PTR [bx+si],al
    2432:	ff 35                	push   WORD PTR [di]
    2434:	50                   	push   ax
    2435:	99                   	cwd
    2436:	00 00                	add    BYTE PTR [bx+si],al
    2438:	ff 35                	push   WORD PTR [di]
    243a:	4c                   	dec    sp
    243b:	99                   	cwd
    243c:	00 00                	add    BYTE PTR [bx+si],al
    243e:	e8 23 00             	call   0x2464
    2441:	00 00                	add    BYTE PTR [bx+si],al
    2443:	f4                   	hlt
    2444:	eb fd                	jmp    0x2443
    2446:	68 69 20             	push   0x2069
    2449:	68 69 20             	push   0x2069
    244c:	68 69 20             	push   0x2069
    244f:	68 69 20             	push   0x2069
    2452:	68 69 20             	push   0x2069
    2455:	68 69 20             	push   0x2069
    2458:	68 69 20             	push   0x2069
    245b:	68 69 20             	push   0x2069
    245e:	68 69 20             	push   0x2069
    2461:	68 69 0a             	push   0xa69
    2464:	0d 00 55             	or     ax,0x5500
    2467:	89 e5                	mov    bp,sp
    2469:	83 ec 18             	sub    sp,0x18
    246c:	c7 45 f0 00 80       	mov    WORD PTR [di-0x10],0x8000
    2471:	0b 00                	or     ax,WORD PTR [bx+si]
    2473:	c7 45 ec 44 94       	mov    WORD PTR [di-0x14],0x9444
    2478:	00 00                	add    BYTE PTR [bx+si],al
    247a:	66 c7 45 f6 00 00 eb 	mov    DWORD PTR [di-0xa],0x29eb0000
    2481:	29 
    2482:	0f b7 55 f6          	movzx  dx,WORD PTR [di-0xa]
    2486:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    2489:	01 d0                	add    ax,dx
    248b:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    248e:	66 98                	cwde
    2490:	80 cc 07             	or     ah,0x7
    2493:	89 c1                	mov    cx,ax
    2495:	0f b7 45 f6          	movzx  ax,WORD PTR [di-0xa]
    2499:	8d 14                	lea    dx,[si]
    249b:	00 8b 45 f0          	add    BYTE PTR [bp+di-0xfbb],cl
    249f:	01 d0                	add    ax,dx
    24a1:	89 ca                	mov    dx,cx
    24a3:	66 89 10             	mov    DWORD PTR [bx+si],edx
    24a6:	66 83 45 f6 01       	add    DWORD PTR [di-0xa],0x1
    24ab:	0f b7 55 f6          	movzx  dx,WORD PTR [di-0xa]
    24af:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    24b2:	01 d0                	add    ax,dx
    24b4:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    24b7:	84 c0                	test   al,al
    24b9:	75 c7                	jne    0x2482
    24bb:	81 7d 08 4e 45       	cmp    WORD PTR [di+0x8],0x454e
    24c0:	4b                   	dec    bx
    24c1:	4f                   	dec    di
    24c2:	0f 85 bc 00          	jne    0x2582
    24c6:	00 00                	add    BYTE PTR [bx+si],al
    24c8:	c7 45 ec 69 94       	mov    WORD PTR [di-0x14],0x9469
    24cd:	00 00                	add    BYTE PTR [bx+si],al
    24cf:	66 c7 45 f6 00 00 eb 	mov    DWORD PTR [di-0xa],0x29eb0000
    24d6:	29 
    24d7:	0f b7 55 f6          	movzx  dx,WORD PTR [di-0xa]
    24db:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    24de:	01 d0                	add    ax,dx
    24e0:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    24e3:	66 98                	cwde
    24e5:	80 cc 07             	or     ah,0x7
    24e8:	89 c1                	mov    cx,ax
    24ea:	0f b7 45 f6          	movzx  ax,WORD PTR [di-0xa]
    24ee:	8d 14                	lea    dx,[si]
    24f0:	00 8b 45 f0          	add    BYTE PTR [bp+di-0xfbb],cl
    24f4:	01 d0                	add    ax,dx
    24f6:	89 ca                	mov    dx,cx
    24f8:	66 89 10             	mov    DWORD PTR [bx+si],edx
    24fb:	66 83 45 f6 01       	add    DWORD PTR [di-0xa],0x1
    2500:	0f b7 55 f6          	movzx  dx,WORD PTR [di-0xa]
    2504:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    2507:	01 d0                	add    ax,dx
    2509:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    250c:	84 c0                	test   al,al
    250e:	75 c7                	jne    0x24d7
    2510:	e8 77 08             	call   0x2d8a
    2513:	00 00                	add    BYTE PTR [bx+si],al
    2515:	83 c0 30             	add    ax,0x30
    2518:	88 45 eb             	mov    BYTE PTR [di-0x15],al
    251b:	66 0f be 45 eb       	movsx  eax,BYTE PTR [di-0x15]
    2520:	80 cc 07             	or     ah,0x7
    2523:	89 c1                	mov    cx,ax
    2525:	0f b7 45 f6          	movzx  ax,WORD PTR [di-0xa]
    2529:	8d 50 01             	lea    dx,[bx+si+0x1]
    252c:	66 89 55 f6          	mov    DWORD PTR [di-0xa],edx
    2530:	0f b7 c0             	movzx  ax,ax
    2533:	8d 14                	lea    dx,[si]
    2535:	00 8b 45 f0          	add    BYTE PTR [bp+di-0xfbb],cl
    2539:	01 d0                	add    ax,dx
    253b:	89 ca                	mov    dx,cx
    253d:	66 89 10             	mov    DWORD PTR [bx+si],edx
    2540:	6a 03                	push   0x3
    2542:	6a 0f                	push   0xf
    2544:	68 7c 94             	push   0x947c
    2547:	00 00                	add    BYTE PTR [bx+si],al
    2549:	68 84 94             	push   0x9484
    254c:	00 00                	add    BYTE PTR [bx+si],al
    254e:	e8 9f 00             	call   0x25f0
    2551:	00 00                	add    BYTE PTR [bx+si],al
    2553:	83 c4 10             	add    sp,0x10
    2556:	e8 7e 06             	call   0x2bd7
    2559:	00 00                	add    BYTE PTR [bx+si],al
    255b:	83 ec 0c             	sub    sp,0xc
    255e:	68 a8 94             	push   0x94a8
    2561:	00 00                	add    BYTE PTR [bx+si],al
    2563:	e8 8a 00             	call   0x25f0
    2566:	00 00                	add    BYTE PTR [bx+si],al
    2568:	83 c4 10             	add    sp,0x10
    256b:	cd 00                	int    0x0
    256d:	83 ec 0c             	sub    sp,0xc
    2570:	68 c8 94             	push   0x94c8
    2573:	00 00                	add    BYTE PTR [bx+si],al
    2575:	e8 78 00             	call   0x25f0
    2578:	00 00                	add    BYTE PTR [bx+si],al
    257a:	83 c4 10             	add    sp,0x10
    257d:	e8 6a 00             	call   0x25ea
    2580:	00 00                	add    BYTE PTR [bx+si],al
    2582:	eb 65                	jmp    0x25e9
    2584:	81 7d 08 02 b0       	cmp    WORD PTR [di+0x8],0xb002
    2589:	ad                   	lods   ax,WORD PTR ds:[si]
    258a:	2b 74 5c             	sub    si,WORD PTR [si+0x5c]
    258d:	81 7d 08 89 62       	cmp    WORD PTR [di+0x8],0x6289
    2592:	d7                   	xlat   BYTE PTR ds:[bx]
    2593:	36 74 53             	ss je  0x25e9
    2596:	c7 45 ec 02 95       	mov    WORD PTR [di-0x14],0x9502
    259b:	00 00                	add    BYTE PTR [bx+si],al
    259d:	66 c7 45 f6 00 00 eb 	mov    DWORD PTR [di-0xa],0x2feb0000
    25a4:	2f 
    25a5:	0f b7 55 f6          	movzx  dx,WORD PTR [di-0xa]
    25a9:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    25ac:	01 d0                	add    ax,dx
    25ae:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    25b1:	66 98                	cwde
    25b3:	80 cc 0f             	or     ah,0xf
    25b6:	89 c1                	mov    cx,ax
    25b8:	0f b7 45 f6          	movzx  ax,WORD PTR [di-0xa]
    25bc:	8d 14                	lea    dx,[si]
    25be:	00 8b 45 f0          	add    BYTE PTR [bp+di-0xfbb],cl
    25c2:	01 d0                	add    ax,dx
    25c4:	89 ca                	mov    dx,cx
    25c6:	66 89 10             	mov    DWORD PTR [bx+si],edx
    25c9:	0f b7 45 f6          	movzx  ax,WORD PTR [di-0xa]
    25cd:	83 c0 01             	add    ax,0x1
    25d0:	66 89 45 f6          	mov    DWORD PTR [di-0xa],eax
    25d4:	0f b7 55 f6          	movzx  dx,WORD PTR [di-0xa]
    25d8:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    25db:	01 d0                	add    ax,dx
    25dd:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    25e0:	84 c0                	test   al,al
    25e2:	75 c1                	jne    0x25a5
    25e4:	e8 03 00             	call   0x25ea
    25e7:	00 00                	add    BYTE PTR [bx+si],al
    25e9:	90                   	nop
    25ea:	c9                   	leave
    25eb:	c3                   	ret
    25ec:	55                   	push   bp
    25ed:	89 e5                	mov    bp,sp
    25ef:	f4                   	hlt
    25f0:	eb fd                	jmp    0x25ef
    25f2:	55                   	push   bp
    25f3:	89 e5                	mov    bp,sp
    25f5:	53                   	push   bx
    25f6:	83 ec 54             	sub    sp,0x54
    25f9:	c7 45 f4 00 00       	mov    WORD PTR [di-0xc],0x0
    25fe:	00 00                	add    BYTE PTR [bx+si],al
    2600:	8d 45 0c             	lea    ax,[di+0xc]
    2603:	89 45 d8             	mov    WORD PTR [di-0x28],ax
    2606:	c7 45 f0 00 00       	mov    WORD PTR [di-0x10],0x0
    260b:	00 00                	add    BYTE PTR [bx+si],al
    260d:	c7 45 ec 00 00       	mov    WORD PTR [di-0x14],0x0
    2612:	00 00                	add    BYTE PTR [bx+si],al
    2614:	c7 45 e8 00 00       	mov    WORD PTR [di-0x18],0x0
    2619:	00 00                	add    BYTE PTR [bx+si],al
    261b:	eb 3b                	jmp    0x2658
    261d:	8b 55 e8             	mov    dx,WORD PTR [di-0x18]
    2620:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2623:	01 d0                	add    ax,dx
    2625:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2628:	3c 25                	cmp    al,0x25
    262a:	75 28                	jne    0x2654
    262c:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    262f:	8d 50 01             	lea    dx,[bx+si+0x1]
    2632:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2635:	01 d0                	add    ax,dx
    2637:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    263a:	84 c0                	test   al,al
    263c:	74 16                	je     0x2654
    263e:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    2641:	8d 50 01             	lea    dx,[bx+si+0x1]
    2644:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2647:	01 d0                	add    ax,dx
    2649:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    264c:	3c 25                	cmp    al,0x25
    264e:	74 04                	je     0x2654
    2650:	83 45 f0 01          	add    WORD PTR [di-0x10],0x1
    2654:	83 45 e8 01          	add    WORD PTR [di-0x18],0x1
    2658:	8b 55 e8             	mov    dx,WORD PTR [di-0x18]
    265b:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    265e:	01 d0                	add    ax,dx
    2660:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2663:	84 c0                	test   al,al
    2665:	75 b6                	jne    0x261d
    2667:	e9 e7 02             	jmp    0x2951
    266a:	00 00                	add    BYTE PTR [bx+si],al
    266c:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    266f:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    2672:	01 d0                	add    ax,dx
    2674:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2677:	3c 0a                	cmp    al,0xa
    2679:	75 1c                	jne    0x2697
    267b:	c7 05 5c 99          	mov    WORD PTR [di],0x995c
    267f:	00 00                	add    BYTE PTR [bx+si],al
    2681:	ff                   	(bad)
    2682:	ff                   	(bad)
    2683:	ff                   	(bad)
    2684:	ff a1 60 99          	jmp    WORD PTR [bx+di-0x66a0]
    2688:	00 00                	add    BYTE PTR [bx+si],al
    268a:	83 c0 01             	add    ax,0x1
    268d:	a3 60 99             	mov    ds:0x9960,ax
    2690:	00 00                	add    BYTE PTR [bx+si],al
    2692:	e9 76 02             	jmp    0x290b
    2695:	00 00                	add    BYTE PTR [bx+si],al
    2697:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    269a:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    269d:	01 d0                	add    ax,dx
    269f:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    26a2:	3c 09                	cmp    al,0x9
    26a4:	75 12                	jne    0x26b8
    26a6:	a1 5c 99             	mov    ax,ds:0x995c
    26a9:	00 00                	add    BYTE PTR [bx+si],al
    26ab:	83 c0 03             	add    ax,0x3
    26ae:	a3 5c 99             	mov    ds:0x995c,ax
    26b1:	00 00                	add    BYTE PTR [bx+si],al
    26b3:	e9 55 02             	jmp    0x290b
    26b6:	00 00                	add    BYTE PTR [bx+si],al
    26b8:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    26bb:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    26be:	01 d0                	add    ax,dx
    26c0:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    26c3:	3c 25                	cmp    al,0x25
    26c5:	0f 85 08 02          	jne    0x28d1
    26c9:	00 00                	add    BYTE PTR [bx+si],al
    26cb:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    26ce:	8d 50 01             	lea    dx,[bx+si+0x1]
    26d1:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    26d4:	01 d0                	add    ax,dx
    26d6:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    26d9:	3c 25                	cmp    al,0x25
    26db:	74 08                	je     0x26e5
    26dd:	8b 45 ec             	mov    ax,WORD PTR [di-0x14]
    26e0:	3b 45 f0             	cmp    ax,WORD PTR [di-0x10]
    26e3:	72 43                	jb     0x2728
    26e5:	83 45 f4 01          	add    WORD PTR [di-0xc],0x1
    26e9:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    26ec:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    26ef:	01 d0                	add    ax,dx
    26f1:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    26f4:	66 98                	cwde
    26f6:	80 cc 0f             	or     ah,0xf
    26f9:	89 c3                	mov    bx,ax
    26fb:	8b 0d                	mov    cx,WORD PTR [di]
    26fd:	40                   	inc    ax
    26fe:	95                   	xchg   bp,ax
    26ff:	00 00                	add    BYTE PTR [bx+si],al
    2701:	8b 15                	mov    dx,WORD PTR [di]
    2703:	60                   	pusha
    2704:	99                   	cwd
    2705:	00 00                	add    BYTE PTR [bx+si],al
    2707:	89 d0                	mov    ax,dx
    2709:	c1 e0 02             	shl    ax,0x2
    270c:	01 d0                	add    ax,dx
    270e:	c1 e0 04             	shl    ax,0x4
    2711:	89 c2                	mov    dx,ax
    2713:	a1 5c 99             	mov    ax,ds:0x995c
    2716:	00 00                	add    BYTE PTR [bx+si],al
    2718:	01 d0                	add    ax,dx
    271a:	01 c0                	add    ax,ax
    271c:	01 c8                	add    ax,cx
    271e:	89 da                	mov    dx,bx
    2720:	66 89 10             	mov    DWORD PTR [bx+si],edx
    2723:	e9 e5 01             	jmp    0x290b
    2726:	00 00                	add    BYTE PTR [bx+si],al
    2728:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    272b:	8d 50 01             	lea    dx,[bx+si+0x1]
    272e:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2731:	01 d0                	add    ax,dx
    2733:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2736:	3c 64                	cmp    al,0x64
    2738:	74 12                	je     0x274c
    273a:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    273d:	8d 50 01             	lea    dx,[bx+si+0x1]
    2740:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2743:	01 d0                	add    ax,dx
    2745:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2748:	3c 69                	cmp    al,0x69
    274a:	75 49                	jne    0x2795
    274c:	83 45 f4 01          	add    WORD PTR [di-0xc],0x1
    2750:	8b 45 d8             	mov    ax,WORD PTR [di-0x28]
    2753:	8d 50 04             	lea    dx,[bx+si+0x4]
    2756:	89 55 d8             	mov    WORD PTR [di-0x28],dx
    2759:	8b 00                	mov    ax,WORD PTR [bx+si]
    275b:	89 45 dc             	mov    WORD PTR [di-0x24],ax
    275e:	83 ec 08             	sub    sp,0x8
    2761:	8d 45 af             	lea    ax,[di-0x51]
    2764:	50                   	push   ax
    2765:	ff 75 dc             	push   WORD PTR [di-0x24]
    2768:	e8 00 02             	call   0x296b
    276b:	00 00                	add    BYTE PTR [bx+si],al
    276d:	83 c4 10             	add    sp,0x10
    2770:	83 ec 0c             	sub    sp,0xc
    2773:	8d 45 af             	lea    ax,[di-0x51]
    2776:	50                   	push   ax
    2777:	e8 76 fe             	call   0x25f0
    277a:	ff                   	(bad)
    277b:	ff 83 c4 10          	inc    WORD PTR [bp+di+0x10c4]
    277f:	a1 5c 99             	mov    ax,ds:0x995c
    2782:	00 00                	add    BYTE PTR [bx+si],al
    2784:	83 e8 01             	sub    ax,0x1
    2787:	a3 5c 99             	mov    ds:0x995c,ax
    278a:	00 00                	add    BYTE PTR [bx+si],al
    278c:	83 45 ec 01          	add    WORD PTR [di-0x14],0x1
    2790:	e9 78 01             	jmp    0x290b
    2793:	00 00                	add    BYTE PTR [bx+si],al
    2795:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    2798:	8d 50 01             	lea    dx,[bx+si+0x1]
    279b:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    279e:	01 d0                	add    ax,dx
    27a0:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    27a3:	3c 78                	cmp    al,0x78
    27a5:	74 16                	je     0x27bd
    27a7:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    27aa:	8d 50 01             	lea    dx,[bx+si+0x1]
    27ad:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    27b0:	01 d0                	add    ax,dx
    27b2:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    27b5:	3c 58                	cmp    al,0x58
    27b7:	0f 85 91 00          	jne    0x284c
    27bb:	00 00                	add    BYTE PTR [bx+si],al
    27bd:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    27c0:	8d 50 01             	lea    dx,[bx+si+0x1]
    27c3:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    27c6:	01 d0                	add    ax,dx
    27c8:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    27cb:	3c 78                	cmp    al,0x78
    27cd:	75 12                	jne    0x27e1
    27cf:	83 ec 0c             	sub    sp,0xc
    27d2:	68 17 95             	push   0x9517
    27d5:	00 00                	add    BYTE PTR [bx+si],al
    27d7:	e8 16 fe             	call   0x25f0
    27da:	ff                   	(bad)
    27db:	ff 83 c4 10          	inc    WORD PTR [bp+di+0x10c4]
    27df:	eb 10                	jmp    0x27f1
    27e1:	83 ec 0c             	sub    sp,0xc
    27e4:	68 1a 95             	push   0x951a
    27e7:	00 00                	add    BYTE PTR [bx+si],al
    27e9:	e8 04 fe             	call   0x25f0
    27ec:	ff                   	(bad)
    27ed:	ff 83 c4 10          	inc    WORD PTR [bp+di+0x10c4]
    27f1:	83 45 f4 01          	add    WORD PTR [di-0xc],0x1
    27f5:	8b 45 d8             	mov    ax,WORD PTR [di-0x28]
    27f8:	8d 50 04             	lea    dx,[bx+si+0x4]
    27fb:	89 55 d8             	mov    WORD PTR [di-0x28],dx
    27fe:	8b 00                	mov    ax,WORD PTR [bx+si]
    2800:	89 45 e0             	mov    WORD PTR [di-0x20],ax
    2803:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    2806:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    2809:	01 d0                	add    ax,dx
    280b:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    280e:	3c 78                	cmp    al,0x78
    2810:	0f 95 c0             	setne  al
    2813:	0f b6 c0             	movzx  ax,al
    2816:	83 ec 04             	sub    sp,0x4
    2819:	50                   	push   ax
    281a:	8d 45 cf             	lea    ax,[di-0x31]
    281d:	50                   	push   ax
    281e:	ff 75 e0             	push   WORD PTR [di-0x20]
    2821:	e8 19 03             	call   0x2b3d
    2824:	00 00                	add    BYTE PTR [bx+si],al
    2826:	83 c4 10             	add    sp,0x10
    2829:	83 ec 0c             	sub    sp,0xc
    282c:	8d 45 cf             	lea    ax,[di-0x31]
    282f:	50                   	push   ax
    2830:	e8 bd fd             	call   0x25f0
    2833:	ff                   	(bad)
    2834:	ff 83 c4 10          	inc    WORD PTR [bp+di+0x10c4]
    2838:	a1 5c 99             	mov    ax,ds:0x995c
    283b:	00 00                	add    BYTE PTR [bx+si],al
    283d:	83 e8 01             	sub    ax,0x1
    2840:	a3 5c 99             	mov    ds:0x995c,ax
    2843:	00 00                	add    BYTE PTR [bx+si],al
    2845:	83 45 ec 01          	add    WORD PTR [di-0x14],0x1
    2849:	e9 bf 00             	jmp    0x290b
    284c:	00 00                	add    BYTE PTR [bx+si],al
    284e:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    2851:	8d 50 01             	lea    dx,[bx+si+0x1]
    2854:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2857:	01 d0                	add    ax,dx
    2859:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    285c:	3c 73                	cmp    al,0x73
    285e:	75 33                	jne    0x2893
    2860:	83 45 f4 01          	add    WORD PTR [di-0xc],0x1
    2864:	8b 45 d8             	mov    ax,WORD PTR [di-0x28]
    2867:	8d 50 04             	lea    dx,[bx+si+0x4]
    286a:	89 55 d8             	mov    WORD PTR [di-0x28],dx
    286d:	8b 00                	mov    ax,WORD PTR [bx+si]
    286f:	89 45 e4             	mov    WORD PTR [di-0x1c],ax
    2872:	83 ec 0c             	sub    sp,0xc
    2875:	ff 75 e4             	push   WORD PTR [di-0x1c]
    2878:	e8 75 fd             	call   0x25f0
    287b:	ff                   	(bad)
    287c:	ff 83 c4 10          	inc    WORD PTR [bp+di+0x10c4]
    2880:	a1 5c 99             	mov    ax,ds:0x995c
    2883:	00 00                	add    BYTE PTR [bx+si],al
    2885:	83 e8 01             	sub    ax,0x1
    2888:	a3 5c 99             	mov    ds:0x995c,ax
    288b:	00 00                	add    BYTE PTR [bx+si],al
    288d:	83 45 ec 01          	add    WORD PTR [di-0x14],0x1
    2891:	eb 7a                	jmp    0x290d
    2893:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    2896:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    2899:	01 d0                	add    ax,dx
    289b:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    289e:	66 98                	cwde
    28a0:	80 cc 0f             	or     ah,0xf
    28a3:	89 c3                	mov    bx,ax
    28a5:	8b 0d                	mov    cx,WORD PTR [di]
    28a7:	40                   	inc    ax
    28a8:	95                   	xchg   bp,ax
    28a9:	00 00                	add    BYTE PTR [bx+si],al
    28ab:	8b 15                	mov    dx,WORD PTR [di]
    28ad:	60                   	pusha
    28ae:	99                   	cwd
    28af:	00 00                	add    BYTE PTR [bx+si],al
    28b1:	89 d0                	mov    ax,dx
    28b3:	c1 e0 02             	shl    ax,0x2
    28b6:	01 d0                	add    ax,dx
    28b8:	c1 e0 04             	shl    ax,0x4
    28bb:	89 c2                	mov    dx,ax
    28bd:	a1 5c 99             	mov    ax,ds:0x995c
    28c0:	00 00                	add    BYTE PTR [bx+si],al
    28c2:	01 d0                	add    ax,dx
    28c4:	01 c0                	add    ax,ax
    28c6:	01 c8                	add    ax,cx
    28c8:	89 da                	mov    dx,bx
    28ca:	66 89 10             	mov    DWORD PTR [bx+si],edx
    28cd:	83 45 ec 01          	add    WORD PTR [di-0x14],0x1
    28d1:	eb 3a                	jmp    0x290d
    28d3:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    28d6:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    28d9:	01 d0                	add    ax,dx
    28db:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    28de:	66 98                	cwde
    28e0:	80 cc 0f             	or     ah,0xf
    28e3:	89 c3                	mov    bx,ax
    28e5:	8b 0d                	mov    cx,WORD PTR [di]
    28e7:	40                   	inc    ax
    28e8:	95                   	xchg   bp,ax
    28e9:	00 00                	add    BYTE PTR [bx+si],al
    28eb:	8b 15                	mov    dx,WORD PTR [di]
    28ed:	60                   	pusha
    28ee:	99                   	cwd
    28ef:	00 00                	add    BYTE PTR [bx+si],al
    28f1:	89 d0                	mov    ax,dx
    28f3:	c1 e0 02             	shl    ax,0x2
    28f6:	01 d0                	add    ax,dx
    28f8:	c1 e0 04             	shl    ax,0x4
    28fb:	89 c2                	mov    dx,ax
    28fd:	a1 5c 99             	mov    ax,ds:0x995c
    2900:	00 00                	add    BYTE PTR [bx+si],al
    2902:	01 d0                	add    ax,dx
    2904:	01 c0                	add    ax,ax
    2906:	01 c8                	add    ax,cx
    2908:	89 da                	mov    dx,bx
    290a:	66 89 10             	mov    DWORD PTR [bx+si],edx
    290d:	a1 5c 99             	mov    ax,ds:0x995c
    2910:	00 00                	add    BYTE PTR [bx+si],al
    2912:	83 c0 01             	add    ax,0x1
    2915:	a3 5c 99             	mov    ds:0x995c,ax
    2918:	00 00                	add    BYTE PTR [bx+si],al
    291a:	a1 5c 99             	mov    ax,ds:0x995c
    291d:	00 00                	add    BYTE PTR [bx+si],al
    291f:	83 f8 50             	cmp    ax,0x50
    2922:	75 17                	jne    0x293b
    2924:	c7 05 5c 99          	mov    WORD PTR [di],0x995c
    2928:	00 00                	add    BYTE PTR [bx+si],al
    292a:	00 00                	add    BYTE PTR [bx+si],al
    292c:	00 00                	add    BYTE PTR [bx+si],al
    292e:	a1 60 99             	mov    ax,ds:0x9960
    2931:	00 00                	add    BYTE PTR [bx+si],al
    2933:	83 c0 01             	add    ax,0x1
    2936:	a3 60 99             	mov    ds:0x9960,ax
    2939:	00 00                	add    BYTE PTR [bx+si],al
    293b:	a1 60 99             	mov    ax,ds:0x9960
    293e:	00 00                	add    BYTE PTR [bx+si],al
    2940:	83 f8 19             	cmp    ax,0x19
    2943:	75 0a                	jne    0x294f
    2945:	c7 05 60 99          	mov    WORD PTR [di],0x9960
    2949:	00 00                	add    BYTE PTR [bx+si],al
    294b:	00 00                	add    BYTE PTR [bx+si],al
    294d:	00 00                	add    BYTE PTR [bx+si],al
    294f:	83 45 f4 01          	add    WORD PTR [di-0xc],0x1
    2953:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    2956:	8b 45 f4             	mov    ax,WORD PTR [di-0xc]
    2959:	01 d0                	add    ax,dx
    295b:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    295e:	84 c0                	test   al,al
    2960:	0f 85 06 fd          	jne    0x266a
    2964:	ff                   	(bad)
    2965:	ff 90 90 8b          	call   WORD PTR [bx+si-0x7470]
    2969:	5d                   	pop    bp
    296a:	fc                   	cld
    296b:	c9                   	leave
    296c:	c3                   	ret
    296d:	55                   	push   bp
    296e:	89 e5                	mov    bp,sp
    2970:	83 ec 30             	sub    sp,0x30
    2973:	83 7d 08 00          	cmp    WORD PTR [di+0x8],0x0
    2977:	75 17                	jne    0x2990
    2979:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    297c:	c6 00 30             	mov    BYTE PTR [bx+si],0x30
    297f:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2982:	83 c0 01             	add    ax,0x1
    2985:	c6 00 00             	mov    BYTE PTR [bx+si],0x0
    2988:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    298b:	e9 ad 01             	jmp    0x2b3b
    298e:	00 00                	add    BYTE PTR [bx+si],al
    2990:	81 7d 08 00 00       	cmp    WORD PTR [di+0x8],0x0
    2995:	00 80 75 4b          	add    BYTE PTR [bx+si+0x4b75],al
    2999:	c7 45 dc 1d 95       	mov    WORD PTR [di-0x24],0x951d
    299e:	00 00                	add    BYTE PTR [bx+si],al
    29a0:	c7 45 fc 00 00       	mov    WORD PTR [di-0x4],0x0
    29a5:	00 00                	add    BYTE PTR [bx+si],al
    29a7:	eb 19                	jmp    0x29c2
    29a9:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    29ac:	8b 45 dc             	mov    ax,WORD PTR [di-0x24]
    29af:	01 d0                	add    ax,dx
    29b1:	8b 4d fc             	mov    cx,WORD PTR [di-0x4]
    29b4:	8b 55 0c             	mov    dx,WORD PTR [di+0xc]
    29b7:	01 ca                	add    dx,cx
    29b9:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    29bc:	88 02                	mov    BYTE PTR [bp+si],al
    29be:	83 45 fc 01          	add    WORD PTR [di-0x4],0x1
    29c2:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    29c5:	8b 45 dc             	mov    ax,WORD PTR [di-0x24]
    29c8:	01 d0                	add    ax,dx
    29ca:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    29cd:	84 c0                	test   al,al
    29cf:	75 d8                	jne    0x29a9
    29d1:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    29d4:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    29d7:	01 d0                	add    ax,dx
    29d9:	c6 00 00             	mov    BYTE PTR [bx+si],0x0
    29dc:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    29df:	e9 59 01             	jmp    0x2b3b
    29e2:	00 00                	add    BYTE PTR [bx+si],al
    29e4:	83 7d 08 00          	cmp    WORD PTR [di+0x8],0x0
    29e8:	0f 9e c0             	setle  al
    29eb:	0f b6 c0             	movzx  ax,al
    29ee:	89 45 e8             	mov    WORD PTR [di-0x18],ax
    29f1:	83 7d e8 01          	cmp    WORD PTR [di-0x18],0x1
    29f5:	75 09                	jne    0x2a00
    29f7:	f7 5d 08             	neg    WORD PTR [di+0x8]
    29fa:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    29fd:	c6 00 2d             	mov    BYTE PTR [bx+si],0x2d
    2a00:	c7 45 f8 01 00       	mov    WORD PTR [di-0x8],0x1
    2a05:	00 00                	add    BYTE PTR [bx+si],al
    2a07:	c7 45 f4 01 00       	mov    WORD PTR [di-0xc],0x1
    2a0c:	00 00                	add    BYTE PTR [bx+si],al
    2a0e:	eb 13                	jmp    0x2a23
    2a10:	83 45 f8 01          	add    WORD PTR [di-0x8],0x1
    2a14:	8b 55 f4             	mov    dx,WORD PTR [di-0xc]
    2a17:	89 d0                	mov    ax,dx
    2a19:	c1 e0 02             	shl    ax,0x2
    2a1c:	01 d0                	add    ax,dx
    2a1e:	01 c0                	add    ax,ax
    2a20:	89 45 f4             	mov    WORD PTR [di-0xc],ax
    2a23:	8b 4d 08             	mov    cx,WORD PTR [di+0x8]
    2a26:	ba 67 66             	mov    dx,0x6667
    2a29:	66 66 89 c8          	data32 mov eax,ecx
    2a2d:	f7 ea                	imul   dx
    2a2f:	89 d0                	mov    ax,dx
    2a31:	c1 f8 02             	sar    ax,0x2
    2a34:	c1 f9 1f             	sar    cx,0x1f
    2a37:	89 ca                	mov    dx,cx
    2a39:	29 d0                	sub    ax,dx
    2a3b:	39 45 f4             	cmp    WORD PTR [di-0xc],ax
    2a3e:	7e d0                	jle    0x2a10
    2a40:	8b 45 f8             	mov    ax,WORD PTR [di-0x8]
    2a43:	89 45 e4             	mov    WORD PTR [di-0x1c],ax
    2a46:	c7 45 f0 00 00       	mov    WORD PTR [di-0x10],0x0
    2a4b:	00 00                	add    BYTE PTR [bx+si],al
    2a4d:	eb 5a                	jmp    0x2aa9
    2a4f:	8b 4d 08             	mov    cx,WORD PTR [di+0x8]
    2a52:	ba 67 66             	mov    dx,0x6667
    2a55:	66 66 89 c8          	data32 mov eax,ecx
    2a59:	f7 ea                	imul   dx
    2a5b:	c1 fa 02             	sar    dx,0x2
    2a5e:	89 c8                	mov    ax,cx
    2a60:	c1 f8 1f             	sar    ax,0x1f
    2a63:	29 c2                	sub    dx,ax
    2a65:	89 d0                	mov    ax,dx
    2a67:	c1 e0 02             	shl    ax,0x2
    2a6a:	01 d0                	add    ax,dx
    2a6c:	01 c0                	add    ax,ax
    2a6e:	29 c1                	sub    cx,ax
    2a70:	89 ca                	mov    dx,cx
    2a72:	89 d0                	mov    ax,dx
    2a74:	8d 48 30             	lea    cx,[bx+si+0x30]
    2a77:	8b 55 f0             	mov    dx,WORD PTR [di-0x10]
    2a7a:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    2a7d:	01 d0                	add    ax,dx
    2a7f:	89 c2                	mov    dx,ax
    2a81:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2a84:	01 d0                	add    ax,dx
    2a86:	89 ca                	mov    dx,cx
    2a88:	88 10                	mov    BYTE PTR [bx+si],dl
    2a8a:	8b 4d 08             	mov    cx,WORD PTR [di+0x8]
    2a8d:	ba 67 66             	mov    dx,0x6667
    2a90:	66 66 89 c8          	data32 mov eax,ecx
    2a94:	f7 ea                	imul   dx
    2a96:	89 d0                	mov    ax,dx
    2a98:	c1 f8 02             	sar    ax,0x2
    2a9b:	c1 f9 1f             	sar    cx,0x1f
    2a9e:	89 ca                	mov    dx,cx
    2aa0:	29 d0                	sub    ax,dx
    2aa2:	89 45 08             	mov    WORD PTR [di+0x8],ax
    2aa5:	83 45 f0 01          	add    WORD PTR [di-0x10],0x1
    2aa9:	8b 45 f0             	mov    ax,WORD PTR [di-0x10]
    2aac:	3b 45 e4             	cmp    ax,WORD PTR [di-0x1c]
    2aaf:	7c 9e                	jl     0x2a4f
    2ab1:	c7 45 ec 00 00       	mov    WORD PTR [di-0x14],0x0
    2ab6:	00 00                	add    BYTE PTR [bx+si],al
    2ab8:	eb 5d                	jmp    0x2b17
    2aba:	8b 55 ec             	mov    dx,WORD PTR [di-0x14]
    2abd:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    2ac0:	01 d0                	add    ax,dx
    2ac2:	89 c2                	mov    dx,ax
    2ac4:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2ac7:	01 d0                	add    ax,dx
    2ac9:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2acc:	88 45 e3             	mov    BYTE PTR [di-0x1d],al
    2acf:	8b 45 e4             	mov    ax,WORD PTR [di-0x1c]
    2ad2:	2b 45 ec             	sub    ax,WORD PTR [di-0x14]
    2ad5:	8d 50 ff             	lea    dx,[bx+si-0x1]
    2ad8:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    2adb:	01 d0                	add    ax,dx
    2add:	89 c2                	mov    dx,ax
    2adf:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2ae2:	01 d0                	add    ax,dx
    2ae4:	8b 4d ec             	mov    cx,WORD PTR [di-0x14]
    2ae7:	8b 55 e8             	mov    dx,WORD PTR [di-0x18]
    2aea:	01 ca                	add    dx,cx
    2aec:	89 d1                	mov    cx,dx
    2aee:	8b 55 0c             	mov    dx,WORD PTR [di+0xc]
    2af1:	01 ca                	add    dx,cx
    2af3:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2af6:	88 02                	mov    BYTE PTR [bp+si],al
    2af8:	8b 45 e4             	mov    ax,WORD PTR [di-0x1c]
    2afb:	2b 45 ec             	sub    ax,WORD PTR [di-0x14]
    2afe:	8d 50 ff             	lea    dx,[bx+si-0x1]
    2b01:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    2b04:	01 d0                	add    ax,dx
    2b06:	89 c2                	mov    dx,ax
    2b08:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2b0b:	01 c2                	add    dx,ax
    2b0d:	0f b6 45 e3          	movzx  ax,BYTE PTR [di-0x1d]
    2b11:	88 02                	mov    BYTE PTR [bp+si],al
    2b13:	83 45 ec 01          	add    WORD PTR [di-0x14],0x1
    2b17:	8b 45 e4             	mov    ax,WORD PTR [di-0x1c]
    2b1a:	89 c2                	mov    dx,ax
    2b1c:	c1 ea 1f             	shr    dx,0x1f
    2b1f:	01 d0                	add    ax,dx
    2b21:	d1 f8                	sar    ax,1
    2b23:	39 45 ec             	cmp    WORD PTR [di-0x14],ax
    2b26:	7c 92                	jl     0x2aba
    2b28:	8b 55 e4             	mov    dx,WORD PTR [di-0x1c]
    2b2b:	8b 45 e8             	mov    ax,WORD PTR [di-0x18]
    2b2e:	01 d0                	add    ax,dx
    2b30:	89 c2                	mov    dx,ax
    2b32:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2b35:	01 d0                	add    ax,dx
    2b37:	c6 00 00             	mov    BYTE PTR [bx+si],0x0
    2b3a:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2b3d:	c9                   	leave
    2b3e:	c3                   	ret
    2b3f:	55                   	push   bp
    2b40:	89 e5                	mov    bp,sp
    2b42:	83 ec 14             	sub    sp,0x14
    2b45:	8b 45 10             	mov    ax,WORD PTR [di+0x10]
    2b48:	88 45 ec             	mov    BYTE PTR [di-0x14],al
    2b4b:	c7 45 f4 00 00       	mov    WORD PTR [di-0xc],0x0
    2b50:	00 f0                	add    al,dh
    2b52:	c6 45 f3 00          	mov    BYTE PTR [di-0xd],0x0
    2b56:	c7 45 fc 00 00       	mov    WORD PTR [di-0x4],0x0
    2b5b:	00 00                	add    BYTE PTR [bx+si],al
    2b5d:	eb 56                	jmp    0x2bb5
    2b5f:	b8 07 00             	mov    ax,0x7
    2b62:	00 00                	add    BYTE PTR [bx+si],al
    2b64:	2b 45 fc             	sub    ax,WORD PTR [di-0x4]
    2b67:	c1 e0 02             	shl    ax,0x2
    2b6a:	8b 55 08             	mov    dx,WORD PTR [di+0x8]
    2b6d:	89 c1                	mov    cx,ax
    2b6f:	d3 fa                	sar    dx,cl
    2b71:	89 d0                	mov    ax,dx
    2b73:	83 e0 0f             	and    ax,0xf
    2b76:	88 45 f2             	mov    BYTE PTR [di-0xe],al
    2b79:	80 7d f2 09          	cmp    BYTE PTR [di-0xe],0x9
    2b7d:	77 0b                	ja     0x2b8a
    2b7f:	0f b6 45 f2          	movzx  ax,BYTE PTR [di-0xe]
    2b83:	83 c0 30             	add    ax,0x30
    2b86:	89 c1                	mov    cx,ax
    2b88:	eb 1d                	jmp    0x2ba7
    2b8a:	80 7d ec 00          	cmp    BYTE PTR [di-0x14],0x0
    2b8e:	74 07                	je     0x2b97
    2b90:	ba 41 00             	mov    dx,0x41
    2b93:	00 00                	add    BYTE PTR [bx+si],al
    2b95:	eb 05                	jmp    0x2b9c
    2b97:	ba 61 00             	mov    dx,0x61
    2b9a:	00 00                	add    BYTE PTR [bx+si],al
    2b9c:	0f b6 45 f2          	movzx  ax,BYTE PTR [di-0xe]
    2ba0:	01 d0                	add    ax,dx
    2ba2:	83 e8 0a             	sub    ax,0xa
    2ba5:	89 c1                	mov    cx,ax
    2ba7:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2baa:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2bad:	01 d0                	add    ax,dx
    2baf:	88 08                	mov    BYTE PTR [bx+si],cl
    2bb1:	83 45 fc 01          	add    WORD PTR [di-0x4],0x1
    2bb5:	83 7d fc 07          	cmp    WORD PTR [di-0x4],0x7
    2bb9:	7e a4                	jle    0x2b5f
    2bbb:	c6 45 fb 00          	mov    BYTE PTR [di-0x5],0x0
    2bbf:	eb 04                	jmp    0x2bc5
    2bc1:	c6 45 fb 01          	mov    BYTE PTR [di-0x5],0x1
    2bc5:	80 7d fb 01          	cmp    BYTE PTR [di-0x5],0x1
    2bc9:	75 f6                	jne    0x2bc1
    2bcb:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2bce:	83 c0 08             	add    ax,0x8
    2bd1:	c6 00 00             	mov    BYTE PTR [bx+si],0x0
    2bd4:	8b 45 0c             	mov    ax,WORD PTR [di+0xc]
    2bd7:	c9                   	leave
    2bd8:	c3                   	ret
    2bd9:	55                   	push   bp
    2bda:	89 e5                	mov    bp,sp
    2bdc:	83 ec 10             	sub    sp,0x10
    2bdf:	c7 45 fc 00 00       	mov    WORD PTR [di-0x4],0x0
    2be4:	00 00                	add    BYTE PTR [bx+si],al
    2be6:	e9 8c 00             	jmp    0x2c75
    2be9:	00 00                	add    BYTE PTR [bx+si],al
    2beb:	a1 48 95             	mov    ax,ds:0x9548
    2bee:	00 00                	add    BYTE PTR [bx+si],al
    2bf0:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2bf3:	c1 e2 02             	shl    dx,0x2
    2bf6:	01 d0                	add    ax,dx
    2bf8:	c7 00 74 89          	mov    WORD PTR [bx+si],0x8974
    2bfc:	00 00                	add    BYTE PTR [bx+si],al
    2bfe:	8b 45 fc             	mov    ax,WORD PTR [di-0x4]
    2c01:	8b 04                	mov    ax,WORD PTR [si]
    2c03:	85 4c 95             	test   WORD PTR [si-0x6b],cx
    2c06:	00 00                	add    BYTE PTR [bx+si],al
    2c08:	89 c1                	mov    cx,ax
    2c0a:	a1 44 95             	mov    ax,ds:0x9544
    2c0d:	00 00                	add    BYTE PTR [bx+si],al
    2c0f:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2c12:	c1 e2 03             	shl    dx,0x3
    2c15:	01 d0                	add    ax,dx
    2c17:	89 ca                	mov    dx,cx
    2c19:	66 89 10             	mov    DWORD PTR [bx+si],edx
    2c1c:	8b 45 fc             	mov    ax,WORD PTR [di-0x4]
    2c1f:	8b 04                	mov    ax,WORD PTR [si]
    2c21:	85 4c 95             	test   WORD PTR [si-0x6b],cx
    2c24:	00 00                	add    BYTE PTR [bx+si],al
    2c26:	c1 e8 10             	shr    ax,0x10
    2c29:	89 c1                	mov    cx,ax
    2c2b:	a1 44 95             	mov    ax,ds:0x9544
    2c2e:	00 00                	add    BYTE PTR [bx+si],al
    2c30:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2c33:	c1 e2 03             	shl    dx,0x3
    2c36:	01 d0                	add    ax,dx
    2c38:	89 ca                	mov    dx,cx
    2c3a:	66 89 50 06          	mov    DWORD PTR [bx+si+0x6],edx
    2c3e:	a1 44 95             	mov    ax,ds:0x9544
    2c41:	00 00                	add    BYTE PTR [bx+si],al
    2c43:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2c46:	c1 e2 03             	shl    dx,0x3
    2c49:	01 d0                	add    ax,dx
    2c4b:	66 c7 40 02 08 00 a1 	mov    DWORD PTR [bx+si+0x2],0x44a10008
    2c52:	44 
    2c53:	95                   	xchg   bp,ax
    2c54:	00 00                	add    BYTE PTR [bx+si],al
    2c56:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2c59:	c1 e2 03             	shl    dx,0x3
    2c5c:	01 d0                	add    ax,dx
    2c5e:	c6 40 04 00          	mov    BYTE PTR [bx+si+0x4],0x0
    2c62:	a1 44 95             	mov    ax,ds:0x9544
    2c65:	00 00                	add    BYTE PTR [bx+si],al
    2c67:	8b 55 fc             	mov    dx,WORD PTR [di-0x4]
    2c6a:	c1 e2 03             	shl    dx,0x3
    2c6d:	01 d0                	add    ax,dx
    2c6f:	c6 40 05 8e          	mov    BYTE PTR [bx+si+0x5],0x8e
    2c73:	83 45 fc 01          	add    WORD PTR [di-0x4],0x1
    2c77:	81 7d fc ff 00       	cmp    WORD PTR [di-0x4],0xff
    2c7c:	00 00                	add    BYTE PTR [bx+si],al
    2c7e:	0f 8e 67 ff          	jle    0x2be9
    2c82:	ff                   	(bad)
    2c83:	ff 66 c7             	jmp    WORD PTR [bp-0x39]
    2c86:	45                   	inc    bp
    2c87:	f6 ff                	idiv   bh
    2c89:	07                   	pop    es
    2c8a:	c7 45 f8 00 10       	mov    WORD PTR [di-0x8],0x1000
    2c8f:	00 00                	add    BYTE PTR [bx+si],al
    2c91:	0f 01 5d f6          	lidtw  [di-0xa]
    2c95:	90                   	nop
    2c96:	c9                   	leave
    2c97:	c3                   	ret
    2c98:	55                   	push   bp
    2c99:	89 e5                	mov    bp,sp
    2c9b:	83 ec 0c             	sub    sp,0xc
    2c9e:	8b 4d 08             	mov    cx,WORD PTR [di+0x8]
    2ca1:	8b 55 0c             	mov    dx,WORD PTR [di+0xc]
    2ca4:	8b 45 10             	mov    ax,WORD PTR [di+0x10]
    2ca7:	88 4d fc             	mov    BYTE PTR [di-0x4],cl
    2caa:	88 55 f8             	mov    BYTE PTR [di-0x8],dl
    2cad:	88 45 f4             	mov    BYTE PTR [di-0xc],al
    2cb0:	a1 48 95             	mov    ax,ds:0x9548
    2cb3:	00 00                	add    BYTE PTR [bx+si],al
    2cb5:	0f b6 55 fc          	movzx  dx,BYTE PTR [di-0x4]
    2cb9:	c1 e2 02             	shl    dx,0x2
    2cbc:	01 c2                	add    dx,ax
    2cbe:	8b 45 14             	mov    ax,WORD PTR [di+0x14]
    2cc1:	89 02                	mov    WORD PTR [bp+si],ax
    2cc3:	0f b6 45 fc          	movzx  ax,BYTE PTR [di-0x4]
    2cc7:	8b 04                	mov    ax,WORD PTR [si]
    2cc9:	85 4c 95             	test   WORD PTR [si-0x6b],cx
    2ccc:	00 00                	add    BYTE PTR [bx+si],al
    2cce:	89 c1                	mov    cx,ax
    2cd0:	a1 44 95             	mov    ax,ds:0x9544
    2cd3:	00 00                	add    BYTE PTR [bx+si],al
    2cd5:	0f b6 55 fc          	movzx  dx,BYTE PTR [di-0x4]
    2cd9:	c1 e2 03             	shl    dx,0x3
    2cdc:	01 d0                	add    ax,dx
    2cde:	89 ca                	mov    dx,cx
    2ce0:	66 89 10             	mov    DWORD PTR [bx+si],edx
    2ce3:	0f b6 45 fc          	movzx  ax,BYTE PTR [di-0x4]
    2ce7:	8b 04                	mov    ax,WORD PTR [si]
    2ce9:	85 4c 95             	test   WORD PTR [si-0x6b],cx
    2cec:	00 00                	add    BYTE PTR [bx+si],al
    2cee:	c1 e8 10             	shr    ax,0x10
    2cf1:	89 c1                	mov    cx,ax
    2cf3:	a1 44 95             	mov    ax,ds:0x9544
    2cf6:	00 00                	add    BYTE PTR [bx+si],al
    2cf8:	0f b6 55 fc          	movzx  dx,BYTE PTR [di-0x4]
    2cfc:	c1 e2 03             	shl    dx,0x3
    2cff:	01 d0                	add    ax,dx
    2d01:	89 ca                	mov    dx,cx
    2d03:	66 89 50 06          	mov    DWORD PTR [bx+si+0x6],edx
    2d07:	a1 44 95             	mov    ax,ds:0x9544
    2d0a:	00 00                	add    BYTE PTR [bx+si],al
    2d0c:	0f b6 55 fc          	movzx  dx,BYTE PTR [di-0x4]
    2d10:	c1 e2 03             	shl    dx,0x3
    2d13:	01 d0                	add    ax,dx
    2d15:	66 c7 40 02 08 00 a1 	mov    DWORD PTR [bx+si+0x2],0x44a10008
    2d1c:	44 
    2d1d:	95                   	xchg   bp,ax
    2d1e:	00 00                	add    BYTE PTR [bx+si],al
    2d20:	0f b6 55 fc          	movzx  dx,BYTE PTR [di-0x4]
    2d24:	c1 e2 03             	shl    dx,0x3
    2d27:	01 d0                	add    ax,dx
    2d29:	c6 40 04 00          	mov    BYTE PTR [bx+si+0x4],0x0
    2d2d:	0f b6 45 f4          	movzx  ax,BYTE PTR [di-0xc]
    2d31:	c1 e0 05             	shl    ax,0x5
    2d34:	0a 45 f8             	or     al,BYTE PTR [di-0x8]
    2d37:	89 c2                	mov    dx,ax
    2d39:	a1 44 95             	mov    ax,ds:0x9544
    2d3c:	00 00                	add    BYTE PTR [bx+si],al
    2d3e:	0f b6 4d fc          	movzx  cx,BYTE PTR [di-0x4]
    2d42:	c1 e1 03             	shl    cx,0x3
    2d45:	01 c8                	add    ax,cx
    2d47:	83 ca 80             	or     dx,0xff80
    2d4a:	88 50 05             	mov    BYTE PTR [bx+si+0x5],dl
    2d4d:	90                   	nop
    2d4e:	c9                   	leave
    2d4f:	c3                   	ret
    2d50:	55                   	push   bp
    2d51:	89 e5                	mov    bp,sp
    2d53:	83 ec 08             	sub    sp,0x8
    2d56:	a1 48 95             	mov    ax,ds:0x9548
    2d59:	00 00                	add    BYTE PTR [bx+si],al
    2d5b:	8b 55 2c             	mov    dx,WORD PTR [di+0x2c]
    2d5e:	c1 e2 02             	shl    dx,0x2
    2d61:	01 d0                	add    ax,dx
    2d63:	8b 00                	mov    ax,WORD PTR [bx+si]
    2d65:	8b 55 30             	mov    dx,WORD PTR [di+0x30]
    2d68:	83 ec 0c             	sub    sp,0xc
    2d6b:	52                   	push   dx
    2d6c:	ff d0                	call   ax
    2d6e:	83 c4 10             	add    sp,0x10
    2d71:	90                   	nop
    2d72:	c9                   	leave
    2d73:	c3                   	ret
    2d74:	55                   	push   bp
    2d75:	89 e5                	mov    bp,sp
    2d77:	83 ec 08             	sub    sp,0x8
    2d7a:	83 ec 0c             	sub    sp,0xc
    2d7d:	68 29 95             	push   0x9529
    2d80:	00 00                	add    BYTE PTR [bx+si],al
    2d82:	e8 6b f8             	call   0x25f0
    2d85:	ff                   	(bad)
    2d86:	ff 83 c4 10          	inc    WORD PTR [bp+di+0x10c4]
    2d8a:	eb fe                	jmp    0x2d8a
    2d8c:	55                   	push   bp
    2d8d:	89 e5                	mov    bp,sp
    2d8f:	b8 00 70             	mov    ax,0x7000
    2d92:	00 00                	add    BYTE PTR [bx+si],al
    2d94:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2d97:	5d                   	pop    bp
    2d98:	c3                   	ret
    2d99:	55                   	push   bp
    2d9a:	89 e5                	mov    bp,sp
    2d9c:	83 ec 04             	sub    sp,0x4
    2d9f:	8b 45 08             	mov    ax,WORD PTR [di+0x8]
    2da2:	88 45 fc             	mov    BYTE PTR [di-0x4],al
    2da5:	b8 00 70             	mov    ax,0x7000
    2da8:	00 00                	add    BYTE PTR [bx+si],al
    2daa:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2dad:	38 45 fc             	cmp    BYTE PTR [di-0x4],al
    2db0:	73 0c                	jae    0x2dbe
    2db2:	b8 00 70             	mov    ax,0x7000
    2db5:	00 00                	add    BYTE PTR [bx+si],al
    2db7:	0f b6 00             	movzx  ax,BYTE PTR [bx+si]
    2dba:	84 c0                	test   al,al
    2dbc:	75 07                	jne    0x2dc5
    2dbe:	b8 00 00             	mov    ax,0x0
    2dc1:	00 00                	add    BYTE PTR [bx+si],al
    2dc3:	eb 12                	jmp    0x2dd7
    2dc5:	0f b6 55 fc          	movzx  dx,BYTE PTR [di-0x4]
    2dc9:	89 d0                	mov    ax,dx
    2dcb:	01 c0                	add    ax,ax
    2dcd:	01 d0                	add    ax,dx
    2dcf:	c1 e0 03             	shl    ax,0x3
    2dd2:	05 04 70             	add    ax,0x7004
    2dd5:	00 00                	add    BYTE PTR [bx+si],al
    2dd7:	c9                   	leave
    2dd8:	c3                   	ret
    2dd9:	66 90                	xchg   eax,eax
    2ddb:	66 90                	xchg   eax,eax
    2ddd:	66 90                	xchg   eax,eax
    2ddf:	90                   	nop
    2de0:	60                   	pusha
    2de1:	66 8c d8             	mov    eax,ds
    2de4:	50                   	push   ax
    2de5:	66 b8 10 00 8e d8    	mov    eax,0xd88e0010
    2deb:	8e c0                	mov    es,ax
    2ded:	8e e0                	mov    fs,ax
    2def:	8e e8                	mov    gs,ax
    2df1:	e8 5a ff             	call   0x2d4e
    2df4:	ff                   	(bad)
    2df5:	ff 58 8e             	call   DWORD PTR [bx+si-0x72]
    2df8:	d8 8e c0 8e          	fmul   DWORD PTR [bp-0x7140]
    2dfc:	e0 8e                	loopne 0x2d8c
    2dfe:	e8 61 83             	call   0xb162
    2e01:	c4 08                	les    cx,DWORD PTR [bx+si]
    2e03:	cf                   	iret
    2e04:	fa                   	cli
    2e05:	6a 00                	push   0x0
    2e07:	6a 00                	push   0x0
    2e09:	eb d5                	jmp    0x2de0
    2e0b:	6a 00                	push   0x0
    2e0d:	6a 01                	push   0x1
    2e0f:	eb cf                	jmp    0x2de0
    2e11:	6a 00                	push   0x0
    2e13:	6a 02                	push   0x2
    2e15:	eb c9                	jmp    0x2de0
    2e17:	6a 00                	push   0x0
    2e19:	6a 03                	push   0x3
    2e1b:	eb c3                	jmp    0x2de0
    2e1d:	6a 00                	push   0x0
    2e1f:	6a 04                	push   0x4
    2e21:	eb bd                	jmp    0x2de0
    2e23:	6a 00                	push   0x0
    2e25:	6a 05                	push   0x5
    2e27:	eb b7                	jmp    0x2de0
    2e29:	6a 00                	push   0x0
    2e2b:	6a 06                	push   0x6
    2e2d:	eb b1                	jmp    0x2de0
    2e2f:	6a 00                	push   0x0
    2e31:	6a 07                	push   0x7
    2e33:	eb ab                	jmp    0x2de0
    2e35:	6a 08                	push   0x8
    2e37:	eb a7                	jmp    0x2de0
    2e39:	6a 00                	push   0x0
    2e3b:	6a 09                	push   0x9
    2e3d:	eb a1                	jmp    0x2de0
    2e3f:	6a 0a                	push   0xa
    2e41:	eb 9d                	jmp    0x2de0
    2e43:	6a 0b                	push   0xb
    2e45:	eb 99                	jmp    0x2de0
    2e47:	6a 0c                	push   0xc
    2e49:	eb 95                	jmp    0x2de0
    2e4b:	6a 0d                	push   0xd
    2e4d:	eb 91                	jmp    0x2de0
    2e4f:	6a 0e                	push   0xe
    2e51:	eb 8d                	jmp    0x2de0
    2e53:	6a 00                	push   0x0
    2e55:	6a 0f                	push   0xf
    2e57:	eb 87                	jmp    0x2de0
    2e59:	6a 00                	push   0x0
    2e5b:	6a 10                	push   0x10
    2e5d:	eb 81                	jmp    0x2de0
    2e5f:	6a 11                	push   0x11
    2e61:	e9 7a ff             	jmp    0x2dde
    2e64:	ff                   	(bad)
    2e65:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e68:	6a 12                	push   0x12
    2e6a:	e9 71 ff             	jmp    0x2dde
    2e6d:	ff                   	(bad)
    2e6e:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e71:	6a 13                	push   0x13
    2e73:	e9 68 ff             	jmp    0x2dde
    2e76:	ff                   	(bad)
    2e77:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e7a:	6a 14                	push   0x14
    2e7c:	e9 5f ff             	jmp    0x2dde
    2e7f:	ff                   	(bad)
    2e80:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e83:	6a 15                	push   0x15
    2e85:	e9 56 ff             	jmp    0x2dde
    2e88:	ff                   	(bad)
    2e89:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e8c:	6a 16                	push   0x16
    2e8e:	e9 4d ff             	jmp    0x2dde
    2e91:	ff                   	(bad)
    2e92:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e95:	6a 17                	push   0x17
    2e97:	e9 44 ff             	jmp    0x2dde
    2e9a:	ff                   	(bad)
    2e9b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2e9e:	6a 18                	push   0x18
    2ea0:	e9 3b ff             	jmp    0x2dde
    2ea3:	ff                   	(bad)
    2ea4:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ea7:	6a 19                	push   0x19
    2ea9:	e9 32 ff             	jmp    0x2dde
    2eac:	ff                   	(bad)
    2ead:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2eb0:	6a 1a                	push   0x1a
    2eb2:	e9 29 ff             	jmp    0x2dde
    2eb5:	ff                   	(bad)
    2eb6:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2eb9:	6a 1b                	push   0x1b
    2ebb:	e9 20 ff             	jmp    0x2dde
    2ebe:	ff                   	(bad)
    2ebf:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ec2:	6a 1c                	push   0x1c
    2ec4:	e9 17 ff             	jmp    0x2dde
    2ec7:	ff                   	(bad)
    2ec8:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ecb:	6a 1d                	push   0x1d
    2ecd:	e9 0e ff             	jmp    0x2dde
    2ed0:	ff                   	(bad)
    2ed1:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ed4:	6a 1e                	push   0x1e
    2ed6:	e9 05 ff             	jmp    0x2dde
    2ed9:	ff                   	(bad)
    2eda:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2edd:	6a 1f                	push   0x1f
    2edf:	e9 fc fe             	jmp    0x2dde
    2ee2:	ff                   	(bad)
    2ee3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ee6:	6a 20                	push   0x20
    2ee8:	e9 f3 fe             	jmp    0x2dde
    2eeb:	ff                   	(bad)
    2eec:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2eef:	6a 21                	push   0x21
    2ef1:	e9 ea fe             	jmp    0x2dde
    2ef4:	ff                   	(bad)
    2ef5:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ef8:	6a 22                	push   0x22
    2efa:	e9 e1 fe             	jmp    0x2dde
    2efd:	ff                   	(bad)
    2efe:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f01:	6a 23                	push   0x23
    2f03:	e9 d8 fe             	jmp    0x2dde
    2f06:	ff                   	(bad)
    2f07:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f0a:	6a 24                	push   0x24
    2f0c:	e9 cf fe             	jmp    0x2dde
    2f0f:	ff                   	(bad)
    2f10:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f13:	6a 25                	push   0x25
    2f15:	e9 c6 fe             	jmp    0x2dde
    2f18:	ff                   	(bad)
    2f19:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f1c:	6a 26                	push   0x26
    2f1e:	e9 bd fe             	jmp    0x2dde
    2f21:	ff                   	(bad)
    2f22:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f25:	6a 27                	push   0x27
    2f27:	e9 b4 fe             	jmp    0x2dde
    2f2a:	ff                   	(bad)
    2f2b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f2e:	6a 28                	push   0x28
    2f30:	e9 ab fe             	jmp    0x2dde
    2f33:	ff                   	(bad)
    2f34:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f37:	6a 29                	push   0x29
    2f39:	e9 a2 fe             	jmp    0x2dde
    2f3c:	ff                   	(bad)
    2f3d:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f40:	6a 2a                	push   0x2a
    2f42:	e9 99 fe             	jmp    0x2dde
    2f45:	ff                   	(bad)
    2f46:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f49:	6a 2b                	push   0x2b
    2f4b:	e9 90 fe             	jmp    0x2dde
    2f4e:	ff                   	(bad)
    2f4f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f52:	6a 2c                	push   0x2c
    2f54:	e9 87 fe             	jmp    0x2dde
    2f57:	ff                   	(bad)
    2f58:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f5b:	6a 2d                	push   0x2d
    2f5d:	e9 7e fe             	jmp    0x2dde
    2f60:	ff                   	(bad)
    2f61:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f64:	6a 2e                	push   0x2e
    2f66:	e9 75 fe             	jmp    0x2dde
    2f69:	ff                   	(bad)
    2f6a:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f6d:	6a 2f                	push   0x2f
    2f6f:	e9 6c fe             	jmp    0x2dde
    2f72:	ff                   	(bad)
    2f73:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f76:	6a 30                	push   0x30
    2f78:	e9 63 fe             	jmp    0x2dde
    2f7b:	ff                   	(bad)
    2f7c:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f7f:	6a 31                	push   0x31
    2f81:	e9 5a fe             	jmp    0x2dde
    2f84:	ff                   	(bad)
    2f85:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f88:	6a 32                	push   0x32
    2f8a:	e9 51 fe             	jmp    0x2dde
    2f8d:	ff                   	(bad)
    2f8e:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f91:	6a 33                	push   0x33
    2f93:	e9 48 fe             	jmp    0x2dde
    2f96:	ff                   	(bad)
    2f97:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2f9a:	6a 34                	push   0x34
    2f9c:	e9 3f fe             	jmp    0x2dde
    2f9f:	ff                   	(bad)
    2fa0:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fa3:	6a 35                	push   0x35
    2fa5:	e9 36 fe             	jmp    0x2dde
    2fa8:	ff                   	(bad)
    2fa9:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fac:	6a 36                	push   0x36
    2fae:	e9 2d fe             	jmp    0x2dde
    2fb1:	ff                   	(bad)
    2fb2:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fb5:	6a 37                	push   0x37
    2fb7:	e9 24 fe             	jmp    0x2dde
    2fba:	ff                   	(bad)
    2fbb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fbe:	6a 38                	push   0x38
    2fc0:	e9 1b fe             	jmp    0x2dde
    2fc3:	ff                   	(bad)
    2fc4:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fc7:	6a 39                	push   0x39
    2fc9:	e9 12 fe             	jmp    0x2dde
    2fcc:	ff                   	(bad)
    2fcd:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fd0:	6a 3a                	push   0x3a
    2fd2:	e9 09 fe             	jmp    0x2dde
    2fd5:	ff                   	(bad)
    2fd6:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fd9:	6a 3b                	push   0x3b
    2fdb:	e9 00 fe             	jmp    0x2dde
    2fde:	ff                   	(bad)
    2fdf:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2fe2:	6a 3c                	push   0x3c
    2fe4:	e9 f7 fd             	jmp    0x2dde
    2fe7:	ff                   	(bad)
    2fe8:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2feb:	6a 3d                	push   0x3d
    2fed:	e9 ee fd             	jmp    0x2dde
    2ff0:	ff                   	(bad)
    2ff1:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ff4:	6a 3e                	push   0x3e
    2ff6:	e9 e5 fd             	jmp    0x2dde
    2ff9:	ff                   	(bad)
    2ffa:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    2ffd:	6a 3f                	push   0x3f
    2fff:	e9 dc fd             	jmp    0x2dde
    3002:	ff                   	(bad)
    3003:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3006:	6a 40                	push   0x40
    3008:	e9 d3 fd             	jmp    0x2dde
    300b:	ff                   	(bad)
    300c:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    300f:	6a 41                	push   0x41
    3011:	e9 ca fd             	jmp    0x2dde
    3014:	ff                   	(bad)
    3015:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3018:	6a 42                	push   0x42
    301a:	e9 c1 fd             	jmp    0x2dde
    301d:	ff                   	(bad)
    301e:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3021:	6a 43                	push   0x43
    3023:	e9 b8 fd             	jmp    0x2dde
    3026:	ff                   	(bad)
    3027:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    302a:	6a 44                	push   0x44
    302c:	e9 af fd             	jmp    0x2dde
    302f:	ff                   	(bad)
    3030:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3033:	6a 45                	push   0x45
    3035:	e9 a6 fd             	jmp    0x2dde
    3038:	ff                   	(bad)
    3039:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    303c:	6a 46                	push   0x46
    303e:	e9 9d fd             	jmp    0x2dde
    3041:	ff                   	(bad)
    3042:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3045:	6a 47                	push   0x47
    3047:	e9 94 fd             	jmp    0x2dde
    304a:	ff                   	(bad)
    304b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    304e:	6a 48                	push   0x48
    3050:	e9 8b fd             	jmp    0x2dde
    3053:	ff                   	(bad)
    3054:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3057:	6a 49                	push   0x49
    3059:	e9 82 fd             	jmp    0x2dde
    305c:	ff                   	(bad)
    305d:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3060:	6a 4a                	push   0x4a
    3062:	e9 79 fd             	jmp    0x2dde
    3065:	ff                   	(bad)
    3066:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3069:	6a 4b                	push   0x4b
    306b:	e9 70 fd             	jmp    0x2dde
    306e:	ff                   	(bad)
    306f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3072:	6a 4c                	push   0x4c
    3074:	e9 67 fd             	jmp    0x2dde
    3077:	ff                   	(bad)
    3078:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    307b:	6a 4d                	push   0x4d
    307d:	e9 5e fd             	jmp    0x2dde
    3080:	ff                   	(bad)
    3081:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3084:	6a 4e                	push   0x4e
    3086:	e9 55 fd             	jmp    0x2dde
    3089:	ff                   	(bad)
    308a:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    308d:	6a 4f                	push   0x4f
    308f:	e9 4c fd             	jmp    0x2dde
    3092:	ff                   	(bad)
    3093:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3096:	6a 50                	push   0x50
    3098:	e9 43 fd             	jmp    0x2dde
    309b:	ff                   	(bad)
    309c:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    309f:	6a 51                	push   0x51
    30a1:	e9 3a fd             	jmp    0x2dde
    30a4:	ff                   	(bad)
    30a5:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30a8:	6a 52                	push   0x52
    30aa:	e9 31 fd             	jmp    0x2dde
    30ad:	ff                   	(bad)
    30ae:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30b1:	6a 53                	push   0x53
    30b3:	e9 28 fd             	jmp    0x2dde
    30b6:	ff                   	(bad)
    30b7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30ba:	6a 54                	push   0x54
    30bc:	e9 1f fd             	jmp    0x2dde
    30bf:	ff                   	(bad)
    30c0:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30c3:	6a 55                	push   0x55
    30c5:	e9 16 fd             	jmp    0x2dde
    30c8:	ff                   	(bad)
    30c9:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30cc:	6a 56                	push   0x56
    30ce:	e9 0d fd             	jmp    0x2dde
    30d1:	ff                   	(bad)
    30d2:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30d5:	6a 57                	push   0x57
    30d7:	e9 04 fd             	jmp    0x2dde
    30da:	ff                   	(bad)
    30db:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30de:	6a 58                	push   0x58
    30e0:	e9 fb fc             	jmp    0x2dde
    30e3:	ff                   	(bad)
    30e4:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30e7:	6a 59                	push   0x59
    30e9:	e9 f2 fc             	jmp    0x2dde
    30ec:	ff                   	(bad)
    30ed:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30f0:	6a 5a                	push   0x5a
    30f2:	e9 e9 fc             	jmp    0x2dde
    30f5:	ff                   	(bad)
    30f6:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    30f9:	6a 5b                	push   0x5b
    30fb:	e9 e0 fc             	jmp    0x2dde
    30fe:	ff                   	(bad)
    30ff:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3102:	6a 5c                	push   0x5c
    3104:	e9 d7 fc             	jmp    0x2dde
    3107:	ff                   	(bad)
    3108:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    310b:	6a 5d                	push   0x5d
    310d:	e9 ce fc             	jmp    0x2dde
    3110:	ff                   	(bad)
    3111:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3114:	6a 5e                	push   0x5e
    3116:	e9 c5 fc             	jmp    0x2dde
    3119:	ff                   	(bad)
    311a:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    311d:	6a 5f                	push   0x5f
    311f:	e9 bc fc             	jmp    0x2dde
    3122:	ff                   	(bad)
    3123:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3126:	6a 60                	push   0x60
    3128:	e9 b3 fc             	jmp    0x2dde
    312b:	ff                   	(bad)
    312c:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    312f:	6a 61                	push   0x61
    3131:	e9 aa fc             	jmp    0x2dde
    3134:	ff                   	(bad)
    3135:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3138:	6a 62                	push   0x62
    313a:	e9 a1 fc             	jmp    0x2dde
    313d:	ff                   	(bad)
    313e:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3141:	6a 63                	push   0x63
    3143:	e9 98 fc             	jmp    0x2dde
    3146:	ff                   	(bad)
    3147:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    314a:	6a 64                	push   0x64
    314c:	e9 8f fc             	jmp    0x2dde
    314f:	ff                   	(bad)
    3150:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3153:	6a 65                	push   0x65
    3155:	e9 86 fc             	jmp    0x2dde
    3158:	ff                   	(bad)
    3159:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    315c:	6a 66                	push   0x66
    315e:	e9 7d fc             	jmp    0x2dde
    3161:	ff                   	(bad)
    3162:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3165:	6a 67                	push   0x67
    3167:	e9 74 fc             	jmp    0x2dde
    316a:	ff                   	(bad)
    316b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    316e:	6a 68                	push   0x68
    3170:	e9 6b fc             	jmp    0x2dde
    3173:	ff                   	(bad)
    3174:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3177:	6a 69                	push   0x69
    3179:	e9 62 fc             	jmp    0x2dde
    317c:	ff                   	(bad)
    317d:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3180:	6a 6a                	push   0x6a
    3182:	e9 59 fc             	jmp    0x2dde
    3185:	ff                   	(bad)
    3186:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3189:	6a 6b                	push   0x6b
    318b:	e9 50 fc             	jmp    0x2dde
    318e:	ff                   	(bad)
    318f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3192:	6a 6c                	push   0x6c
    3194:	e9 47 fc             	jmp    0x2dde
    3197:	ff                   	(bad)
    3198:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    319b:	6a 6d                	push   0x6d
    319d:	e9 3e fc             	jmp    0x2dde
    31a0:	ff                   	(bad)
    31a1:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31a4:	6a 6e                	push   0x6e
    31a6:	e9 35 fc             	jmp    0x2dde
    31a9:	ff                   	(bad)
    31aa:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31ad:	6a 6f                	push   0x6f
    31af:	e9 2c fc             	jmp    0x2dde
    31b2:	ff                   	(bad)
    31b3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31b6:	6a 70                	push   0x70
    31b8:	e9 23 fc             	jmp    0x2dde
    31bb:	ff                   	(bad)
    31bc:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31bf:	6a 71                	push   0x71
    31c1:	e9 1a fc             	jmp    0x2dde
    31c4:	ff                   	(bad)
    31c5:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31c8:	6a 72                	push   0x72
    31ca:	e9 11 fc             	jmp    0x2dde
    31cd:	ff                   	(bad)
    31ce:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31d1:	6a 73                	push   0x73
    31d3:	e9 08 fc             	jmp    0x2dde
    31d6:	ff                   	(bad)
    31d7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31da:	6a 74                	push   0x74
    31dc:	e9 ff fb             	jmp    0x2dde
    31df:	ff                   	(bad)
    31e0:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31e3:	6a 75                	push   0x75
    31e5:	e9 f6 fb             	jmp    0x2dde
    31e8:	ff                   	(bad)
    31e9:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31ec:	6a 76                	push   0x76
    31ee:	e9 ed fb             	jmp    0x2dde
    31f1:	ff                   	(bad)
    31f2:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31f5:	6a 77                	push   0x77
    31f7:	e9 e4 fb             	jmp    0x2dde
    31fa:	ff                   	(bad)
    31fb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    31fe:	6a 78                	push   0x78
    3200:	e9 db fb             	jmp    0x2dde
    3203:	ff                   	(bad)
    3204:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3207:	6a 79                	push   0x79
    3209:	e9 d2 fb             	jmp    0x2dde
    320c:	ff                   	(bad)
    320d:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3210:	6a 7a                	push   0x7a
    3212:	e9 c9 fb             	jmp    0x2dde
    3215:	ff                   	(bad)
    3216:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3219:	6a 7b                	push   0x7b
    321b:	e9 c0 fb             	jmp    0x2dde
    321e:	ff                   	(bad)
    321f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3222:	6a 7c                	push   0x7c
    3224:	e9 b7 fb             	jmp    0x2dde
    3227:	ff                   	(bad)
    3228:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    322b:	6a 7d                	push   0x7d
    322d:	e9 ae fb             	jmp    0x2dde
    3230:	ff                   	(bad)
    3231:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3234:	6a 7e                	push   0x7e
    3236:	e9 a5 fb             	jmp    0x2dde
    3239:	ff                   	(bad)
    323a:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    323d:	6a 7f                	push   0x7f
    323f:	e9 9c fb             	jmp    0x2dde
    3242:	ff                   	(bad)
    3243:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3246:	68 80 00             	push   0x80
    3249:	00 00                	add    BYTE PTR [bx+si],al
    324b:	e9 90 fb             	jmp    0x2dde
    324e:	ff                   	(bad)
    324f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3252:	68 81 00             	push   0x81
    3255:	00 00                	add    BYTE PTR [bx+si],al
    3257:	e9 84 fb             	jmp    0x2dde
    325a:	ff                   	(bad)
    325b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    325e:	68 82 00             	push   0x82
    3261:	00 00                	add    BYTE PTR [bx+si],al
    3263:	e9 78 fb             	jmp    0x2dde
    3266:	ff                   	(bad)
    3267:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    326a:	68 83 00             	push   0x83
    326d:	00 00                	add    BYTE PTR [bx+si],al
    326f:	e9 6c fb             	jmp    0x2dde
    3272:	ff                   	(bad)
    3273:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3276:	68 84 00             	push   0x84
    3279:	00 00                	add    BYTE PTR [bx+si],al
    327b:	e9 60 fb             	jmp    0x2dde
    327e:	ff                   	(bad)
    327f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3282:	68 85 00             	push   0x85
    3285:	00 00                	add    BYTE PTR [bx+si],al
    3287:	e9 54 fb             	jmp    0x2dde
    328a:	ff                   	(bad)
    328b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    328e:	68 86 00             	push   0x86
    3291:	00 00                	add    BYTE PTR [bx+si],al
    3293:	e9 48 fb             	jmp    0x2dde
    3296:	ff                   	(bad)
    3297:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    329a:	68 87 00             	push   0x87
    329d:	00 00                	add    BYTE PTR [bx+si],al
    329f:	e9 3c fb             	jmp    0x2dde
    32a2:	ff                   	(bad)
    32a3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32a6:	68 88 00             	push   0x88
    32a9:	00 00                	add    BYTE PTR [bx+si],al
    32ab:	e9 30 fb             	jmp    0x2dde
    32ae:	ff                   	(bad)
    32af:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32b2:	68 89 00             	push   0x89
    32b5:	00 00                	add    BYTE PTR [bx+si],al
    32b7:	e9 24 fb             	jmp    0x2dde
    32ba:	ff                   	(bad)
    32bb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32be:	68 8a 00             	push   0x8a
    32c1:	00 00                	add    BYTE PTR [bx+si],al
    32c3:	e9 18 fb             	jmp    0x2dde
    32c6:	ff                   	(bad)
    32c7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32ca:	68 8b 00             	push   0x8b
    32cd:	00 00                	add    BYTE PTR [bx+si],al
    32cf:	e9 0c fb             	jmp    0x2dde
    32d2:	ff                   	(bad)
    32d3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32d6:	68 8c 00             	push   0x8c
    32d9:	00 00                	add    BYTE PTR [bx+si],al
    32db:	e9 00 fb             	jmp    0x2dde
    32de:	ff                   	(bad)
    32df:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32e2:	68 8d 00             	push   0x8d
    32e5:	00 00                	add    BYTE PTR [bx+si],al
    32e7:	e9 f4 fa             	jmp    0x2dde
    32ea:	ff                   	(bad)
    32eb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32ee:	68 8e 00             	push   0x8e
    32f1:	00 00                	add    BYTE PTR [bx+si],al
    32f3:	e9 e8 fa             	jmp    0x2dde
    32f6:	ff                   	(bad)
    32f7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    32fa:	68 8f 00             	push   0x8f
    32fd:	00 00                	add    BYTE PTR [bx+si],al
    32ff:	e9 dc fa             	jmp    0x2dde
    3302:	ff                   	(bad)
    3303:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3306:	68 90 00             	push   0x90
    3309:	00 00                	add    BYTE PTR [bx+si],al
    330b:	e9 d0 fa             	jmp    0x2dde
    330e:	ff                   	(bad)
    330f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3312:	68 91 00             	push   0x91
    3315:	00 00                	add    BYTE PTR [bx+si],al
    3317:	e9 c4 fa             	jmp    0x2dde
    331a:	ff                   	(bad)
    331b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    331e:	68 92 00             	push   0x92
    3321:	00 00                	add    BYTE PTR [bx+si],al
    3323:	e9 b8 fa             	jmp    0x2dde
    3326:	ff                   	(bad)
    3327:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    332a:	68 93 00             	push   0x93
    332d:	00 00                	add    BYTE PTR [bx+si],al
    332f:	e9 ac fa             	jmp    0x2dde
    3332:	ff                   	(bad)
    3333:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3336:	68 94 00             	push   0x94
    3339:	00 00                	add    BYTE PTR [bx+si],al
    333b:	e9 a0 fa             	jmp    0x2dde
    333e:	ff                   	(bad)
    333f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3342:	68 95 00             	push   0x95
    3345:	00 00                	add    BYTE PTR [bx+si],al
    3347:	e9 94 fa             	jmp    0x2dde
    334a:	ff                   	(bad)
    334b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    334e:	68 96 00             	push   0x96
    3351:	00 00                	add    BYTE PTR [bx+si],al
    3353:	e9 88 fa             	jmp    0x2dde
    3356:	ff                   	(bad)
    3357:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    335a:	68 97 00             	push   0x97
    335d:	00 00                	add    BYTE PTR [bx+si],al
    335f:	e9 7c fa             	jmp    0x2dde
    3362:	ff                   	(bad)
    3363:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3366:	68 98 00             	push   0x98
    3369:	00 00                	add    BYTE PTR [bx+si],al
    336b:	e9 70 fa             	jmp    0x2dde
    336e:	ff                   	(bad)
    336f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3372:	68 99 00             	push   0x99
    3375:	00 00                	add    BYTE PTR [bx+si],al
    3377:	e9 64 fa             	jmp    0x2dde
    337a:	ff                   	(bad)
    337b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    337e:	68 9a 00             	push   0x9a
    3381:	00 00                	add    BYTE PTR [bx+si],al
    3383:	e9 58 fa             	jmp    0x2dde
    3386:	ff                   	(bad)
    3387:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    338a:	68 9b 00             	push   0x9b
    338d:	00 00                	add    BYTE PTR [bx+si],al
    338f:	e9 4c fa             	jmp    0x2dde
    3392:	ff                   	(bad)
    3393:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3396:	68 9c 00             	push   0x9c
    3399:	00 00                	add    BYTE PTR [bx+si],al
    339b:	e9 40 fa             	jmp    0x2dde
    339e:	ff                   	(bad)
    339f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33a2:	68 9d 00             	push   0x9d
    33a5:	00 00                	add    BYTE PTR [bx+si],al
    33a7:	e9 34 fa             	jmp    0x2dde
    33aa:	ff                   	(bad)
    33ab:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33ae:	68 9e 00             	push   0x9e
    33b1:	00 00                	add    BYTE PTR [bx+si],al
    33b3:	e9 28 fa             	jmp    0x2dde
    33b6:	ff                   	(bad)
    33b7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33ba:	68 9f 00             	push   0x9f
    33bd:	00 00                	add    BYTE PTR [bx+si],al
    33bf:	e9 1c fa             	jmp    0x2dde
    33c2:	ff                   	(bad)
    33c3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33c6:	68 a0 00             	push   0xa0
    33c9:	00 00                	add    BYTE PTR [bx+si],al
    33cb:	e9 10 fa             	jmp    0x2dde
    33ce:	ff                   	(bad)
    33cf:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33d2:	68 a1 00             	push   0xa1
    33d5:	00 00                	add    BYTE PTR [bx+si],al
    33d7:	e9 04 fa             	jmp    0x2dde
    33da:	ff                   	(bad)
    33db:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33de:	68 a2 00             	push   0xa2
    33e1:	00 00                	add    BYTE PTR [bx+si],al
    33e3:	e9 f8 f9             	jmp    0x2dde
    33e6:	ff                   	(bad)
    33e7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33ea:	68 a3 00             	push   0xa3
    33ed:	00 00                	add    BYTE PTR [bx+si],al
    33ef:	e9 ec f9             	jmp    0x2dde
    33f2:	ff                   	(bad)
    33f3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    33f6:	68 a4 00             	push   0xa4
    33f9:	00 00                	add    BYTE PTR [bx+si],al
    33fb:	e9 e0 f9             	jmp    0x2dde
    33fe:	ff                   	(bad)
    33ff:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3402:	68 a5 00             	push   0xa5
    3405:	00 00                	add    BYTE PTR [bx+si],al
    3407:	e9 d4 f9             	jmp    0x2dde
    340a:	ff                   	(bad)
    340b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    340e:	68 a6 00             	push   0xa6
    3411:	00 00                	add    BYTE PTR [bx+si],al
    3413:	e9 c8 f9             	jmp    0x2dde
    3416:	ff                   	(bad)
    3417:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    341a:	68 a7 00             	push   0xa7
    341d:	00 00                	add    BYTE PTR [bx+si],al
    341f:	e9 bc f9             	jmp    0x2dde
    3422:	ff                   	(bad)
    3423:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3426:	68 a8 00             	push   0xa8
    3429:	00 00                	add    BYTE PTR [bx+si],al
    342b:	e9 b0 f9             	jmp    0x2dde
    342e:	ff                   	(bad)
    342f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3432:	68 a9 00             	push   0xa9
    3435:	00 00                	add    BYTE PTR [bx+si],al
    3437:	e9 a4 f9             	jmp    0x2dde
    343a:	ff                   	(bad)
    343b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    343e:	68 aa 00             	push   0xaa
    3441:	00 00                	add    BYTE PTR [bx+si],al
    3443:	e9 98 f9             	jmp    0x2dde
    3446:	ff                   	(bad)
    3447:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    344a:	68 ab 00             	push   0xab
    344d:	00 00                	add    BYTE PTR [bx+si],al
    344f:	e9 8c f9             	jmp    0x2dde
    3452:	ff                   	(bad)
    3453:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3456:	68 ac 00             	push   0xac
    3459:	00 00                	add    BYTE PTR [bx+si],al
    345b:	e9 80 f9             	jmp    0x2dde
    345e:	ff                   	(bad)
    345f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3462:	68 ad 00             	push   0xad
    3465:	00 00                	add    BYTE PTR [bx+si],al
    3467:	e9 74 f9             	jmp    0x2dde
    346a:	ff                   	(bad)
    346b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    346e:	68 ae 00             	push   0xae
    3471:	00 00                	add    BYTE PTR [bx+si],al
    3473:	e9 68 f9             	jmp    0x2dde
    3476:	ff                   	(bad)
    3477:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    347a:	68 af 00             	push   0xaf
    347d:	00 00                	add    BYTE PTR [bx+si],al
    347f:	e9 5c f9             	jmp    0x2dde
    3482:	ff                   	(bad)
    3483:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3486:	68 b0 00             	push   0xb0
    3489:	00 00                	add    BYTE PTR [bx+si],al
    348b:	e9 50 f9             	jmp    0x2dde
    348e:	ff                   	(bad)
    348f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3492:	68 b1 00             	push   0xb1
    3495:	00 00                	add    BYTE PTR [bx+si],al
    3497:	e9 44 f9             	jmp    0x2dde
    349a:	ff                   	(bad)
    349b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    349e:	68 b2 00             	push   0xb2
    34a1:	00 00                	add    BYTE PTR [bx+si],al
    34a3:	e9 38 f9             	jmp    0x2dde
    34a6:	ff                   	(bad)
    34a7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34aa:	68 b3 00             	push   0xb3
    34ad:	00 00                	add    BYTE PTR [bx+si],al
    34af:	e9 2c f9             	jmp    0x2dde
    34b2:	ff                   	(bad)
    34b3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34b6:	68 b4 00             	push   0xb4
    34b9:	00 00                	add    BYTE PTR [bx+si],al
    34bb:	e9 20 f9             	jmp    0x2dde
    34be:	ff                   	(bad)
    34bf:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34c2:	68 b5 00             	push   0xb5
    34c5:	00 00                	add    BYTE PTR [bx+si],al
    34c7:	e9 14 f9             	jmp    0x2dde
    34ca:	ff                   	(bad)
    34cb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34ce:	68 b6 00             	push   0xb6
    34d1:	00 00                	add    BYTE PTR [bx+si],al
    34d3:	e9 08 f9             	jmp    0x2dde
    34d6:	ff                   	(bad)
    34d7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34da:	68 b7 00             	push   0xb7
    34dd:	00 00                	add    BYTE PTR [bx+si],al
    34df:	e9 fc f8             	jmp    0x2dde
    34e2:	ff                   	(bad)
    34e3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34e6:	68 b8 00             	push   0xb8
    34e9:	00 00                	add    BYTE PTR [bx+si],al
    34eb:	e9 f0 f8             	jmp    0x2dde
    34ee:	ff                   	(bad)
    34ef:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34f2:	68 b9 00             	push   0xb9
    34f5:	00 00                	add    BYTE PTR [bx+si],al
    34f7:	e9 e4 f8             	jmp    0x2dde
    34fa:	ff                   	(bad)
    34fb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    34fe:	68 ba 00             	push   0xba
    3501:	00 00                	add    BYTE PTR [bx+si],al
    3503:	e9 d8 f8             	jmp    0x2dde
    3506:	ff                   	(bad)
    3507:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    350a:	68 bb 00             	push   0xbb
    350d:	00 00                	add    BYTE PTR [bx+si],al
    350f:	e9 cc f8             	jmp    0x2dde
    3512:	ff                   	(bad)
    3513:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3516:	68 bc 00             	push   0xbc
    3519:	00 00                	add    BYTE PTR [bx+si],al
    351b:	e9 c0 f8             	jmp    0x2dde
    351e:	ff                   	(bad)
    351f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3522:	68 bd 00             	push   0xbd
    3525:	00 00                	add    BYTE PTR [bx+si],al
    3527:	e9 b4 f8             	jmp    0x2dde
    352a:	ff                   	(bad)
    352b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    352e:	68 be 00             	push   0xbe
    3531:	00 00                	add    BYTE PTR [bx+si],al
    3533:	e9 a8 f8             	jmp    0x2dde
    3536:	ff                   	(bad)
    3537:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    353a:	68 bf 00             	push   0xbf
    353d:	00 00                	add    BYTE PTR [bx+si],al
    353f:	e9 9c f8             	jmp    0x2dde
    3542:	ff                   	(bad)
    3543:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3546:	68 c0 00             	push   0xc0
    3549:	00 00                	add    BYTE PTR [bx+si],al
    354b:	e9 90 f8             	jmp    0x2dde
    354e:	ff                   	(bad)
    354f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3552:	68 c1 00             	push   0xc1
    3555:	00 00                	add    BYTE PTR [bx+si],al
    3557:	e9 84 f8             	jmp    0x2dde
    355a:	ff                   	(bad)
    355b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    355e:	68 c2 00             	push   0xc2
    3561:	00 00                	add    BYTE PTR [bx+si],al
    3563:	e9 78 f8             	jmp    0x2dde
    3566:	ff                   	(bad)
    3567:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    356a:	68 c3 00             	push   0xc3
    356d:	00 00                	add    BYTE PTR [bx+si],al
    356f:	e9 6c f8             	jmp    0x2dde
    3572:	ff                   	(bad)
    3573:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3576:	68 c4 00             	push   0xc4
    3579:	00 00                	add    BYTE PTR [bx+si],al
    357b:	e9 60 f8             	jmp    0x2dde
    357e:	ff                   	(bad)
    357f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3582:	68 c5 00             	push   0xc5
    3585:	00 00                	add    BYTE PTR [bx+si],al
    3587:	e9 54 f8             	jmp    0x2dde
    358a:	ff                   	(bad)
    358b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    358e:	68 c6 00             	push   0xc6
    3591:	00 00                	add    BYTE PTR [bx+si],al
    3593:	e9 48 f8             	jmp    0x2dde
    3596:	ff                   	(bad)
    3597:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    359a:	68 c7 00             	push   0xc7
    359d:	00 00                	add    BYTE PTR [bx+si],al
    359f:	e9 3c f8             	jmp    0x2dde
    35a2:	ff                   	(bad)
    35a3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35a6:	68 c8 00             	push   0xc8
    35a9:	00 00                	add    BYTE PTR [bx+si],al
    35ab:	e9 30 f8             	jmp    0x2dde
    35ae:	ff                   	(bad)
    35af:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35b2:	68 c9 00             	push   0xc9
    35b5:	00 00                	add    BYTE PTR [bx+si],al
    35b7:	e9 24 f8             	jmp    0x2dde
    35ba:	ff                   	(bad)
    35bb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35be:	68 ca 00             	push   0xca
    35c1:	00 00                	add    BYTE PTR [bx+si],al
    35c3:	e9 18 f8             	jmp    0x2dde
    35c6:	ff                   	(bad)
    35c7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35ca:	68 cb 00             	push   0xcb
    35cd:	00 00                	add    BYTE PTR [bx+si],al
    35cf:	e9 0c f8             	jmp    0x2dde
    35d2:	ff                   	(bad)
    35d3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35d6:	68 cc 00             	push   0xcc
    35d9:	00 00                	add    BYTE PTR [bx+si],al
    35db:	e9 00 f8             	jmp    0x2dde
    35de:	ff                   	(bad)
    35df:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35e2:	68 cd 00             	push   0xcd
    35e5:	00 00                	add    BYTE PTR [bx+si],al
    35e7:	e9 f4 f7             	jmp    0x2dde
    35ea:	ff                   	(bad)
    35eb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35ee:	68 ce 00             	push   0xce
    35f1:	00 00                	add    BYTE PTR [bx+si],al
    35f3:	e9 e8 f7             	jmp    0x2dde
    35f6:	ff                   	(bad)
    35f7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    35fa:	68 cf 00             	push   0xcf
    35fd:	00 00                	add    BYTE PTR [bx+si],al
    35ff:	e9 dc f7             	jmp    0x2dde
    3602:	ff                   	(bad)
    3603:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3606:	68 d0 00             	push   0xd0
    3609:	00 00                	add    BYTE PTR [bx+si],al
    360b:	e9 d0 f7             	jmp    0x2dde
    360e:	ff                   	(bad)
    360f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3612:	68 d1 00             	push   0xd1
    3615:	00 00                	add    BYTE PTR [bx+si],al
    3617:	e9 c4 f7             	jmp    0x2dde
    361a:	ff                   	(bad)
    361b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    361e:	68 d2 00             	push   0xd2
    3621:	00 00                	add    BYTE PTR [bx+si],al
    3623:	e9 b8 f7             	jmp    0x2dde
    3626:	ff                   	(bad)
    3627:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    362a:	68 d3 00             	push   0xd3
    362d:	00 00                	add    BYTE PTR [bx+si],al
    362f:	e9 ac f7             	jmp    0x2dde
    3632:	ff                   	(bad)
    3633:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3636:	68 d4 00             	push   0xd4
    3639:	00 00                	add    BYTE PTR [bx+si],al
    363b:	e9 a0 f7             	jmp    0x2dde
    363e:	ff                   	(bad)
    363f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3642:	68 d5 00             	push   0xd5
    3645:	00 00                	add    BYTE PTR [bx+si],al
    3647:	e9 94 f7             	jmp    0x2dde
    364a:	ff                   	(bad)
    364b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    364e:	68 d6 00             	push   0xd6
    3651:	00 00                	add    BYTE PTR [bx+si],al
    3653:	e9 88 f7             	jmp    0x2dde
    3656:	ff                   	(bad)
    3657:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    365a:	68 d7 00             	push   0xd7
    365d:	00 00                	add    BYTE PTR [bx+si],al
    365f:	e9 7c f7             	jmp    0x2dde
    3662:	ff                   	(bad)
    3663:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3666:	68 d8 00             	push   0xd8
    3669:	00 00                	add    BYTE PTR [bx+si],al
    366b:	e9 70 f7             	jmp    0x2dde
    366e:	ff                   	(bad)
    366f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3672:	68 d9 00             	push   0xd9
    3675:	00 00                	add    BYTE PTR [bx+si],al
    3677:	e9 64 f7             	jmp    0x2dde
    367a:	ff                   	(bad)
    367b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    367e:	68 da 00             	push   0xda
    3681:	00 00                	add    BYTE PTR [bx+si],al
    3683:	e9 58 f7             	jmp    0x2dde
    3686:	ff                   	(bad)
    3687:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    368a:	68 db 00             	push   0xdb
    368d:	00 00                	add    BYTE PTR [bx+si],al
    368f:	e9 4c f7             	jmp    0x2dde
    3692:	ff                   	(bad)
    3693:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3696:	68 dc 00             	push   0xdc
    3699:	00 00                	add    BYTE PTR [bx+si],al
    369b:	e9 40 f7             	jmp    0x2dde
    369e:	ff                   	(bad)
    369f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36a2:	68 dd 00             	push   0xdd
    36a5:	00 00                	add    BYTE PTR [bx+si],al
    36a7:	e9 34 f7             	jmp    0x2dde
    36aa:	ff                   	(bad)
    36ab:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36ae:	68 de 00             	push   0xde
    36b1:	00 00                	add    BYTE PTR [bx+si],al
    36b3:	e9 28 f7             	jmp    0x2dde
    36b6:	ff                   	(bad)
    36b7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36ba:	68 df 00             	push   0xdf
    36bd:	00 00                	add    BYTE PTR [bx+si],al
    36bf:	e9 1c f7             	jmp    0x2dde
    36c2:	ff                   	(bad)
    36c3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36c6:	68 e0 00             	push   0xe0
    36c9:	00 00                	add    BYTE PTR [bx+si],al
    36cb:	e9 10 f7             	jmp    0x2dde
    36ce:	ff                   	(bad)
    36cf:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36d2:	68 e1 00             	push   0xe1
    36d5:	00 00                	add    BYTE PTR [bx+si],al
    36d7:	e9 04 f7             	jmp    0x2dde
    36da:	ff                   	(bad)
    36db:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36de:	68 e2 00             	push   0xe2
    36e1:	00 00                	add    BYTE PTR [bx+si],al
    36e3:	e9 f8 f6             	jmp    0x2dde
    36e6:	ff                   	(bad)
    36e7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36ea:	68 e3 00             	push   0xe3
    36ed:	00 00                	add    BYTE PTR [bx+si],al
    36ef:	e9 ec f6             	jmp    0x2dde
    36f2:	ff                   	(bad)
    36f3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    36f6:	68 e4 00             	push   0xe4
    36f9:	00 00                	add    BYTE PTR [bx+si],al
    36fb:	e9 e0 f6             	jmp    0x2dde
    36fe:	ff                   	(bad)
    36ff:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3702:	68 e5 00             	push   0xe5
    3705:	00 00                	add    BYTE PTR [bx+si],al
    3707:	e9 d4 f6             	jmp    0x2dde
    370a:	ff                   	(bad)
    370b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    370e:	68 e6 00             	push   0xe6
    3711:	00 00                	add    BYTE PTR [bx+si],al
    3713:	e9 c8 f6             	jmp    0x2dde
    3716:	ff                   	(bad)
    3717:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    371a:	68 e7 00             	push   0xe7
    371d:	00 00                	add    BYTE PTR [bx+si],al
    371f:	e9 bc f6             	jmp    0x2dde
    3722:	ff                   	(bad)
    3723:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3726:	68 e8 00             	push   0xe8
    3729:	00 00                	add    BYTE PTR [bx+si],al
    372b:	e9 b0 f6             	jmp    0x2dde
    372e:	ff                   	(bad)
    372f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3732:	68 e9 00             	push   0xe9
    3735:	00 00                	add    BYTE PTR [bx+si],al
    3737:	e9 a4 f6             	jmp    0x2dde
    373a:	ff                   	(bad)
    373b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    373e:	68 ea 00             	push   0xea
    3741:	00 00                	add    BYTE PTR [bx+si],al
    3743:	e9 98 f6             	jmp    0x2dde
    3746:	ff                   	(bad)
    3747:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    374a:	68 eb 00             	push   0xeb
    374d:	00 00                	add    BYTE PTR [bx+si],al
    374f:	e9 8c f6             	jmp    0x2dde
    3752:	ff                   	(bad)
    3753:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3756:	68 ec 00             	push   0xec
    3759:	00 00                	add    BYTE PTR [bx+si],al
    375b:	e9 80 f6             	jmp    0x2dde
    375e:	ff                   	(bad)
    375f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3762:	68 ed 00             	push   0xed
    3765:	00 00                	add    BYTE PTR [bx+si],al
    3767:	e9 74 f6             	jmp    0x2dde
    376a:	ff                   	(bad)
    376b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    376e:	68 ee 00             	push   0xee
    3771:	00 00                	add    BYTE PTR [bx+si],al
    3773:	e9 68 f6             	jmp    0x2dde
    3776:	ff                   	(bad)
    3777:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    377a:	68 ef 00             	push   0xef
    377d:	00 00                	add    BYTE PTR [bx+si],al
    377f:	e9 5c f6             	jmp    0x2dde
    3782:	ff                   	(bad)
    3783:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3786:	68 f0 00             	push   0xf0
    3789:	00 00                	add    BYTE PTR [bx+si],al
    378b:	e9 50 f6             	jmp    0x2dde
    378e:	ff                   	(bad)
    378f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3792:	68 f1 00             	push   0xf1
    3795:	00 00                	add    BYTE PTR [bx+si],al
    3797:	e9 44 f6             	jmp    0x2dde
    379a:	ff                   	(bad)
    379b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    379e:	68 f2 00             	push   0xf2
    37a1:	00 00                	add    BYTE PTR [bx+si],al
    37a3:	e9 38 f6             	jmp    0x2dde
    37a6:	ff                   	(bad)
    37a7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37aa:	68 f3 00             	push   0xf3
    37ad:	00 00                	add    BYTE PTR [bx+si],al
    37af:	e9 2c f6             	jmp    0x2dde
    37b2:	ff                   	(bad)
    37b3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37b6:	68 f4 00             	push   0xf4
    37b9:	00 00                	add    BYTE PTR [bx+si],al
    37bb:	e9 20 f6             	jmp    0x2dde
    37be:	ff                   	(bad)
    37bf:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37c2:	68 f5 00             	push   0xf5
    37c5:	00 00                	add    BYTE PTR [bx+si],al
    37c7:	e9 14 f6             	jmp    0x2dde
    37ca:	ff                   	(bad)
    37cb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37ce:	68 f6 00             	push   0xf6
    37d1:	00 00                	add    BYTE PTR [bx+si],al
    37d3:	e9 08 f6             	jmp    0x2dde
    37d6:	ff                   	(bad)
    37d7:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37da:	68 f7 00             	push   0xf7
    37dd:	00 00                	add    BYTE PTR [bx+si],al
    37df:	e9 fc f5             	jmp    0x2dde
    37e2:	ff                   	(bad)
    37e3:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37e6:	68 f8 00             	push   0xf8
    37e9:	00 00                	add    BYTE PTR [bx+si],al
    37eb:	e9 f0 f5             	jmp    0x2dde
    37ee:	ff                   	(bad)
    37ef:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37f2:	68 f9 00             	push   0xf9
    37f5:	00 00                	add    BYTE PTR [bx+si],al
    37f7:	e9 e4 f5             	jmp    0x2dde
    37fa:	ff                   	(bad)
    37fb:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    37fe:	68 fa 00             	push   0xfa
    3801:	00 00                	add    BYTE PTR [bx+si],al
    3803:	e9 d8 f5             	jmp    0x2dde
    3806:	ff                   	(bad)
    3807:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    380a:	68 fb 00             	push   0xfb
    380d:	00 00                	add    BYTE PTR [bx+si],al
    380f:	e9 cc f5             	jmp    0x2dde
    3812:	ff                   	(bad)
    3813:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3816:	68 fc 00             	push   0xfc
    3819:	00 00                	add    BYTE PTR [bx+si],al
    381b:	e9 c0 f5             	jmp    0x2dde
    381e:	ff                   	(bad)
    381f:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    3822:	68 fd 00             	push   0xfd
    3825:	00 00                	add    BYTE PTR [bx+si],al
    3827:	e9 b4 f5             	jmp    0x2dde
    382a:	ff                   	(bad)
    382b:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    382e:	68 fe 00             	push   0xfe
    3831:	00 00                	add    BYTE PTR [bx+si],al
    3833:	e9 a8 f5             	jmp    0x2dde
    3836:	ff                   	(bad)
    3837:	ff 6a 00             	jmp    DWORD PTR [bp+si+0x0]
    383a:	68 ff 00             	push   0xff
    383d:	00 00                	add    BYTE PTR [bx+si],al
    383f:	e9 9c f5             	jmp    0x2dde
    3842:	ff                   	(bad)
    3843:	ff 53 42             	call   WORD PTR [bp+di+0x42]
    3846:	4c                   	dec    sp
    3847:	3a 20                	cmp    ah,BYTE PTR [bx+si]
    3849:	4c                   	dec    sp
    384a:	6f                   	outs   dx,WORD PTR ds:[si]
    384b:	61                   	popa
    384c:	64 69 6e 67 20 4e    	imul   bp,WORD PTR fs:[bp+0x67],0x4e20
    3852:	65 6b 6f 2e 2e       	imul   bp,WORD PTR gs:[bx+0x2e],0x2e
    3857:	2e 20 20             	and    BYTE PTR cs:[bx+si],ah
    385a:	20 20                	and    BYTE PTR [bx+si],ah
    385c:	20 20                	and    BYTE PTR [bx+si],ah
    385e:	20 20                	and    BYTE PTR [bx+si],ah
    3860:	20 20                	and    BYTE PTR [bx+si],ah
    3862:	20 20                	and    BYTE PTR [bx+si],ah
    3864:	20 20                	and    BYTE PTR [bx+si],ah
    3866:	20 00                	and    BYTE PTR [bx+si],al
    3868:	00 53 4d             	add    BYTE PTR [bp+di+0x4d],dl
    386b:	41                   	inc    cx
    386c:	50                   	push   ax
    386d:	20 69 73             	and    BYTE PTR [bx+di+0x73],ch
    3870:	20 6f 66             	and    BYTE PTR [bx+0x66],ch
    3873:	20 73 69             	and    BYTE PTR [bp+di+0x69],dh
    3876:	7a 65                	jp     0x38dd
    3878:	3a 20                	cmp    ah,BYTE PTR [bx+si]
    387a:	00 00                	add    BYTE PTR [bx+si],al
    387c:	73 74                	jae    0x38f2
    387e:	72 31                	jb     0x38b1
    3880:	00 00                	add    BYTE PTR [bx+si],al
    3882:	00 00                	add    BYTE PTR [bx+si],al
    3884:	74 65                	je     0x38eb
    3886:	73 74                	jae    0x38fc
    3888:	0a 09                	or     cl,BYTE PTR [bx+di]
    388a:	74 65                	je     0x38f1
    388c:	73 74                	jae    0x3902
    388e:	32 0a                	xor    cl,BYTE PTR [bp+si]
    3890:	25 25 20             	and    ax,0x2025
    3893:	25 73 20             	and    ax,0x2073
    3896:	25 78 20             	and    ax,0x2078
    3899:	25 69 20             	and    ax,0x2069
    389c:	25 63 20             	and    ax,0x2063
    389f:	25 69 20             	and    ax,0x2069
    38a2:	25 69 0a             	and    ax,0xa69
    38a5:	00 00                	add    BYTE PTR [bx+si],al
    38a7:	00 41 62             	add    BYTE PTR [bx+di+0x62],al
    38aa:	6f                   	outs   dx,WORD PTR ds:[si]
    38ab:	75 74                	jne    0x3921
    38ad:	20 74 6f             	and    BYTE PTR [si+0x6f],dh
    38b0:	20 74 72             	and    BYTE PTR [si+0x72],dh
    38b3:	69 67 67 65 72       	imul   sp,WORD PTR [bx+0x67],0x7265
    38b8:	20 69 6e             	and    BYTE PTR [bx+di+0x6e],ch
    38bb:	74 65                	je     0x3922
    38bd:	72 72                	jb     0x3931
    38bf:	75 70                	jne    0x3931
    38c1:	74 2e                	je     0x38f1
    38c3:	2e 2e 0a 00          	cs or  al,BYTE PTR cs:[bx+si]
    38c7:	00 54 68             	add    BYTE PTR [si+0x68],dl
    38ca:	69 73 20 73 68       	imul   si,WORD PTR [bp+di+0x20],0x6873
    38cf:	6f                   	outs   dx,WORD PTR ds:[si]
    38d0:	75 6c                	jne    0x393e
    38d2:	64 6e                	outs   dx,BYTE PTR fs:[si]
    38d4:	27                   	daa
    38d5:	74 20                	je     0x38f7
    38d7:	70 72                	jo     0x394b
    38d9:	69 6e 74 20 69       	imul   bp,WORD PTR [bp+0x74],0x6920
    38de:	66 20 77 65          	data32 and BYTE PTR [bx+0x65],dh
    38e2:	27                   	daa
    38e3:	72 65                	jb     0x394a
    38e5:	20 73 74             	and    BYTE PTR [bp+di+0x74],dh
    38e8:	75 63                	jne    0x394d
    38ea:	6b 20 69             	imul   sp,WORD PTR [bx+si],0x69
    38ed:	6e                   	outs   dx,BYTE PTR ds:[si]
    38ee:	20 74 68             	and    BYTE PTR [si+0x68],dh
    38f1:	65 20 69 6e          	and    BYTE PTR gs:[bx+di+0x6e],ch
    38f5:	66 69 6e 69 74 65 20 	imul   ebp,DWORD PTR [bp+0x69],0x6c206574
    38fc:	6c 
    38fd:	6f                   	outs   dx,WORD PTR ds:[si]
    38fe:	6f                   	outs   dx,WORD PTR ds:[si]
    38ff:	70 0a                	jo     0x390b
    3901:	00 77 68             	add    BYTE PTR [bx+0x68],dh
    3904:	61                   	popa
    3905:	74 3f                	je     0x3946
    3907:	3f                   	aas
    3908:	3f                   	aas
    3909:	3f                   	aas
    390a:	3f                   	aas
    390b:	3f                   	aas
    390c:	3f                   	aas
    390d:	3f                   	aas
    390e:	3f                   	aas
    390f:	3f                   	aas
    3910:	3f                   	aas
    3911:	3f                   	aas
    3912:	3f                   	aas
    3913:	3f                   	aas
    3914:	3f                   	aas
    3915:	3f                   	aas
    3916:	00 30                	add    BYTE PTR [bx+si],dh
    3918:	78 00                	js     0x391a
    391a:	30 58 00             	xor    BYTE PTR [bx+si+0x0],bl
    391d:	2d 32 31             	sub    ax,0x3132
    3920:	34 37                	xor    al,0x37
    3922:	34 38                	xor    al,0x38
    3924:	33 36 34 38          	xor    si,WORD PTR ds:0x3834
    3928:	00 55 6e             	add    BYTE PTR [di+0x6e],dl
    392b:	68 61 6e             	push   0x6e61
    392e:	64 6c                	fs ins BYTE PTR es:[di],dx
    3930:	65 64 20 69 6e       	gs and BYTE PTR fs:[bx+di+0x6e],ch
    3935:	74 65                	je     0x399c
    3937:	72 72                	jb     0x39ab
    3939:	75 70                	jne    0x39ab
    393b:	74 21                	je     0x395e
    393d:	00 00                	add    BYTE PTR [bx+si],al
    393f:	00 00                	add    BYTE PTR [bx+si],al
    3941:	80 0b 00             	or     BYTE PTR [bp+di],0x0
    3944:	00 10                	add    BYTE PTR [bx+si],dl
    3946:	00 00                	add    BYTE PTR [bx+si],al
    3948:	00 20                	add    BYTE PTR [bx+si],ah
    394a:	00 00                	add    BYTE PTR [bx+si],al
    394c:	04 8a                	add    al,0x8a
    394e:	00 00                	add    BYTE PTR [bx+si],al
    3950:	0b 8a 00 00          	or     cx,WORD PTR [bp+si+0x0]
    3954:	11 8a 00 00          	adc    WORD PTR [bp+si+0x0],cx
    3958:	17                   	pop    ss
    3959:	8a 00                	mov    al,BYTE PTR [bx+si]
    395b:	00 1d                	add    BYTE PTR [di],bl
    395d:	8a 00                	mov    al,BYTE PTR [bx+si]
    395f:	00 23                	add    BYTE PTR [bp+di],ah
    3961:	8a 00                	mov    al,BYTE PTR [bx+si]
    3963:	00 29                	add    BYTE PTR [bx+di],ch
    3965:	8a 00                	mov    al,BYTE PTR [bx+si]
    3967:	00 2f                	add    BYTE PTR [bx],ch
    3969:	8a 00                	mov    al,BYTE PTR [bx+si]
    396b:	00 35                	add    BYTE PTR [di],dh
    396d:	8a 00                	mov    al,BYTE PTR [bx+si]
    396f:	00 39                	add    BYTE PTR [bx+di],bh
    3971:	8a 00                	mov    al,BYTE PTR [bx+si]
    3973:	00 3f                	add    BYTE PTR [bx],bh
    3975:	8a 00                	mov    al,BYTE PTR [bx+si]
    3977:	00 43 8a             	add    BYTE PTR [bp+di-0x76],al
    397a:	00 00                	add    BYTE PTR [bx+si],al
    397c:	47                   	inc    di
    397d:	8a 00                	mov    al,BYTE PTR [bx+si]
    397f:	00 4b 8a             	add    BYTE PTR [bp+di-0x76],cl
    3982:	00 00                	add    BYTE PTR [bx+si],al
    3984:	4f                   	dec    di
    3985:	8a 00                	mov    al,BYTE PTR [bx+si]
    3987:	00 53 8a             	add    BYTE PTR [bp+di-0x76],dl
    398a:	00 00                	add    BYTE PTR [bx+si],al
    398c:	59                   	pop    cx
    398d:	8a 00                	mov    al,BYTE PTR [bx+si]
    398f:	00 5f 8a             	add    BYTE PTR [bx-0x76],bl
    3992:	00 00                	add    BYTE PTR [bx+si],al
    3994:	66 8a 00             	data32 mov al,BYTE PTR [bx+si]
    3997:	00 6f 8a             	add    BYTE PTR [bx-0x76],ch
    399a:	00 00                	add    BYTE PTR [bx+si],al
    399c:	78 8a                	js     0x3928
    399e:	00 00                	add    BYTE PTR [bx+si],al
    39a0:	81 8a 00 00 8a 8a    	or     WORD PTR [bp+si+0x0],0x8a8a
    39a6:	00 00                	add    BYTE PTR [bx+si],al
    39a8:	93                   	xchg   bx,ax
    39a9:	8a 00                	mov    al,BYTE PTR [bx+si]
    39ab:	00 9c 8a 00          	add    BYTE PTR [si+0x8a],bl
    39af:	00 a5 8a 00          	add    BYTE PTR [di+0x8a],ah
    39b3:	00 ae 8a 00          	add    BYTE PTR [bp+0x8a],ch
    39b7:	00 b7 8a 00          	add    BYTE PTR [bx+0x8a],dh
    39bb:	00 c0                	add    al,al
    39bd:	8a 00                	mov    al,BYTE PTR [bx+si]
    39bf:	00 c9                	add    cl,cl
    39c1:	8a 00                	mov    al,BYTE PTR [bx+si]
    39c3:	00 d2                	add    dl,dl
    39c5:	8a 00                	mov    al,BYTE PTR [bx+si]
    39c7:	00 db                	add    bl,bl
    39c9:	8a 00                	mov    al,BYTE PTR [bx+si]
    39cb:	00 e4                	add    ah,ah
    39cd:	8a 00                	mov    al,BYTE PTR [bx+si]
    39cf:	00 ed                	add    ch,ch
    39d1:	8a 00                	mov    al,BYTE PTR [bx+si]
    39d3:	00 f6                	add    dh,dh
    39d5:	8a 00                	mov    al,BYTE PTR [bx+si]
    39d7:	00 ff                	add    bh,bh
    39d9:	8a 00                	mov    al,BYTE PTR [bx+si]
    39db:	00 08                	add    BYTE PTR [bx+si],cl
    39dd:	8b 00                	mov    ax,WORD PTR [bx+si]
    39df:	00 11                	add    BYTE PTR [bx+di],dl
    39e1:	8b 00                	mov    ax,WORD PTR [bx+si]
    39e3:	00 1a                	add    BYTE PTR [bp+si],bl
    39e5:	8b 00                	mov    ax,WORD PTR [bx+si]
    39e7:	00 23                	add    BYTE PTR [bp+di],ah
    39e9:	8b 00                	mov    ax,WORD PTR [bx+si]
    39eb:	00 2c                	add    BYTE PTR [si],ch
    39ed:	8b 00                	mov    ax,WORD PTR [bx+si]
    39ef:	00 35                	add    BYTE PTR [di],dh
    39f1:	8b 00                	mov    ax,WORD PTR [bx+si]
    39f3:	00 3e 8b 00          	add    BYTE PTR ds:0x8b,bh
    39f7:	00 47 8b             	add    BYTE PTR [bx-0x75],al
    39fa:	00 00                	add    BYTE PTR [bx+si],al
    39fc:	50                   	push   ax
    39fd:	8b 00                	mov    ax,WORD PTR [bx+si]
    39ff:	00 59 8b             	add    BYTE PTR [bx+di-0x75],bl
    3a02:	00 00                	add    BYTE PTR [bx+si],al
    3a04:	62 8b 00 00          	bound  cx,DWORD PTR [bp+di+0x0]
    3a08:	6b 8b 00 00 74       	imul   cx,WORD PTR [bp+di+0x0],0x74
    3a0d:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a0f:	00 7d 8b             	add    BYTE PTR [di-0x75],bh
    3a12:	00 00                	add    BYTE PTR [bx+si],al
    3a14:	86 8b 00 00          	xchg   BYTE PTR [bp+di+0x0],cl
    3a18:	8f                   	(bad)
    3a19:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a1b:	00 98 8b 00          	add    BYTE PTR [bx+si+0x8b],bl
    3a1f:	00 a1 8b 00          	add    BYTE PTR [bx+di+0x8b],ah
    3a23:	00 aa 8b 00          	add    BYTE PTR [bp+si+0x8b],ch
    3a27:	00 b3 8b 00          	add    BYTE PTR [bp+di+0x8b],dh
    3a2b:	00 bc 8b 00          	add    BYTE PTR [si+0x8b],bh
    3a2f:	00 c5                	add    ch,al
    3a31:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a33:	00 ce                	add    dh,cl
    3a35:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a37:	00 d7                	add    bh,dl
    3a39:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a3b:	00 e0                	add    al,ah
    3a3d:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a3f:	00 e9                	add    cl,ch
    3a41:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a43:	00 f2                	add    dl,dh
    3a45:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a47:	00 fb                	add    bl,bh
    3a49:	8b 00                	mov    ax,WORD PTR [bx+si]
    3a4b:	00 04                	add    BYTE PTR [si],al
    3a4d:	8c 00                	mov    WORD PTR [bx+si],es
    3a4f:	00 0d                	add    BYTE PTR [di],cl
    3a51:	8c 00                	mov    WORD PTR [bx+si],es
    3a53:	00 16 8c 00          	add    BYTE PTR ds:0x8c,dl
    3a57:	00 1f                	add    BYTE PTR [bx],bl
    3a59:	8c 00                	mov    WORD PTR [bx+si],es
    3a5b:	00 28                	add    BYTE PTR [bx+si],ch
    3a5d:	8c 00                	mov    WORD PTR [bx+si],es
    3a5f:	00 31                	add    BYTE PTR [bx+di],dh
    3a61:	8c 00                	mov    WORD PTR [bx+si],es
    3a63:	00 3a                	add    BYTE PTR [bp+si],bh
    3a65:	8c 00                	mov    WORD PTR [bx+si],es
    3a67:	00 43 8c             	add    BYTE PTR [bp+di-0x74],al
    3a6a:	00 00                	add    BYTE PTR [bx+si],al
    3a6c:	4c                   	dec    sp
    3a6d:	8c 00                	mov    WORD PTR [bx+si],es
    3a6f:	00 55 8c             	add    BYTE PTR [di-0x74],dl
    3a72:	00 00                	add    BYTE PTR [bx+si],al
    3a74:	5e                   	pop    si
    3a75:	8c 00                	mov    WORD PTR [bx+si],es
    3a77:	00 67 8c             	add    BYTE PTR [bx-0x74],ah
    3a7a:	00 00                	add    BYTE PTR [bx+si],al
    3a7c:	70 8c                	jo     0x3a0a
    3a7e:	00 00                	add    BYTE PTR [bx+si],al
    3a80:	79 8c                	jns    0x3a0e
    3a82:	00 00                	add    BYTE PTR [bx+si],al
    3a84:	82 8c 00 00 8b       	or     BYTE PTR [si+0x0],0x8b
    3a89:	8c 00                	mov    WORD PTR [bx+si],es
    3a8b:	00 94 8c 00          	add    BYTE PTR [si+0x8c],dl
    3a8f:	00 9d 8c 00          	add    BYTE PTR [di+0x8c],bl
    3a93:	00 a6 8c 00          	add    BYTE PTR [bp+0x8c],ah
    3a97:	00 af 8c 00          	add    BYTE PTR [bx+0x8c],ch
    3a9b:	00 b8 8c 00          	add    BYTE PTR [bx+si+0x8c],bh
    3a9f:	00 c1                	add    cl,al
    3aa1:	8c 00                	mov    WORD PTR [bx+si],es
    3aa3:	00 ca                	add    dl,cl
    3aa5:	8c 00                	mov    WORD PTR [bx+si],es
    3aa7:	00 d3                	add    bl,dl
    3aa9:	8c 00                	mov    WORD PTR [bx+si],es
    3aab:	00 dc                	add    ah,bl
    3aad:	8c 00                	mov    WORD PTR [bx+si],es
    3aaf:	00 e5                	add    ch,ah
    3ab1:	8c 00                	mov    WORD PTR [bx+si],es
    3ab3:	00 ee                	add    dh,ch
    3ab5:	8c 00                	mov    WORD PTR [bx+si],es
    3ab7:	00 f7                	add    bh,dh
    3ab9:	8c 00                	mov    WORD PTR [bx+si],es
    3abb:	00 00                	add    BYTE PTR [bx+si],al
    3abd:	8d 00                	lea    ax,[bx+si]
    3abf:	00 09                	add    BYTE PTR [bx+di],cl
    3ac1:	8d 00                	lea    ax,[bx+si]
    3ac3:	00 12                	add    BYTE PTR [bp+si],dl
    3ac5:	8d 00                	lea    ax,[bx+si]
    3ac7:	00 1b                	add    BYTE PTR [bp+di],bl
    3ac9:	8d 00                	lea    ax,[bx+si]
    3acb:	00 24                	add    BYTE PTR [si],ah
    3acd:	8d 00                	lea    ax,[bx+si]
    3acf:	00 2d                	add    BYTE PTR [di],ch
    3ad1:	8d 00                	lea    ax,[bx+si]
    3ad3:	00 36 8d 00          	add    BYTE PTR ds:0x8d,dh
    3ad7:	00 3f                	add    BYTE PTR [bx],bh
    3ad9:	8d 00                	lea    ax,[bx+si]
    3adb:	00 48 8d             	add    BYTE PTR [bx+si-0x73],cl
    3ade:	00 00                	add    BYTE PTR [bx+si],al
    3ae0:	51                   	push   cx
    3ae1:	8d 00                	lea    ax,[bx+si]
    3ae3:	00 5a 8d             	add    BYTE PTR [bp+si-0x73],bl
    3ae6:	00 00                	add    BYTE PTR [bx+si],al
    3ae8:	63 8d 00 00          	arpl   WORD PTR [di+0x0],cx
    3aec:	6c                   	ins    BYTE PTR es:[di],dx
    3aed:	8d 00                	lea    ax,[bx+si]
    3aef:	00 75 8d             	add    BYTE PTR [di-0x73],dh
    3af2:	00 00                	add    BYTE PTR [bx+si],al
    3af4:	7e 8d                	jle    0x3a83
    3af6:	00 00                	add    BYTE PTR [bx+si],al
    3af8:	87 8d 00 00          	xchg   WORD PTR [di+0x0],cx
    3afc:	90                   	nop
    3afd:	8d 00                	lea    ax,[bx+si]
    3aff:	00 99 8d 00          	add    BYTE PTR [bx+di+0x8d],bl
    3b03:	00 a2 8d 00          	add    BYTE PTR [bp+si+0x8d],ah
    3b07:	00 ab 8d 00          	add    BYTE PTR [bp+di+0x8d],ch
    3b0b:	00 b4 8d 00          	add    BYTE PTR [si+0x8d],dh
    3b0f:	00 bd 8d 00          	add    BYTE PTR [di+0x8d],bh
    3b13:	00 c6                	add    dh,al
    3b15:	8d 00                	lea    ax,[bx+si]
    3b17:	00 cf                	add    bh,cl
    3b19:	8d 00                	lea    ax,[bx+si]
    3b1b:	00 d8                	add    al,bl
    3b1d:	8d 00                	lea    ax,[bx+si]
    3b1f:	00 e1                	add    cl,ah
    3b21:	8d 00                	lea    ax,[bx+si]
    3b23:	00 ea                	add    dl,ch
    3b25:	8d 00                	lea    ax,[bx+si]
    3b27:	00 f3                	add    bl,dh
    3b29:	8d 00                	lea    ax,[bx+si]
    3b2b:	00 fc                	add    ah,bh
    3b2d:	8d 00                	lea    ax,[bx+si]
    3b2f:	00 05                	add    BYTE PTR [di],al
    3b31:	8e 00                	mov    es,WORD PTR [bx+si]
    3b33:	00 0e 8e 00          	add    BYTE PTR ds:0x8e,cl
    3b37:	00 17                	add    BYTE PTR [bx],dl
    3b39:	8e 00                	mov    es,WORD PTR [bx+si]
    3b3b:	00 20                	add    BYTE PTR [bx+si],ah
    3b3d:	8e 00                	mov    es,WORD PTR [bx+si]
    3b3f:	00 29                	add    BYTE PTR [bx+di],ch
    3b41:	8e 00                	mov    es,WORD PTR [bx+si]
    3b43:	00 32                	add    BYTE PTR [bp+si],dh
    3b45:	8e 00                	mov    es,WORD PTR [bx+si]
    3b47:	00 3b                	add    BYTE PTR [bp+di],bh
    3b49:	8e 00                	mov    es,WORD PTR [bx+si]
    3b4b:	00 44 8e             	add    BYTE PTR [si-0x72],al
    3b4e:	00 00                	add    BYTE PTR [bx+si],al
    3b50:	50                   	push   ax
    3b51:	8e 00                	mov    es,WORD PTR [bx+si]
    3b53:	00 5c 8e             	add    BYTE PTR [si-0x72],bl
    3b56:	00 00                	add    BYTE PTR [bx+si],al
    3b58:	68 8e 00             	push   0x8e
    3b5b:	00 74 8e             	add    BYTE PTR [si-0x72],dh
    3b5e:	00 00                	add    BYTE PTR [bx+si],al
    3b60:	80 8e 00 00 8c       	or     BYTE PTR [bp+0x0],0x8c
    3b65:	8e 00                	mov    es,WORD PTR [bx+si]
    3b67:	00 98 8e 00          	add    BYTE PTR [bx+si+0x8e],bl
    3b6b:	00 a4 8e 00          	add    BYTE PTR [si+0x8e],ah
    3b6f:	00 b0 8e 00          	add    BYTE PTR [bx+si+0x8e],dh
    3b73:	00 bc 8e 00          	add    BYTE PTR [si+0x8e],bh
    3b77:	00 c8                	add    al,cl
    3b79:	8e 00                	mov    es,WORD PTR [bx+si]
    3b7b:	00 d4                	add    ah,dl
    3b7d:	8e 00                	mov    es,WORD PTR [bx+si]
    3b7f:	00 e0                	add    al,ah
    3b81:	8e 00                	mov    es,WORD PTR [bx+si]
    3b83:	00 ec                	add    ah,ch
    3b85:	8e 00                	mov    es,WORD PTR [bx+si]
    3b87:	00 f8                	add    al,bh
    3b89:	8e 00                	mov    es,WORD PTR [bx+si]
    3b8b:	00 04                	add    BYTE PTR [si],al
    3b8d:	8f 00                	pop    WORD PTR [bx+si]
    3b8f:	00 10                	add    BYTE PTR [bx+si],dl
    3b91:	8f 00                	pop    WORD PTR [bx+si]
    3b93:	00 1c                	add    BYTE PTR [si],bl
    3b95:	8f 00                	pop    WORD PTR [bx+si]
    3b97:	00 28                	add    BYTE PTR [bx+si],ch
    3b99:	8f 00                	pop    WORD PTR [bx+si]
    3b9b:	00 34                	add    BYTE PTR [si],dh
    3b9d:	8f 00                	pop    WORD PTR [bx+si]
    3b9f:	00 40 8f             	add    BYTE PTR [bx+si-0x71],al
    3ba2:	00 00                	add    BYTE PTR [bx+si],al
    3ba4:	4c                   	dec    sp
    3ba5:	8f 00                	pop    WORD PTR [bx+si]
    3ba7:	00 58 8f             	add    BYTE PTR [bx+si-0x71],bl
    3baa:	00 00                	add    BYTE PTR [bx+si],al
    3bac:	64 8f 00             	pop    WORD PTR fs:[bx+si]
    3baf:	00 70 8f             	add    BYTE PTR [bx+si-0x71],dh
    3bb2:	00 00                	add    BYTE PTR [bx+si],al
    3bb4:	7c 8f                	jl     0x3b45
    3bb6:	00 00                	add    BYTE PTR [bx+si],al
    3bb8:	88 8f 00 00          	mov    BYTE PTR [bx+0x0],cl
    3bbc:	94                   	xchg   sp,ax
    3bbd:	8f 00                	pop    WORD PTR [bx+si]
    3bbf:	00 a0 8f 00          	add    BYTE PTR [bx+si+0x8f],ah
    3bc3:	00 ac 8f 00          	add    BYTE PTR [si+0x8f],ch
    3bc7:	00 b8 8f 00          	add    BYTE PTR [bx+si+0x8f],bh
    3bcb:	00 c4                	add    ah,al
    3bcd:	8f 00                	pop    WORD PTR [bx+si]
    3bcf:	00 d0                	add    al,dl
    3bd1:	8f 00                	pop    WORD PTR [bx+si]
    3bd3:	00 dc                	add    ah,bl
    3bd5:	8f 00                	pop    WORD PTR [bx+si]
    3bd7:	00 e8                	add    al,ch
    3bd9:	8f 00                	pop    WORD PTR [bx+si]
    3bdb:	00 f4                	add    ah,dh
    3bdd:	8f 00                	pop    WORD PTR [bx+si]
    3bdf:	00 00                	add    BYTE PTR [bx+si],al
    3be1:	90                   	nop
    3be2:	00 00                	add    BYTE PTR [bx+si],al
    3be4:	0c 90                	or     al,0x90
    3be6:	00 00                	add    BYTE PTR [bx+si],al
    3be8:	18 90 00 00          	sbb    BYTE PTR [bx+si+0x0],dl
    3bec:	24 90                	and    al,0x90
    3bee:	00 00                	add    BYTE PTR [bx+si],al
    3bf0:	30 90 00 00          	xor    BYTE PTR [bx+si+0x0],dl
    3bf4:	3c 90                	cmp    al,0x90
    3bf6:	00 00                	add    BYTE PTR [bx+si],al
    3bf8:	48                   	dec    ax
    3bf9:	90                   	nop
    3bfa:	00 00                	add    BYTE PTR [bx+si],al
    3bfc:	54                   	push   sp
    3bfd:	90                   	nop
    3bfe:	00 00                	add    BYTE PTR [bx+si],al
    3c00:	60                   	pusha
    3c01:	90                   	nop
    3c02:	00 00                	add    BYTE PTR [bx+si],al
    3c04:	6c                   	ins    BYTE PTR es:[di],dx
    3c05:	90                   	nop
    3c06:	00 00                	add    BYTE PTR [bx+si],al
    3c08:	78 90                	js     0x3b9a
    3c0a:	00 00                	add    BYTE PTR [bx+si],al
    3c0c:	84 90 00 00          	test   BYTE PTR [bx+si+0x0],dl
    3c10:	90                   	nop
    3c11:	90                   	nop
    3c12:	00 00                	add    BYTE PTR [bx+si],al
    3c14:	9c                   	pushf
    3c15:	90                   	nop
    3c16:	00 00                	add    BYTE PTR [bx+si],al
    3c18:	a8 90                	test   al,0x90
    3c1a:	00 00                	add    BYTE PTR [bx+si],al
    3c1c:	b4 90                	mov    ah,0x90
    3c1e:	00 00                	add    BYTE PTR [bx+si],al
    3c20:	c0 90 00 00 cc       	rcl    BYTE PTR [bx+si+0x0],0xcc
    3c25:	90                   	nop
    3c26:	00 00                	add    BYTE PTR [bx+si],al
    3c28:	d8 90 00 00          	fcom   DWORD PTR [bx+si+0x0]
    3c2c:	e4 90                	in     al,0x90
    3c2e:	00 00                	add    BYTE PTR [bx+si],al
    3c30:	f0 90                	lock nop
    3c32:	00 00                	add    BYTE PTR [bx+si],al
    3c34:	fc                   	cld
    3c35:	90                   	nop
    3c36:	00 00                	add    BYTE PTR [bx+si],al
    3c38:	08 91 00 00          	or     BYTE PTR [bx+di+0x0],dl
    3c3c:	14 91                	adc    al,0x91
    3c3e:	00 00                	add    BYTE PTR [bx+si],al
    3c40:	20 91 00 00          	and    BYTE PTR [bx+di+0x0],dl
    3c44:	2c 91                	sub    al,0x91
    3c46:	00 00                	add    BYTE PTR [bx+si],al
    3c48:	38 91 00 00          	cmp    BYTE PTR [bx+di+0x0],dl
    3c4c:	44                   	inc    sp
    3c4d:	91                   	xchg   cx,ax
    3c4e:	00 00                	add    BYTE PTR [bx+si],al
    3c50:	50                   	push   ax
    3c51:	91                   	xchg   cx,ax
    3c52:	00 00                	add    BYTE PTR [bx+si],al
    3c54:	5c                   	pop    sp
    3c55:	91                   	xchg   cx,ax
    3c56:	00 00                	add    BYTE PTR [bx+si],al
    3c58:	68 91 00             	push   0x91
    3c5b:	00 74 91             	add    BYTE PTR [si-0x6f],dh
    3c5e:	00 00                	add    BYTE PTR [bx+si],al
    3c60:	80 91 00 00 8c       	adc    BYTE PTR [bx+di+0x0],0x8c
    3c65:	91                   	xchg   cx,ax
    3c66:	00 00                	add    BYTE PTR [bx+si],al
    3c68:	98                   	cbw
    3c69:	91                   	xchg   cx,ax
    3c6a:	00 00                	add    BYTE PTR [bx+si],al
    3c6c:	a4                   	movs   BYTE PTR es:[di],BYTE PTR ds:[si]
    3c6d:	91                   	xchg   cx,ax
    3c6e:	00 00                	add    BYTE PTR [bx+si],al
    3c70:	b0 91                	mov    al,0x91
    3c72:	00 00                	add    BYTE PTR [bx+si],al
    3c74:	bc 91 00             	mov    sp,0x91
    3c77:	00 c8                	add    al,cl
    3c79:	91                   	xchg   cx,ax
    3c7a:	00 00                	add    BYTE PTR [bx+si],al
    3c7c:	d4 91                	aam    0x91
    3c7e:	00 00                	add    BYTE PTR [bx+si],al
    3c80:	e0 91                	loopne 0x3c13
    3c82:	00 00                	add    BYTE PTR [bx+si],al
    3c84:	ec                   	in     al,dx
    3c85:	91                   	xchg   cx,ax
    3c86:	00 00                	add    BYTE PTR [bx+si],al
    3c88:	f8                   	clc
    3c89:	91                   	xchg   cx,ax
    3c8a:	00 00                	add    BYTE PTR [bx+si],al
    3c8c:	04 92                	add    al,0x92
    3c8e:	00 00                	add    BYTE PTR [bx+si],al
    3c90:	10 92 00 00          	adc    BYTE PTR [bp+si+0x0],dl
    3c94:	1c 92                	sbb    al,0x92
    3c96:	00 00                	add    BYTE PTR [bx+si],al
    3c98:	28 92 00 00          	sub    BYTE PTR [bp+si+0x0],dl
    3c9c:	34 92                	xor    al,0x92
    3c9e:	00 00                	add    BYTE PTR [bx+si],al
    3ca0:	40                   	inc    ax
    3ca1:	92                   	xchg   dx,ax
    3ca2:	00 00                	add    BYTE PTR [bx+si],al
    3ca4:	4c                   	dec    sp
    3ca5:	92                   	xchg   dx,ax
    3ca6:	00 00                	add    BYTE PTR [bx+si],al
    3ca8:	58                   	pop    ax
    3ca9:	92                   	xchg   dx,ax
    3caa:	00 00                	add    BYTE PTR [bx+si],al
    3cac:	64 92                	fs xchg dx,ax
    3cae:	00 00                	add    BYTE PTR [bx+si],al
    3cb0:	70 92                	jo     0x3c44
    3cb2:	00 00                	add    BYTE PTR [bx+si],al
    3cb4:	7c 92                	jl     0x3c48
    3cb6:	00 00                	add    BYTE PTR [bx+si],al
    3cb8:	88 92 00 00          	mov    BYTE PTR [bp+si+0x0],dl
    3cbc:	94                   	xchg   sp,ax
    3cbd:	92                   	xchg   dx,ax
    3cbe:	00 00                	add    BYTE PTR [bx+si],al
    3cc0:	a0 92 00             	mov    al,ds:0x92
    3cc3:	00 ac 92 00          	add    BYTE PTR [si+0x92],ch
    3cc7:	00 b8 92 00          	add    BYTE PTR [bx+si+0x92],bh
    3ccb:	00 c4                	add    ah,al
    3ccd:	92                   	xchg   dx,ax
    3cce:	00 00                	add    BYTE PTR [bx+si],al
    3cd0:	d0 92 00 00          	rcl    BYTE PTR [bp+si+0x0],1
    3cd4:	dc 92 00 00          	fcom   QWORD PTR [bp+si+0x0]
    3cd8:	e8 92 00             	call   0x3d6d
    3cdb:	00 f4                	add    ah,dh
    3cdd:	92                   	xchg   dx,ax
    3cde:	00 00                	add    BYTE PTR [bx+si],al
    3ce0:	00 93 00 00          	add    BYTE PTR [bp+di+0x0],dl
    3ce4:	0c 93                	or     al,0x93
    3ce6:	00 00                	add    BYTE PTR [bx+si],al
    3ce8:	18 93 00 00          	sbb    BYTE PTR [bp+di+0x0],dl
    3cec:	24 93                	and    al,0x93
    3cee:	00 00                	add    BYTE PTR [bx+si],al
    3cf0:	30 93 00 00          	xor    BYTE PTR [bp+di+0x0],dl
    3cf4:	3c 93                	cmp    al,0x93
    3cf6:	00 00                	add    BYTE PTR [bx+si],al
    3cf8:	48                   	dec    ax
    3cf9:	93                   	xchg   bx,ax
    3cfa:	00 00                	add    BYTE PTR [bx+si],al
    3cfc:	54                   	push   sp
    3cfd:	93                   	xchg   bx,ax
    3cfe:	00 00                	add    BYTE PTR [bx+si],al
    3d00:	60                   	pusha
    3d01:	93                   	xchg   bx,ax
    3d02:	00 00                	add    BYTE PTR [bx+si],al
    3d04:	6c                   	ins    BYTE PTR es:[di],dx
    3d05:	93                   	xchg   bx,ax
    3d06:	00 00                	add    BYTE PTR [bx+si],al
    3d08:	78 93                	js     0x3c9d
    3d0a:	00 00                	add    BYTE PTR [bx+si],al
    3d0c:	84 93 00 00          	test   BYTE PTR [bp+di+0x0],dl
    3d10:	90                   	nop
    3d11:	93                   	xchg   bx,ax
    3d12:	00 00                	add    BYTE PTR [bx+si],al
    3d14:	9c                   	pushf
    3d15:	93                   	xchg   bx,ax
    3d16:	00 00                	add    BYTE PTR [bx+si],al
    3d18:	a8 93                	test   al,0x93
    3d1a:	00 00                	add    BYTE PTR [bx+si],al
    3d1c:	b4 93                	mov    ah,0x93
    3d1e:	00 00                	add    BYTE PTR [bx+si],al
    3d20:	c0 93 00 00 cc       	rcl    BYTE PTR [bp+di+0x0],0xcc
    3d25:	93                   	xchg   bx,ax
    3d26:	00 00                	add    BYTE PTR [bx+si],al
    3d28:	d8 93 00 00          	fcom   DWORD PTR [bp+di+0x0]
    3d2c:	e4 93                	in     al,0x93
    3d2e:	00 00                	add    BYTE PTR [bx+si],al
    3d30:	f0 93                	lock xchg bx,ax
    3d32:	00 00                	add    BYTE PTR [bx+si],al
    3d34:	fc                   	cld
    3d35:	93                   	xchg   bx,ax
    3d36:	00 00                	add    BYTE PTR [bx+si],al
    3d38:	08 94 00 00          	or     BYTE PTR [si+0x0],dl
    3d3c:	14 94                	adc    al,0x94
    3d3e:	00 00                	add    BYTE PTR [bx+si],al
    3d40:	20 94 00 00          	and    BYTE PTR [si+0x0],dl
    3d44:	2c 94                	sub    al,0x94
    3d46:	00 00                	add    BYTE PTR [bx+si],al
    3d48:	38 94 00 00          	cmp    BYTE PTR [si+0x0],dl
