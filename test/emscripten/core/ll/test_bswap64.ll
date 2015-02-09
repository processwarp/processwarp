; ModuleID = 'test_bswap64.bc'
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
%"class.std::basic_stringstream" = type { %"class.std::basic_iostream.base", %"class.std::basic_stringbuf", %"class.std::basic_ios" }
%"class.std::basic_iostream.base" = type { %"class.std::basic_istream.base", %"class.std::basic_ostream.base" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_ostream.base" = type { i32 (...)** }
%"class.std::basic_stringbuf" = type { %"class.std::basic_streambuf", i32, %"class.std::basic_string" }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str = private unnamed_addr constant [17 x i8] c"4433ffeeddccbb00\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%lld\0A\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str4 = private unnamed_addr constant [15 x i8] c"bbccddeeff3344\00", align 1
@.str5 = private unnamed_addr constant [8 x i8] c"Failed!\00", align 1
@.str6 = private unnamed_addr constant [11 x i8] c"Succeeded!\00", align 1
@.str7 = private unnamed_addr constant [42 x i8] c"basic_string::_S_construct null not valid\00", align 1
@_ZNSs4_Rep11_S_terminalE = external constant i8
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [15 x i8*]
@_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [10 x i8*]
@_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]
@str = private unnamed_addr constant [2 x i8] c"1\00"
@str8 = private unnamed_addr constant [2 x i8] c"2\00"

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main() #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator", align 1
  %string64bitInt = alloca %"class.std::basic_string", align 8
  %7 = alloca %"class.std::allocator", align 1
  %s = alloca %"class.std::basic_stringstream", align 8
  %int64bitInt = alloca i64, align 8
  %out = alloca %"class.std::basic_stringstream", align 8
  %8 = alloca %"class.std::basic_string", align 8
  %9 = alloca %"class.std::basic_string", align 8
  %10 = call i64 @strtoull(i8* nocapture getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), i8** null, i32 16) #1
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i64 %10) #1
  call void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %string64bitInt, i8* getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %7) #1
  %12 = bitcast %"class.std::basic_stringstream"* %s to i8*
  call void @llvm.lifetime.start(i64 368, i8* %12) #1
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_stringstream"* %s, %"class.std::basic_string"* %string64bitInt, i32 24)
  store i64 0, i64* %int64bitInt, align 8, !tbaa !1
  %puts = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str, i64 0, i64 0))
  %13 = bitcast %"class.std::basic_stringstream"* %s to %"class.std::basic_istream"*
  %14 = bitcast %"class.std::basic_stringstream"* %s to i8**
  %15 = load i8** %14, align 8, !tbaa !5
  %16 = getelementptr i8* %15, i64 -24
  %17 = bitcast i8* %16 to i64*
  %18 = load i64* %17, align 8
  %.sum = add i64 %18, 24
  %19 = getelementptr inbounds i8* %12, i64 %.sum
  %20 = bitcast i8* %19 to i32*
  %21 = load i32* %20, align 4, !tbaa !7
  %22 = and i32 %21, -75
  %23 = or i32 %22, 8
  store i32 %23, i32* %20, align 4, !tbaa !7
  %24 = call %"class.std::basic_istream"* @_ZNSi10_M_extractIyEERSiRT_(%"class.std::basic_istream"* %13, i64* %int64bitInt) #1
  %puts1 = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str8, i64 0, i64 0))
  %25 = bitcast %"class.std::basic_stringstream"* %out to i8*
  call void @llvm.lifetime.start(i64 368, i8* %25) #1
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode(%"class.std::basic_stringstream"* %out, i32 24)
  %26 = getelementptr inbounds %"class.std::basic_stringstream"* %out, i64 0, i32 0, i32 1
  %27 = bitcast %"class.std::basic_ostream.base"* %26 to %"class.std::basic_ostream"*
  %28 = bitcast %"class.std::basic_ostream.base"* %26 to i8**
  %29 = load i8** %28, align 8, !tbaa !5
  %30 = getelementptr i8* %29, i64 -24
  %31 = bitcast i8* %30 to i64*
  %32 = load i64* %31, align 8
  %33 = bitcast %"class.std::basic_ostream.base"* %26 to i8*
  %.sum20 = add i64 %32, 24
  %34 = getelementptr inbounds i8* %33, i64 %.sum20
  %35 = bitcast i8* %34 to i32*
  %36 = load i32* %35, align 4, !tbaa !7
  %37 = and i32 %36, -75
  %38 = or i32 %37, 8
  store i32 %38, i32* %35, align 4, !tbaa !7
  %39 = load i64* %int64bitInt, align 8, !tbaa !1
  %40 = call i64 @llvm.bswap.i64(i64 %39) #1
  %41 = call %"class.std::basic_ostream"* @_ZNSo9_M_insertIyEERSoT_(%"class.std::basic_ostream"* %27, i64 %40) #1
  %42 = getelementptr inbounds %"class.std::basic_stringstream"* %out, i64 0, i32 1
  call void @_ZNKSt15basic_stringbufIcSt11char_traitsIcESaIcEE3strEv(%"class.std::basic_string"* sret %8, %"class.std::basic_stringbuf"* %42) #1
  %43 = getelementptr inbounds %"class.std::basic_string"* %8, i64 0, i32 0, i32 0
  %44 = load i8** %43, align 8, !tbaa !9
  %45 = getelementptr inbounds i8* %44, i64 -24
  %46 = bitcast i8* %45 to i64*
  %47 = load i64* %46, align 8, !tbaa !13
  %48 = call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %44, i64 %47) #1
  %49 = bitcast %"class.std::basic_ostream"* %48 to i8**
  %50 = load i8** %49, align 8, !tbaa !5
  %51 = getelementptr i8* %50, i64 -24
  %52 = bitcast i8* %51 to i64*
  %53 = load i64* %52, align 8
  %54 = bitcast %"class.std::basic_ostream"* %48 to i8*
  %.sum21 = add i64 %53, 240
  %55 = getelementptr inbounds i8* %54, i64 %.sum21
  %56 = bitcast i8* %55 to %"class.std::ctype"**
  %57 = load %"class.std::ctype"** %56, align 8, !tbaa !17
  %58 = icmp eq %"class.std::ctype"* %57, null
  br i1 %58, label %59, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit16

