; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -show-mc-encoding -mattr=+sse2 | FileCheck %s --check-prefix=SSE
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -show-mc-encoding -mattr=+avx  | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -mtriple=x86_64-unknown-unknown -show-mc-encoding -mattr=+avx512dq,+avx512vl  | FileCheck %s --check-prefix=AVX512DQ

; Test that we can replace "scalar" FP-bitwise-logic with the optimal instruction.
; Scalar x86 FP-logic instructions only exist in your imagination and/or the bowels
; of compilers, but float and double variants of FP-logic instructions are reality
; and float may be a shorter instruction depending on which flavor of vector ISA
; you have...so just prefer float all the time, ok? Yay, x86!

define double @FsANDPSrr(double %x, double %y) {
; SSE-LABEL: FsANDPSrr:
; SSE:       # %bb.0:
; SSE-NEXT:    andps %xmm1, %xmm0 # encoding: [0x0f,0x54,0xc1]
; SSE-NEXT:    retq # encoding: [0xc3]
;
; AVX-LABEL: FsANDPSrr:
; AVX:       # %bb.0:
; AVX-NEXT:    vandps %xmm1, %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x54,0xc1]
; AVX-NEXT:    retq # encoding: [0xc3]
;
; AVX512DQ-LABEL: FsANDPSrr:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vandps %xmm1, %xmm0, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x54,0xc1]
; AVX512DQ-NEXT:    retq # encoding: [0xc3]
  %bc1 = bitcast double %x to i64
  %bc2 = bitcast double %y to i64
  %and = and i64 %bc1, %bc2
  %bc3 = bitcast i64 %and to double
  ret double %bc3
}

define double @FsANDNPSrr(double %x, double %y) {
; SSE-LABEL: FsANDNPSrr:
; SSE:       # %bb.0:
; SSE-NEXT:    andnps %xmm0, %xmm1 # encoding: [0x0f,0x55,0xc8]
; SSE-NEXT:    movaps %xmm1, %xmm0 # encoding: [0x0f,0x28,0xc1]
; SSE-NEXT:    retq # encoding: [0xc3]
;
; AVX-LABEL: FsANDNPSrr:
; AVX:       # %bb.0:
; AVX-NEXT:    vandnps %xmm0, %xmm1, %xmm0 # encoding: [0xc5,0xf0,0x55,0xc0]
; AVX-NEXT:    retq # encoding: [0xc3]
;
; AVX512DQ-LABEL: FsANDNPSrr:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vandnps %xmm0, %xmm1, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf0,0x55,0xc0]
; AVX512DQ-NEXT:    retq # encoding: [0xc3]
  %bc1 = bitcast double %x to i64
  %bc2 = bitcast double %y to i64
  %not = xor i64 %bc2, -1
  %and = and i64 %bc1, %not
  %bc3 = bitcast i64 %and to double
  ret double %bc3
}

define double @FsORPSrr(double %x, double %y) {
; SSE-LABEL: FsORPSrr:
; SSE:       # %bb.0:
; SSE-NEXT:    orps %xmm1, %xmm0 # encoding: [0x0f,0x56,0xc1]
; SSE-NEXT:    retq # encoding: [0xc3]
;
; AVX-LABEL: FsORPSrr:
; AVX:       # %bb.0:
; AVX-NEXT:    vorps %xmm1, %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x56,0xc1]
; AVX-NEXT:    retq # encoding: [0xc3]
;
; AVX512DQ-LABEL: FsORPSrr:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vorps %xmm1, %xmm0, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x56,0xc1]
; AVX512DQ-NEXT:    retq # encoding: [0xc3]
  %bc1 = bitcast double %x to i64
  %bc2 = bitcast double %y to i64
  %or = or i64 %bc1, %bc2
  %bc3 = bitcast i64 %or to double
  ret double %bc3
}

define double @FsXORPSrr(double %x, double %y) {
; SSE-LABEL: FsXORPSrr:
; SSE:       # %bb.0:
; SSE-NEXT:    xorps %xmm1, %xmm0 # encoding: [0x0f,0x57,0xc1]
; SSE-NEXT:    retq # encoding: [0xc3]
;
; AVX-LABEL: FsXORPSrr:
; AVX:       # %bb.0:
; AVX-NEXT:    vxorps %xmm1, %xmm0, %xmm0 # encoding: [0xc5,0xf8,0x57,0xc1]
; AVX-NEXT:    retq # encoding: [0xc3]
;
; AVX512DQ-LABEL: FsXORPSrr:
; AVX512DQ:       # %bb.0:
; AVX512DQ-NEXT:    vxorps %xmm1, %xmm0, %xmm0 # EVEX TO VEX Compression encoding: [0xc5,0xf8,0x57,0xc1]
; AVX512DQ-NEXT:    retq # encoding: [0xc3]
  %bc1 = bitcast double %x to i64
  %bc2 = bitcast double %y to i64
  %xor = xor i64 %bc1, %bc2
  %bc3 = bitcast i64 %xor to double
  ret double %bc3
}

