; ModuleID = 'hellollvm.cpp'
source_filename = "hellollvm.cpp"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.llvm::StringRef" = type { i8*, i64 }
%"class.llvm::SMDiagnostic" = type { %"class.llvm::SourceMgr"*, %"class.llvm::SMLoc", %"class.std::__cxx11::basic_string", i32, i32, i32, %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::vector.10", %"class.llvm::SmallVector" }
%"class.llvm::SourceMgr" = type { %"class.std::vector", %"class.std::vector.2", i8*, void (%"class.llvm::SMDiagnostic"*, i8*)*, i8* }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<llvm::SourceMgr::SrcBuffer, std::allocator<llvm::SourceMgr::SrcBuffer> >::_Vector_impl" }
%"struct.std::_Vector_base<llvm::SourceMgr::SrcBuffer, std::allocator<llvm::SourceMgr::SrcBuffer> >::_Vector_impl" = type { %"struct.llvm::SourceMgr::SrcBuffer"*, %"struct.llvm::SourceMgr::SrcBuffer"*, %"struct.llvm::SourceMgr::SrcBuffer"* }
%"struct.llvm::SourceMgr::SrcBuffer" = type { %"class.std::unique_ptr", %"class.llvm::SMLoc" }
%"class.std::unique_ptr" = type { %"class.std::__uniq_ptr_impl" }
%"class.std::__uniq_ptr_impl" = type { %"class.std::tuple" }
%"class.std::tuple" = type { %"struct.std::_Tuple_impl" }
%"struct.std::_Tuple_impl" = type { %"struct.std::_Head_base.1" }
%"struct.std::_Head_base.1" = type { %"class.llvm::MemoryBuffer"* }
%"class.llvm::MemoryBuffer" = type { i32 (...)**, i8*, i8* }
%"class.std::vector.2" = type { %"struct.std::_Vector_base.3" }
%"struct.std::_Vector_base.3" = type { %"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl" }
%"struct.std::_Vector_base<std::__cxx11::basic_string<char>, std::allocator<std::__cxx11::basic_string<char> > >::_Vector_impl" = type { %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"*, %"class.std::__cxx11::basic_string"* }
%"class.llvm::SMLoc" = type { i8* }
%"class.std::__cxx11::basic_string" = type { %"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider", i64, %union.anon }
%"struct.std::__cxx11::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%union.anon = type { i64, [8 x i8] }
%"class.std::vector.10" = type { %"struct.std::_Vector_base.11" }
%"struct.std::_Vector_base.11" = type { %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl" }
%"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl" = type { %"struct.std::pair"*, %"struct.std::pair"*, %"struct.std::pair"* }
%"struct.std::pair" = type { i32, i32 }
%"class.llvm::SmallVector" = type { %"class.llvm::SmallVectorImpl", %"struct.llvm::SmallVectorStorage" }
%"class.llvm::SmallVectorImpl" = type { %"class.llvm::SmallVectorTemplateBase" }
%"class.llvm::SmallVectorTemplateBase" = type { %"class.llvm::SmallVectorTemplateCommon" }
%"class.llvm::SmallVectorTemplateCommon" = type { %"class.llvm::SmallVectorBase", %"struct.llvm::AlignedCharArrayUnion" }
%"class.llvm::SmallVectorBase" = type { i8*, i8*, i8* }
%"struct.llvm::AlignedCharArrayUnion" = type { %"struct.llvm::AlignedCharArray" }
%"struct.llvm::AlignedCharArray" = type { [48 x i8] }
%"struct.llvm::SmallVectorStorage" = type { [3 x %"struct.llvm::AlignedCharArrayUnion"] }
%"class.llvm::LLVMContext" = type { %"class.llvm::LLVMContextImpl"* }
%"class.llvm::LLVMContextImpl" = type opaque
%"class.std::unique_ptr.15" = type { %"class.std::__uniq_ptr_impl.16" }
%"class.std::__uniq_ptr_impl.16" = type { %"class.std::tuple.17" }
%"class.std::tuple.17" = type { %"struct.std::_Tuple_impl.18" }
%"struct.std::_Tuple_impl.18" = type { %"struct.std::_Head_base.23" }
%"struct.std::_Head_base.23" = type { %"class.llvm::Module"* }
%"class.llvm::Module" = type { %"class.llvm::LLVMContext"*, %"class.llvm::SymbolTableList", %"class.llvm::SymbolTableList.24", %"class.llvm::SymbolTableList.32", %"class.llvm::SymbolTableList.40", %"class.llvm::iplist", %"class.std::__cxx11::basic_string", %"class.llvm::ValueSymbolTable"*, %"class.llvm::StringMap", %"class.std::unique_ptr", %"class.std::unique_ptr.54", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", %"class.std::__cxx11::basic_string", i8*, %"class.llvm::DataLayout" }
%"class.llvm::SymbolTableList" = type { %"class.llvm::iplist_impl" }
%"class.llvm::iplist_impl" = type { %"class.llvm::simple_ilist" }
%"class.llvm::simple_ilist" = type { %"class.llvm::ilist_sentinel" }
%"class.llvm::ilist_sentinel" = type { %"class.llvm::ilist_node_impl" }
%"class.llvm::ilist_node_impl" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::ilist_node_base" = type { %"class.llvm::ilist_node_base"*, %"class.llvm::ilist_node_base"* }
%"class.llvm::SymbolTableList.24" = type { %"class.llvm::iplist_impl.25" }
%"class.llvm::iplist_impl.25" = type { %"class.llvm::simple_ilist.28" }
%"class.llvm::simple_ilist.28" = type { %"class.llvm::ilist_sentinel.30" }
%"class.llvm::ilist_sentinel.30" = type { %"class.llvm::ilist_node_impl.31" }
%"class.llvm::ilist_node_impl.31" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::SymbolTableList.32" = type { %"class.llvm::iplist_impl.33" }
%"class.llvm::iplist_impl.33" = type { %"class.llvm::simple_ilist.36" }
%"class.llvm::simple_ilist.36" = type { %"class.llvm::ilist_sentinel.38" }
%"class.llvm::ilist_sentinel.38" = type { %"class.llvm::ilist_node_impl.39" }
%"class.llvm::ilist_node_impl.39" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::SymbolTableList.40" = type { %"class.llvm::iplist_impl.41" }
%"class.llvm::iplist_impl.41" = type { %"class.llvm::simple_ilist.44" }
%"class.llvm::simple_ilist.44" = type { %"class.llvm::ilist_sentinel.46" }
%"class.llvm::ilist_sentinel.46" = type { %"class.llvm::ilist_node_impl.47" }
%"class.llvm::ilist_node_impl.47" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::iplist" = type { %"class.llvm::iplist_impl.48" }
%"class.llvm::iplist_impl.48" = type { %"class.llvm::simple_ilist.50" }
%"class.llvm::simple_ilist.50" = type { %"class.llvm::ilist_sentinel.52" }
%"class.llvm::ilist_sentinel.52" = type { %"class.llvm::ilist_node_impl.53" }
%"class.llvm::ilist_node_impl.53" = type { %"class.llvm::ilist_node_base" }
%"class.llvm::ValueSymbolTable" = type opaque
%"class.llvm::StringMap" = type <{ %"class.llvm::StringMapImpl", %"class.llvm::MallocAllocator", [7 x i8] }>
%"class.llvm::StringMapImpl" = type { %"class.llvm::StringMapEntryBase"**, i32, i32, i32, i32 }
%"class.llvm::StringMapEntryBase" = type { i32 }
%"class.llvm::MallocAllocator" = type { i8 }
%"class.std::unique_ptr.54" = type { %"class.std::__uniq_ptr_impl.55" }
%"class.std::__uniq_ptr_impl.55" = type { %"class.std::tuple.56" }
%"class.std::tuple.56" = type { %"struct.std::_Tuple_impl.57" }
%"struct.std::_Tuple_impl.57" = type { %"struct.std::_Head_base.62" }
%"struct.std::_Head_base.62" = type { %"class.llvm::GVMaterializer"* }
%"class.llvm::GVMaterializer" = type opaque
%"class.llvm::DataLayout" = type { i8, i32, i32, i32, %"class.llvm::SmallVector.63", %"class.llvm::SmallVector.70", %"class.std::__cxx11::basic_string", %"class.llvm::SmallVector.77", i8*, %"class.llvm::SmallVector.84" }
%"class.llvm::SmallVector.63" = type { %"class.llvm::SmallVectorImpl.base", %"struct.llvm::SmallVectorStorage.69" }
%"class.llvm::SmallVectorImpl.base" = type { %"class.llvm::SmallVectorTemplateBase.base" }
%"class.llvm::SmallVectorTemplateBase.base" = type { %"class.llvm::SmallVectorTemplateCommon.base" }
%"class.llvm::SmallVectorTemplateCommon.base" = type <{ %"class.llvm::SmallVectorBase", %"struct.llvm::AlignedCharArrayUnion.67" }>
%"struct.llvm::AlignedCharArrayUnion.67" = type { %"struct.llvm::AlignedCharArray.68" }
%"struct.llvm::AlignedCharArray.68" = type { [1 x i8] }
%"struct.llvm::SmallVectorStorage.69" = type { [7 x %"struct.llvm::AlignedCharArrayUnion.67"] }
%"class.llvm::SmallVector.70" = type { %"class.llvm::SmallVectorImpl.71", %"struct.llvm::SmallVectorStorage.76" }
%"class.llvm::SmallVectorImpl.71" = type { %"class.llvm::SmallVectorTemplateBase.72" }
%"class.llvm::SmallVectorTemplateBase.72" = type { %"class.llvm::SmallVectorTemplateCommon.73" }
%"class.llvm::SmallVectorTemplateCommon.73" = type { %"class.llvm::SmallVectorBase", %"struct.llvm::AlignedCharArrayUnion.74" }
%"struct.llvm::AlignedCharArrayUnion.74" = type { %"struct.llvm::AlignedCharArray.75" }
%"struct.llvm::AlignedCharArray.75" = type { [8 x i8] }
%"struct.llvm::SmallVectorStorage.76" = type { [15 x %"struct.llvm::AlignedCharArrayUnion.74"] }
%"class.llvm::SmallVector.77" = type { %"class.llvm::SmallVectorImpl.78", %"struct.llvm::SmallVectorStorage.83" }
%"class.llvm::SmallVectorImpl.78" = type { %"class.llvm::SmallVectorTemplateBase.79" }
%"class.llvm::SmallVectorTemplateBase.79" = type { %"class.llvm::SmallVectorTemplateCommon.80" }
%"class.llvm::SmallVectorTemplateCommon.80" = type { %"class.llvm::SmallVectorBase", %"struct.llvm::AlignedCharArrayUnion.81" }
%"struct.llvm::AlignedCharArrayUnion.81" = type { %"struct.llvm::AlignedCharArray.82" }
%"struct.llvm::AlignedCharArray.82" = type { [16 x i8] }
%"struct.llvm::SmallVectorStorage.83" = type { [7 x %"struct.llvm::AlignedCharArrayUnion.81"] }
%"class.llvm::SmallVector.84" = type { %"class.llvm::SmallVectorImpl.base.92", %"struct.llvm::SmallVectorStorage.93" }
%"class.llvm::SmallVectorImpl.base.92" = type { %"class.llvm::SmallVectorTemplateBase.base.91" }
%"class.llvm::SmallVectorTemplateBase.base.91" = type { %"class.llvm::SmallVectorTemplateCommon.base.90" }
%"class.llvm::SmallVectorTemplateCommon.base.90" = type <{ %"class.llvm::SmallVectorBase", %"struct.llvm::AlignedCharArrayUnion.88" }>
%"struct.llvm::AlignedCharArrayUnion.88" = type { %"struct.llvm::AlignedCharArray.89" }
%"struct.llvm::AlignedCharArray.89" = type { [4 x i8] }
%"struct.llvm::SmallVectorStorage.93" = type { [7 x %"struct.llvm::AlignedCharArrayUnion.88"] }
%"class.llvm::ilist_iterator" = type { %"class.llvm::ilist_node_impl.53"* }
%"class.llvm::ilist_iterator.94" = type { %"class.llvm::ilist_node_impl.53"* }
%"class.llvm::Metadata" = type { i8, i8, i16, i32 }
%"class.llvm::MDNode" = type { %"class.llvm::Metadata", i32, i32, %"class.llvm::ContextAndReplaceableUses" }
%"class.llvm::ContextAndReplaceableUses" = type { %"class.llvm::PointerUnion" }
%"class.llvm::PointerUnion" = type { %"class.llvm::PointerIntPair" }
%"class.llvm::PointerIntPair" = type { i64 }
%"class.llvm::raw_ostream" = type <{ i32 (...)**, i8*, i8*, i8*, i32, [4 x i8] }>
%"class.llvm::NamedMDNode" = type { %"class.llvm::ilist_node", %"class.std::__cxx11::basic_string", %"class.llvm::Module"*, i8* }
%"class.llvm::ilist_node" = type { %"class.llvm::ilist_node_impl.53" }
%"struct.llvm::ilist_detail::SpecificNodeAccess.51" = type { i8 }
%"struct.std::default_delete.21" = type { i8 }
%"class.std::allocator.12" = type { i8 }
%"class.__gnu_cxx::new_allocator.13" = type { i8 }
%"class.llvm::SMFixIt" = type { %"class.llvm::SMRange", %"class.std::__cxx11::basic_string" }
%"class.llvm::SMRange" = type { %"class.llvm::SMLoc", %"class.llvm::SMLoc" }
%"struct.std::_Tuple_impl.19" = type { i8 }
%"struct.std::_Head_base.20" = type { i8 }

$_ZN4llvm11raw_ostreamlsEPKc = comdat any

$_ZN4llvm12SMDiagnosticC2Ev = comdat any

$_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEcvbEv = comdat any

$_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEptEv = comdat any

$_ZN4llvm6Module20named_metadata_beginEv = comdat any

$_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEC2ILb0EEERKNS0_IS4_Lb0EXT_EEENSt9enable_ifIXooLb1EntT_EPvE4typeE = comdat any

$_ZN4llvm6Module18named_metadata_endEv = comdat any

$_ZN4llvmneERKNS_14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEES7_ = comdat any

$_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEptEv = comdat any

$_ZN4llvm8dyn_castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_ = comdat any

$_ZN4llvm11raw_ostreamlsEj = comdat any

$_ZNK4llvm6MDNode14getNumOperandsEv = comdat any

$_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEppEv = comdat any

$_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EED2Ev = comdat any

$_ZN4llvm12SMDiagnosticD2Ev = comdat any

$_ZN4llvm11raw_ostreamlsENS_9StringRefE = comdat any

$_ZN4llvm5SMLocC2Ev = comdat any

$_ZNSt6vectorISt4pairIjjESaIS1_EEC2Ev = comdat any

$_ZN4llvm11SmallVectorINS_7SMFixItELj4EEC2Ev = comdat any

$_ZNSt6vectorISt4pairIjjESaIS1_EED2Ev = comdat any

$_ZNSt12_Vector_baseISt4pairIjjESaIS1_EEC2Ev = comdat any

$__clang_call_terminate = comdat any

$_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implC2Ev = comdat any

$_ZNSaISt4pairIjjEEC2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorISt4pairIjjEEC2Ev = comdat any

$_ZN4llvm15SmallVectorImplINS_7SMFixItEEC2Ej = comdat any

$_ZN4llvm23SmallVectorTemplateBaseINS_7SMFixItELb0EEC2Em = comdat any

$_ZN4llvm25SmallVectorTemplateCommonINS_7SMFixItEvEC2Em = comdat any

$_ZN4llvm15SmallVectorBaseC2EPvm = comdat any

$_ZSt8_DestroyIPSt4pairIjjES1_EvT_S3_RSaIT0_E = comdat any

$_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE19_M_get_Tp_allocatorEv = comdat any

$_ZNSt12_Vector_baseISt4pairIjjESaIS1_EED2Ev = comdat any

$_ZSt8_DestroyIPSt4pairIjjEEvT_S3_ = comdat any

$_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIjjEEEvT_S5_ = comdat any

$_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE13_M_deallocateEPS1_m = comdat any

$_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implD2Ev = comdat any

$_ZNSt16allocator_traitsISaISt4pairIjjEEE10deallocateERS2_PS1_m = comdat any

$_ZN9__gnu_cxx13new_allocatorISt4pairIjjEE10deallocateEPS2_m = comdat any

$_ZNSaISt4pairIjjEED2Ev = comdat any

$_ZN9__gnu_cxx13new_allocatorISt4pairIjjEED2Ev = comdat any

$_ZN4llvm12simple_ilistINS_11NamedMDNodeEJEE5beginEv = comdat any

$_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEC2ERNS_15ilist_node_implIS4_EE = comdat any

$_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEppEv = comdat any

$_ZN4llvm15ilist_node_implINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE7getNextEv = comdat any

$_ZNK4llvm15ilist_node_baseILb0EE7getNextEv = comdat any

$_ZN4llvm12simple_ilistINS_11NamedMDNodeEJEE3endEv = comdat any

$_ZN4llvm11SmallVectorINS_7SMFixItELj4EED2Ev = comdat any

$_ZN4llvm15SmallVectorImplINS_7SMFixItEED2Ev = comdat any

$_ZN4llvm23SmallVectorTemplateBaseINS_7SMFixItELb0EE13destroy_rangeEPS1_S3_ = comdat any

$_ZNK4llvm25SmallVectorTemplateCommonINS_7SMFixItEvE7isSmallEv = comdat any

$_ZN4llvm7SMFixItD2Ev = comdat any

$_ZNSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE6_M_ptrEv = comdat any

$_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE11get_deleterEv = comdat any

$_ZNKSt14default_deleteIN4llvm6ModuleEEclEPS1_ = comdat any

$_ZSt3getILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS9_ = comdat any

$_ZSt12__get_helperILm0EPN4llvm6ModuleEJSt14default_deleteIS1_EEERT0_RSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEE7_M_headERS5_ = comdat any

$_ZNSt10_Head_baseILm0EPN4llvm6ModuleELb0EE7_M_headERS3_ = comdat any

$_ZNSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE10_M_deleterEv = comdat any

$_ZSt3getILm1EJPN4llvm6ModuleESt14default_deleteIS1_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS9_ = comdat any

$_ZSt12__get_helperILm1ESt14default_deleteIN4llvm6ModuleEEJEERT0_RSt11_Tuple_implIXT_EJS4_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm1EJSt14default_deleteIN4llvm6ModuleEEEE7_M_headERS4_ = comdat any

$_ZNSt10_Head_baseILm1ESt14default_deleteIN4llvm6ModuleEELb1EE7_M_headERS4_ = comdat any

$_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE3getEv = comdat any

$_ZNKSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE6_M_ptrEv = comdat any

$_ZSt3getILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_ = comdat any

$_ZSt12__get_helperILm0EPN4llvm6ModuleEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE = comdat any

$_ZNSt11_Tuple_implILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEE7_M_headERKS5_ = comdat any

$_ZNSt10_Head_baseILm0EPN4llvm6ModuleELb0EE7_M_headERKS3_ = comdat any

$_ZNK4llvm15ilist_node_implINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE7getNextEv = comdat any

$_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEdeEv = comdat any

$_ZNK4llvm15ilist_node_baseILb0EE15isKnownSentinelEv = comdat any

$_ZN4llvm12ilist_detail18SpecificNodeAccessINS0_12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE11getValuePtrEPKNS_15ilist_node_implIS4_EE = comdat any

$_ZN4llvm12ilist_detail10NodeAccess11getValuePtrINS0_12node_optionsINS_11NamedMDNodeELb0ELb0EvEEEENT_13const_pointerEPKNS_15ilist_node_implIS6_EE = comdat any

$_ZN4llvm3isaINS_6MDNodeEPNS_8MetadataEEEbRKT0_ = comdat any

$_ZN4llvm4castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_ = comdat any

$_ZN4llvm13isa_impl_wrapINS_6MDNodeEKPNS_8MetadataEPKS2_E4doitERS4_ = comdat any

$_ZN4llvm13isa_impl_wrapINS_6MDNodeEPKNS_8MetadataES4_E4doitERKS4_ = comdat any

$_ZN4llvm13simplify_typeIKPNS_8MetadataEE18getSimplifiedValueERS3_ = comdat any

$_ZN4llvm11isa_impl_clINS_6MDNodeEPKNS_8MetadataEE4doitES4_ = comdat any

$_ZN4llvm8isa_implINS_6MDNodeENS_8MetadataEvE4doitERKS2_ = comdat any

$_ZN4llvm6MDNode7classofEPKNS_8MetadataE = comdat any

$_ZNK4llvm8Metadata13getMetadataIDEv = comdat any

$_ZN4llvm13simplify_typeIPNS_8MetadataEE18getSimplifiedValueERS2_ = comdat any

$_ZN4llvm16cast_convert_valINS_6MDNodeEPNS_8MetadataES3_E4doitERKS3_ = comdat any

@_ZN4llvm24DisableABIBreakingChecksE = external global i32, align 4
@_ZN4llvm30VerifyDisableABIBreakingChecksE = weak hidden global i32* @_ZN4llvm24DisableABIBreakingChecksE, align 8
@.str = private unnamed_addr constant [8 x i8] c"Usage: \00", align 1
@.str.1 = private unnamed_addr constant [12 x i8] c" <IR file>\0A\00", align 1
@.str.2 = private unnamed_addr constant [15 x i8] c"Found MDNode:\0A\00", align 1
@.str.3 = private unnamed_addr constant [25 x i8] c"  Has MDNode operand:\0A  \00", align 1
@.str.4 = private unnamed_addr constant [3 x i8] c"  \00", align 1
@.str.5 = private unnamed_addr constant [11 x i8] c" operands\0A\00", align 1
@.str.6 = private unnamed_addr constant [28 x i8] c"!NodePtr->isKnownSentinel()\00", align 1
@.str.7 = private unnamed_addr constant [39 x i8] c"/usr/include/llvm/ADT/ilist_iterator.h\00", align 1
@__PRETTY_FUNCTION__._ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEdeEv = private unnamed_addr constant [278 x i8] c"llvm::ilist_iterator::reference llvm::ilist_iterator<llvm::ilist_detail::node_options<llvm::NamedMDNode, false, false, void>, false, true>::operator*() const [OptionsT = llvm::ilist_detail::node_options<llvm::NamedMDNode, false, false, void>, IsReverse = false, IsConst = true]\00", align 1
@.str.8 = private unnamed_addr constant [29 x i8] c"isa<> used on a null pointer\00", align 1
@.str.9 = private unnamed_addr constant [38 x i8] c"Val && \22isa<> used on a null pointer\22\00", align 1
@.str.10 = private unnamed_addr constant [36 x i8] c"/usr/include/llvm/Support/Casting.h\00", align 1
@__PRETTY_FUNCTION__._ZN4llvm11isa_impl_clINS_6MDNodeEPKNS_8MetadataEE4doitES4_ = private unnamed_addr constant [139 x i8] c"static bool llvm::isa_impl_cl<llvm::MDNode, const llvm::Metadata *>::doit(const From *) [To = llvm::MDNode, From = const llvm::Metadata *]\00", align 1
@.str.11 = private unnamed_addr constant [42 x i8] c"cast<Ty>() argument of incompatible type!\00", align 1
@.str.12 = private unnamed_addr constant [59 x i8] c"isa<X>(Val) && \22cast<Ty>() argument of incompatible type!\22\00", align 1
@__PRETTY_FUNCTION__._ZN4llvm4castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_ = private unnamed_addr constant [93 x i8] c"typename cast_retty<X, Y *>::ret_type llvm::cast(Y *) [X = llvm::MDNode, Y = llvm::Metadata]\00", align 1

; Function Attrs: noinline norecurse optnone uwtable
define i32 @main(i32, i8**) #0 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %3 = alloca %"class.llvm::StringRef"*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i8**, align 8
  %8 = alloca %"class.llvm::SMDiagnostic", align 8
  %9 = alloca %"class.llvm::LLVMContext", align 8
  %10 = alloca i8*
  %11 = alloca i32
  %12 = alloca %"class.std::unique_ptr.15", align 8
  %13 = alloca %"class.llvm::StringRef", align 8
  %14 = alloca i32
  %15 = alloca %"class.llvm::ilist_iterator", align 8
  %16 = alloca %"class.llvm::ilist_iterator.94", align 8
  %17 = alloca %"class.llvm::ilist_iterator", align 8
  %18 = alloca %"class.llvm::ilist_iterator.94", align 8
  %19 = alloca i32, align 4
  %20 = alloca i32, align 4
  %21 = alloca %"class.llvm::Metadata"*, align 8
  %22 = alloca %"class.llvm::MDNode"*, align 8
  store i32 0, i32* %5, align 4
  store i32 %0, i32* %6, align 4
  store i8** %1, i8*** %7, align 8
  %23 = load i32, i32* %6, align 4
  %24 = icmp slt i32 %23, 2
  br i1 %24, label %25, label %33

; <label>:25:                                     ; preds = %2
  %26 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4errsEv()
  %27 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %26, i8* getelementptr inbounds ([8 x i8], [8 x i8]* @.str, i32 0, i32 0))
  %28 = load i8**, i8*** %7, align 8
  %29 = getelementptr inbounds i8*, i8** %28, i64 0
  %30 = load i8*, i8** %29, align 8
  %31 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %27, i8* %30)
  %32 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %31, i8* getelementptr inbounds ([12 x i8], [12 x i8]* @.str.1, i32 0, i32 0))
  store i32 1, i32* %5, align 4
  br label %144

; <label>:33:                                     ; preds = %2
  call void @_ZN4llvm12SMDiagnosticC2Ev(%"class.llvm::SMDiagnostic"* %8)
  invoke void @_ZN4llvm11LLVMContextC1Ev(%"class.llvm::LLVMContext"* %9)
          to label %34 unwind label %65

; <label>:34:                                     ; preds = %33
  %35 = load i8**, i8*** %7, align 8
  %36 = getelementptr inbounds i8*, i8** %35, i64 1
  %37 = load i8*, i8** %36, align 8
  store %"class.llvm::StringRef"* %13, %"class.llvm::StringRef"** %3, align 8
  store i8* %37, i8** %4, align 8
  %38 = load %"class.llvm::StringRef"*, %"class.llvm::StringRef"** %3, align 8
  %39 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %38, i32 0, i32 0
  %40 = load i8*, i8** %4, align 8
  store i8* %40, i8** %39, align 8
  %41 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %38, i32 0, i32 1
  %42 = load i8*, i8** %4, align 8
  %43 = icmp ne i8* %42, null
  br i1 %43, label %44, label %47

; <label>:44:                                     ; preds = %34
  %45 = load i8*, i8** %4, align 8
  %46 = call i64 @strlen(i8* %45) #10
  br label %48

; <label>:47:                                     ; preds = %34
  br label %48

; <label>:48:                                     ; preds = %44, %47
  %49 = phi i64 [ %46, %44 ], [ 0, %47 ]
  store i64 %49, i64* %41, align 8
  br label %50

; <label>:50:                                     ; preds = %48
  %51 = bitcast %"class.llvm::StringRef"* %13 to { i8*, i64 }*
  %52 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %51, i32 0, i32 0
  %53 = load i8*, i8** %52, align 8
  %54 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %51, i32 0, i32 1
  %55 = load i64, i64* %54, align 8
  invoke void @_ZN4llvm11parseIRFileENS_9StringRefERNS_12SMDiagnosticERNS_11LLVMContextEb(%"class.std::unique_ptr.15"* sret %12, i8* %53, i64 %55, %"class.llvm::SMDiagnostic"* dereferenceable(368) %8, %"class.llvm::LLVMContext"* dereferenceable(8) %9, i1 zeroext true)
          to label %56 unwind label %69

; <label>:56:                                     ; preds = %50
  %57 = call zeroext i1 @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.15"* %12) #11
  br i1 %57, label %77, label %58

; <label>:58:                                     ; preds = %56
  %59 = load i8**, i8*** %7, align 8
  %60 = getelementptr inbounds i8*, i8** %59, i64 0
  %61 = load i8*, i8** %60, align 8
  %62 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4errsEv()
          to label %63 unwind label %73

; <label>:63:                                     ; preds = %58
  invoke void @_ZNK4llvm12SMDiagnostic5printEPKcRNS_11raw_ostreamEbb(%"class.llvm::SMDiagnostic"* %8, i8* %61, %"class.llvm::raw_ostream"* dereferenceable(40) %62, i1 zeroext true, i1 zeroext true)
          to label %64 unwind label %73

; <label>:64:                                     ; preds = %63
  store i32 1, i32* %5, align 4
  store i32 1, i32* %14, align 4
  br label %141

; <label>:65:                                     ; preds = %33
  %66 = landingpad { i8*, i32 }
          cleanup
  %67 = extractvalue { i8*, i32 } %66, 0
  store i8* %67, i8** %10, align 8
  %68 = extractvalue { i8*, i32 } %66, 1
  store i32 %68, i32* %11, align 4
  br label %143

; <label>:69:                                     ; preds = %50
  %70 = landingpad { i8*, i32 }
          cleanup
  %71 = extractvalue { i8*, i32 } %70, 0
  store i8* %71, i8** %10, align 8
  %72 = extractvalue { i8*, i32 } %70, 1
  store i32 %72, i32* %11, align 4
  br label %142

; <label>:73:                                     ; preds = %137, %129, %127, %124, %122, %120, %118, %116, %109, %106, %104, %97, %95, %93, %91, %88, %85, %82, %80, %77, %63, %58
  %74 = landingpad { i8*, i32 }
          cleanup
  %75 = extractvalue { i8*, i32 } %74, 0
  store i8* %75, i8** %10, align 8
  %76 = extractvalue { i8*, i32 } %74, 1
  store i32 %76, i32* %11, align 4
  call void @_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EED2Ev(%"class.std::unique_ptr.15"* %12) #11
  br label %142

; <label>:77:                                     ; preds = %56
  %78 = call %"class.llvm::Module"* @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.15"* %12) #11
  %79 = invoke %"class.llvm::ilist_node_impl.53"* @_ZN4llvm6Module20named_metadata_beginEv(%"class.llvm::Module"* %78)
          to label %80 unwind label %73

; <label>:80:                                     ; preds = %77
  %81 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %16, i32 0, i32 0
  store %"class.llvm::ilist_node_impl.53"* %79, %"class.llvm::ilist_node_impl.53"** %81, align 8
  invoke void @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEC2ILb0EEERKNS0_IS4_Lb0EXT_EEENSt9enable_ifIXooLb1EntT_EPvE4typeE(%"class.llvm::ilist_iterator"* %15, %"class.llvm::ilist_iterator.94"* dereferenceable(8) %16, i8* null)
          to label %82 unwind label %73

; <label>:82:                                     ; preds = %80
  %83 = call %"class.llvm::Module"* @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.15"* %12) #11
  %84 = invoke %"class.llvm::ilist_node_impl.53"* @_ZN4llvm6Module18named_metadata_endEv(%"class.llvm::Module"* %83)
          to label %85 unwind label %73

; <label>:85:                                     ; preds = %82
  %86 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %18, i32 0, i32 0
  store %"class.llvm::ilist_node_impl.53"* %84, %"class.llvm::ilist_node_impl.53"** %86, align 8
  invoke void @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEC2ILb0EEERKNS0_IS4_Lb0EXT_EEENSt9enable_ifIXooLb1EntT_EPvE4typeE(%"class.llvm::ilist_iterator"* %17, %"class.llvm::ilist_iterator.94"* dereferenceable(8) %18, i8* null)
          to label %87 unwind label %73

; <label>:87:                                     ; preds = %85
  br label %88

; <label>:88:                                     ; preds = %139, %87
  %89 = invoke zeroext i1 @_ZN4llvmneERKNS_14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEES7_(%"class.llvm::ilist_iterator"* dereferenceable(8) %15, %"class.llvm::ilist_iterator"* dereferenceable(8) %17)
          to label %90 unwind label %73

; <label>:90:                                     ; preds = %88
  br i1 %89, label %91, label %140

; <label>:91:                                     ; preds = %90
  %92 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4outsEv()
          to label %93 unwind label %73

; <label>:93:                                     ; preds = %91
  %94 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %92, i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.2, i32 0, i32 0))
          to label %95 unwind label %73