; <label>:59                                      ; preds = %0
  call void @_ZSt16__throw_bad_castv() #6
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit16:  ; preds = %0
  %60 = getelementptr inbounds %"class.std::ctype"* %57, i64 0, i32 6
  %61 = load i8* %60, align 1, !tbaa !20
  %62 = icmp eq i8 %61, 0
  br i1 %62, label %66, label %63

; <label>:63                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit16
  %64 = getelementptr inbounds %"class.std::ctype"* %57, i64 0, i32 7, i64 10
  %65 = load i8* %64, align 1, !tbaa !22
  br label %_ZNKSt5ctypeIcE5widenEc.exit9

; <label>:66                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit16
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %57) #1
  %67 = bitcast %"class.std::ctype"* %57 to i8 (%"class.std::ctype"*, i8)***
  %68 = load i8 (%"class.std::ctype"*, i8)*** %67, align 8, !tbaa !5
  %69 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %68, i64 6
  %70 = load i8 (%"class.std::ctype"*, i8)** %69, align 8
  %71 = call signext i8 %70(%"class.std::ctype"* %57, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit9

_ZNKSt5ctypeIcE5widenEc.exit9:                    ; preds = %66, %63
  %.0.i8 = phi i8 [ %65, %63 ], [ %71, %66 ]
  %72 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %48, i8 signext %.0.i8) #1
  %73 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %72) #1
  %74 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %74) #1
  %75 = load i8** %43, align 8, !tbaa !9
  %76 = getelementptr inbounds i8* %75, i64 -24
  %77 = bitcast i8* %76 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %78 = icmp eq i8* %76, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %78, label %_ZNSsD1Ev.exit4, label %79, !prof !23

; <label>:79                                      ; preds = %_ZNKSt5ctypeIcE5widenEc.exit9
  %80 = getelementptr inbounds i8* %75, i64 -8
  %81 = bitcast i8* %80 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %82, label %86

; <label>:82                                      ; preds = %79
  %83 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %83)
  %84 = atomicrmw volatile add i32* %81, i32 -1 acq_rel
  store i32 %84, i32* %3, align 4
  %85 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %83)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

; <label>:86                                      ; preds = %79
  %87 = load i32* %81, align 4, !tbaa !24
  %88 = add nsw i32 %87, -1
  store i32 %88, i32* %81, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3: ; preds = %86, %82
  %.0.i.i.i.i2 = phi i32 [ %85, %82 ], [ %87, %86 ]
  %89 = icmp slt i32 %.0.i.i.i.i2, 1
  br i1 %89, label %90, label %_ZNSsD1Ev.exit4

; <label>:90                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %77, %"class.std::allocator"* %4) #1
  br label %_ZNSsD1Ev.exit4

_ZNSsD1Ev.exit4:                                  ; preds = %90, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3, %_ZNKSt5ctypeIcE5widenEc.exit9
  call void @llvm.lifetime.end(i64 1, i8* %74) #1
  %91 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !5
  %92 = getelementptr i8* %91, i64 -24
  %93 = bitcast i8* %92 to i64*
  %94 = load i64* %93, align 8
  %.sum22 = add i64 %94, 24
  %95 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum22
  %96 = bitcast i8* %95 to i32*
  %97 = load i32* %96, align 4, !tbaa !7
  %98 = and i32 %97, -75
  %99 = or i32 %98, 8
  store i32 %99, i32* %96, align 4, !tbaa !7
  %100 = load i64* %int64bitInt, align 8, !tbaa !1
  %101 = call %"class.std::basic_ostream"* @_ZNSo9_M_insertIyEERSoT_(%"class.std::basic_ostream"* @_ZSt4cout, i64 %100) #1
  %102 = bitcast %"class.std::basic_ostream"* %101 to i8**
  %103 = load i8** %102, align 8, !tbaa !5
  %104 = getelementptr i8* %103, i64 -24
  %105 = bitcast i8* %104 to i64*
  %106 = load i64* %105, align 8
  %107 = bitcast %"class.std::basic_ostream"* %101 to i8*
  %.sum23 = add i64 %106, 240
  %108 = getelementptr inbounds i8* %107, i64 %.sum23
  %109 = bitcast i8* %108 to %"class.std::ctype"**
  %110 = load %"class.std::ctype"** %109, align 8, !tbaa !17
  %111 = icmp eq %"class.std::ctype"* %110, null
  br i1 %111, label %112, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit17

; <label>:112                                     ; preds = %_ZNSsD1Ev.exit4
  call void @_ZSt16__throw_bad_castv() #6
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit17:  ; preds = %_ZNSsD1Ev.exit4
  %113 = getelementptr inbounds %"class.std::ctype"* %110, i64 0, i32 6
  %114 = load i8* %113, align 1, !tbaa !20
  %115 = icmp eq i8 %114, 0
  br i1 %115, label %119, label %116

; <label>:116                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit17
  %117 = getelementptr inbounds %"class.std::ctype"* %110, i64 0, i32 7, i64 10
  %118 = load i8* %117, align 1, !tbaa !22
  br label %_ZNKSt5ctypeIcE5widenEc.exit11

