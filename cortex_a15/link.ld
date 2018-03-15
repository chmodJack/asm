ENTRY(_start)
MEMORY
{
	RAM(rwx) : o = 0x00000000 , l = 512M
}
SECTIONS
{
	. = ALIGN(4);

	.vectors :
	{
		*(.vectors)
	} > RAM

	. = ALIGN(4);

	.text :
	{
		*(.text)
	} > RAM

	. = ALIGN(4);
	
	.rodata :
	{
		*(.rodata)
	} > RAM

	. = ALIGN(4);

	_data_start = . ;

	.data :
	{
		*(.data)
	} > RAM

	. = ALIGN(4);

	_bss_start = . ;

	.bss :
	{
		*(.bss)
		*(COMMON)
	} > RAM
	. = ALIGN(4);

	_bss_end = . ;
}
