import os
import ../core/header
import ../core/elf_costant
import streams
import strutils



proc elf_parser*(filename: string): ELF_Header =
 echo "name of the file is: ", filename
 var stream = newFileStream(filename, fmRead)
 defer: stream.close()
 var header: ELF_Header

 if isNil(stream):
  echo "stream is null"
 var x: int = stream.readData(header.addr, sizeof(header))

 echo "Class: ", if header.class == 1: "ELF32" 
  elif header.class == 2:"ELF64" else: "Unknown"
 echo "Endianness: ", if header.data == 1: "Little Endian" elif header.data == 2: "Big Endian" else: "Unknown"
 echo "Type: ", case header.eType:
  of 1: "Relocatable"
  of 2: "Executable"
  of 3: "Shared Object"
  of 4: "Core Dump"
  else: "Unknown"
 echo "Machine: ", header.eMachine
 echo "Entry Point: 0x", toHex(header.eEntry)
 echo "Program Header Offset: ", header.ePhoff
 echo "Section Header Offset: ", header.eShoff
 echo "Flags: ", header.eFlags
 echo "ELF Header Size: ", header.eEhsize
 echo "Program Header Entries: ", header.ePhnum
 echo "Section Header Entries: ", header.eShnum
 echo "Section Name Index: ", header.eShstrndx

 return header


# Funzione per leggere i Program Headers
proc readProgramHeaders*(file: string, phoff: uint64, phnum: uint16, phentsize: uint16): seq[Elf64Phdr] =
  var f = newFileStream(file, fmRead)
  defer: f.close()

  var phdrs: seq[Elf64Phdr]
  
#funziona male, rivedere l'offset
  for i in 0..(int(phnum) - 1):
    var ph: Elf64Phdr

    # Calcoliamo l'offset giusto per questo header
    let offset = phoff + uint64(i) * uint64(phentsize)

    # Spostiamo manualmente la posizione del file all'offset corretto (senza usare seek)
    f.setPosition(int(offset))  # Castiamo l'offset a int per evitare il tipo mismatch

    # Leggi i dati dell'header in una sequenza di byte
    var buffer: seq[byte]
    buffer.setLen(sizeof(Elf64Phdr))  # Allochiamo lo spazio necessario per l'header

    discard f.readData(addr buffer[0], buffer.len)  # Leggiamo i dati direttamente

    # Ora interpretiamo i byte letti come Elf64Phdr
    ph = cast[Elf64Phdr](addr buffer[0])  # Converti i byte letti nel tipo Elf64Phdr

    phdrs.add(ph)

  result = phdrs