; <label>:119                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit17
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %110) #1
  %120 = bitcast %"class.std::ctype"* %110 to i8 (%"class.std::ctype"*, i8)***
  %121 = load i8 (%"class.std::ctype"*, i8)*** %120, align 8, !tbaa !5
  %122 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %121, i64 6
  %123 = load i8 (%"class.std::ctype"*, i8)** %122, align 8
  %124 = call signext i8 %123(%"class.std::ctype"* %110, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit11

_ZNKSt5ctypeIcE5widenEc.exit11:                   ; preds = %119, %116
  %.0.i10 = phi i8 [ %118, %116 ], [ %124, %119 ]
  %125 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %101, i8 signext %.0.i10) #1
  %126 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %125) #1
  %127 = getelementptr inbounds %"class.std::basic_string"* %string64bitInt, i64 0, i32 0, i32 0
  %128 = load i8** %127, align 8, !tbaa !9
  %129 = getelementptr inbounds i8* %128, i64 -24
  %130 = bitcast i8* %129 to i64*
  %131 = load i64* %130, align 8, !tbaa !13
  %132 = call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %128, i64 %131) #1
  %133 = bitcast %"class.std::basic_ostream"* %132 to i8**
  %134 = load i8** %133, align 8, !tbaa !5
  %135 = getelementptr i8* %134, i64 -24
  %136 = bitcast i8* %135 to i64*
  %137 = load i64* %136, align 8
  %138 = bitcast %"class.std::basic_ostream"* %132 to i8*
  %.sum24 = add i64 %137, 240
  %139 = getelementptr inbounds i8* %138, i64 %.sum24
  %140 = bitcast i8* %139 to %"class.std::ctype"**
  %141 = load %"class.std::ctype"** %140, align 8, !tbaa !17
  %142 = icmp eq %"class.std::ctype"* %141, null
  br i1 %142, label %143, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit18

; <label>:143                                     ; preds = %_ZNKSt5ctypeIcE5widenEc.exit11
  call void @_ZSt16__throw_bad_castv() #6
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit18:  ; preds = %_ZNKSt5ctypeIcE5widenEc.exit11
  %144 = getelementptr inbounds %"class.std::ctype"* %141, i64 0, i32 6
  %145 = load i8* %144, align 1, !tbaa !20
  %146 = icmp eq i8 %145, 0
  br i1 %146, label %150, label %147

; <label>:147                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit18
  %148 = getelementptr inbounds %"class.std::ctype"* %141, i64 0, i32 7, i64 10
  %149 = load i8* %148, align 1, !tbaa !22
  br label %_ZNKSt5ctypeIcE5widenEc.exit13

; <label>:150                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit18
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %141) #1
  %151 = bitcast %"class.std::ctype"* %141 to i8 (%"class.std::ctype"*, i8)***
  %152 = load i8 (%"class.std::ctype"*, i8)*** %151, align 8, !tbaa !5
  %153 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %152, i64 6
  %154 = load i8 (%"class.std::ctype"*, i8)** %153, align 8
  %155 = call signext i8 %154(%"class.std::ctype"* %141, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit13

_ZNKSt5ctypeIcE5widenEc.exit13:                   ; preds = %150, %147
  %.0.i12 = phi i8 [ %149, %147 ], [ %155, %150 ]
  %156 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %132, i8 signext %.0.i12) #1
  %157 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %156) #1
  call void @_ZNKSt15basic_stringbufIcSt11char_traitsIcESaIcEE3strEv(%"class.std::basic_string"* sret %9, %"class.std::basic_stringbuf"* %42) #1
  %158 = call i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %9, i8* getelementptr inbounds ([15 x i8]* @.str4, i64 0, i64 0)) #1
  %159 = icmp eq i32 %158, 0
  %160 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %160) #1
  %161 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %162 = load i8** %161, align 8, !tbaa !9
  %163 = getelementptr inbounds i8* %162, i64 -24
  %164 = bitcast i8* %163 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %165 = icmp eq i8* %163, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %165, label %_ZNSsD1Ev.exit7, label %166, !prof !23

; <label>:166                                     ; preds = %_ZNKSt5ctypeIcE5widenEc.exit13
  %167 = getelementptr inbounds i8* %162, i64 -8
  %168 = bitcast i8* %167 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %169, label %173

; <label>:169                                     ; preds = %166
  %170 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %170)
  %171 = atomicrmw volatile add i32* %168, i32 -1 acq_rel
  store i32 %171, i32* %1, align 4
  %172 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %170)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6

; <label>:173                                     ; preds = %166
  %174 = load i32* %168, align 4, !tbaa !24
  %175 = add nsw i32 %174, -1
  store i32 %175, i32* %168, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6: ; preds = %173, %169
  %.0.i.i.i.i5 = phi i32 [ %172, %169 ], [ %174, %173 ]
  %176 = icmp slt i32 %.0.i.i.i.i5, 1
  br i1 %176, label %177, label %_ZNSsD1Ev.exit7

; <label>:177                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %164, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit7

_ZNSsD1Ev.exit7:                                  ; preds = %177, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6, %_ZNKSt5ctypeIcE5widenEc.exit13
  call void @llvm.lifetime.end(i64 1, i8* %160) #1
  br i1 %159, label %203, label %178

; <label>:178                                     ; preds = %_ZNSsD1Ev.exit7
  %179 = call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i64 7) #1
  %180 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !5
  %181 = getelementptr i8* %180, i64 -24
  %182 = bitcast i8* %181 to i64*
  %183 = load i64* %182, align 8
  %.sum26 = add i64 %183, 240
  %184 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum26
  %185 = bitcast i8* %184 to %"class.std::ctype"**
  %186 = load %"class.std::ctype"** %185, align 8, !tbaa !17
  %187 = icmp eq %"class.std::ctype"* %186, null
  br i1 %187, label %188, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit19

; <label>:188                                     ; preds = %178
  call void @_ZSt16__throw_bad_castv() #6
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit19:  ; preds = %178
  %189 = getelementptr inbounds %"class.std::ctype"* %186, i64 0, i32 6
  %190 = load i8* %189, align 1, !tbaa !20
  %191 = icmp eq i8 %190, 0
  br i1 %191, label %195, label %192

; <label>:192                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit19
  %193 = getelementptr inbounds %"class.std::ctype"* %186, i64 0, i32 7, i64 10
  %194 = load i8* %193, align 1, !tbaa !22
  br label %_ZNKSt5ctypeIcE5widenEc.exit15

; <label>:195                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit19
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %186) #1
  %196 = bitcast %"class.std::ctype"* %186 to i8 (%"class.std::ctype"*, i8)***
  %197 = load i8 (%"class.std::ctype"*, i8)*** %196, align 8, !tbaa !5
  %198 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %197, i64 6
  %199 = load i8 (%"class.std::ctype"*, i8)** %198, align 8
  %200 = call signext i8 %199(%"class.std::ctype"* %186, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit15

_ZNKSt5ctypeIcE5widenEc.exit15:                   ; preds = %195, %192
  %.0.i14 = phi i8 [ %194, %192 ], [ %200, %195 ]
  %201 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i14) #1
  %202 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %201) #1
  br label %228

