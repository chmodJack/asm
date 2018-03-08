ENTRY(_start)
MEMORY
{
	RAM(rwx) : ORIGIN = 0x00000000 , LENGTH = 10M
}
SECTIONS
{
	.text :
	{
		text_start = . ;
		. = ALIGN(4);
		*(.text)
		. = ALIGN(4);
		text_end = . ;
	} > RAM

	.rodata :
	{
		rodata_start = . ;
		. = ALIGN(4);
		*(.rodata)
		. = ALIGN(4);
		rodata_end = . ;
	} > RAM

	.data :
	{
		data_start = . ;
		. = ALIGN(4);
		*(.data)
		. = ALIGN(4);
		data_end = . ;
	} > RAM

	.bss :
	{
		bss_start = . ;
		. = ALIGN(4);
		*(.bss)
		*(COMMON)
		. = ALIGN(4);
		bss_end = . ;
	} > RAM
}