; <label>:95:                                     ; preds = %93
  store i32 0, i32* %19, align 4
  %96 = invoke %"class.llvm::NamedMDNode"* @_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEptEv(%"class.llvm::ilist_iterator"* %15)
          to label %97 unwind label %73

; <label>:97:                                     ; preds = %95
  %98 = invoke i32 @_ZNK4llvm11NamedMDNode14getNumOperandsEv(%"class.llvm::NamedMDNode"* %96)
          to label %99 unwind label %73

; <label>:99:                                     ; preds = %97
  store i32 %98, i32* %20, align 4
  br label %100

; <label>:100:                                    ; preds = %133, %99
  %101 = load i32, i32* %19, align 4
  %102 = load i32, i32* %20, align 4
  %103 = icmp ne i32 %101, %102
  br i1 %103, label %104, label %136

; <label>:104:                                    ; preds = %100
  %105 = invoke %"class.llvm::NamedMDNode"* @_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEptEv(%"class.llvm::ilist_iterator"* %15)
          to label %106 unwind label %73

; <label>:106:                                    ; preds = %104
  %107 = load i32, i32* %19, align 4
  %108 = invoke %"class.llvm::MDNode"* @_ZNK4llvm11NamedMDNode10getOperandEj(%"class.llvm::NamedMDNode"* %105, i32 %107)
          to label %109 unwind label %73