; <label>:203                                     ; preds = %_ZNSsD1Ev.exit7
  %204 = call %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([11 x i8]* @.str6, i64 0, i64 0), i64 10) #1
  %205 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !5
  %206 = getelementptr i8* %205, i64 -24
  %207 = bitcast i8* %206 to i64*
  %208 = load i64* %207, align 8
  %.sum25 = add i64 %208, 240
  %209 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum25
  %210 = bitcast i8* %209 to %"class.std::ctype"**
  %211 = load %"class.std::ctype"** %210, align 8, !tbaa !17
  %212 = icmp eq %"class.std::ctype"* %211, null
  br i1 %212, label %213, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit

; <label>:213                                     ; preds = %203
  call void @_ZSt16__throw_bad_castv() #6
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit:    ; preds = %203
  %214 = getelementptr inbounds %"class.std::ctype"* %211, i64 0, i32 6
  %215 = load i8* %214, align 1, !tbaa !20
  %216 = icmp eq i8 %215, 0
  br i1 %216, label %220, label %217

; <label>:217                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit
  %218 = getelementptr inbounds %"class.std::ctype"* %211, i64 0, i32 7, i64 10
  %219 = load i8* %218, align 1, !tbaa !22
  br label %_ZNKSt5ctypeIcE5widenEc.exit

; <label>:220                                     ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit
  call void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %211) #1
  %221 = bitcast %"class.std::ctype"* %211 to i8 (%"class.std::ctype"*, i8)***
  %222 = load i8 (%"class.std::ctype"*, i8)*** %221, align 8, !tbaa !5
  %223 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %222, i64 6
  %224 = load i8 (%"class.std::ctype"*, i8)** %223, align 8
  %225 = call signext i8 %224(%"class.std::ctype"* %211, i8 signext 10) #1
  br label %_ZNKSt5ctypeIcE5widenEc.exit

_ZNKSt5ctypeIcE5widenEc.exit:                     ; preds = %220, %217
  %.0.i = phi i8 [ %219, %217 ], [ %225, %220 ]
  %226 = call %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i) #1
  %227 = call %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %226) #1
  br label %228

; <label>:228                                     ; preds = %_ZNKSt5ctypeIcE5widenEc.exit, %_ZNKSt5ctypeIcE5widenEc.exit15
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %out)
  call void @llvm.lifetime.end(i64 368, i8* %25) #1
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %s)
  call void @llvm.lifetime.end(i64 368, i8* %12) #1
  %229 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %229) #1
  %230 = load i8** %127, align 8, !tbaa !9
  %231 = getelementptr inbounds i8* %230, i64 -24
  %232 = bitcast i8* %231 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %233 = icmp eq i8* %231, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %233, label %_ZNSsD1Ev.exit, label %234, !prof !23

; <label>:234                                     ; preds = %228
  %235 = getelementptr inbounds i8* %230, i64 -8
  %236 = bitcast i8* %235 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %237, label %241

; <label>:237                                     ; preds = %234
  %238 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %238)
  %239 = atomicrmw volatile add i32* %236, i32 -1 acq_rel
  store i32 %239, i32* %5, align 4
  %240 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %238)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:241                                     ; preds = %234
  %242 = load i32* %236, align 4, !tbaa !24
  %243 = add nsw i32 %242, -1
  store i32 %243, i32* %236, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %241, %237
  %.0.i.i.i.i = phi i32 [ %240, %237 ], [ %242, %241 ]
  %244 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %244, label %245, label %_ZNSsD1Ev.exit

; <label>:245                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %232, %"class.std::allocator"* %6) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %245, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %228
  call void @llvm.lifetime.end(i64 1, i8* %229) #1
  ret i32 0
}

