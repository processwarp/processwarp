; ModuleID = 'test_corruption_2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type { i32 (...)**, i32 }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type { %"class.std::locale::facet", %struct.__locale_struct*, i8, i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8 }
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet" }
%"class.std::num_get" = type { %"class.std::locale::facet" }
%"class.std::allocator" = type { i8 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::basic_fstream" = type { %"class.std::basic_iostream.base", %"class.std::basic_filebuf", %"class.std::basic_ios" }
%"class.std::basic_iostream.base" = type { %"class.std::basic_istream.base", %"class.std::basic_ostream.base" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_ostream.base" = type { i32 (...)** }
%"class.std::basic_filebuf" = type { %"class.std::basic_streambuf", %union.pthread_mutex_t, %"class.std::__basic_file", i32, %struct.__mbstate_t, %struct.__mbstate_t, %struct.__mbstate_t, i8*, i64, i8, i8, i8, i8, i8*, i8*, i8, %"class.std::codecvt"*, i8*, i64, i8*, i8* }
%union.pthread_mutex_t = type { %"struct.<anonymous union>::__pthread_mutex_s" }
%"struct.<anonymous union>::__pthread_mutex_s" = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { %struct.__pthread_internal_list*, %struct.__pthread_internal_list* }
%"class.std::__basic_file" = type { %struct._IO_FILE*, i8 }
%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }
%struct.__mbstate_t = type { i32, %union.anon }
%union.anon = type { i32 }
%"class.std::codecvt" = type { %"class.std::__codecvt_abstract_base", %struct.__locale_struct* }
%"class.std::__codecvt_abstract_base" = type { %"class.std::locale::facet" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str1 = private unnamed_addr constant [18 x i8] c"/Script/WA-KA.txt\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str2 = private unnamed_addr constant [6 x i8] c"open!\00", align 1
@.str3 = private unnamed_addr constant [9 x i8] c"missing!\00", align 1
@_ZTVSt13basic_fstreamIcSt11char_traitsIcEE = external unnamed_addr constant [15 x i8*]
@_ZTTSt13basic_fstreamIcSt11char_traitsIcEE = external unnamed_addr constant [10 x i8*]
@_ZTVSt13basic_filebufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*]
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]
@str = private unnamed_addr constant [7 x i8] c"all ok\00"

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nounwind uwtable
define void @_Z3byev() #2 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %testPath = alloca %"class.std::basic_string", align 8
  %3 = alloca %"class.std::allocator", align 1
  %str = alloca %"class.std::basic_fstream", align 8
  %4 = call i32 @atexit(void ()* @_Z3byev) #1
  call void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %testPath, i8* getelementptr inbounds ([18 x i8]* @.str1, i64 0, i64 0), %"class.std::allocator"* %3) #1
  %5 = bitcast %"class.std::basic_fstream"* %str to i8*
  call void @llvm.lifetime.start(i64 528, i8* %5) #1
  %6 = getelementptr inbounds %"class.std::basic_string"* %testPath, i64 0, i32 0, i32 0
  %7 = load i8** %6, align 8, !tbaa !1
  call void @_ZNSt13basic_fstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_fstream"* %str, i8* %7, i32 12)
  %8 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 1, i32 2
  %9 = call zeroext i1 @_ZNKSt12__basic_fileIcE7is_openEv(%"class.std::__basic_file"* %8) #6
  br i1 %9, label %10, label %35

; <label>:10                                      ; preds = %0
  %11 = call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 5) #1
  %12 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !7
  %13 = getelementptr i8* %12, i64 -24
  %14 = bitcast i8* %13 to i64*
  %15 = load i64* %14, align 8
  %.sum4 = add i64 %15, 240
  %16 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum4
  %17 = bitcast i8* %16 to %"class.std::ctype"**
  %18 = load %"class.std::ctype"** %17, align 8, !tbaa !9
  %19 = icmp eq %"class.std::ctype"* %18, null
  br i1 %19, label %20, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit

; <label>:20                                      ; preds = %10
  call void @_ZSt16__throw_bad_castv() #7
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit:    ; preds = %10
  %21 = getelementptr inbounds %"class.std::ctype"* %18, i64 0, i32 6
  %22 = load i8* %21, align 1, !tbaa !12
  %23 = icmp eq i8 %22, 0
  br i1 %23, label %27, label %24

; <label>:24                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit
  %25 = getelementptr inbounds %"class.std::ctype"* %18, i64 0, i32 7, i64 10
  %26 = load i8* %25, align 1, !tbaa !14
  br label %_ZNKSt5ctypeIcE5widenEc.exit