; <label>:109:                                    ; preds = %106
  %110 = bitcast %"class.llvm::MDNode"* %108 to %"class.llvm::Metadata"*
  store %"class.llvm::Metadata"* %110, %"class.llvm::Metadata"** %21, align 8
  %111 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %21, align 8
  %112 = invoke %"class.llvm::MDNode"* @_ZN4llvm8dyn_castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_(%"class.llvm::Metadata"* %111)
          to label %113 unwind label %73

; <label>:113:                                    ; preds = %109
  store %"class.llvm::MDNode"* %112, %"class.llvm::MDNode"** %22, align 8
  %114 = load %"class.llvm::MDNode"*, %"class.llvm::MDNode"** %22, align 8
  %115 = icmp ne %"class.llvm::MDNode"* %114, null
  br i1 %115, label %116, label %132

; <label>:116:                                    ; preds = %113
  %117 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4outsEv()
          to label %118 unwind label %73

; <label>:118:                                    ; preds = %116
  %119 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %117, i8* getelementptr inbounds ([25 x i8], [25 x i8]* @.str.3, i32 0, i32 0))
          to label %120 unwind label %73

; <label>:120:                                    ; preds = %118
  %121 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4outsEv()
          to label %122 unwind label %73

; <label>:122:                                    ; preds = %120
  %123 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %121, i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i32 0, i32 0))
          to label %124 unwind label %73

; <label>:124:                                    ; preds = %122
  %125 = load %"class.llvm::MDNode"*, %"class.llvm::MDNode"** %22, align 8
  %126 = invoke i32 @_ZNK4llvm6MDNode14getNumOperandsEv(%"class.llvm::MDNode"* %125)
          to label %127 unwind label %73

; <label>:127:                                    ; preds = %124
  %128 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEj(%"class.llvm::raw_ostream"* %123, i32 %126)
          to label %129 unwind label %73

; <label>:129:                                    ; preds = %127
  %130 = invoke dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"* %128, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.5, i32 0, i32 0))
          to label %131 unwind label %73

; <label>:131:                                    ; preds = %129
  br label %132

; <label>:132:                                    ; preds = %131, %113
  br label %133

; <label>:133:                                    ; preds = %132
  %134 = load i32, i32* %19, align 4
  %135 = add i32 %134, 1
  store i32 %135, i32* %19, align 4
  br label %100

; <label>:136:                                    ; preds = %100
  br label %137

; <label>:137:                                    ; preds = %136
  %138 = invoke dereferenceable(8) %"class.llvm::ilist_iterator"* @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEppEv(%"class.llvm::ilist_iterator"* %15)
          to label %139 unwind label %73

; <label>:139:                                    ; preds = %137
  br label %88

; <label>:140:                                    ; preds = %90
  store i32 0, i32* %5, align 4
  store i32 1, i32* %14, align 4
  br label %141

; <label>:141:                                    ; preds = %140, %64
  call void @_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EED2Ev(%"class.std::unique_ptr.15"* %12) #11
  call void @_ZN4llvm11LLVMContextD1Ev(%"class.llvm::LLVMContext"* %9) #11
  call void @_ZN4llvm12SMDiagnosticD2Ev(%"class.llvm::SMDiagnostic"* %8) #11
  br label %144

; <label>:142:                                    ; preds = %73, %69
  call void @_ZN4llvm11LLVMContextD1Ev(%"class.llvm::LLVMContext"* %9) #11
  br label %143

; <label>:143:                                    ; preds = %142, %65
  call void @_ZN4llvm12SMDiagnosticD2Ev(%"class.llvm::SMDiagnostic"* %8) #11
  br label %146

; <label>:144:                                    ; preds = %141, %25
  %145 = load i32, i32* %5, align 4
  ret i32 %145

; <label>:146:                                    ; preds = %143
  %147 = load i8*, i8** %10, align 8
  %148 = load i32, i32* %11, align 4
  %149 = insertvalue { i8*, i32 } undef, i8* %147, 0
  %150 = insertvalue { i8*, i32 } %149, i32 %148, 1
  resume { i8*, i32 } %150
}

declare dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4errsEv() #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEPKc(%"class.llvm::raw_ostream"*, i8*) #2 comdat align 2 {
  %3 = alloca %"class.llvm::StringRef"*, align 8
  %4 = alloca i8*, align 8
  %5 = alloca %"class.llvm::raw_ostream"*, align 8
  %6 = alloca i8*, align 8
  %7 = alloca %"class.llvm::StringRef", align 8
  store %"class.llvm::raw_ostream"* %0, %"class.llvm::raw_ostream"** %5, align 8
  store i8* %1, i8** %6, align 8
  %8 = load %"class.llvm::raw_ostream"*, %"class.llvm::raw_ostream"** %5, align 8
  %9 = load i8*, i8** %6, align 8
  store %"class.llvm::StringRef"* %7, %"class.llvm::StringRef"** %3, align 8
  store i8* %9, i8** %4, align 8
  %10 = load %"class.llvm::StringRef"*, %"class.llvm::StringRef"** %3, align 8
  %11 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %10, i32 0, i32 0
  %12 = load i8*, i8** %4, align 8
  store i8* %12, i8** %11, align 8
  %13 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %10, i32 0, i32 1
  %14 = load i8*, i8** %4, align 8
  %15 = icmp ne i8* %14, null
  br i1 %15, label %16, label %19

; <label>:16:                                     ; preds = %2
  %17 = load i8*, i8** %4, align 8
  %18 = call i64 @strlen(i8* %17) #10
  br label %20

; <label>:19:                                     ; preds = %2
  br label %20

; <label>:20:                                     ; preds = %16, %19
  %21 = phi i64 [ %18, %16 ], [ 0, %19 ]
  store i64 %21, i64* %13, align 8
  %22 = bitcast %"class.llvm::StringRef"* %7 to { i8*, i64 }*
  %23 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %22, i32 0, i32 0
  %24 = load i8*, i8** %23, align 8
  %25 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %22, i32 0, i32 1
  %26 = load i64, i64* %25, align 8
  %27 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsENS_9StringRefE(%"class.llvm::raw_ostream"* %8, i8* %24, i64 %26)
  ret %"class.llvm::raw_ostream"* %27
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN4llvm12SMDiagnosticC2Ev(%"class.llvm::SMDiagnostic"*) unnamed_addr #2 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.llvm::SMDiagnostic"*, align 8
  %3 = alloca i8*
  %4 = alloca i32
  store %"class.llvm::SMDiagnostic"* %0, %"class.llvm::SMDiagnostic"** %2, align 8
  %5 = load %"class.llvm::SMDiagnostic"*, %"class.llvm::SMDiagnostic"** %2, align 8
  %6 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 0
  store %"class.llvm::SourceMgr"* null, %"class.llvm::SourceMgr"** %6, align 8
  %7 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 1
  call void @_ZN4llvm5SMLocC2Ev(%"class.llvm::SMLoc"* %7) #11
  %8 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 2
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* %8) #11
  %9 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 3
  store i32 0, i32* %9, align 8
  %10 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 4
  store i32 0, i32* %10, align 4
  %11 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 5
  store i32 0, i32* %11, align 8
  %12 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 6
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* %12) #11
  %13 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 7
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"* %13) #11
  %14 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 8
  call void @_ZNSt6vectorISt4pairIjjESaIS1_EEC2Ev(%"class.std::vector.10"* %14) #11
  %15 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %5, i32 0, i32 9
  invoke void @_ZN4llvm11SmallVectorINS_7SMFixItELj4EEC2Ev(%"class.llvm::SmallVector"* %15)
          to label %16 unwind label %17

; <label>:16:                                     ; preds = %1
  ret void

; <label>:17:                                     ; preds = %1
  %18 = landingpad { i8*, i32 }
          cleanup
  %19 = extractvalue { i8*, i32 } %18, 0
  store i8* %19, i8** %3, align 8
  %20 = extractvalue { i8*, i32 } %18, 1
  store i32 %20, i32* %4, align 4
  call void @_ZNSt6vectorISt4pairIjjESaIS1_EED2Ev(%"class.std::vector.10"* %14) #11
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %13) #11
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %12) #11
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %8) #11
  br label %21

; <label>:21:                                     ; preds = %17
  %22 = load i8*, i8** %3, align 8
  %23 = load i32, i32* %4, align 4
  %24 = insertvalue { i8*, i32 } undef, i8* %22, 0
  %25 = insertvalue { i8*, i32 } %24, i32 %23, 1
  resume { i8*, i32 } %25
}

declare void @_ZN4llvm11LLVMContextC1Ev(%"class.llvm::LLVMContext"*) unnamed_addr #1

declare i32 @__gxx_personality_v0(...)

declare void @_ZN4llvm11parseIRFileENS_9StringRefERNS_12SMDiagnosticERNS_11LLVMContextEb(%"class.std::unique_ptr.15"* sret, i8*, i64, %"class.llvm::SMDiagnostic"* dereferenceable(368), %"class.llvm::LLVMContext"* dereferenceable(8), i1 zeroext) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEcvbEv(%"class.std::unique_ptr.15"*) #3 comdat align 2 {
  %2 = alloca %"class.std::unique_ptr.15"*, align 8
  store %"class.std::unique_ptr.15"* %0, %"class.std::unique_ptr.15"** %2, align 8
  %3 = load %"class.std::unique_ptr.15"*, %"class.std::unique_ptr.15"** %2, align 8
  %4 = call %"class.llvm::Module"* @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.15"* %3) #11
  %5 = icmp eq %"class.llvm::Module"* %4, null
  %6 = zext i1 %5 to i64
  %7 = select i1 %5, i1 false, i1 true
  ret i1 %7
}

declare void @_ZNK4llvm12SMDiagnostic5printEPKcRNS_11raw_ostreamEbb(%"class.llvm::SMDiagnostic"*, i8*, %"class.llvm::raw_ostream"* dereferenceable(40), i1 zeroext, i1 zeroext) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::Module"* @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EEptEv(%"class.std::unique_ptr.15"*) #3 comdat align 2 {
  %2 = alloca %"class.std::unique_ptr.15"*, align 8
  store %"class.std::unique_ptr.15"* %0, %"class.std::unique_ptr.15"** %2, align 8
  %3 = load %"class.std::unique_ptr.15"*, %"class.std::unique_ptr.15"** %2, align 8
  %4 = call %"class.llvm::Module"* @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.15"* %3) #11
  ret %"class.llvm::Module"* %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_impl.53"* @_ZN4llvm6Module20named_metadata_beginEv(%"class.llvm::Module"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator.94", align 8
  %3 = alloca %"class.llvm::Module"*, align 8
  store %"class.llvm::Module"* %0, %"class.llvm::Module"** %3, align 8
  %4 = load %"class.llvm::Module"*, %"class.llvm::Module"** %3, align 8
  %5 = getelementptr inbounds %"class.llvm::Module", %"class.llvm::Module"* %4, i32 0, i32 5
  %6 = bitcast %"class.llvm::iplist"* %5 to %"class.llvm::iplist_impl.48"*
  %7 = bitcast %"class.llvm::iplist_impl.48"* %6 to %"class.llvm::simple_ilist.50"*
  %8 = call %"class.llvm::ilist_node_impl.53"* @_ZN4llvm12simple_ilistINS_11NamedMDNodeEJEE5beginEv(%"class.llvm::simple_ilist.50"* %7)
  %9 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %2, i32 0, i32 0
  store %"class.llvm::ilist_node_impl.53"* %8, %"class.llvm::ilist_node_impl.53"** %9, align 8
  %10 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %2, i32 0, i32 0
  %11 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %10, align 8
  ret %"class.llvm::ilist_node_impl.53"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEC2ILb0EEERKNS0_IS4_Lb0EXT_EEENSt9enable_ifIXooLb1EntT_EPvE4typeE(%"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator.94"* dereferenceable(8), i8*) unnamed_addr #3 comdat align 2 {
  %4 = alloca %"class.llvm::ilist_iterator"*, align 8
  %5 = alloca %"class.llvm::ilist_iterator.94"*, align 8
  %6 = alloca i8*, align 8
  store %"class.llvm::ilist_iterator"* %0, %"class.llvm::ilist_iterator"** %4, align 8
  store %"class.llvm::ilist_iterator.94"* %1, %"class.llvm::ilist_iterator.94"** %5, align 8
  store i8* %2, i8** %6, align 8
  %7 = load %"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator"** %4, align 8
  %8 = bitcast %"class.llvm::ilist_iterator"* %7 to %"struct.llvm::ilist_detail::SpecificNodeAccess.51"*
  %9 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %7, i32 0, i32 0
  %10 = load %"class.llvm::ilist_iterator.94"*, %"class.llvm::ilist_iterator.94"** %5, align 8
  %11 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %10, i32 0, i32 0
  %12 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %11, align 8
  store %"class.llvm::ilist_node_impl.53"* %12, %"class.llvm::ilist_node_impl.53"** %9, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_impl.53"* @_ZN4llvm6Module18named_metadata_endEv(%"class.llvm::Module"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator.94", align 8
  %3 = alloca %"class.llvm::Module"*, align 8
  store %"class.llvm::Module"* %0, %"class.llvm::Module"** %3, align 8
  %4 = load %"class.llvm::Module"*, %"class.llvm::Module"** %3, align 8
  %5 = getelementptr inbounds %"class.llvm::Module", %"class.llvm::Module"* %4, i32 0, i32 5
  %6 = bitcast %"class.llvm::iplist"* %5 to %"class.llvm::iplist_impl.48"*
  %7 = bitcast %"class.llvm::iplist_impl.48"* %6 to %"class.llvm::simple_ilist.50"*
  %8 = call %"class.llvm::ilist_node_impl.53"* @_ZN4llvm12simple_ilistINS_11NamedMDNodeEJEE3endEv(%"class.llvm::simple_ilist.50"* %7)
  %9 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %2, i32 0, i32 0
  store %"class.llvm::ilist_node_impl.53"* %8, %"class.llvm::ilist_node_impl.53"** %9, align 8
  %10 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %2, i32 0, i32 0
  %11 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %10, align 8
  ret %"class.llvm::ilist_node_impl.53"* %11
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvmneERKNS_14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEES7_(%"class.llvm::ilist_iterator"* dereferenceable(8), %"class.llvm::ilist_iterator"* dereferenceable(8)) #3 comdat {
  %3 = alloca %"class.llvm::ilist_iterator"*, align 8
  %4 = alloca %"class.llvm::ilist_iterator"*, align 8
  store %"class.llvm::ilist_iterator"* %0, %"class.llvm::ilist_iterator"** %3, align 8
  store %"class.llvm::ilist_iterator"* %1, %"class.llvm::ilist_iterator"** %4, align 8
  %5 = load %"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator"** %3, align 8
  %6 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %5, i32 0, i32 0
  %7 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %6, align 8
  %8 = load %"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator"** %4, align 8
  %9 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %8, i32 0, i32 0
  %10 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %9, align 8
  %11 = icmp ne %"class.llvm::ilist_node_impl.53"* %7, %10
  ret i1 %11
}

