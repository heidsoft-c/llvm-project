//===- Writer.h -------------------------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLVM_TOOLS_OBJCOPY_COFF_WRITER_H
#define LLVM_TOOLS_OBJCOPY_COFF_WRITER_H

#include "Buffer.h"
#include "llvm/MC/StringTableBuilder.h"
#include "llvm/Support/Error.h"
#include <cstddef>
#include <utility>

namespace llvm {
namespace objcopy {
namespace coff {

struct Object;

class COFFWriter {
  Object &Obj;
  Buffer &Buf;

  size_t FileSize;
  size_t FileAlignment;
  size_t SizeOfInitializedData;
  StringTableBuilder StrTabBuilder;

  Error finalizeRelocTargets();
  Error finalizeSectionNumbers();
  void layoutSections();
  size_t finalizeStringTable();
  template <class SymbolTy> std::pair<size_t, size_t> finalizeSymbolTable();

  Error finalize(bool IsBigObj);

  void writeHeaders(bool IsBigObj);
  void writeSections();
  template <class SymbolTy> void writeSymbolStringTables();

  Error write(bool IsBigObj);

  Error patchDebugDirectory();

public:
  virtual ~COFFWriter() {}
  Error write();

  COFFWriter(Object &Obj, Buffer &Buf)
      : Obj(Obj), Buf(Buf), StrTabBuilder(StringTableBuilder::WinCOFF) {}
};

} // end namespace coff
} // end namespace objcopy
} // end namespace llvm

#endif // LLVM_TOOLS_OBJCOPY_COFF_WRITER_H