; Function Attrs: nounwind
declare i64 @strtoull(i8* readonly, i8** nocapture, i32) #3

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_stringstream"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__m) unnamed_addr #2 align 2 {
  %1 = alloca %"class.std::allocator", align 1
  %2 = bitcast %"class.std::basic_stringstream"* %this to i8*
  %3 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2
  %4 = getelementptr inbounds %"class.std::basic_ios"* %3, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %4) #1
  %5 = getelementptr inbounds %"class.std::basic_ios"* %3, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %5, align 8, !tbaa !5
  %6 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %6, align 8, !tbaa !25
  %7 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %7, align 1, !tbaa !26
  %8 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %8, align 1, !tbaa !27
  %9 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 4
  %10 = bitcast %"class.std::basic_streambuf"** %9 to i8*
  call void @llvm.memset.p0i8.i64(i8* %10, i8 0, i64 32, i32 8, i1 false) #1
  %11 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %12 = bitcast %"class.std::basic_stringstream"* %this to i8**
  %13 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 0
  %.c.i.i = bitcast i8* %11 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %13, align 8, !tbaa !5
  %14 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %15 = getelementptr i8* %11, i64 -24
  %16 = bitcast i8* %15 to i64*
  %17 = load i64* %16, align 8
  %18 = getelementptr inbounds i8* %2, i64 %17
  %19 = bitcast i8* %18 to i8**
  store i8* %14, i8** %19, align 8, !tbaa !5
  %20 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %20, align 8, !tbaa !28
  %21 = load i8** %12, align 8, !tbaa !5
  %22 = getelementptr i8* %21, i64 -24
  %23 = bitcast i8* %22 to i64*
  %24 = load i64* %23, align 8
  %25 = getelementptr inbounds i8* %2, i64 %24
  %26 = bitcast i8* %25 to %"class.std::basic_ios"*
  call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %26, %"class.std::basic_streambuf"* null) #1
  %27 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1
  %28 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 4), align 8
  %29 = bitcast %"class.std::basic_ostream.base"* %27 to i8**
  %30 = getelementptr inbounds %"class.std::basic_ostream.base"* %27, i64 0, i32 0
  %.c.i2.i = bitcast i8* %28 to i32 (...)**
  store i32 (...)** %.c.i2.i, i32 (...)*** %30, align 8, !tbaa !5
  %31 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 5), align 8
  %32 = getelementptr i8* %28, i64 -24
  %33 = bitcast i8* %32 to i64*
  %34 = load i64* %33, align 8
  %35 = bitcast %"class.std::basic_ostream.base"* %27 to i8*
  %36 = getelementptr inbounds i8* %35, i64 %34
  %37 = bitcast i8* %36 to i8**
  store i8* %31, i8** %37, align 8, !tbaa !5
  %38 = load i8** %29, align 8, !tbaa !5
  %39 = getelementptr i8* %38, i64 -24
  %40 = bitcast i8* %39 to i64*
  %41 = load i64* %40, align 8
  %42 = getelementptr inbounds i8* %35, i64 %41
  %43 = bitcast i8* %42 to %"class.std::basic_ios"*
  call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %43, %"class.std::basic_streambuf"* null) #1
  %44 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.c.i = bitcast i8* %44 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %13, align 8, !tbaa !5
  %45 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 6), align 8
  %46 = getelementptr i8* %44, i64 -24
  %47 = bitcast i8* %46 to i64*
  %48 = load i64* %47, align 8
  %49 = getelementptr inbounds i8* %2, i64 %48
  %50 = bitcast i8* %49 to i8**
  store i8* %45, i8** %50, align 8, !tbaa !5
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %13, align 8, !tbaa !5
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 13) to i32 (...)**), i32 (...)*** %5, align 8, !tbaa !5
  %51 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %51, align 8, !tbaa !5
  %52 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1
  %53 = getelementptr inbounds %"class.std::allocator"* %1, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %53) #1
  %54 = getelementptr inbounds %"class.std::basic_stringbuf"* %52, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %54, align 8, !tbaa !5
  %55 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 1
  %56 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 7
  %57 = bitcast i8** %55 to i8*
  call void @llvm.memset.p0i8.i64(i8* %57, i8 0, i64 48, i32 8, i1 false) #1
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %56) #1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %54, align 8, !tbaa !5
  %58 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 1
  store i32 0, i32* %58, align 4, !tbaa !30
  %59 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 2
  %60 = getelementptr inbounds %"class.std::basic_string"* %__str, i64 0, i32 0, i32 0
  %61 = load i8** %60, align 8, !tbaa !9
  %62 = getelementptr inbounds i8* %61, i64 -24
  %63 = bitcast i8* %62 to i64*
  %64 = load i64* %63, align 8, !tbaa !13
  call void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"* %59, i8* %61, i64 %64, %"class.std::allocator"* %1) #1
  store i32 %__m, i32* %58, align 4, !tbaa !30
  %65 = and i32 %__m, 3
  %66 = icmp eq i32 %65, 0
  %.phi.trans.insert.i.i.i = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %.pre.i.i.i = load i8** %.phi.trans.insert.i.i.i, align 8, !tbaa !9
  br i1 %66, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit, label %67