declare dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm4outsEv() #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::NamedMDNode"* @_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEptEv(%"class.llvm::ilist_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator"*, align 8
  store %"class.llvm::ilist_iterator"* %0, %"class.llvm::ilist_iterator"** %2, align 8
  %3 = load %"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator"** %2, align 8
  %4 = call dereferenceable(64) %"class.llvm::NamedMDNode"* @_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEdeEv(%"class.llvm::ilist_iterator"* %3)
  ret %"class.llvm::NamedMDNode"* %4
}

declare i32 @_ZNK4llvm11NamedMDNode14getNumOperandsEv(%"class.llvm::NamedMDNode"*) #1

declare %"class.llvm::MDNode"* @_ZNK4llvm11NamedMDNode10getOperandEj(%"class.llvm::NamedMDNode"*, i32) #1

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::MDNode"* @_ZN4llvm8dyn_castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_(%"class.llvm::Metadata"*) #2 comdat {
  %2 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"* %0, %"class.llvm::Metadata"** %2, align 8
  %3 = call zeroext i1 @_ZN4llvm3isaINS_6MDNodeEPNS_8MetadataEEEbRKT0_(%"class.llvm::Metadata"** dereferenceable(8) %2)
  br i1 %3, label %4, label %7

; <label>:4:                                      ; preds = %1
  %5 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %2, align 8
  %6 = call %"class.llvm::MDNode"* @_ZN4llvm4castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_(%"class.llvm::Metadata"* %5)
  br label %8

; <label>:7:                                      ; preds = %1
  br label %8

; <label>:8:                                      ; preds = %7, %4
  %9 = phi %"class.llvm::MDNode"* [ %6, %4 ], [ null, %7 ]
  ret %"class.llvm::MDNode"* %9
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEj(%"class.llvm::raw_ostream"*, i32) #2 comdat align 2 {
  %3 = alloca %"class.llvm::raw_ostream"*, align 8
  %4 = alloca i32, align 4
  store %"class.llvm::raw_ostream"* %0, %"class.llvm::raw_ostream"** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %"class.llvm::raw_ostream"*, %"class.llvm::raw_ostream"** %3, align 8
  %6 = load i32, i32* %4, align 4
  %7 = zext i32 %6 to i64
  %8 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEm(%"class.llvm::raw_ostream"* %5, i64 %7)
  ret %"class.llvm::raw_ostream"* %8
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i32 @_ZNK4llvm6MDNode14getNumOperandsEv(%"class.llvm::MDNode"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::MDNode"*, align 8
  store %"class.llvm::MDNode"* %0, %"class.llvm::MDNode"** %2, align 8
  %3 = load %"class.llvm::MDNode"*, %"class.llvm::MDNode"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::MDNode", %"class.llvm::MDNode"* %3, i32 0, i32 1
  %5 = load i32, i32* %4, align 8
  ret i32 %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::ilist_iterator"* @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEppEv(%"class.llvm::ilist_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator"*, align 8
  store %"class.llvm::ilist_iterator"* %0, %"class.llvm::ilist_iterator"** %2, align 8
  %3 = load %"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %3, i32 0, i32 0
  %5 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %4, align 8
  %6 = call %"class.llvm::ilist_node_impl.53"* @_ZNK4llvm15ilist_node_implINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE7getNextEv(%"class.llvm::ilist_node_impl.53"* %5)
  %7 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %3, i32 0, i32 0
  store %"class.llvm::ilist_node_impl.53"* %6, %"class.llvm::ilist_node_impl.53"** %7, align 8
  ret %"class.llvm::ilist_iterator"* %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EED2Ev(%"class.std::unique_ptr.15"*) unnamed_addr #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::unique_ptr.15"*, align 8
  %3 = alloca %"class.llvm::Module"**, align 8
  store %"class.std::unique_ptr.15"* %0, %"class.std::unique_ptr.15"** %2, align 8
  %4 = load %"class.std::unique_ptr.15"*, %"class.std::unique_ptr.15"** %2, align 8
  %5 = getelementptr inbounds %"class.std::unique_ptr.15", %"class.std::unique_ptr.15"* %4, i32 0, i32 0
  %6 = invoke dereferenceable(8) %"class.llvm::Module"** @_ZNSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.16"* %5)
          to label %7 unwind label %18

; <label>:7:                                      ; preds = %1
  store %"class.llvm::Module"** %6, %"class.llvm::Module"*** %3, align 8
  %8 = load %"class.llvm::Module"**, %"class.llvm::Module"*** %3, align 8
  %9 = load %"class.llvm::Module"*, %"class.llvm::Module"** %8, align 8
  %10 = icmp ne %"class.llvm::Module"* %9, null
  br i1 %10, label %11, label %16

; <label>:11:                                     ; preds = %7
  %12 = call dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE11get_deleterEv(%"class.std::unique_ptr.15"* %4) #11
  %13 = load %"class.llvm::Module"**, %"class.llvm::Module"*** %3, align 8
  %14 = load %"class.llvm::Module"*, %"class.llvm::Module"** %13, align 8
  invoke void @_ZNKSt14default_deleteIN4llvm6ModuleEEclEPS1_(%"struct.std::default_delete.21"* %12, %"class.llvm::Module"* %14)
          to label %15 unwind label %18

; <label>:15:                                     ; preds = %11
  br label %16

; <label>:16:                                     ; preds = %15, %7
  %17 = load %"class.llvm::Module"**, %"class.llvm::Module"*** %3, align 8
  store %"class.llvm::Module"* null, %"class.llvm::Module"** %17, align 8
  ret void

; <label>:18:                                     ; preds = %11, %1
  %19 = landingpad { i8*, i32 }
          catch i8* null
  %20 = extractvalue { i8*, i32 } %19, 0
  call void @__clang_call_terminate(i8* %20) #12
  unreachable
}

; Function Attrs: nounwind
declare void @_ZN4llvm11LLVMContextD1Ev(%"class.llvm::LLVMContext"*) unnamed_addr #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm12SMDiagnosticD2Ev(%"class.llvm::SMDiagnostic"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.llvm::SMDiagnostic"*, align 8
  store %"class.llvm::SMDiagnostic"* %0, %"class.llvm::SMDiagnostic"** %2, align 8
  %3 = load %"class.llvm::SMDiagnostic"*, %"class.llvm::SMDiagnostic"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %3, i32 0, i32 9
  call void @_ZN4llvm11SmallVectorINS_7SMFixItELj4EED2Ev(%"class.llvm::SmallVector"* %4) #11
  %5 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %3, i32 0, i32 8
  call void @_ZNSt6vectorISt4pairIjjESaIS1_EED2Ev(%"class.std::vector.10"* %5) #11
  %6 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %3, i32 0, i32 7
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %6) #11
  %7 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %3, i32 0, i32 6
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %7) #11
  %8 = getelementptr inbounds %"class.llvm::SMDiagnostic", %"class.llvm::SMDiagnostic"* %3, i32 0, i32 2
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %8) #11
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsENS_9StringRefE(%"class.llvm::raw_ostream"*, i8*, i64) #2 comdat align 2 {
  %4 = alloca %"class.llvm::StringRef"*, align 8
  %5 = alloca %"class.llvm::StringRef"*, align 8
  %6 = alloca %"class.llvm::StringRef"*, align 8
  %7 = alloca %"class.llvm::raw_ostream"*, align 8
  %8 = alloca %"class.llvm::StringRef", align 8
  %9 = alloca %"class.llvm::raw_ostream"*, align 8
  %10 = alloca i64, align 8
  %11 = bitcast %"class.llvm::StringRef"* %8 to { i8*, i64 }*
  %12 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %11, i32 0, i32 0
  store i8* %1, i8** %12, align 8
  %13 = getelementptr inbounds { i8*, i64 }, { i8*, i64 }* %11, i32 0, i32 1
  store i64 %2, i64* %13, align 8
  store %"class.llvm::raw_ostream"* %0, %"class.llvm::raw_ostream"** %9, align 8
  %14 = load %"class.llvm::raw_ostream"*, %"class.llvm::raw_ostream"** %9, align 8
  store %"class.llvm::StringRef"* %8, %"class.llvm::StringRef"** %6, align 8
  %15 = load %"class.llvm::StringRef"*, %"class.llvm::StringRef"** %6, align 8
  %16 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %15, i32 0, i32 1
  %17 = load i64, i64* %16, align 8
  store i64 %17, i64* %10, align 8
  %18 = load i64, i64* %10, align 8
  %19 = getelementptr inbounds %"class.llvm::raw_ostream", %"class.llvm::raw_ostream"* %14, i32 0, i32 2
  %20 = load i8*, i8** %19, align 8
  %21 = getelementptr inbounds %"class.llvm::raw_ostream", %"class.llvm::raw_ostream"* %14, i32 0, i32 3
  %22 = load i8*, i8** %21, align 8
  %23 = ptrtoint i8* %20 to i64
  %24 = ptrtoint i8* %22 to i64
  %25 = sub i64 %23, %24
  %26 = icmp ugt i64 %18, %25
  br i1 %26, label %27, label %33

; <label>:27:                                     ; preds = %3
  store %"class.llvm::StringRef"* %8, %"class.llvm::StringRef"** %4, align 8
  %28 = load %"class.llvm::StringRef"*, %"class.llvm::StringRef"** %4, align 8
  %29 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %28, i32 0, i32 0
  %30 = load i8*, i8** %29, align 8
  %31 = load i64, i64* %10, align 8
  %32 = call dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostream5writeEPKcm(%"class.llvm::raw_ostream"* %14, i8* %30, i64 %31)
  store %"class.llvm::raw_ostream"* %32, %"class.llvm::raw_ostream"** %7, align 8
  br label %48

; <label>:33:                                     ; preds = %3
  %34 = load i64, i64* %10, align 8
  %35 = icmp ne i64 %34, 0
  br i1 %35, label %36, label %47

; <label>:36:                                     ; preds = %33
  %37 = getelementptr inbounds %"class.llvm::raw_ostream", %"class.llvm::raw_ostream"* %14, i32 0, i32 3
  %38 = load i8*, i8** %37, align 8
  store %"class.llvm::StringRef"* %8, %"class.llvm::StringRef"** %5, align 8
  %39 = load %"class.llvm::StringRef"*, %"class.llvm::StringRef"** %5, align 8
  %40 = getelementptr inbounds %"class.llvm::StringRef", %"class.llvm::StringRef"* %39, i32 0, i32 0
  %41 = load i8*, i8** %40, align 8
  %42 = load i64, i64* %10, align 8
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %38, i8* %41, i64 %42, i32 1, i1 false)
  %43 = load i64, i64* %10, align 8
  %44 = getelementptr inbounds %"class.llvm::raw_ostream", %"class.llvm::raw_ostream"* %14, i32 0, i32 3
  %45 = load i8*, i8** %44, align 8
  %46 = getelementptr inbounds i8, i8* %45, i64 %43
  store i8* %46, i8** %44, align 8
  br label %47

; <label>:47:                                     ; preds = %36, %33
  store %"class.llvm::raw_ostream"* %14, %"class.llvm::raw_ostream"** %7, align 8
  br label %48

; <label>:48:                                     ; preds = %47, %27
  %49 = load %"class.llvm::raw_ostream"*, %"class.llvm::raw_ostream"** %7, align 8
  ret %"class.llvm::raw_ostream"* %49
}

declare dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostream5writeEPKcm(%"class.llvm::raw_ostream"*, i8*, i64) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #5

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm5SMLocC2Ev(%"class.llvm::SMLoc"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.llvm::SMLoc"*, align 8
  store %"class.llvm::SMLoc"* %0, %"class.llvm::SMLoc"** %2, align 8
  %3 = load %"class.llvm::SMLoc"*, %"class.llvm::SMLoc"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::SMLoc", %"class.llvm::SMLoc"* %3, i32 0, i32 0
  store i8* null, i8** %4, align 8
  ret void
}

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1Ev(%"class.std::__cxx11::basic_string"*) unnamed_addr #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt6vectorISt4pairIjjESaIS1_EEC2Ev(%"class.std::vector.10"*) unnamed_addr #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::vector.10"*, align 8
  store %"class.std::vector.10"* %0, %"class.std::vector.10"** %2, align 8
  %3 = load %"class.std::vector.10"*, %"class.std::vector.10"** %2, align 8
  %4 = bitcast %"class.std::vector.10"* %3 to %"struct.std::_Vector_base.11"*
  invoke void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EEC2Ev(%"struct.std::_Vector_base.11"* %4)
          to label %5 unwind label %6

; <label>:5:                                      ; preds = %1
  ret void

; <label>:6:                                      ; preds = %1
  %7 = landingpad { i8*, i32 }
          catch i8* null
  %8 = extractvalue { i8*, i32 } %7, 0
  call void @__clang_call_terminate(i8* %8) #12
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN4llvm11SmallVectorINS_7SMFixItELj4EEC2Ev(%"class.llvm::SmallVector"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"class.llvm::SmallVector"*, align 8
  store %"class.llvm::SmallVector"* %0, %"class.llvm::SmallVector"** %2, align 8
  %3 = load %"class.llvm::SmallVector"*, %"class.llvm::SmallVector"** %2, align 8
  %4 = bitcast %"class.llvm::SmallVector"* %3 to %"class.llvm::SmallVectorImpl"*
  call void @_ZN4llvm15SmallVectorImplINS_7SMFixItEEC2Ej(%"class.llvm::SmallVectorImpl"* %4, i32 4)
  %5 = getelementptr inbounds %"class.llvm::SmallVector", %"class.llvm::SmallVector"* %3, i32 0, i32 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt6vectorISt4pairIjjESaIS1_EED2Ev(%"class.std::vector.10"*) unnamed_addr #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::vector.10"*, align 8
  %3 = alloca i8*
  %4 = alloca i32
  store %"class.std::vector.10"* %0, %"class.std::vector.10"** %2, align 8
  %5 = load %"class.std::vector.10"*, %"class.std::vector.10"** %2, align 8
  %6 = bitcast %"class.std::vector.10"* %5 to %"struct.std::_Vector_base.11"*
  %7 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %6, i32 0, i32 0
  %8 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %7, i32 0, i32 0
  %9 = load %"struct.std::pair"*, %"struct.std::pair"** %8, align 8
  %10 = bitcast %"class.std::vector.10"* %5 to %"struct.std::_Vector_base.11"*
  %11 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %10, i32 0, i32 0
  %12 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %11, i32 0, i32 1
  %13 = load %"struct.std::pair"*, %"struct.std::pair"** %12, align 8
  %14 = bitcast %"class.std::vector.10"* %5 to %"struct.std::_Vector_base.11"*
  %15 = call dereferenceable(1) %"class.std::allocator.12"* @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.11"* %14) #11
  invoke void @_ZSt8_DestroyIPSt4pairIjjES1_EvT_S3_RSaIT0_E(%"struct.std::pair"* %9, %"struct.std::pair"* %13, %"class.std::allocator.12"* dereferenceable(1) %15)
          to label %16 unwind label %18

; <label>:16:                                     ; preds = %1
  %17 = bitcast %"class.std::vector.10"* %5 to %"struct.std::_Vector_base.11"*
  call void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EED2Ev(%"struct.std::_Vector_base.11"* %17) #11
  ret void

; <label>:18:                                     ; preds = %1
  %19 = landingpad { i8*, i32 }
          catch i8* null
  %20 = extractvalue { i8*, i32 } %19, 0
  store i8* %20, i8** %3, align 8
  %21 = extractvalue { i8*, i32 } %19, 1
  store i32 %21, i32* %4, align 4
  %22 = bitcast %"class.std::vector.10"* %5 to %"struct.std::_Vector_base.11"*
  call void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EED2Ev(%"struct.std::_Vector_base.11"* %22) #11
  br label %23

; <label>:23:                                     ; preds = %18
  %24 = load i8*, i8** %3, align 8
  call void @__clang_call_terminate(i8* %24) #12
  unreachable
}

