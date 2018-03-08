ENTRY(_start)
MEMORY
{
	RAM(rwx) : ORIGIN = 0xff000000 , LENGTH = 10M
}
SECTIONS
{
	. = ALIGN(4);

	.text :
	{
		text_start = . ;
		*(.text)
		text_end = . ;
	} > RAM

	. = ALIGN(4);

	.rodata :
	{
		rodata_start = . ;
		*(.rodata)
		rodata_end = . ;
	} > RAM

	. = ALIGN(4);

	.data :
	{
		data_start = . ;
		*(.data)
		data_end = . ;
	} > RAM

	. = ALIGN(4);

	.bss :
	{
		bss_start = . ;
		*(.bss)
		*(COMMON)
		bss_end = . ;
	} > RAM

	. = ALIGN(4);
}
