	.file	"SHITIDE.c"
	.text
	.globl	channels
	.section	.bss
	.align 4
	.type	channels, @object
	.size	channels, 16
channels:
	.zero	16
	.globl	ide_buf
	.align 32
	.type	ide_buf, @object
	.size	ide_buf, 2048
ide_buf:
	.zero	2048
	.local	ide_irq_invoked
	.comm	ide_irq_invoked,1,1
	.data
	.align 4
	.type	atapi_packet, @object
	.size	atapi_packet, 12
atapi_packet:
	.base64	"qAAAAAAAAAAAAAAA"
	.ident	"GCC: (GNU) 15.2.0"