; Function Attrs: nounwind
declare void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"*) unnamed_addr #4

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EEC2Ev(%"struct.std::_Vector_base.11"*) unnamed_addr #2 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base.11"*, align 8
  store %"struct.std::_Vector_base.11"* %0, %"struct.std::_Vector_base.11"** %2, align 8
  %3 = load %"struct.std::_Vector_base.11"*, %"struct.std::_Vector_base.11"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %3, i32 0, i32 0
  call void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implC2Ev(%"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %4)
  ret void
}

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #6 comdat {
  %2 = call i8* @__cxa_begin_catch(i8* %0) #11
  call void @_ZSt9terminatev() #12
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implC2Ev(%"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %0, %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"** %2, align 8
  %3 = load %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"*, %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %3 to %"class.std::allocator.12"*
  call void @_ZNSaISt4pairIjjEEC2Ev(%"class.std::allocator.12"* %4) #11
  %5 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %3, i32 0, i32 0
  store %"struct.std::pair"* null, %"struct.std::pair"** %5, align 8
  %6 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %3, i32 0, i32 1
  store %"struct.std::pair"* null, %"struct.std::pair"** %6, align 8
  %7 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %3, i32 0, i32 2
  store %"struct.std::pair"* null, %"struct.std::pair"** %7, align 8
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSaISt4pairIjjEEC2Ev(%"class.std::allocator.12"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.std::allocator.12"*, align 8
  store %"class.std::allocator.12"* %0, %"class.std::allocator.12"** %2, align 8
  %3 = load %"class.std::allocator.12"*, %"class.std::allocator.12"** %2, align 8
  %4 = bitcast %"class.std::allocator.12"* %3 to %"class.__gnu_cxx::new_allocator.13"*
  call void @_ZN9__gnu_cxx13new_allocatorISt4pairIjjEEC2Ev(%"class.__gnu_cxx::new_allocator.13"* %4) #11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt4pairIjjEEC2Ev(%"class.__gnu_cxx::new_allocator.13"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator.13"*, align 8
  store %"class.__gnu_cxx::new_allocator.13"* %0, %"class.__gnu_cxx::new_allocator.13"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator.13"*, %"class.__gnu_cxx::new_allocator.13"** %2, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN4llvm15SmallVectorImplINS_7SMFixItEEC2Ej(%"class.llvm::SmallVectorImpl"*, i32) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.llvm::SmallVectorImpl"*, align 8
  %4 = alloca i32, align 4
  store %"class.llvm::SmallVectorImpl"* %0, %"class.llvm::SmallVectorImpl"** %3, align 8
  store i32 %1, i32* %4, align 4
  %5 = load %"class.llvm::SmallVectorImpl"*, %"class.llvm::SmallVectorImpl"** %3, align 8
  %6 = bitcast %"class.llvm::SmallVectorImpl"* %5 to %"class.llvm::SmallVectorTemplateBase"*
  %7 = load i32, i32* %4, align 4
  %8 = zext i32 %7 to i64
  %9 = mul i64 %8, 48
  call void @_ZN4llvm23SmallVectorTemplateBaseINS_7SMFixItELb0EEC2Em(%"class.llvm::SmallVectorTemplateBase"* %6, i64 %9)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN4llvm23SmallVectorTemplateBaseINS_7SMFixItELb0EEC2Em(%"class.llvm::SmallVectorTemplateBase"*, i64) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.llvm::SmallVectorTemplateBase"*, align 8
  %4 = alloca i64, align 8
  store %"class.llvm::SmallVectorTemplateBase"* %0, %"class.llvm::SmallVectorTemplateBase"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.llvm::SmallVectorTemplateBase"*, %"class.llvm::SmallVectorTemplateBase"** %3, align 8
  %6 = bitcast %"class.llvm::SmallVectorTemplateBase"* %5 to %"class.llvm::SmallVectorTemplateCommon"*
  %7 = load i64, i64* %4, align 8
  call void @_ZN4llvm25SmallVectorTemplateCommonINS_7SMFixItEvEC2Em(%"class.llvm::SmallVectorTemplateCommon"* %6, i64 %7)
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZN4llvm25SmallVectorTemplateCommonINS_7SMFixItEvEC2Em(%"class.llvm::SmallVectorTemplateCommon"*, i64) unnamed_addr #2 comdat align 2 {
  %3 = alloca %"class.llvm::SmallVectorTemplateCommon"*, align 8
  %4 = alloca i64, align 8
  store %"class.llvm::SmallVectorTemplateCommon"* %0, %"class.llvm::SmallVectorTemplateCommon"** %3, align 8
  store i64 %1, i64* %4, align 8
  %5 = load %"class.llvm::SmallVectorTemplateCommon"*, %"class.llvm::SmallVectorTemplateCommon"** %3, align 8
  %6 = bitcast %"class.llvm::SmallVectorTemplateCommon"* %5 to %"class.llvm::SmallVectorBase"*
  %7 = getelementptr inbounds %"class.llvm::SmallVectorTemplateCommon", %"class.llvm::SmallVectorTemplateCommon"* %5, i32 0, i32 1
  %8 = bitcast %"struct.llvm::AlignedCharArrayUnion"* %7 to i8*
  %9 = load i64, i64* %4, align 8
  call void @_ZN4llvm15SmallVectorBaseC2EPvm(%"class.llvm::SmallVectorBase"* %6, i8* %8, i64 %9)
  %10 = getelementptr inbounds %"class.llvm::SmallVectorTemplateCommon", %"class.llvm::SmallVectorTemplateCommon"* %5, i32 0, i32 1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm15SmallVectorBaseC2EPvm(%"class.llvm::SmallVectorBase"*, i8*, i64) unnamed_addr #3 comdat align 2 {
  %4 = alloca %"class.llvm::SmallVectorBase"*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  store %"class.llvm::SmallVectorBase"* %0, %"class.llvm::SmallVectorBase"** %4, align 8
  store i8* %1, i8** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.llvm::SmallVectorBase"*, %"class.llvm::SmallVectorBase"** %4, align 8
  %8 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %7, i32 0, i32 0
  %9 = load i8*, i8** %5, align 8
  store i8* %9, i8** %8, align 8
  %10 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %7, i32 0, i32 1
  %11 = load i8*, i8** %5, align 8
  store i8* %11, i8** %10, align 8
  %12 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %7, i32 0, i32 2
  %13 = load i8*, i8** %5, align 8
  %14 = load i64, i64* %6, align 8
  %15 = getelementptr inbounds i8, i8* %13, i64 %14
  store i8* %15, i8** %12, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZSt8_DestroyIPSt4pairIjjES1_EvT_S3_RSaIT0_E(%"struct.std::pair"*, %"struct.std::pair"*, %"class.std::allocator.12"* dereferenceable(1)) #2 comdat {
  %4 = alloca %"struct.std::pair"*, align 8
  %5 = alloca %"struct.std::pair"*, align 8
  %6 = alloca %"class.std::allocator.12"*, align 8
  store %"struct.std::pair"* %0, %"struct.std::pair"** %4, align 8
  store %"struct.std::pair"* %1, %"struct.std::pair"** %5, align 8
  store %"class.std::allocator.12"* %2, %"class.std::allocator.12"** %6, align 8
  %7 = load %"struct.std::pair"*, %"struct.std::pair"** %4, align 8
  %8 = load %"struct.std::pair"*, %"struct.std::pair"** %5, align 8
  call void @_ZSt8_DestroyIPSt4pairIjjEEvT_S3_(%"struct.std::pair"* %7, %"struct.std::pair"* %8)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"class.std::allocator.12"* @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE19_M_get_Tp_allocatorEv(%"struct.std::_Vector_base.11"*) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base.11"*, align 8
  store %"struct.std::_Vector_base.11"* %0, %"struct.std::_Vector_base.11"** %2, align 8
  %3 = load %"struct.std::_Vector_base.11"*, %"struct.std::_Vector_base.11"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %3, i32 0, i32 0
  %5 = bitcast %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %4 to %"class.std::allocator.12"*
  ret %"class.std::allocator.12"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EED2Ev(%"struct.std::_Vector_base.11"*) unnamed_addr #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"struct.std::_Vector_base.11"*, align 8
  %3 = alloca i8*
  %4 = alloca i32
  store %"struct.std::_Vector_base.11"* %0, %"struct.std::_Vector_base.11"** %2, align 8
  %5 = load %"struct.std::_Vector_base.11"*, %"struct.std::_Vector_base.11"** %2, align 8
  %6 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %5, i32 0, i32 0
  %7 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %6, i32 0, i32 0
  %8 = load %"struct.std::pair"*, %"struct.std::pair"** %7, align 8
  %9 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %5, i32 0, i32 0
  %10 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %9, i32 0, i32 2
  %11 = load %"struct.std::pair"*, %"struct.std::pair"** %10, align 8
  %12 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %5, i32 0, i32 0
  %13 = getelementptr inbounds %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl", %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %12, i32 0, i32 0
  %14 = load %"struct.std::pair"*, %"struct.std::pair"** %13, align 8
  %15 = ptrtoint %"struct.std::pair"* %11 to i64
  %16 = ptrtoint %"struct.std::pair"* %14 to i64
  %17 = sub i64 %15, %16
  %18 = sdiv exact i64 %17, 8
  invoke void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE13_M_deallocateEPS1_m(%"struct.std::_Vector_base.11"* %5, %"struct.std::pair"* %8, i64 %18)
          to label %19 unwind label %21

; <label>:19:                                     ; preds = %1
  %20 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %5, i32 0, i32 0
  call void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %20) #11
  ret void

; <label>:21:                                     ; preds = %1
  %22 = landingpad { i8*, i32 }
          catch i8* null
  %23 = extractvalue { i8*, i32 } %22, 0
  store i8* %23, i8** %3, align 8
  %24 = extractvalue { i8*, i32 } %22, 1
  store i32 %24, i32* %4, align 4
  %25 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %5, i32 0, i32 0
  call void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %25) #11
  br label %26

; <label>:26:                                     ; preds = %21
  %27 = load i8*, i8** %3, align 8
  call void @__clang_call_terminate(i8* %27) #12
  unreachable
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZSt8_DestroyIPSt4pairIjjEEvT_S3_(%"struct.std::pair"*, %"struct.std::pair"*) #2 comdat {
  %3 = alloca %"struct.std::pair"*, align 8
  %4 = alloca %"struct.std::pair"*, align 8
  store %"struct.std::pair"* %0, %"struct.std::pair"** %3, align 8
  store %"struct.std::pair"* %1, %"struct.std::pair"** %4, align 8
  %5 = load %"struct.std::pair"*, %"struct.std::pair"** %3, align 8
  %6 = load %"struct.std::pair"*, %"struct.std::pair"** %4, align 8
  call void @_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIjjEEEvT_S5_(%"struct.std::pair"* %5, %"struct.std::pair"* %6)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIjjEEEvT_S5_(%"struct.std::pair"*, %"struct.std::pair"*) #3 comdat align 2 {
  %3 = alloca %"struct.std::pair"*, align 8
  %4 = alloca %"struct.std::pair"*, align 8
  store %"struct.std::pair"* %0, %"struct.std::pair"** %3, align 8
  store %"struct.std::pair"* %1, %"struct.std::pair"** %4, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE13_M_deallocateEPS1_m(%"struct.std::_Vector_base.11"*, %"struct.std::pair"*, i64) #2 comdat align 2 {
  %4 = alloca %"struct.std::_Vector_base.11"*, align 8
  %5 = alloca %"struct.std::pair"*, align 8
  %6 = alloca i64, align 8
  store %"struct.std::_Vector_base.11"* %0, %"struct.std::_Vector_base.11"** %4, align 8
  store %"struct.std::pair"* %1, %"struct.std::pair"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"struct.std::_Vector_base.11"*, %"struct.std::_Vector_base.11"** %4, align 8
  %8 = load %"struct.std::pair"*, %"struct.std::pair"** %5, align 8
  %9 = icmp ne %"struct.std::pair"* %8, null
  br i1 %9, label %10, label %15

; <label>:10:                                     ; preds = %3
  %11 = getelementptr inbounds %"struct.std::_Vector_base.11", %"struct.std::_Vector_base.11"* %7, i32 0, i32 0
  %12 = bitcast %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %11 to %"class.std::allocator.12"*
  %13 = load %"struct.std::pair"*, %"struct.std::pair"** %5, align 8
  %14 = load i64, i64* %6, align 8
  call void @_ZNSt16allocator_traitsISaISt4pairIjjEEE10deallocateERS2_PS1_m(%"class.std::allocator.12"* dereferenceable(1) %12, %"struct.std::pair"* %13, i64 %14)
  br label %15