; <label>:27                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %18) #1
  %28 = bitcast %"class.std::ctype"* %18 to i8 (%"class.std::ctype"*, i8)***
  %29 = load i8 (%"class.std::ctype"*, i8)*** %28, align 8, !tbaa !7
  %30 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %29, i64 6
  %31 = load i8 (%"class.std::ctype"*, i8)** %30, align 8
  %32 = call signext i8 %31(%"class.std::ctype"* %18, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit

_ZNKSt5ctypeIcE5widenEc.exit:                     ; preds = %27, %24
  %.0.i = phi i8 [ %26, %24 ], [ %32, %27 ]
  %33 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i) #1
  %34 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %33) #1
  br label %60

; <label>:35                                      ; preds = %0
  %36 = call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 8) #1
  %37 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !7
  %38 = getelementptr i8* %37, i64 -24
  %39 = bitcast i8* %38 to i64*
  %40 = load i64* %39, align 8
  %.sum = add i64 %40, 240
  %41 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %42 = bitcast i8* %41 to %"class.std::ctype"**
  %43 = load %"class.std::ctype"** %42, align 8, !tbaa !9
  %44 = icmp eq %"class.std::ctype"* %43, null
  br i1 %44, label %45, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit3

; <label>:45                                      ; preds = %35
  call void @_ZSt16__throw_bad_castv() #7
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit3:   ; preds = %35
  %46 = getelementptr inbounds %"class.std::ctype"* %43, i64 0, i32 6
  %47 = load i8* %46, align 1, !tbaa !12
  %48 = icmp eq i8 %47, 0
  br i1 %48, label %52, label %49

; <label>:49                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit3
  %50 = getelementptr inbounds %"class.std::ctype"* %43, i64 0, i32 7, i64 10
  %51 = load i8* %50, align 1, !tbaa !14
  br label %_ZNKSt5ctypeIcE5widenEc.exit2

; <label>:52                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit3
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %43) #1
  %53 = bitcast %"class.std::ctype"* %43 to i8 (%"class.std::ctype"*, i8)***
  %54 = load i8 (%"class.std::ctype"*, i8)*** %53, align 8, !tbaa !7
  %55 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %54, i64 6
  %56 = load i8 (%"class.std::ctype"*, i8)** %55, align 8
  %57 = call signext i8 %56(%"class.std::ctype"* %43, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit2

_ZNKSt5ctypeIcE5widenEc.exit2:                    ; preds = %52, %49
  %.0.i1 = phi i8 [ %51, %49 ], [ %57, %52 ]
  %58 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i1) #1
  %59 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %58) #1
  br label %60

; <label>:60                                      ; preds = %_ZNKSt5ctypeIcE5widenEc.exit2, %_ZNKSt5ctypeIcE5widenEc.exit
  %61 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 0), align 8
  %62 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 0, i32 0
  %.c.i.i = bitcast i8* %61 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %62, align 8, !tbaa !7
  %63 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 8), align 8
  %64 = getelementptr i8* %61, i64 -24
  %65 = bitcast i8* %64 to i64*
  %66 = load i64* %65, align 8
  %67 = getelementptr inbounds i8* %5, i64 %66
  %68 = bitcast i8* %67 to i8**
  store i8* %63, i8** %68, align 8, !tbaa !7
  %69 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 9), align 8
  %70 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 1, i32 0
  %.c1.i.i = bitcast i8* %69 to i32 (...)**
  store i32 (...)** %.c1.i.i, i32 (...)*** %70, align 8, !tbaa !7
  %71 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 1
  %72 = getelementptr inbounds %"class.std::basic_filebuf"* %71, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt13basic_filebufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %72, align 8, !tbaa !7
  %73 = call %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(%"class.std::basic_filebuf"* %71) #1
  call void @_ZNSt12__basic_fileIcED1Ev(%"class.std::__basic_file"* %8) #1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %72, align 8, !tbaa !7
  %74 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %74) #1
  %75 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 2), align 8
  %.c.i.i.i.i = bitcast i8* %75 to i32 (...)**
  store i32 (...)** %.c.i.i.i.i, i32 (...)*** %62, align 8, !tbaa !7
  %76 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3), align 8
  %77 = getelementptr i8* %75, i64 -24
  %78 = bitcast i8* %77 to i64*
  %79 = load i64* %78, align 8
  %80 = getelementptr inbounds i8* %5, i64 %79
  %81 = bitcast i8* %80 to i8**
  store i8* %76, i8** %81, align 8, !tbaa !7
  %82 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %82, align 8, !tbaa !15
  %83 = getelementptr inbounds %"class.std::basic_fstream"* %str, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %83) #1
  call void @llvm.lifetime.end(i64 528, i8* %5) #1
  %84 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %84) #1
  %85 = load i8** %6, align 8, !tbaa !1
  %86 = getelementptr inbounds i8* %85, i64 -24
  %87 = bitcast i8* %86 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %88 = icmp eq i8* %86, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %88, label %_ZNSsD1Ev.exit, label %89, !prof !18