; <label>:67                                      ; preds = %0
  %68 = getelementptr inbounds i8* %.pre.i.i.i, i64 -24
  %69 = bitcast i8* %68 to i64*
  %70 = load i64* %69, align 8, !tbaa !13
  br label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit: ; preds = %67, %0
  %__len.0.i.i.i = phi i64 [ %70, %67 ], [ 0, %0 ]
  call void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"* %52, i8* %.pre.i.i.i, i64 0, i64 %__len.0.i.i.i) #1
  call void @llvm.lifetime.end(i64 1, i8* %53) #1
  %71 = load i8** %12, align 8, !tbaa !5
  %72 = getelementptr i8* %71, i64 -24
  %73 = bitcast i8* %72 to i64*
  %74 = load i64* %73, align 8
  %75 = getelementptr inbounds i8* %2, i64 %74
  %76 = bitcast i8* %75 to %"class.std::basic_ios"*
  %77 = getelementptr inbounds %"class.std::basic_stringbuf"* %52, i64 0, i32 0
  call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %76, %"class.std::basic_streambuf"* %77) #1
  ret void
}

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode(%"class.std::basic_stringstream"* %this, i32 %__m) unnamed_addr #2 align 2 {
  %1 = bitcast %"class.std::basic_stringstream"* %this to i8*
  %2 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2
  %3 = getelementptr inbounds %"class.std::basic_ios"* %2, i64 0, i32 0
  tail call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %3) #1
  %4 = getelementptr inbounds %"class.std::basic_ios"* %2, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !5
  %5 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %5, align 8, !tbaa !25
  %6 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %6, align 1, !tbaa !26
  %7 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %7, align 1, !tbaa !27
  %8 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 4
  %9 = bitcast %"class.std::basic_streambuf"** %8 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 32, i32 8, i1 false) #1
  %10 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %11 = bitcast %"class.std::basic_stringstream"* %this to i8**
  %12 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 0
  %.c.i.i = bitcast i8* %10 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %12, align 8, !tbaa !5
  %13 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %14 = getelementptr i8* %10, i64 -24
  %15 = bitcast i8* %14 to i64*
  %16 = load i64* %15, align 8
  %17 = getelementptr inbounds i8* %1, i64 %16
  %18 = bitcast i8* %17 to i8**
  store i8* %13, i8** %18, align 8, !tbaa !5
  %19 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %19, align 8, !tbaa !28
  %20 = load i8** %11, align 8, !tbaa !5
  %21 = getelementptr i8* %20, i64 -24
  %22 = bitcast i8* %21 to i64*
  %23 = load i64* %22, align 8
  %24 = getelementptr inbounds i8* %1, i64 %23
  %25 = bitcast i8* %24 to %"class.std::basic_ios"*
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %25, %"class.std::basic_streambuf"* null) #1
  %26 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1
  %27 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 4), align 8
  %28 = bitcast %"class.std::basic_ostream.base"* %26 to i8**
  %29 = getelementptr inbounds %"class.std::basic_ostream.base"* %26, i64 0, i32 0
  %.c.i2.i = bitcast i8* %27 to i32 (...)**
  store i32 (...)** %.c.i2.i, i32 (...)*** %29, align 8, !tbaa !5
  %30 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 5), align 8
  %31 = getelementptr i8* %27, i64 -24
  %32 = bitcast i8* %31 to i64*
  %33 = load i64* %32, align 8
  %34 = bitcast %"class.std::basic_ostream.base"* %26 to i8*
  %35 = getelementptr inbounds i8* %34, i64 %33
  %36 = bitcast i8* %35 to i8**
  store i8* %30, i8** %36, align 8, !tbaa !5
  %37 = load i8** %28, align 8, !tbaa !5
  %38 = getelementptr i8* %37, i64 -24
  %39 = bitcast i8* %38 to i64*
  %40 = load i64* %39, align 8
  %41 = getelementptr inbounds i8* %34, i64 %40
  %42 = bitcast i8* %41 to %"class.std::basic_ios"*
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %42, %"class.std::basic_streambuf"* null) #1
  %43 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.c.i = bitcast i8* %43 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %12, align 8, !tbaa !5
  %44 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 6), align 8
  %45 = getelementptr i8* %43, i64 -24
  %46 = bitcast i8* %45 to i64*
  %47 = load i64* %46, align 8
  %48 = getelementptr inbounds i8* %1, i64 %47
  %49 = bitcast i8* %48 to i8**
  store i8* %44, i8** %49, align 8, !tbaa !5
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !5
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 13) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !5
  %50 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !5
  %51 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1
  %52 = getelementptr inbounds %"class.std::basic_stringbuf"* %51, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %52, align 8, !tbaa !5
  %53 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 1
  %54 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 7
  %55 = bitcast i8** %53 to i8*
  tail call void @llvm.memset.p0i8.i64(i8* %55, i8 0, i64 48, i32 8, i1 false) #1
  tail call void @_ZNSt6localeC1Ev(%"class.std::locale"* %54) #1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %52, align 8, !tbaa !5
  %56 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 1
  store i32 %__m, i32* %56, align 4, !tbaa !30
  %57 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %57, align 8, !tbaa !33
  %58 = load i8** %11, align 8, !tbaa !5
  %59 = getelementptr i8* %58, i64 -24
  %60 = bitcast i8* %59 to i64*
  %61 = load i64* %60, align 8
  %62 = getelementptr inbounds i8* %1, i64 %61
  %63 = bitcast i8* %62 to %"class.std::basic_ios"*
  %64 = getelementptr inbounds %"class.std::basic_stringbuf"* %51, i64 0, i32 0
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %63, %"class.std::basic_streambuf"* %64) #1
  ret void
}

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %this) unnamed_addr #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 0), align 8
  %4 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 0
  %.c.i = bitcast i8* %3 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %4, align 8, !tbaa !5
  %5 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8), align 8
  %6 = getelementptr i8* %3, i64 -24
  %7 = bitcast i8* %6 to i64*
  %8 = load i64* %7, align 8
  %9 = bitcast %"class.std::basic_stringstream"* %this to i8*
  %10 = getelementptr inbounds i8* %9, i64 %8
  %11 = bitcast i8* %10 to i8**
  store i8* %5, i8** %11, align 8, !tbaa !5
  %12 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 9), align 8
  %13 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1, i32 0
  %.c1.i = bitcast i8* %12 to i32 (...)**
  store i32 (...)** %.c1.i, i32 (...)*** %13, align 8, !tbaa !5
  %14 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !5
  %15 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %15) #1
  %16 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %17 = load i8** %16, align 8, !tbaa !9
  %18 = getelementptr inbounds i8* %17, i64 -24
  %19 = bitcast i8* %18 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %20 = icmp eq i8* %18, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %20, label %_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED2Ev.exit, label %21, !prof !23

; <label>:21                                      ; preds = %0
  %22 = getelementptr inbounds i8* %17, i64 -8
  %23 = bitcast i8* %22 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %24, label %28

; <label>:24                                      ; preds = %21
  %25 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %25)
  %26 = atomicrmw volatile add i32* %23, i32 -1 acq_rel
  store i32 %26, i32* %1, align 4
  %27 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %25)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

; <label>:28                                      ; preds = %21
  %29 = load i32* %23, align 4, !tbaa !24
  %30 = add nsw i32 %29, -1
  store i32 %30, i32* %23, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i: ; preds = %28, %24
  %.0.i.i.i.i.i.i = phi i32 [ %27, %24 ], [ %29, %28 ]
  %31 = icmp slt i32 %.0.i.i.i.i.i.i, 1
  br i1 %31, label %32, label %_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:32                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %19, %"class.std::allocator"* %2) #1
  br label %_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %32, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %15) #1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !5
  %33 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %33) #1
  %34 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %.c.i.i.i = bitcast i8* %34 to i32 (...)**
  store i32 (...)** %.c.i.i.i, i32 (...)*** %4, align 8, !tbaa !5
  %35 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %36 = getelementptr i8* %34, i64 -24
  %37 = bitcast i8* %36 to i64*
  %38 = load i64* %37, align 8
  %39 = getelementptr inbounds i8* %9, i64 %38
  %40 = bitcast i8* %39 to i8**
  store i8* %35, i8** %40, align 8, !tbaa !5
  %41 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %41, align 8, !tbaa !28
  %42 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %42) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

declare i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"*, i8*) #0

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #4

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

; Function Attrs: nounwind uwtable
define available_externally void @_ZNKSt15basic_stringbufIcSt11char_traitsIcESaIcEE3strEv(%"class.std::basic_string"* noalias sret %agg.result, %"class.std::basic_stringbuf"* %this) #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca %"class.std::basic_string", align 8
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca %"class.std::basic_string", align 8
  %8 = alloca %"class.std::allocator", align 1
  %9 = getelementptr inbounds %"class.std::basic_string"* %agg.result, i64 0, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %9, align 8, !tbaa !33
  %10 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 5
  %11 = load i8** %10, align 8, !tbaa !34
  %12 = icmp eq i8* %11, null
  br i1 %12, label %97, label %13

; <label>:13                                      ; preds = %0
  %14 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 3
  %15 = load i8** %14, align 8, !tbaa !37
  %16 = icmp ugt i8* %11, %15
  %17 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 4
  %18 = load i8** %17, align 8, !tbaa !38
  br i1 %16, label %19, label %58

