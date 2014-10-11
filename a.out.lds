OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
ENTRY(_start)
SECTIONS
{
 . = 0x21000000;

 . = ALIGN(4);
 .text :
 {
  _stext = .;
  _text = .;
  *(.text_entry*)
  __bare_init_start = .;
  *(.text_bare_init*)
  __bare_init_end = .;
  __exceptions_start = .;
  KEEP(*(.text_exceptions*))
  __exceptions_stop = .;
  *(.text*)
 }
 . = ALIGN(4);
 .rodata : { *(.rodata*) }
 _etext = .; /* End of text and rodata section */
 _sdata = .;
 . = ALIGN(4);
 .data : { *(.data*) }
 . = .;
 .rel.dyn : {
  __rel_dyn_start = .;
  *(.rel*)
  __rel_dyn_end = .;
 }
 .dynsym : {
  __dynsym_start = .;
  *(.dynsym)
  __dynsym_end = .;
 }
 _edata = .;
 . = ALIGN(4);
 __bss_start = .;
 .bss : { *(.bss*) }
 __bss_stop = .;
 _end = .;
 _barebox_image_size = __bss_start - 0x21000000;
}