; <label>:15:                                     ; preds = %10, %3
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSt12_Vector_baseISt4pairIjjESaIS1_EE12_Vector_implD2Ev(%"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"*, align 8
  store %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %0, %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"** %2, align 8
  %3 = load %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"*, %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"** %2, align 8
  %4 = bitcast %"struct.std::_Vector_base<std::pair<unsigned int, unsigned int>, std::allocator<std::pair<unsigned int, unsigned int> > >::_Vector_impl"* %3 to %"class.std::allocator.12"*
  call void @_ZNSaISt4pairIjjEED2Ev(%"class.std::allocator.12"* %4) #11
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr void @_ZNSt16allocator_traitsISaISt4pairIjjEEE10deallocateERS2_PS1_m(%"class.std::allocator.12"* dereferenceable(1), %"struct.std::pair"*, i64) #2 comdat align 2 {
  %4 = alloca %"class.std::allocator.12"*, align 8
  %5 = alloca %"struct.std::pair"*, align 8
  %6 = alloca i64, align 8
  store %"class.std::allocator.12"* %0, %"class.std::allocator.12"** %4, align 8
  store %"struct.std::pair"* %1, %"struct.std::pair"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.std::allocator.12"*, %"class.std::allocator.12"** %4, align 8
  %8 = bitcast %"class.std::allocator.12"* %7 to %"class.__gnu_cxx::new_allocator.13"*
  %9 = load %"struct.std::pair"*, %"struct.std::pair"** %5, align 8
  %10 = load i64, i64* %6, align 8
  call void @_ZN9__gnu_cxx13new_allocatorISt4pairIjjEE10deallocateEPS2_m(%"class.__gnu_cxx::new_allocator.13"* %8, %"struct.std::pair"* %9, i64 %10)
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt4pairIjjEE10deallocateEPS2_m(%"class.__gnu_cxx::new_allocator.13"*, %"struct.std::pair"*, i64) #3 comdat align 2 {
  %4 = alloca %"class.__gnu_cxx::new_allocator.13"*, align 8
  %5 = alloca %"struct.std::pair"*, align 8
  %6 = alloca i64, align 8
  store %"class.__gnu_cxx::new_allocator.13"* %0, %"class.__gnu_cxx::new_allocator.13"** %4, align 8
  store %"struct.std::pair"* %1, %"struct.std::pair"** %5, align 8
  store i64 %2, i64* %6, align 8
  %7 = load %"class.__gnu_cxx::new_allocator.13"*, %"class.__gnu_cxx::new_allocator.13"** %4, align 8
  %8 = load %"struct.std::pair"*, %"struct.std::pair"** %5, align 8
  %9 = bitcast %"struct.std::pair"* %8 to i8*
  call void @_ZdlPv(i8* %9) #11
  ret void
}

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #7

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNSaISt4pairIjjEED2Ev(%"class.std::allocator.12"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.std::allocator.12"*, align 8
  store %"class.std::allocator.12"* %0, %"class.std::allocator.12"** %2, align 8
  %3 = load %"class.std::allocator.12"*, %"class.std::allocator.12"** %2, align 8
  %4 = bitcast %"class.std::allocator.12"* %3 to %"class.__gnu_cxx::new_allocator.13"*
  call void @_ZN9__gnu_cxx13new_allocatorISt4pairIjjEED2Ev(%"class.__gnu_cxx::new_allocator.13"* %4) #11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN9__gnu_cxx13new_allocatorISt4pairIjjEED2Ev(%"class.__gnu_cxx::new_allocator.13"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.__gnu_cxx::new_allocator.13"*, align 8
  store %"class.__gnu_cxx::new_allocator.13"* %0, %"class.__gnu_cxx::new_allocator.13"** %2, align 8
  %3 = load %"class.__gnu_cxx::new_allocator.13"*, %"class.__gnu_cxx::new_allocator.13"** %2, align 8
  ret void
}

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #8

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_impl.53"* @_ZN4llvm12simple_ilistINS_11NamedMDNodeEJEE5beginEv(%"class.llvm::simple_ilist.50"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator.94", align 8
  %3 = alloca %"class.llvm::simple_ilist.50"*, align 8
  %4 = alloca %"class.llvm::ilist_iterator.94", align 8
  store %"class.llvm::simple_ilist.50"* %0, %"class.llvm::simple_ilist.50"** %3, align 8
  %5 = load %"class.llvm::simple_ilist.50"*, %"class.llvm::simple_ilist.50"** %3, align 8
  %6 = getelementptr inbounds %"class.llvm::simple_ilist.50", %"class.llvm::simple_ilist.50"* %5, i32 0, i32 0
  %7 = bitcast %"class.llvm::ilist_sentinel.52"* %6 to %"class.llvm::ilist_node_impl.53"*
  call void @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEC2ERNS_15ilist_node_implIS4_EE(%"class.llvm::ilist_iterator.94"* %4, %"class.llvm::ilist_node_impl.53"* dereferenceable(16) %7)
  %8 = call dereferenceable(8) %"class.llvm::ilist_iterator.94"* @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEppEv(%"class.llvm::ilist_iterator.94"* %4)
  %9 = bitcast %"class.llvm::ilist_iterator.94"* %2 to i8*
  %10 = bitcast %"class.llvm::ilist_iterator.94"* %8 to i8*
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %9, i8* %10, i64 8, i32 8, i1 false)
  %11 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %2, i32 0, i32 0
  %12 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %11, align 8
  ret %"class.llvm::ilist_node_impl.53"* %12
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEC2ERNS_15ilist_node_implIS4_EE(%"class.llvm::ilist_iterator.94"*, %"class.llvm::ilist_node_impl.53"* dereferenceable(16)) unnamed_addr #3 comdat align 2 {
  %3 = alloca %"class.llvm::ilist_iterator.94"*, align 8
  %4 = alloca %"class.llvm::ilist_node_impl.53"*, align 8
  store %"class.llvm::ilist_iterator.94"* %0, %"class.llvm::ilist_iterator.94"** %3, align 8
  store %"class.llvm::ilist_node_impl.53"* %1, %"class.llvm::ilist_node_impl.53"** %4, align 8
  %5 = load %"class.llvm::ilist_iterator.94"*, %"class.llvm::ilist_iterator.94"** %3, align 8
  %6 = bitcast %"class.llvm::ilist_iterator.94"* %5 to %"struct.llvm::ilist_detail::SpecificNodeAccess.51"*
  %7 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %5, i32 0, i32 0
  %8 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %4, align 8
  store %"class.llvm::ilist_node_impl.53"* %8, %"class.llvm::ilist_node_impl.53"** %7, align 8
  ret void
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::ilist_iterator.94"* @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEppEv(%"class.llvm::ilist_iterator.94"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator.94"*, align 8
  store %"class.llvm::ilist_iterator.94"* %0, %"class.llvm::ilist_iterator.94"** %2, align 8
  %3 = load %"class.llvm::ilist_iterator.94"*, %"class.llvm::ilist_iterator.94"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %3, i32 0, i32 0
  %5 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %4, align 8
  %6 = call %"class.llvm::ilist_node_impl.53"* @_ZN4llvm15ilist_node_implINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE7getNextEv(%"class.llvm::ilist_node_impl.53"* %5)
  %7 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %3, i32 0, i32 0
  store %"class.llvm::ilist_node_impl.53"* %6, %"class.llvm::ilist_node_impl.53"** %7, align 8
  ret %"class.llvm::ilist_iterator.94"* %3
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_impl.53"* @_ZN4llvm15ilist_node_implINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE7getNextEv(%"class.llvm::ilist_node_impl.53"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_node_impl.53"*, align 8
  store %"class.llvm::ilist_node_impl.53"* %0, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %3 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %4 = bitcast %"class.llvm::ilist_node_impl.53"* %3 to %"class.llvm::ilist_node_base"*
  %5 = call %"class.llvm::ilist_node_base"* @_ZNK4llvm15ilist_node_baseILb0EE7getNextEv(%"class.llvm::ilist_node_base"* %4)
  %6 = bitcast %"class.llvm::ilist_node_base"* %5 to %"class.llvm::ilist_node_impl.53"*
  ret %"class.llvm::ilist_node_impl.53"* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_base"* @_ZNK4llvm15ilist_node_baseILb0EE7getNextEv(%"class.llvm::ilist_node_base"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_node_base"*, align 8
  store %"class.llvm::ilist_node_base"* %0, %"class.llvm::ilist_node_base"** %2, align 8
  %3 = load %"class.llvm::ilist_node_base"*, %"class.llvm::ilist_node_base"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::ilist_node_base", %"class.llvm::ilist_node_base"* %3, i32 0, i32 1
  %5 = load %"class.llvm::ilist_node_base"*, %"class.llvm::ilist_node_base"** %4, align 8
  ret %"class.llvm::ilist_node_base"* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_impl.53"* @_ZN4llvm12simple_ilistINS_11NamedMDNodeEJEE3endEv(%"class.llvm::simple_ilist.50"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator.94", align 8
  %3 = alloca %"class.llvm::simple_ilist.50"*, align 8
  store %"class.llvm::simple_ilist.50"* %0, %"class.llvm::simple_ilist.50"** %3, align 8
  %4 = load %"class.llvm::simple_ilist.50"*, %"class.llvm::simple_ilist.50"** %3, align 8
  %5 = getelementptr inbounds %"class.llvm::simple_ilist.50", %"class.llvm::simple_ilist.50"* %4, i32 0, i32 0
  %6 = bitcast %"class.llvm::ilist_sentinel.52"* %5 to %"class.llvm::ilist_node_impl.53"*
  call void @_ZN4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb0EEC2ERNS_15ilist_node_implIS4_EE(%"class.llvm::ilist_iterator.94"* %2, %"class.llvm::ilist_node_impl.53"* dereferenceable(16) %6)
  %7 = getelementptr inbounds %"class.llvm::ilist_iterator.94", %"class.llvm::ilist_iterator.94"* %2, i32 0, i32 0
  %8 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %7, align 8
  ret %"class.llvm::ilist_node_impl.53"* %8
}