; <label>:19                                      ; preds = %13
  %20 = icmp eq i8* %18, %11
  br i1 %20, label %_ZNSsC2IPcEET_S1_RKSaIcE.exit9, label %.critedge.i.i.i.i6

.critedge.i.i.i.i6:                               ; preds = %19
  %.not.i.i.i.i5 = icmp eq i8* %18, null
  br i1 %.not.i.i.i.i5, label %21, label %22

; <label>:21                                      ; preds = %.critedge.i.i.i.i6
  call void @_ZSt19__throw_logic_errorPKc(i8* getelementptr inbounds ([42 x i8]* @.str7, i64 0, i64 0)) #6
  unreachable

; <label>:22                                      ; preds = %.critedge.i.i.i.i6
  %23 = ptrtoint i8* %11 to i64
  %24 = ptrtoint i8* %18 to i64
  %25 = sub i64 %23, %24
  %26 = call %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* @_ZNSs4_Rep9_S_createEmmRKSaIcE(i64 %25, i64 0, %"class.std::allocator"* %6) #1
  %27 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %26, i64 1
  %28 = bitcast %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %27 to i8*
  %29 = icmp eq i64 %25, 1
  br i1 %29, label %30, label %32

; <label>:30                                      ; preds = %22
  %31 = load i8* %18, align 1, !tbaa !22
  store i8 %31, i8* %28, align 1, !tbaa !22
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i7

; <label>:32                                      ; preds = %22
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %28, i8* %18, i64 %25, i32 1, i1 false) #1
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i7

_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i7:        ; preds = %32, %30
  %33 = icmp eq %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %26, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*)
  br i1 %33, label %_ZNSsC2IPcEET_S1_RKSaIcE.exit9, label %34, !prof !23

; <label>:34                                      ; preds = %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i7
  %35 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %26, i64 0, i32 0, i32 2
  store i32 0, i32* %35, align 4, !tbaa !39
  %36 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %26, i64 0, i32 0, i32 0
  store i64 %25, i64* %36, align 8, !tbaa !13
  %37 = getelementptr inbounds i8* %28, i64 %25
  %38 = load i8* @_ZNSs4_Rep11_S_terminalE, align 1, !tbaa !22
  store i8 %38, i8* %37, align 1, !tbaa !22
  br label %_ZNSsC2IPcEET_S1_RKSaIcE.exit9

_ZNSsC2IPcEET_S1_RKSaIcE.exit9:                   ; preds = %34, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i7, %19
  %.0.i.i.i.i8 = phi i8* [ bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), %19 ], [ %28, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i7 ], [ %28, %34 ]
  %39 = getelementptr inbounds %"class.std::basic_string"* %5, i64 0, i32 0, i32 0
  store i8* %.0.i.i.i.i8, i8** %39, align 8, !tbaa !33
  %40 = call %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %agg.result, %"class.std::basic_string"* %5) #1
  %41 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %41) #1
  %42 = load i8** %39, align 8, !tbaa !9
  %43 = getelementptr inbounds i8* %42, i64 -24
  %44 = bitcast i8* %43 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %45 = icmp eq i8* %43, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %45, label %_ZNSsD1Ev.exit4, label %46, !prof !23

; <label>:46                                      ; preds = %_ZNSsC2IPcEET_S1_RKSaIcE.exit9
  %47 = getelementptr inbounds i8* %42, i64 -8
  %48 = bitcast i8* %47 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %49, label %53

; <label>:49                                      ; preds = %46
  %50 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %50)
  %51 = atomicrmw volatile add i32* %48, i32 -1 acq_rel
  store i32 %51, i32* %1, align 4
  %52 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %50)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

; <label>:53                                      ; preds = %46
  %54 = load i32* %48, align 4, !tbaa !24
  %55 = add nsw i32 %54, -1
  store i32 %55, i32* %48, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3: ; preds = %53, %49
  %.0.i.i.i.i2 = phi i32 [ %52, %49 ], [ %54, %53 ]
  %56 = icmp slt i32 %.0.i.i.i.i2, 1
  br i1 %56, label %57, label %_ZNSsD1Ev.exit4

; <label>:57                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %44, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit4

; <label>:58                                      ; preds = %13
  %59 = icmp eq i8* %18, %15
  br i1 %59, label %_ZNSsC2IPcEET_S1_RKSaIcE.exit, label %.critedge.i.i.i.i

.critedge.i.i.i.i:                                ; preds = %58
  %.not.i.i.i.i = icmp eq i8* %18, null
  br i1 %.not.i.i.i.i, label %60, label %61

; <label>:60                                      ; preds = %.critedge.i.i.i.i
  call void @_ZSt19__throw_logic_errorPKc(i8* getelementptr inbounds ([42 x i8]* @.str7, i64 0, i64 0)) #6
  unreachable

; <label>:61                                      ; preds = %.critedge.i.i.i.i
  %62 = ptrtoint i8* %15 to i64
  %63 = ptrtoint i8* %18 to i64
  %64 = sub i64 %62, %63
  %65 = call %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* @_ZNSs4_Rep9_S_createEmmRKSaIcE(i64 %64, i64 0, %"class.std::allocator"* %8) #1
  %66 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %65, i64 1
  %67 = bitcast %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %66 to i8*
  %68 = icmp eq i64 %64, 1
  br i1 %68, label %69, label %71

; <label>:69                                      ; preds = %61
  %70 = load i8* %18, align 1, !tbaa !22
  store i8 %70, i8* %67, align 1, !tbaa !22
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i

; <label>:71                                      ; preds = %61
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %67, i8* %18, i64 %64, i32 1, i1 false) #1
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i

_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i:         ; preds = %71, %69
  %72 = icmp eq %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %65, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*)
  br i1 %72, label %_ZNSsC2IPcEET_S1_RKSaIcE.exit, label %73, !prof !23

; <label>:73                                      ; preds = %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i
  %74 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %65, i64 0, i32 0, i32 2
  store i32 0, i32* %74, align 4, !tbaa !39
  %75 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %65, i64 0, i32 0, i32 0
  store i64 %64, i64* %75, align 8, !tbaa !13
  %76 = getelementptr inbounds i8* %67, i64 %64
  %77 = load i8* @_ZNSs4_Rep11_S_terminalE, align 1, !tbaa !22
  store i8 %77, i8* %76, align 1, !tbaa !22
  br label %_ZNSsC2IPcEET_S1_RKSaIcE.exit