; <label>:89                                      ; preds = %60
  %90 = getelementptr inbounds i8* %85, i64 -8
  %91 = bitcast i8* %90 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %92, label %96

; <label>:92                                      ; preds = %89
  %93 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %93)
  %94 = atomicrmw volatile add i32* %91, i32 -1 acq_rel
  store i32 %94, i32* %1, align 4
  %95 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %93)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:96                                      ; preds = %89
  %97 = load i32* %91, align 4, !tbaa !19
  %98 = add nsw i32 %97, -1
  store i32 %98, i32* %91, align 4, !tbaa !19
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %96, %92
  %.0.i.i.i.i = phi i32 [ %95, %92 ], [ %97, %96 ]
  %99 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %99, label %100, label %_ZNSsD1Ev.exit

; <label>:100                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %87, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %100, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %60
  call void @llvm.lifetime.end(i64 1, i8* %84) #1
  ret i32 1
}

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #3

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt13basic_fstreamIcSt11char_traitsIcEEC1EPKcSt13_Ios_Openmode(%"class.std::basic_fstream"* %this, i8* %__s, i32 %__mode) unnamed_addr #2 align 2 {
  %1 = bitcast %"class.std::basic_fstream"* %this to i8*
  %2 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2
  %3 = getelementptr inbounds %"class.std::basic_ios"* %2, i64 0, i32 0
  tail call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %3) #1
  %4 = getelementptr inbounds %"class.std::basic_ios"* %2, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !7
  %5 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %5, align 8, !tbaa !21
  %6 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %6, align 1, !tbaa !22
  %7 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %7, align 1, !tbaa !23
  %8 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 2, i32 4
  %9 = bitcast %"class.std::basic_streambuf"** %8 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 32, i32 8, i1 false) #1
  %10 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 2), align 8
  %11 = bitcast %"class.std::basic_fstream"* %this to i8**
  %12 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 0, i32 0
  %.c.i.i = bitcast i8* %10 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %12, align 8, !tbaa !7
  %13 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3), align 8
  %14 = getelementptr i8* %10, i64 -24
  %15 = bitcast i8* %14 to i64*
  %16 = load i64* %15, align 8
  %17 = getelementptr inbounds i8* %1, i64 %16
  %18 = bitcast i8* %17 to i8**
  store i8* %13, i8** %18, align 8, !tbaa !7
  %19 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %19, align 8, !tbaa !15
  %20 = load i8** %11, align 8, !tbaa !7
  %21 = getelementptr i8* %20, i64 -24
  %22 = bitcast i8* %21 to i64*
  %23 = load i64* %22, align 8
  %24 = getelementptr inbounds i8* %1, i64 %23
  %25 = bitcast i8* %24 to %"class.std::basic_ios"*
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %25, %"class.std::basic_streambuf"* null) #1
  %26 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 1
  %27 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 4), align 8
  %28 = bitcast %"class.std::basic_ostream.base"* %26 to i8**
  %29 = getelementptr inbounds %"class.std::basic_ostream.base"* %26, i64 0, i32 0
  %.c.i2.i = bitcast i8* %27 to i32 (...)**
  store i32 (...)** %.c.i2.i, i32 (...)*** %29, align 8, !tbaa !7
  %30 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 5), align 8
  %31 = getelementptr i8* %27, i64 -24
  %32 = bitcast i8* %31 to i64*
  %33 = load i64* %32, align 8
  %34 = bitcast %"class.std::basic_ostream.base"* %26 to i8*
  %35 = getelementptr inbounds i8* %34, i64 %33
  %36 = bitcast i8* %35 to i8**
  store i8* %30, i8** %36, align 8, !tbaa !7
  %37 = load i8** %28, align 8, !tbaa !7
  %38 = getelementptr i8* %37, i64 -24
  %39 = bitcast i8* %38 to i64*
  %40 = load i64* %39, align 8
  %41 = getelementptr inbounds i8* %34, i64 %40
  %42 = bitcast i8* %41 to %"class.std::basic_ios"*
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %42, %"class.std::basic_streambuf"* null) #1
  %43 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 1), align 8
  %.c.i = bitcast i8* %43 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %12, align 8, !tbaa !7
  %44 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 6), align 8
  %45 = getelementptr i8* %43, i64 -24
  %46 = bitcast i8* %45 to i64*
  %47 = load i64* %46, align 8
  %48 = getelementptr inbounds i8* %1, i64 %47
  %49 = bitcast i8* %48 to i8**
  store i8* %44, i8** %49, align 8, !tbaa !7
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !7
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 13) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !7
  %50 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 0, i32 1, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt13basic_fstreamIcSt11char_traitsIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !7
  %51 = getelementptr inbounds %"class.std::basic_fstream"* %this, i64 0, i32 1
  tail call void @_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev(%"class.std::basic_filebuf"* %51) #1
  %52 = load i8** %11, align 8, !tbaa !7
  %53 = getelementptr i8* %52, i64 -24
  %54 = bitcast i8* %53 to i64*
  %55 = load i64* %54, align 8
  %56 = getelementptr inbounds i8* %1, i64 %55
  %57 = bitcast i8* %56 to %"class.std::basic_ios"*
  %58 = getelementptr inbounds %"class.std::basic_filebuf"* %51, i64 0, i32 0
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %57, %"class.std::basic_streambuf"* %58) #1
  %59 = tail call %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(%"class.std::basic_filebuf"* %51, i8* %__s, i32 %__mode) #1
  %60 = icmp eq %"class.std::basic_filebuf"* %59, null
  %61 = load i8** %11, align 8, !tbaa !7
  %62 = getelementptr i8* %61, i64 -24
  %63 = bitcast i8* %62 to i64*
  %64 = load i64* %63, align 8
  %65 = getelementptr inbounds i8* %1, i64 %64
  %66 = bitcast i8* %65 to %"class.std::basic_ios"*
  br i1 %60, label %67, label %72