declare dereferenceable(40) %"class.llvm::raw_ostream"* @_ZN4llvm11raw_ostreamlsEm(%"class.llvm::raw_ostream"*, i64) #1

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm11SmallVectorINS_7SMFixItELj4EED2Ev(%"class.llvm::SmallVector"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.llvm::SmallVector"*, align 8
  store %"class.llvm::SmallVector"* %0, %"class.llvm::SmallVector"** %2, align 8
  %3 = load %"class.llvm::SmallVector"*, %"class.llvm::SmallVector"** %2, align 8
  %4 = bitcast %"class.llvm::SmallVector"* %3 to %"class.llvm::SmallVectorImpl"*
  call void @_ZN4llvm15SmallVectorImplINS_7SMFixItEED2Ev(%"class.llvm::SmallVectorImpl"* %4) #11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm15SmallVectorImplINS_7SMFixItEED2Ev(%"class.llvm::SmallVectorImpl"*) unnamed_addr #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.llvm::SmallVectorTemplateCommon"*, align 8
  %3 = alloca %"class.llvm::SmallVectorTemplateCommon"*, align 8
  %4 = alloca %"class.llvm::SmallVectorTemplateCommon"*, align 8
  %5 = alloca %"class.llvm::SmallVectorImpl"*, align 8
  store %"class.llvm::SmallVectorImpl"* %0, %"class.llvm::SmallVectorImpl"** %5, align 8
  %6 = load %"class.llvm::SmallVectorImpl"*, %"class.llvm::SmallVectorImpl"** %5, align 8
  %7 = bitcast %"class.llvm::SmallVectorImpl"* %6 to %"class.llvm::SmallVectorTemplateCommon"*
  store %"class.llvm::SmallVectorTemplateCommon"* %7, %"class.llvm::SmallVectorTemplateCommon"** %4, align 8
  %8 = load %"class.llvm::SmallVectorTemplateCommon"*, %"class.llvm::SmallVectorTemplateCommon"** %4, align 8
  %9 = bitcast %"class.llvm::SmallVectorTemplateCommon"* %8 to %"class.llvm::SmallVectorBase"*
  %10 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %9, i32 0, i32 0
  %11 = load i8*, i8** %10, align 8
  %12 = bitcast i8* %11 to %"class.llvm::SMFixIt"*
  br label %13

; <label>:13:                                     ; preds = %1
  %14 = bitcast %"class.llvm::SmallVectorImpl"* %6 to %"class.llvm::SmallVectorTemplateCommon"*
  store %"class.llvm::SmallVectorTemplateCommon"* %14, %"class.llvm::SmallVectorTemplateCommon"** %3, align 8
  %15 = load %"class.llvm::SmallVectorTemplateCommon"*, %"class.llvm::SmallVectorTemplateCommon"** %3, align 8
  %16 = bitcast %"class.llvm::SmallVectorTemplateCommon"* %15 to %"class.llvm::SmallVectorBase"*
  %17 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %16, i32 0, i32 1
  %18 = load i8*, i8** %17, align 8
  %19 = bitcast i8* %18 to %"class.llvm::SMFixIt"*
  br label %20

; <label>:20:                                     ; preds = %13
  invoke void @_ZN4llvm23SmallVectorTemplateBaseINS_7SMFixItELb0EE13destroy_rangeEPS1_S3_(%"class.llvm::SMFixIt"* %12, %"class.llvm::SMFixIt"* %19)
          to label %21 unwind label %35

; <label>:21:                                     ; preds = %20
  %22 = bitcast %"class.llvm::SmallVectorImpl"* %6 to %"class.llvm::SmallVectorTemplateCommon"*
  %23 = invoke zeroext i1 @_ZNK4llvm25SmallVectorTemplateCommonINS_7SMFixItEvE7isSmallEv(%"class.llvm::SmallVectorTemplateCommon"* %22)
          to label %24 unwind label %35

; <label>:24:                                     ; preds = %21
  br i1 %23, label %34, label %25

; <label>:25:                                     ; preds = %24
  %26 = bitcast %"class.llvm::SmallVectorImpl"* %6 to %"class.llvm::SmallVectorTemplateCommon"*
  store %"class.llvm::SmallVectorTemplateCommon"* %26, %"class.llvm::SmallVectorTemplateCommon"** %2, align 8
  %27 = load %"class.llvm::SmallVectorTemplateCommon"*, %"class.llvm::SmallVectorTemplateCommon"** %2, align 8
  %28 = bitcast %"class.llvm::SmallVectorTemplateCommon"* %27 to %"class.llvm::SmallVectorBase"*
  %29 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %28, i32 0, i32 0
  %30 = load i8*, i8** %29, align 8
  %31 = bitcast i8* %30 to %"class.llvm::SMFixIt"*
  br label %32

; <label>:32:                                     ; preds = %25
  %33 = bitcast %"class.llvm::SMFixIt"* %31 to i8*
  call void @free(i8* %33) #11
  br label %34

; <label>:34:                                     ; preds = %32, %24
  ret void

; <label>:35:                                     ; preds = %21, %20
  %36 = landingpad { i8*, i32 }
          catch i8* null
  %37 = extractvalue { i8*, i32 } %36, 0
  call void @__clang_call_terminate(i8* %37) #12
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm23SmallVectorTemplateBaseINS_7SMFixItELb0EE13destroy_rangeEPS1_S3_(%"class.llvm::SMFixIt"*, %"class.llvm::SMFixIt"*) #3 comdat align 2 {
  %3 = alloca %"class.llvm::SMFixIt"*, align 8
  %4 = alloca %"class.llvm::SMFixIt"*, align 8
  store %"class.llvm::SMFixIt"* %0, %"class.llvm::SMFixIt"** %3, align 8
  store %"class.llvm::SMFixIt"* %1, %"class.llvm::SMFixIt"** %4, align 8
  br label %5

; <label>:5:                                      ; preds = %9, %2
  %6 = load %"class.llvm::SMFixIt"*, %"class.llvm::SMFixIt"** %3, align 8
  %7 = load %"class.llvm::SMFixIt"*, %"class.llvm::SMFixIt"** %4, align 8
  %8 = icmp ne %"class.llvm::SMFixIt"* %6, %7
  br i1 %8, label %9, label %13

; <label>:9:                                      ; preds = %5
  %10 = load %"class.llvm::SMFixIt"*, %"class.llvm::SMFixIt"** %4, align 8
  %11 = getelementptr inbounds %"class.llvm::SMFixIt", %"class.llvm::SMFixIt"* %10, i32 -1
  store %"class.llvm::SMFixIt"* %11, %"class.llvm::SMFixIt"** %4, align 8
  %12 = load %"class.llvm::SMFixIt"*, %"class.llvm::SMFixIt"** %4, align 8
  call void @_ZN4llvm7SMFixItD2Ev(%"class.llvm::SMFixIt"* %12) #11
  br label %5

; <label>:13:                                     ; preds = %5
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNK4llvm25SmallVectorTemplateCommonINS_7SMFixItEvE7isSmallEv(%"class.llvm::SmallVectorTemplateCommon"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::SmallVectorTemplateCommon"*, align 8
  store %"class.llvm::SmallVectorTemplateCommon"* %0, %"class.llvm::SmallVectorTemplateCommon"** %2, align 8
  %3 = load %"class.llvm::SmallVectorTemplateCommon"*, %"class.llvm::SmallVectorTemplateCommon"** %2, align 8
  %4 = bitcast %"class.llvm::SmallVectorTemplateCommon"* %3 to %"class.llvm::SmallVectorBase"*
  %5 = getelementptr inbounds %"class.llvm::SmallVectorBase", %"class.llvm::SmallVectorBase"* %4, i32 0, i32 0
  %6 = load i8*, i8** %5, align 8
  %7 = getelementptr inbounds %"class.llvm::SmallVectorTemplateCommon", %"class.llvm::SmallVectorTemplateCommon"* %3, i32 0, i32 1
  %8 = bitcast %"struct.llvm::AlignedCharArrayUnion"* %7 to i8*
  %9 = icmp eq i8* %6, %8
  ret i1 %9
}

; Function Attrs: nounwind
declare void @free(i8*) #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZN4llvm7SMFixItD2Ev(%"class.llvm::SMFixIt"*) unnamed_addr #3 comdat align 2 {
  %2 = alloca %"class.llvm::SMFixIt"*, align 8
  store %"class.llvm::SMFixIt"* %0, %"class.llvm::SMFixIt"** %2, align 8
  %3 = load %"class.llvm::SMFixIt"*, %"class.llvm::SMFixIt"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::SMFixIt", %"class.llvm::SMFixIt"* %3, i32 0, i32 1
  call void @_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev(%"class.std::__cxx11::basic_string"* %4) #11
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZNSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.16"*) #3 comdat align 2 {
  %2 = alloca %"class.std::__uniq_ptr_impl.16"*, align 8
  store %"class.std::__uniq_ptr_impl.16"* %0, %"class.std::__uniq_ptr_impl.16"** %2, align 8
  %3 = load %"class.std::__uniq_ptr_impl.16"*, %"class.std::__uniq_ptr_impl.16"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.16", %"class.std::__uniq_ptr_impl.16"* %3, i32 0, i32 0
  %5 = call dereferenceable(8) %"class.llvm::Module"** @_ZSt3getILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS9_(%"class.std::tuple.17"* dereferenceable(8) %4) #11
  ret %"class.llvm::Module"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE11get_deleterEv(%"class.std::unique_ptr.15"*) #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::unique_ptr.15"*, align 8
  store %"class.std::unique_ptr.15"* %0, %"class.std::unique_ptr.15"** %2, align 8
  %3 = load %"class.std::unique_ptr.15"*, %"class.std::unique_ptr.15"** %2, align 8
  %4 = getelementptr inbounds %"class.std::unique_ptr.15", %"class.std::unique_ptr.15"* %3, i32 0, i32 0
  %5 = invoke dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE10_M_deleterEv(%"class.std::__uniq_ptr_impl.16"* %4)
          to label %6 unwind label %7

; <label>:6:                                      ; preds = %1
  ret %"struct.std::default_delete.21"* %5

; <label>:7:                                      ; preds = %1
  %8 = landingpad { i8*, i32 }
          catch i8* null
  %9 = extractvalue { i8*, i32 } %8, 0
  call void @__clang_call_terminate(i8* %9) #12
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr void @_ZNKSt14default_deleteIN4llvm6ModuleEEclEPS1_(%"struct.std::default_delete.21"*, %"class.llvm::Module"*) #3 comdat align 2 {
  %3 = alloca %"struct.std::default_delete.21"*, align 8
  %4 = alloca %"class.llvm::Module"*, align 8
  store %"struct.std::default_delete.21"* %0, %"struct.std::default_delete.21"** %3, align 8
  store %"class.llvm::Module"* %1, %"class.llvm::Module"** %4, align 8
  %5 = load %"struct.std::default_delete.21"*, %"struct.std::default_delete.21"** %3, align 8
  %6 = load %"class.llvm::Module"*, %"class.llvm::Module"** %4, align 8
  %7 = icmp eq %"class.llvm::Module"* %6, null
  br i1 %7, label %10, label %8

; <label>:8:                                      ; preds = %2
  call void @_ZN4llvm6ModuleD1Ev(%"class.llvm::Module"* %6) #11
  %9 = bitcast %"class.llvm::Module"* %6 to i8*
  call void @_ZdlPv(i8* %9) #13
  br label %10

; <label>:10:                                     ; preds = %8, %2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZSt3getILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS9_(%"class.std::tuple.17"* dereferenceable(8)) #3 comdat {
  %2 = alloca %"class.std::tuple.17"*, align 8
  store %"class.std::tuple.17"* %0, %"class.std::tuple.17"** %2, align 8
  %3 = load %"class.std::tuple.17"*, %"class.std::tuple.17"** %2, align 8
  %4 = bitcast %"class.std::tuple.17"* %3 to %"struct.std::_Tuple_impl.18"*
  %5 = call dereferenceable(8) %"class.llvm::Module"** @_ZSt12__get_helperILm0EPN4llvm6ModuleEJSt14default_deleteIS1_EEERT0_RSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.18"* dereferenceable(8) %4) #11
  ret %"class.llvm::Module"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZSt12__get_helperILm0EPN4llvm6ModuleEJSt14default_deleteIS1_EEERT0_RSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.18"* dereferenceable(8)) #3 comdat {
  %2 = alloca %"struct.std::_Tuple_impl.18"*, align 8
  store %"struct.std::_Tuple_impl.18"* %0, %"struct.std::_Tuple_impl.18"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.18"*, %"struct.std::_Tuple_impl.18"** %2, align 8
  %4 = call dereferenceable(8) %"class.llvm::Module"** @_ZNSt11_Tuple_implILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEE7_M_headERS5_(%"struct.std::_Tuple_impl.18"* dereferenceable(8) %3) #11
  ret %"class.llvm::Module"** %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZNSt11_Tuple_implILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEE7_M_headERS5_(%"struct.std::_Tuple_impl.18"* dereferenceable(8)) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Tuple_impl.18"*, align 8
  store %"struct.std::_Tuple_impl.18"* %0, %"struct.std::_Tuple_impl.18"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.18"*, %"struct.std::_Tuple_impl.18"** %2, align 8
  %4 = bitcast %"struct.std::_Tuple_impl.18"* %3 to %"struct.std::_Head_base.23"*
  %5 = call dereferenceable(8) %"class.llvm::Module"** @_ZNSt10_Head_baseILm0EPN4llvm6ModuleELb0EE7_M_headERS3_(%"struct.std::_Head_base.23"* dereferenceable(8) %4) #11
  ret %"class.llvm::Module"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZNSt10_Head_baseILm0EPN4llvm6ModuleELb0EE7_M_headERS3_(%"struct.std::_Head_base.23"* dereferenceable(8)) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Head_base.23"*, align 8
  store %"struct.std::_Head_base.23"* %0, %"struct.std::_Head_base.23"** %2, align 8
  %3 = load %"struct.std::_Head_base.23"*, %"struct.std::_Head_base.23"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Head_base.23", %"struct.std::_Head_base.23"* %3, i32 0, i32 0
  ret %"class.llvm::Module"** %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE10_M_deleterEv(%"class.std::__uniq_ptr_impl.16"*) #3 comdat align 2 {
  %2 = alloca %"class.std::__uniq_ptr_impl.16"*, align 8
  store %"class.std::__uniq_ptr_impl.16"* %0, %"class.std::__uniq_ptr_impl.16"** %2, align 8
  %3 = load %"class.std::__uniq_ptr_impl.16"*, %"class.std::__uniq_ptr_impl.16"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.16", %"class.std::__uniq_ptr_impl.16"* %3, i32 0, i32 0
  %5 = call dereferenceable(1) %"struct.std::default_delete.21"* @_ZSt3getILm1EJPN4llvm6ModuleESt14default_deleteIS1_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS9_(%"class.std::tuple.17"* dereferenceable(8) %4) #11
  ret %"struct.std::default_delete.21"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::default_delete.21"* @_ZSt3getILm1EJPN4llvm6ModuleESt14default_deleteIS1_EEERNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERS9_(%"class.std::tuple.17"* dereferenceable(8)) #3 comdat {
  %2 = alloca %"class.std::tuple.17"*, align 8
  store %"class.std::tuple.17"* %0, %"class.std::tuple.17"** %2, align 8
  %3 = load %"class.std::tuple.17"*, %"class.std::tuple.17"** %2, align 8
  %4 = bitcast %"class.std::tuple.17"* %3 to %"struct.std::_Tuple_impl.19"*
  %5 = call dereferenceable(1) %"struct.std::default_delete.21"* @_ZSt12__get_helperILm1ESt14default_deleteIN4llvm6ModuleEEJEERT0_RSt11_Tuple_implIXT_EJS4_DpT1_EE(%"struct.std::_Tuple_impl.19"* dereferenceable(1) %4) #11
  ret %"struct.std::default_delete.21"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::default_delete.21"* @_ZSt12__get_helperILm1ESt14default_deleteIN4llvm6ModuleEEJEERT0_RSt11_Tuple_implIXT_EJS4_DpT1_EE(%"struct.std::_Tuple_impl.19"* dereferenceable(1)) #3 comdat {
  %2 = alloca %"struct.std::_Tuple_impl.19"*, align 8
  store %"struct.std::_Tuple_impl.19"* %0, %"struct.std::_Tuple_impl.19"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.19"*, %"struct.std::_Tuple_impl.19"** %2, align 8
  %4 = call dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt11_Tuple_implILm1EJSt14default_deleteIN4llvm6ModuleEEEE7_M_headERS4_(%"struct.std::_Tuple_impl.19"* dereferenceable(1) %3) #11
  ret %"struct.std::default_delete.21"* %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt11_Tuple_implILm1EJSt14default_deleteIN4llvm6ModuleEEEE7_M_headERS4_(%"struct.std::_Tuple_impl.19"* dereferenceable(1)) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Tuple_impl.19"*, align 8
  store %"struct.std::_Tuple_impl.19"* %0, %"struct.std::_Tuple_impl.19"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.19"*, %"struct.std::_Tuple_impl.19"** %2, align 8
  %4 = bitcast %"struct.std::_Tuple_impl.19"* %3 to %"struct.std::_Head_base.20"*
  %5 = call dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt10_Head_baseILm1ESt14default_deleteIN4llvm6ModuleEELb1EE7_M_headERS4_(%"struct.std::_Head_base.20"* dereferenceable(1) %4) #11
  ret %"struct.std::default_delete.21"* %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(1) %"struct.std::default_delete.21"* @_ZNSt10_Head_baseILm1ESt14default_deleteIN4llvm6ModuleEELb1EE7_M_headERS4_(%"struct.std::_Head_base.20"* dereferenceable(1)) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Head_base.20"*, align 8
  store %"struct.std::_Head_base.20"* %0, %"struct.std::_Head_base.20"** %2, align 8
  %3 = load %"struct.std::_Head_base.20"*, %"struct.std::_Head_base.20"** %2, align 8
  %4 = bitcast %"struct.std::_Head_base.20"* %3 to %"struct.std::default_delete.21"*
  ret %"struct.std::default_delete.21"* %4
}

; Function Attrs: nounwind
declare void @_ZN4llvm6ModuleD1Ev(%"class.llvm::Module"*) unnamed_addr #4

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::Module"* @_ZNKSt10unique_ptrIN4llvm6ModuleESt14default_deleteIS1_EE3getEv(%"class.std::unique_ptr.15"*) #3 comdat align 2 personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*) {
  %2 = alloca %"class.std::unique_ptr.15"*, align 8
  store %"class.std::unique_ptr.15"* %0, %"class.std::unique_ptr.15"** %2, align 8
  %3 = load %"class.std::unique_ptr.15"*, %"class.std::unique_ptr.15"** %2, align 8
  %4 = getelementptr inbounds %"class.std::unique_ptr.15", %"class.std::unique_ptr.15"* %3, i32 0, i32 0
  %5 = invoke %"class.llvm::Module"* @_ZNKSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.16"* %4)
          to label %6 unwind label %7

; <label>:6:                                      ; preds = %1
  ret %"class.llvm::Module"* %5

; <label>:7:                                      ; preds = %1
  %8 = landingpad { i8*, i32 }
          catch i8* null
  %9 = extractvalue { i8*, i32 } %8, 0
  call void @__clang_call_terminate(i8* %9) #12
  unreachable
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::Module"* @_ZNKSt15__uniq_ptr_implIN4llvm6ModuleESt14default_deleteIS1_EE6_M_ptrEv(%"class.std::__uniq_ptr_impl.16"*) #3 comdat align 2 {
  %2 = alloca %"class.std::__uniq_ptr_impl.16"*, align 8
  store %"class.std::__uniq_ptr_impl.16"* %0, %"class.std::__uniq_ptr_impl.16"** %2, align 8
  %3 = load %"class.std::__uniq_ptr_impl.16"*, %"class.std::__uniq_ptr_impl.16"** %2, align 8
  %4 = getelementptr inbounds %"class.std::__uniq_ptr_impl.16", %"class.std::__uniq_ptr_impl.16"* %3, i32 0, i32 0
  %5 = call dereferenceable(8) %"class.llvm::Module"** @_ZSt3getILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.17"* dereferenceable(8) %4) #11
  %6 = load %"class.llvm::Module"*, %"class.llvm::Module"** %5, align 8
  ret %"class.llvm::Module"* %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZSt3getILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEERKNSt13tuple_elementIXT_ESt5tupleIJDpT0_EEE4typeERKS9_(%"class.std::tuple.17"* dereferenceable(8)) #3 comdat {
  %2 = alloca %"class.std::tuple.17"*, align 8
  store %"class.std::tuple.17"* %0, %"class.std::tuple.17"** %2, align 8
  %3 = load %"class.std::tuple.17"*, %"class.std::tuple.17"** %2, align 8
  %4 = bitcast %"class.std::tuple.17"* %3 to %"struct.std::_Tuple_impl.18"*
  %5 = call dereferenceable(8) %"class.llvm::Module"** @_ZSt12__get_helperILm0EPN4llvm6ModuleEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.18"* dereferenceable(8) %4) #11
  ret %"class.llvm::Module"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZSt12__get_helperILm0EPN4llvm6ModuleEJSt14default_deleteIS1_EEERKT0_RKSt11_Tuple_implIXT_EJS5_DpT1_EE(%"struct.std::_Tuple_impl.18"* dereferenceable(8)) #3 comdat {
  %2 = alloca %"struct.std::_Tuple_impl.18"*, align 8
  store %"struct.std::_Tuple_impl.18"* %0, %"struct.std::_Tuple_impl.18"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.18"*, %"struct.std::_Tuple_impl.18"** %2, align 8
  %4 = call dereferenceable(8) %"class.llvm::Module"** @_ZNSt11_Tuple_implILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.18"* dereferenceable(8) %3) #11
  ret %"class.llvm::Module"** %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZNSt11_Tuple_implILm0EJPN4llvm6ModuleESt14default_deleteIS1_EEE7_M_headERKS5_(%"struct.std::_Tuple_impl.18"* dereferenceable(8)) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Tuple_impl.18"*, align 8
  store %"struct.std::_Tuple_impl.18"* %0, %"struct.std::_Tuple_impl.18"** %2, align 8
  %3 = load %"struct.std::_Tuple_impl.18"*, %"struct.std::_Tuple_impl.18"** %2, align 8
  %4 = bitcast %"struct.std::_Tuple_impl.18"* %3 to %"struct.std::_Head_base.23"*
  %5 = call dereferenceable(8) %"class.llvm::Module"** @_ZNSt10_Head_baseILm0EPN4llvm6ModuleELb0EE7_M_headERKS3_(%"struct.std::_Head_base.23"* dereferenceable(8) %4) #11
  ret %"class.llvm::Module"** %5
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Module"** @_ZNSt10_Head_baseILm0EPN4llvm6ModuleELb0EE7_M_headERKS3_(%"struct.std::_Head_base.23"* dereferenceable(8)) #3 comdat align 2 {
  %2 = alloca %"struct.std::_Head_base.23"*, align 8
  store %"struct.std::_Head_base.23"* %0, %"struct.std::_Head_base.23"** %2, align 8
  %3 = load %"struct.std::_Head_base.23"*, %"struct.std::_Head_base.23"** %2, align 8
  %4 = getelementptr inbounds %"struct.std::_Head_base.23", %"struct.std::_Head_base.23"* %3, i32 0, i32 0
  ret %"class.llvm::Module"** %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::ilist_node_impl.53"* @_ZNK4llvm15ilist_node_implINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE7getNextEv(%"class.llvm::ilist_node_impl.53"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_node_impl.53"*, align 8
  store %"class.llvm::ilist_node_impl.53"* %0, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %3 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %4 = bitcast %"class.llvm::ilist_node_impl.53"* %3 to %"class.llvm::ilist_node_base"*
  %5 = call %"class.llvm::ilist_node_base"* @_ZNK4llvm15ilist_node_baseILb0EE7getNextEv(%"class.llvm::ilist_node_base"* %4)
  %6 = bitcast %"class.llvm::ilist_node_base"* %5 to %"class.llvm::ilist_node_impl.53"*
  ret %"class.llvm::ilist_node_impl.53"* %6
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr dereferenceable(64) %"class.llvm::NamedMDNode"* @_ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEdeEv(%"class.llvm::ilist_iterator"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_iterator"*, align 8
  store %"class.llvm::ilist_iterator"* %0, %"class.llvm::ilist_iterator"** %2, align 8
  %3 = load %"class.llvm::ilist_iterator"*, %"class.llvm::ilist_iterator"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %3, i32 0, i32 0
  %5 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %4, align 8
  %6 = bitcast %"class.llvm::ilist_node_impl.53"* %5 to %"class.llvm::ilist_node_base"*
  %7 = call zeroext i1 @_ZNK4llvm15ilist_node_baseILb0EE15isKnownSentinelEv(%"class.llvm::ilist_node_base"* %6)
  %8 = xor i1 %7, true
  br i1 %8, label %9, label %10

; <label>:9:                                      ; preds = %1
  br label %12

; <label>:10:                                     ; preds = %1
  call void @__assert_fail(i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.6, i32 0, i32 0), i8* getelementptr inbounds ([39 x i8], [39 x i8]* @.str.7, i32 0, i32 0), i32 140, i8* getelementptr inbounds ([278 x i8], [278 x i8]* @__PRETTY_FUNCTION__._ZNK4llvm14ilist_iteratorINS_12ilist_detail12node_optionsINS_11NamedMDNodeELb0ELb0EvEELb0ELb1EEdeEv, i32 0, i32 0)) #12
  unreachable
                                                  ; No predecessors!
  br label %12