_ZNSsC2IPcEET_S1_RKSaIcE.exit:                    ; preds = %73, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i, %58
  %.0.i.i.i.i1 = phi i8* [ bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), %58 ], [ %67, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i ], [ %67, %73 ]
  %78 = getelementptr inbounds %"class.std::basic_string"* %7, i64 0, i32 0, i32 0
  store i8* %.0.i.i.i.i1, i8** %78, align 8, !tbaa !33
  %79 = call %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %agg.result, %"class.std::basic_string"* %7) #1
  %80 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %80) #1
  %81 = load i8** %78, align 8, !tbaa !9
  %82 = getelementptr inbounds i8* %81, i64 -24
  %83 = bitcast i8* %82 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %84 = icmp eq i8* %82, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %84, label %_ZNSsD1Ev.exit4, label %85, !prof !23

; <label>:85                                      ; preds = %_ZNSsC2IPcEET_S1_RKSaIcE.exit
  %86 = getelementptr inbounds i8* %81, i64 -8
  %87 = bitcast i8* %86 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %88, label %92

; <label>:88                                      ; preds = %85
  %89 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %89)
  %90 = atomicrmw volatile add i32* %87, i32 -1 acq_rel
  store i32 %90, i32* %3, align 4
  %91 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %89)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:92                                      ; preds = %85
  %93 = load i32* %87, align 4, !tbaa !24
  %94 = add nsw i32 %93, -1
  store i32 %94, i32* %87, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %92, %88
  %.0.i.i.i.i = phi i32 [ %91, %88 ], [ %93, %92 ]
  %95 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %95, label %96, label %_ZNSsD1Ev.exit4

; <label>:96                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %83, %"class.std::allocator"* %4) #1
  br label %_ZNSsD1Ev.exit4

; <label>:97                                      ; preds = %0
  %98 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2
  %99 = call %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %agg.result, %"class.std::basic_string"* %98) #1
  br label %_ZNSsD1Ev.exit4

_ZNSsD1Ev.exit4:                                  ; preds = %97, %96, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNSsC2IPcEET_S1_RKSaIcE.exit, %57, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3, %_ZNSsC2IPcEET_S1_RKSaIcE.exit9
  ret void
}

; Function Attrs: noreturn
declare void @_ZSt19__throw_logic_errorPKc(i8*) #4

declare %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* @_ZNSs4_Rep9_S_createEmmRKSaIcE(i64, i64, %"class.std::allocator"*) #0

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

declare %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

declare %"class.std::basic_ostream"* @_ZNSo9_M_insertIyEERSoT_(%"class.std::basic_ostream"*, i64) #0

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeC1Ev(%"class.std::locale"*) #3

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #3

declare %"class.std::basic_istream"* @_ZNSi10_M_extractIyEERSiRT_(%"class.std::basic_istream"*, i64*) #0

declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #3

declare void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"*, i8*, i64, %"class.std::allocator"*) #0

declare void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"*, i8*, i64, i64) #0

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

; Function Attrs: nounwind readnone
declare i64 @llvm.bswap.i64(i64) #5

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"long long", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"vtable pointer", metadata !4, i64 0}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !3, i64 0}
!9 = metadata !{metadata !10, metadata !12, i64 0}
!10 = metadata !{metadata !"_ZTSSs", metadata !11, i64 0}
!11 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !12, i64 0}
!12 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!13 = metadata !{metadata !14, metadata !15, i64 0}
!14 = metadata !{metadata !"_ZTSNSs9_Rep_baseE", metadata !15, i64 0, metadata !15, i64 8, metadata !16, i64 16}
!15 = metadata !{metadata !"long", metadata !3, i64 0}
!16 = metadata !{metadata !"int", metadata !3, i64 0}
!17 = metadata !{metadata !18, metadata !12, i64 240}
!18 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !12, i64 216, metadata !3, i64 224, metadata !19, i64 225, metadata !12, i64 232, metadata !12, i64 240, metadata !12, i64 248, metadata !12, i64 256}
!19 = metadata !{metadata !"bool", metadata !3, i64 0}
!20 = metadata !{metadata !21, metadata !3, i64 56}
!21 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !12, i64 16, metadata !19, i64 24, metadata !12, i64 32, metadata !12, i64 40, metadata !12, i64 48, metadata !3, i64 56, metadata !3, i64 57, metadata !3, i64 313, metadata !3, i64 569}
!22 = metadata !{metadata !3, metadata !3, i64 0}
!23 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!24 = metadata !{metadata !16, metadata !16, i64 0}
!25 = metadata !{metadata !18, metadata !12, i64 216}
!26 = metadata !{metadata !18, metadata !3, i64 224}
!27 = metadata !{metadata !18, metadata !19, i64 225}
!28 = metadata !{metadata !29, metadata !15, i64 8}
!29 = metadata !{metadata !"_ZTSSi", metadata !15, i64 8}
!30 = metadata !{metadata !31, metadata !32, i64 64}
!31 = metadata !{metadata !"_ZTSSt15basic_stringbufIcSt11char_traitsIcESaIcEE", metadata !32, i64 64, metadata !10, i64 72}
!32 = metadata !{metadata !"_ZTSSt13_Ios_Openmode", metadata !3, i64 0}
!33 = metadata !{metadata !11, metadata !12, i64 0}
!34 = metadata !{metadata !35, metadata !12, i64 40}
!35 = metadata !{metadata !"_ZTSSt15basic_streambufIcSt11char_traitsIcEE", metadata !12, i64 8, metadata !12, i64 16, metadata !12, i64 24, metadata !12, i64 32, metadata !12, i64 40, metadata !12, i64 48, metadata !36, i64 56}
!36 = metadata !{metadata !"_ZTSSt6locale", metadata !12, i64 0}
!37 = metadata !{metadata !35, metadata !12, i64 24}
!38 = metadata !{metadata !35, metadata !12, i64 32}
!39 = metadata !{metadata !14, metadata !16, i64 16}