; <label>:67                                      ; preds = %0
  %.sum.i = add i64 %64, 32
  %68 = getelementptr inbounds i8* %1, i64 %.sum.i
  %69 = bitcast i8* %68 to i32*
  %70 = load i32* %69, align 4, !tbaa !24
  %71 = or i32 %70, 4
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %66, i32 %71) #1
  br label %_ZNSt13basic_fstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode.exit

; <label>:72                                      ; preds = %0
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %66, i32 0) #1
  br label %_ZNSt13basic_fstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode.exit

_ZNSt13basic_fstreamIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode.exit: ; preds = %72, %67
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #4

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind readonly
declare zeroext i1 @_ZNKSt12__basic_fileIcE7is_openEv(%"class.std::__basic_file"*) #5

declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #0

declare %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv(%"class.std::basic_filebuf"*) #0

declare void @_ZNSt12__basic_fileIcED1Ev(%"class.std::__basic_file"*) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #3

declare void @_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev(%"class.std::basic_filebuf"*) #0

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

declare %"class.std::basic_filebuf"* @_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode(%"class.std::basic_filebuf"*, i8*, i32) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #3

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #3

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #3

; Function Attrs: nounwind
define internal void @_GLOBAL__I_a() #1 section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit) #1
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly }
attributes #7 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !4, i64 0}
!2 = metadata !{metadata !"_ZTSSs", metadata !3, i64 0}
!3 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !4, i64 0}
!4 = metadata !{metadata !"any pointer", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!9 = metadata !{metadata !10, metadata !4, i64 240}
!10 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !4, i64 216, metadata !5, i64 224, metadata !11, i64 225, metadata !4, i64 232, metadata !4, i64 240, metadata !4, i64 248, metadata !4, i64 256}
!11 = metadata !{metadata !"bool", metadata !5, i64 0}
!12 = metadata !{metadata !13, metadata !5, i64 56}
!13 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !4, i64 16, metadata !11, i64 24, metadata !4, i64 32, metadata !4, i64 40, metadata !4, i64 48, metadata !5, i64 56, metadata !5, i64 57, metadata !5, i64 313, metadata !5, i64 569}
!14 = metadata !{metadata !5, metadata !5, i64 0}
!15 = metadata !{metadata !16, metadata !17, i64 8}
!16 = metadata !{metadata !"_ZTSSi", metadata !17, i64 8}
!17 = metadata !{metadata !"long", metadata !5, i64 0}
!18 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!19 = metadata !{metadata !20, metadata !20, i64 0}
!20 = metadata !{metadata !"int", metadata !5, i64 0}
!21 = metadata !{metadata !10, metadata !4, i64 216}
!22 = metadata !{metadata !10, metadata !5, i64 224}
!23 = metadata !{metadata !10, metadata !11, i64 225}
!24 = metadata !{metadata !25, metadata !27, i64 32}
!25 = metadata !{metadata !"_ZTSSt8ios_base", metadata !17, i64 8, metadata !17, i64 16, metadata !26, i64 24, metadata !27, i64 28, metadata !27, i64 32, metadata !4, i64 40, metadata !28, i64 48, metadata !5, i64 64, metadata !20, i64 192, metadata !4, i64 200, metadata !29, i64 208}
!26 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !5, i64 0}
!27 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !5, i64 0}
!28 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !4, i64 0, metadata !17, i64 8}
!29 = metadata !{metadata !"_ZTSSt6locale", metadata !4, i64 0}
