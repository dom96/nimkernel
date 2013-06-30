import ioutils
type
  TMultiboot_header{.pure, final.} = object
  PMultiboot_header = ptr TMultiboot_header

proc kmain(mb_header: PMultiboot_header, magic: int) {.exportc.} =
  if magic != 0x2BADB002:
    # Something went wrong?
  
  var vram = cast[PVIDMem](0xB8000)
  screenClear(vram, Yellow) # Make the screen yellow.
  
  # Demonstration of error handling.
  var outOfBounds = vram[len(vram[])]
  
  let attr = makeColor(Yellow, DarkGrey)
  writeString(vram, "Nimrod", attr, (25, 9))
  writeString(vram, "Expressive. Efficient. Elegant.", attr, (25, 10))
  rainbow(vram, "It's pure pleasure.", (x: 25, y: 11))