; <label>:12:                                     ; preds = %11, %9
  %13 = getelementptr inbounds %"class.llvm::ilist_iterator", %"class.llvm::ilist_iterator"* %3, i32 0, i32 0
  %14 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %13, align 8
  %15 = call %"class.llvm::NamedMDNode"* @_ZN4llvm12ilist_detail18SpecificNodeAccessINS0_12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE11getValuePtrEPKNS_15ilist_node_implIS4_EE(%"class.llvm::ilist_node_impl.53"* %14)
  ret %"class.llvm::NamedMDNode"* %15
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr zeroext i1 @_ZNK4llvm15ilist_node_baseILb0EE15isKnownSentinelEv(%"class.llvm::ilist_node_base"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_node_base"*, align 8
  store %"class.llvm::ilist_node_base"* %0, %"class.llvm::ilist_node_base"** %2, align 8
  %3 = load %"class.llvm::ilist_node_base"*, %"class.llvm::ilist_node_base"** %2, align 8
  ret i1 false
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #9

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::NamedMDNode"* @_ZN4llvm12ilist_detail18SpecificNodeAccessINS0_12node_optionsINS_11NamedMDNodeELb0ELb0EvEEE11getValuePtrEPKNS_15ilist_node_implIS4_EE(%"class.llvm::ilist_node_impl.53"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_node_impl.53"*, align 8
  store %"class.llvm::ilist_node_impl.53"* %0, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %3 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %4 = call %"class.llvm::NamedMDNode"* @_ZN4llvm12ilist_detail10NodeAccess11getValuePtrINS0_12node_optionsINS_11NamedMDNodeELb0ELb0EvEEEENT_13const_pointerEPKNS_15ilist_node_implIS6_EE(%"class.llvm::ilist_node_impl.53"* %3)
  ret %"class.llvm::NamedMDNode"* %4
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::NamedMDNode"* @_ZN4llvm12ilist_detail10NodeAccess11getValuePtrINS0_12node_optionsINS_11NamedMDNodeELb0ELb0EvEEEENT_13const_pointerEPKNS_15ilist_node_implIS6_EE(%"class.llvm::ilist_node_impl.53"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::ilist_node_impl.53"*, align 8
  store %"class.llvm::ilist_node_impl.53"* %0, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %3 = load %"class.llvm::ilist_node_impl.53"*, %"class.llvm::ilist_node_impl.53"** %2, align 8
  %4 = bitcast %"class.llvm::ilist_node_impl.53"* %3 to %"class.llvm::NamedMDNode"*
  ret %"class.llvm::NamedMDNode"* %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvm3isaINS_6MDNodeEPNS_8MetadataEEEbRKT0_(%"class.llvm::Metadata"** dereferenceable(8)) #2 comdat {
  %2 = alloca %"class.llvm::Metadata"**, align 8
  store %"class.llvm::Metadata"** %0, %"class.llvm::Metadata"*** %2, align 8
  %3 = load %"class.llvm::Metadata"**, %"class.llvm::Metadata"*** %2, align 8
  %4 = call zeroext i1 @_ZN4llvm13isa_impl_wrapINS_6MDNodeEKPNS_8MetadataEPKS2_E4doitERS4_(%"class.llvm::Metadata"** dereferenceable(8) %3)
  ret i1 %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::MDNode"* @_ZN4llvm4castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_(%"class.llvm::Metadata"*) #2 comdat {
  %2 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"* %0, %"class.llvm::Metadata"** %2, align 8
  %3 = call zeroext i1 @_ZN4llvm3isaINS_6MDNodeEPNS_8MetadataEEEbRKT0_(%"class.llvm::Metadata"** dereferenceable(8) %2)
  br i1 %3, label %4, label %5

; <label>:4:                                      ; preds = %1
  br label %5

; <label>:5:                                      ; preds = %4, %1
  %6 = phi i1 [ false, %1 ], [ true, %4 ]
  br i1 %6, label %7, label %8

; <label>:7:                                      ; preds = %5
  br label %10

; <label>:8:                                      ; preds = %5
  call void @__assert_fail(i8* getelementptr inbounds ([59 x i8], [59 x i8]* @.str.12, i32 0, i32 0), i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.10, i32 0, i32 0), i32 255, i8* getelementptr inbounds ([93 x i8], [93 x i8]* @__PRETTY_FUNCTION__._ZN4llvm4castINS_6MDNodeENS_8MetadataEEENS_10cast_rettyIT_PT0_E8ret_typeES6_, i32 0, i32 0)) #12
  unreachable
                                                  ; No predecessors!
  br label %10

; <label>:10:                                     ; preds = %9, %7
  %11 = call %"class.llvm::MDNode"* @_ZN4llvm16cast_convert_valINS_6MDNodeEPNS_8MetadataES3_E4doitERKS3_(%"class.llvm::Metadata"** dereferenceable(8) %2)
  ret %"class.llvm::MDNode"* %11
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvm13isa_impl_wrapINS_6MDNodeEKPNS_8MetadataEPKS2_E4doitERS4_(%"class.llvm::Metadata"** dereferenceable(8)) #2 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"**, align 8
  %3 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"** %0, %"class.llvm::Metadata"*** %2, align 8
  %4 = load %"class.llvm::Metadata"**, %"class.llvm::Metadata"*** %2, align 8
  %5 = call %"class.llvm::Metadata"* @_ZN4llvm13simplify_typeIKPNS_8MetadataEE18getSimplifiedValueERS3_(%"class.llvm::Metadata"** dereferenceable(8) %4)
  store %"class.llvm::Metadata"* %5, %"class.llvm::Metadata"** %3, align 8
  %6 = call zeroext i1 @_ZN4llvm13isa_impl_wrapINS_6MDNodeEPKNS_8MetadataES4_E4doitERKS4_(%"class.llvm::Metadata"** dereferenceable(8) %3)
  ret i1 %6
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvm13isa_impl_wrapINS_6MDNodeEPKNS_8MetadataES4_E4doitERKS4_(%"class.llvm::Metadata"** dereferenceable(8)) #2 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"**, align 8
  store %"class.llvm::Metadata"** %0, %"class.llvm::Metadata"*** %2, align 8
  %3 = load %"class.llvm::Metadata"**, %"class.llvm::Metadata"*** %2, align 8
  %4 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %3, align 8
  %5 = call zeroext i1 @_ZN4llvm11isa_impl_clINS_6MDNodeEPKNS_8MetadataEE4doitES4_(%"class.llvm::Metadata"* %4)
  ret i1 %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr %"class.llvm::Metadata"* @_ZN4llvm13simplify_typeIKPNS_8MetadataEE18getSimplifiedValueERS3_(%"class.llvm::Metadata"** dereferenceable(8)) #2 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"**, align 8
  store %"class.llvm::Metadata"** %0, %"class.llvm::Metadata"*** %2, align 8
  %3 = load %"class.llvm::Metadata"**, %"class.llvm::Metadata"*** %2, align 8
  %4 = call dereferenceable(8) %"class.llvm::Metadata"** @_ZN4llvm13simplify_typeIPNS_8MetadataEE18getSimplifiedValueERS2_(%"class.llvm::Metadata"** dereferenceable(8) %3)
  %5 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %4, align 8
  ret %"class.llvm::Metadata"* %5
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvm11isa_impl_clINS_6MDNodeEPKNS_8MetadataEE4doitES4_(%"class.llvm::Metadata"*) #2 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"* %0, %"class.llvm::Metadata"** %2, align 8
  %3 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %2, align 8
  %4 = icmp ne %"class.llvm::Metadata"* %3, null
  br i1 %4, label %5, label %6

; <label>:5:                                      ; preds = %1
  br label %6

; <label>:6:                                      ; preds = %5, %1
  %7 = phi i1 [ false, %1 ], [ true, %5 ]
  br i1 %7, label %8, label %9

; <label>:8:                                      ; preds = %6
  br label %11

; <label>:9:                                      ; preds = %6
  call void @__assert_fail(i8* getelementptr inbounds ([38 x i8], [38 x i8]* @.str.9, i32 0, i32 0), i8* getelementptr inbounds ([36 x i8], [36 x i8]* @.str.10, i32 0, i32 0), i32 106, i8* getelementptr inbounds ([139 x i8], [139 x i8]* @__PRETTY_FUNCTION__._ZN4llvm11isa_impl_clINS_6MDNodeEPKNS_8MetadataEE4doitES4_, i32 0, i32 0)) #12
  unreachable
                                                  ; No predecessors!
  br label %11

; <label>:11:                                     ; preds = %10, %8
  %12 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %2, align 8
  %13 = call zeroext i1 @_ZN4llvm8isa_implINS_6MDNodeENS_8MetadataEvE4doitERKS2_(%"class.llvm::Metadata"* dereferenceable(8) %12)
  ret i1 %13
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvm8isa_implINS_6MDNodeENS_8MetadataEvE4doitERKS2_(%"class.llvm::Metadata"* dereferenceable(8)) #2 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"* %0, %"class.llvm::Metadata"** %2, align 8
  %3 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %2, align 8
  %4 = call zeroext i1 @_ZN4llvm6MDNode7classofEPKNS_8MetadataE(%"class.llvm::Metadata"* %3)
  ret i1 %4
}

; Function Attrs: noinline optnone uwtable
define linkonce_odr zeroext i1 @_ZN4llvm6MDNode7classofEPKNS_8MetadataE(%"class.llvm::Metadata"*) #2 comdat align 2 {
  %2 = alloca i1, align 1
  %3 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"* %0, %"class.llvm::Metadata"** %3, align 8
  %4 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %3, align 8
  %5 = call i32 @_ZNK4llvm8Metadata13getMetadataIDEv(%"class.llvm::Metadata"* %4)
  switch i32 %5, label %6 [
    i32 4, label %7
    i32 5, label %8
    i32 6, label %9
    i32 7, label %10
    i32 8, label %11
    i32 9, label %12
    i32 10, label %13
    i32 11, label %14
    i32 12, label %15
    i32 13, label %16
    i32 14, label %17
    i32 15, label %18
    i32 16, label %19
    i32 17, label %20
    i32 18, label %21
    i32 19, label %22
    i32 20, label %23
    i32 21, label %24
    i32 22, label %25
    i32 23, label %26
    i32 24, label %27
    i32 25, label %28
    i32 26, label %29
    i32 27, label %30
    i32 28, label %31
    i32 29, label %32
  ]

; <label>:6:                                      ; preds = %1
  store i1 false, i1* %2, align 1
  br label %33

; <label>:7:                                      ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:8:                                      ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:9:                                      ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:10:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:11:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:12:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:13:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:14:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:15:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:16:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:17:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:18:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:19:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:20:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:21:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:22:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:23:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:24:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:25:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:26:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:27:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:28:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:29:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:30:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:31:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:32:                                     ; preds = %1
  store i1 true, i1* %2, align 1
  br label %33

; <label>:33:                                     ; preds = %32, %31, %30, %29, %28, %27, %26, %25, %24, %23, %22, %21, %20, %19, %18, %17, %16, %15, %14, %13, %12, %11, %10, %9, %8, %7, %6
  %34 = load i1, i1* %2, align 1
  ret i1 %34
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr i32 @_ZNK4llvm8Metadata13getMetadataIDEv(%"class.llvm::Metadata"*) #3 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"*, align 8
  store %"class.llvm::Metadata"* %0, %"class.llvm::Metadata"** %2, align 8
  %3 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %2, align 8
  %4 = getelementptr inbounds %"class.llvm::Metadata", %"class.llvm::Metadata"* %3, i32 0, i32 0
  %5 = load i8, i8* %4, align 4
  %6 = zext i8 %5 to i32
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr dereferenceable(8) %"class.llvm::Metadata"** @_ZN4llvm13simplify_typeIPNS_8MetadataEE18getSimplifiedValueERS2_(%"class.llvm::Metadata"** dereferenceable(8)) #3 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"**, align 8
  store %"class.llvm::Metadata"** %0, %"class.llvm::Metadata"*** %2, align 8
  %3 = load %"class.llvm::Metadata"**, %"class.llvm::Metadata"*** %2, align 8
  ret %"class.llvm::Metadata"** %3
}

; Function Attrs: noinline nounwind optnone uwtable
define linkonce_odr %"class.llvm::MDNode"* @_ZN4llvm16cast_convert_valINS_6MDNodeEPNS_8MetadataES3_E4doitERKS3_(%"class.llvm::Metadata"** dereferenceable(8)) #3 comdat align 2 {
  %2 = alloca %"class.llvm::Metadata"**, align 8
  %3 = alloca %"class.llvm::MDNode"*, align 8
  store %"class.llvm::Metadata"** %0, %"class.llvm::Metadata"*** %2, align 8
  %4 = load %"class.llvm::Metadata"**, %"class.llvm::Metadata"*** %2, align 8
  %5 = load %"class.llvm::Metadata"*, %"class.llvm::Metadata"** %4, align 8
  %6 = bitcast %"class.llvm::Metadata"* %5 to %"class.llvm::MDNode"*
  store %"class.llvm::MDNode"* %6, %"class.llvm::MDNode"** %3, align 8
  %7 = load %"class.llvm::MDNode"*, %"class.llvm::MDNode"** %3, align 8
  ret %"class.llvm::MDNode"* %7
}

attributes #0 = { noinline norecurse optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noinline optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { argmemonly nounwind }
attributes #6 = { noinline noreturn nounwind }
attributes #7 = { nobuiltin nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nounwind readonly }
attributes #11 = { nounwind }
attributes #12 = { noreturn nounwind }
attributes #13 = { builtin nounwind }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 6.0.0-1ubuntu2 (tags/RELEASE_600/final)"}
