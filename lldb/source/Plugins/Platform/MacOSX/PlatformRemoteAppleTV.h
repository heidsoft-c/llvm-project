//===-- PlatformRemoteAppleTV.h ---------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef liblldb_PlatformRemoteAppleTV_h_
#define liblldb_PlatformRemoteAppleTV_h_

#include <string>

#include "lldb/Utility/FileSpec.h"

#include "llvm/Support/FileSystem.h"

#include "PlatformRemoteDarwinDevice.h"

class PlatformRemoteAppleTV : public PlatformRemoteDarwinDevice {
public:
  PlatformRemoteAppleTV();

  ~PlatformRemoteAppleTV() override = default;

  //------------------------------------------------------------
  // Class Functions
  //------------------------------------------------------------
  static lldb::PlatformSP CreateInstance(bool force,
                                         const lldb_private::ArchSpec *arch);

  static void Initialize();

  static void Terminate();

  static lldb_private::ConstString GetPluginNameStatic();

  static const char *GetDescriptionStatic();

  //------------------------------------------------------------
  // lldb_private::PluginInterface functions
  //------------------------------------------------------------
  lldb_private::ConstString GetPluginName() override {
    return GetPluginNameStatic();
  }

  uint32_t GetPluginVersion() override { return 1; }

  //------------------------------------------------------------
  // lldb_private::Platform functions
  //------------------------------------------------------------

  const char *GetDescription() override { return GetDescriptionStatic(); }

  bool GetSupportedArchitectureAtIndex(uint32_t idx,
                                       lldb_private::ArchSpec &arch) override;

protected:

  //------------------------------------------------------------
  // lldb_private::PlatformRemoteDarwinDevice functions
  //------------------------------------------------------------

  void GetDeviceSupportDirectoryNames (std::vector<std::string> &dirnames) override;

  std::string GetPlatformName () override;

private:
  DISALLOW_COPY_AND_ASSIGN(PlatformRemoteAppleTV);
};

#endif // liblldb_PlatformRemoteAppleTV_h_
