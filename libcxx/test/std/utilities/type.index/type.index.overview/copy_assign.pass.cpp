//===----------------------------------------------------------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

// <typeindex>

// class type_index

// type_index& operator=(const type_index& ti);

#include <typeindex>
#include <cassert>

int main()
{
    std::type_index t1(typeid(int));
    std::type_index t2(typeid(double));
    assert(t2 != t1);
    t2 = t1;
    assert(t2 == t1);
}
