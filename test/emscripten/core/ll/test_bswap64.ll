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
%"class.std::basic_iostream" = type { %"class.std::basic_istream.base", %"class.std::basic_ostream.base", %"class.std::basic_ios" }

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

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #1

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: uwtable
define i32 @main() #3 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::allocator", align 1
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::allocator", align 1
  %11 = alloca i32, align 4
  %12 = alloca %"class.std::allocator", align 1
  %string64bitInt = alloca %"class.std::basic_string", align 8
  %13 = alloca %"class.std::allocator", align 1
  %s = alloca %"class.std::basic_stringstream", align 8
  %int64bitInt = alloca i64, align 8
  %out = alloca %"class.std::basic_stringstream", align 8
  %14 = alloca %"class.std::basic_string", align 8
  %15 = alloca %"class.std::basic_string", align 8
  %16 = call i64 @strtoull(i8* nocapture getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), i8** null, i32 16) #2
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i64 %16)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %string64bitInt, i8* getelementptr inbounds ([17 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %13)
          to label %18 unwind label %215

; <label>:18                                      ; preds = %0
  %19 = bitcast %"class.std::basic_stringstream"* %s to i8*
  call void @llvm.lifetime.start(i64 368, i8* %19) #2
  invoke void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_stringstream"* %s, %"class.std::basic_string"* %string64bitInt, i32 24)
          to label %20 unwind label %219

; <label>:20                                      ; preds = %18
  store i64 0, i64* %int64bitInt, align 8, !tbaa !1
  %puts = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str, i64 0, i64 0))
  %21 = bitcast %"class.std::basic_stringstream"* %s to %"class.std::basic_istream"*
  %22 = bitcast %"class.std::basic_stringstream"* %s to i8**
  %23 = load i8** %22, align 8, !tbaa !5
  %24 = getelementptr i8* %23, i64 -24
  %25 = bitcast i8* %24 to i64*
  %26 = load i64* %25, align 8
  %.sum = add i64 %26, 24
  %27 = getelementptr inbounds i8* %19, i64 %.sum
  %28 = bitcast i8* %27 to i32*
  %29 = load i32* %28, align 4, !tbaa !7
  %30 = and i32 %29, -75
  %31 = or i32 %30, 8
  store i32 %31, i32* %28, align 4, !tbaa !7
  %32 = invoke %"class.std::basic_istream"* @_ZNSi10_M_extractIyEERSiRT_(%"class.std::basic_istream"* %21, i64* %int64bitInt)
          to label %33 unwind label %223

; <label>:33                                      ; preds = %20
  %puts117 = call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str8, i64 0, i64 0))
  %34 = bitcast %"class.std::basic_stringstream"* %out to i8*
  call void @llvm.lifetime.start(i64 368, i8* %34) #2
  invoke void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode(%"class.std::basic_stringstream"* %out, i32 24)
          to label %35 unwind label %223

; <label>:35                                      ; preds = %33
  %36 = getelementptr inbounds %"class.std::basic_stringstream"* %out, i64 0, i32 0, i32 1
  %37 = bitcast %"class.std::basic_ostream.base"* %36 to %"class.std::basic_ostream"*
  %38 = bitcast %"class.std::basic_ostream.base"* %36 to i8**
  %39 = load i8** %38, align 8, !tbaa !5
  %40 = getelementptr i8* %39, i64 -24
  %41 = bitcast i8* %40 to i64*
  %42 = load i64* %41, align 8
  %43 = bitcast %"class.std::basic_ostream.base"* %36 to i8*
  %.sum118 = add i64 %42, 24
  %44 = getelementptr inbounds i8* %43, i64 %.sum118
  %45 = bitcast i8* %44 to i32*
  %46 = load i32* %45, align 4, !tbaa !7
  %47 = and i32 %46, -75
  %48 = or i32 %47, 8
  store i32 %48, i32* %45, align 4, !tbaa !7
  %49 = load i64* %int64bitInt, align 8, !tbaa !1
  %50 = call i64 @llvm.bswap.i64(i64 %49) #2
  %51 = invoke %"class.std::basic_ostream"* @_ZNSo9_M_insertIyEERSoT_(%"class.std::basic_ostream"* %37, i64 %50)
          to label %_ZNSolsEy.exit unwind label %227

_ZNSolsEy.exit:                                   ; preds = %35
  %52 = getelementptr inbounds %"class.std::basic_stringstream"* %out, i64 0, i32 1
  invoke void @_ZNKSt15basic_stringbufIcSt11char_traitsIcESaIcEE3strEv(%"class.std::basic_string"* sret %14, %"class.std::basic_stringbuf"* %52)
          to label %_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit unwind label %227

_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit: ; preds = %_ZNSolsEy.exit
  %53 = getelementptr inbounds %"class.std::basic_string"* %14, i64 0, i32 0, i32 0
  %54 = load i8** %53, align 8, !tbaa !9
  %55 = getelementptr inbounds i8* %54, i64 -24
  %56 = bitcast i8* %55 to i64*
  %57 = load i64* %56, align 8, !tbaa !13
  %58 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %54, i64 %57)
          to label %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit unwind label %231

_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit: ; preds = %_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit
  %59 = bitcast %"class.std::basic_ostream"* %58 to i8**
  %60 = load i8** %59, align 8, !tbaa !5
  %61 = getelementptr i8* %60, i64 -24
  %62 = bitcast i8* %61 to i64*
  %63 = load i64* %62, align 8
  %64 = bitcast %"class.std::basic_ostream"* %58 to i8*
  %.sum119 = add i64 %63, 240
  %65 = getelementptr inbounds i8* %64, i64 %.sum119
  %66 = bitcast i8* %65 to %"class.std::ctype"**
  %67 = load %"class.std::ctype"** %66, align 8, !tbaa !17
  %68 = icmp eq %"class.std::ctype"* %67, null
  br i1 %68, label %69, label %.noexc80

; <label>:69                                      ; preds = %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit
  invoke void @_ZSt16__throw_bad_castv() #7
          to label %.noexc109 unwind label %231

.noexc109:                                        ; preds = %69
  unreachable

.noexc80:                                         ; preds = %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit
  %70 = getelementptr inbounds %"class.std::ctype"* %67, i64 0, i32 6
  %71 = load i8* %70, align 1, !tbaa !20
  %72 = icmp eq i8 %71, 0
  br i1 %72, label %76, label %73

; <label>:73                                      ; preds = %.noexc80
  %74 = getelementptr inbounds %"class.std::ctype"* %67, i64 0, i32 7, i64 10
  %75 = load i8* %74, align 1, !tbaa !22
  br label %.noexc18

; <label>:76                                      ; preds = %.noexc80
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %67)
          to label %.noexc84 unwind label %231

.noexc84:                                         ; preds = %76
  %77 = bitcast %"class.std::ctype"* %67 to i8 (%"class.std::ctype"*, i8)***
  %78 = load i8 (%"class.std::ctype"*, i8)*** %77, align 8, !tbaa !5
  %79 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %78, i64 6
  %80 = load i8 (%"class.std::ctype"*, i8)** %79, align 8
  %81 = invoke signext i8 %80(%"class.std::ctype"* %67, i8 signext 10)
          to label %.noexc18 unwind label %231

.noexc18:                                         ; preds = %.noexc84, %73
  %.0.i83 = phi i8 [ %75, %73 ], [ %81, %.noexc84 ]
  %82 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %58, i8 signext %.0.i83)
          to label %.noexc19 unwind label %231

.noexc19:                                         ; preds = %.noexc18
  %83 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %82)
          to label %_ZNSolsEPFRSoS_E.exit17 unwind label %231

_ZNSolsEPFRSoS_E.exit17:                          ; preds = %.noexc19
  %84 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %84) #2
  %85 = load i8** %53, align 8, !tbaa !9
  %86 = getelementptr inbounds i8* %85, i64 -24
  %87 = bitcast i8* %86 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %88 = icmp eq i8* %86, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %88, label %101, label %89, !prof !23

; <label>:89                                      ; preds = %_ZNSolsEPFRSoS_E.exit17
  %90 = getelementptr inbounds i8* %85, i64 -8
  %91 = bitcast i8* %90 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %92, label %96

; <label>:92                                      ; preds = %89
  %93 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %93)
  %94 = atomicrmw volatile add i32* %91, i32 -1 acq_rel
  store i32 %94, i32* %7, align 4
  %95 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %93)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25

; <label>:96                                      ; preds = %89
  %97 = load i32* %91, align 4, !tbaa !24
  %98 = add nsw i32 %97, -1
  store i32 %98, i32* %91, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25: ; preds = %96, %92
  %.0.i.i.i.i24 = phi i32 [ %95, %92 ], [ %97, %96 ]
  %99 = icmp slt i32 %.0.i.i.i.i24, 1
  br i1 %99, label %100, label %101

; <label>:100                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %87, %"class.std::allocator"* %8) #2
  br label %101

; <label>:101                                     ; preds = %100, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25, %_ZNSolsEPFRSoS_E.exit17
  call void @llvm.lifetime.end(i64 1, i8* %84) #2
  %102 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !5
  %103 = getelementptr i8* %102, i64 -24
  %104 = bitcast i8* %103 to i64*
  %105 = load i64* %104, align 8
  %.sum120 = add i64 %105, 24
  %106 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum120
  %107 = bitcast i8* %106 to i32*
  %108 = load i32* %107, align 4, !tbaa !7
  %109 = and i32 %108, -75
  %110 = or i32 %109, 8
  store i32 %110, i32* %107, align 4, !tbaa !7
  %111 = load i64* %int64bitInt, align 8, !tbaa !1
  %112 = invoke %"class.std::basic_ostream"* @_ZNSo9_M_insertIyEERSoT_(%"class.std::basic_ostream"* @_ZSt4cout, i64 %111)
          to label %_ZNSolsEy.exit34 unwind label %227

_ZNSolsEy.exit34:                                 ; preds = %101
  %113 = bitcast %"class.std::basic_ostream"* %112 to i8**
  %114 = load i8** %113, align 8, !tbaa !5
  %115 = getelementptr i8* %114, i64 -24
  %116 = bitcast i8* %115 to i64*
  %117 = load i64* %116, align 8
  %118 = bitcast %"class.std::basic_ostream"* %112 to i8*
  %.sum121 = add i64 %117, 240
  %119 = getelementptr inbounds i8* %118, i64 %.sum121
  %120 = bitcast i8* %119 to %"class.std::ctype"**
  %121 = load %"class.std::ctype"** %120, align 8, !tbaa !17
  %122 = icmp eq %"class.std::ctype"* %121, null
  br i1 %122, label %123, label %.noexc87

; <label>:123                                     ; preds = %_ZNSolsEy.exit34
  invoke void @_ZSt16__throw_bad_castv() #7
          to label %.noexc111 unwind label %227

.noexc111:                                        ; preds = %123
  unreachable

.noexc87:                                         ; preds = %_ZNSolsEy.exit34
  %124 = getelementptr inbounds %"class.std::ctype"* %121, i64 0, i32 6
  %125 = load i8* %124, align 1, !tbaa !20
  %126 = icmp eq i8 %125, 0
  br i1 %126, label %130, label %127

; <label>:127                                     ; preds = %.noexc87
  %128 = getelementptr inbounds %"class.std::ctype"* %121, i64 0, i32 7, i64 10
  %129 = load i8* %128, align 1, !tbaa !22
  br label %.noexc37

; <label>:130                                     ; preds = %.noexc87
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %121)
          to label %.noexc91 unwind label %227

.noexc91:                                         ; preds = %130
  %131 = bitcast %"class.std::ctype"* %121 to i8 (%"class.std::ctype"*, i8)***
  %132 = load i8 (%"class.std::ctype"*, i8)*** %131, align 8, !tbaa !5
  %133 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %132, i64 6
  %134 = load i8 (%"class.std::ctype"*, i8)** %133, align 8
  %135 = invoke signext i8 %134(%"class.std::ctype"* %121, i8 signext 10)
          to label %.noexc37 unwind label %227

.noexc37:                                         ; preds = %.noexc91, %127
  %.0.i90 = phi i8 [ %129, %127 ], [ %135, %.noexc91 ]
  %136 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %112, i8 signext %.0.i90)
          to label %.noexc38 unwind label %227

.noexc38:                                         ; preds = %.noexc37
  %137 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %136)
          to label %_ZNSolsEPFRSoS_E.exit36 unwind label %227

_ZNSolsEPFRSoS_E.exit36:                          ; preds = %.noexc38
  %138 = getelementptr inbounds %"class.std::basic_string"* %string64bitInt, i64 0, i32 0, i32 0
  %139 = load i8** %138, align 8, !tbaa !9
  %140 = getelementptr inbounds i8* %139, i64 -24
  %141 = bitcast i8* %140 to i64*
  %142 = load i64* %141, align 8, !tbaa !13
  %143 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %139, i64 %142)
          to label %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit44 unwind label %227

_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit44: ; preds = %_ZNSolsEPFRSoS_E.exit36
  %144 = bitcast %"class.std::basic_ostream"* %143 to i8**
  %145 = load i8** %144, align 8, !tbaa !5
  %146 = getelementptr i8* %145, i64 -24
  %147 = bitcast i8* %146 to i64*
  %148 = load i64* %147, align 8
  %149 = bitcast %"class.std::basic_ostream"* %143 to i8*
  %.sum122 = add i64 %148, 240
  %150 = getelementptr inbounds i8* %149, i64 %.sum122
  %151 = bitcast i8* %150 to %"class.std::ctype"**
  %152 = load %"class.std::ctype"** %151, align 8, !tbaa !17
  %153 = icmp eq %"class.std::ctype"* %152, null
  br i1 %153, label %154, label %.noexc94

; <label>:154                                     ; preds = %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit44
  invoke void @_ZSt16__throw_bad_castv() #7
          to label %.noexc113 unwind label %227

.noexc113:                                        ; preds = %154
  unreachable

.noexc94:                                         ; preds = %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit44
  %155 = getelementptr inbounds %"class.std::ctype"* %152, i64 0, i32 6
  %156 = load i8* %155, align 1, !tbaa !20
  %157 = icmp eq i8 %156, 0
  br i1 %157, label %161, label %158

; <label>:158                                     ; preds = %.noexc94
  %159 = getelementptr inbounds %"class.std::ctype"* %152, i64 0, i32 7, i64 10
  %160 = load i8* %159, align 1, !tbaa !22
  br label %.noexc47

; <label>:161                                     ; preds = %.noexc94
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %152)
          to label %.noexc98 unwind label %227

.noexc98:                                         ; preds = %161
  %162 = bitcast %"class.std::ctype"* %152 to i8 (%"class.std::ctype"*, i8)***
  %163 = load i8 (%"class.std::ctype"*, i8)*** %162, align 8, !tbaa !5
  %164 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %163, i64 6
  %165 = load i8 (%"class.std::ctype"*, i8)** %164, align 8
  %166 = invoke signext i8 %165(%"class.std::ctype"* %152, i8 signext 10)
          to label %.noexc47 unwind label %227

.noexc47:                                         ; preds = %.noexc98, %158
  %.0.i97 = phi i8 [ %160, %158 ], [ %166, %.noexc98 ]
  %167 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %143, i8 signext %.0.i97)
          to label %.noexc48 unwind label %227

.noexc48:                                         ; preds = %.noexc47
  %168 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %167)
          to label %_ZNSolsEPFRSoS_E.exit46 unwind label %227

_ZNSolsEPFRSoS_E.exit46:                          ; preds = %.noexc48
  invoke void @_ZNKSt15basic_stringbufIcSt11char_traitsIcESaIcEE3strEv(%"class.std::basic_string"* sret %15, %"class.std::basic_stringbuf"* %52)
          to label %_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit54 unwind label %227

_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit54: ; preds = %_ZNSolsEPFRSoS_E.exit46
  %169 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %15, i8* getelementptr inbounds ([15 x i8]* @.str4, i64 0, i64 0))
          to label %170 unwind label %252

; <label>:170                                     ; preds = %_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit54
  %171 = icmp eq i32 %169, 0
  %172 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %172) #2
  %173 = getelementptr inbounds %"class.std::basic_string"* %15, i64 0, i32 0, i32 0
  %174 = load i8** %173, align 8, !tbaa !9
  %175 = getelementptr inbounds i8* %174, i64 -24
  %176 = bitcast i8* %175 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %177 = icmp eq i8* %175, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %177, label %_ZNSsD1Ev.exit58, label %178, !prof !23

; <label>:178                                     ; preds = %170
  %179 = getelementptr inbounds i8* %174, i64 -8
  %180 = bitcast i8* %179 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %181, label %185

; <label>:181                                     ; preds = %178
  %182 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %182)
  %183 = atomicrmw volatile add i32* %180, i32 -1 acq_rel
  store i32 %183, i32* %5, align 4
  %184 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %182)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57

; <label>:185                                     ; preds = %178
  %186 = load i32* %180, align 4, !tbaa !24
  %187 = add nsw i32 %186, -1
  store i32 %187, i32* %180, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57: ; preds = %185, %181
  %.0.i.i.i.i56 = phi i32 [ %184, %181 ], [ %186, %185 ]
  %188 = icmp slt i32 %.0.i.i.i.i56, 1
  br i1 %188, label %189, label %_ZNSsD1Ev.exit58

; <label>:189                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %176, %"class.std::allocator"* %6) #2
  br label %_ZNSsD1Ev.exit58

_ZNSsD1Ev.exit58:                                 ; preds = %189, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57, %170
  call void @llvm.lifetime.end(i64 1, i8* %172) #2
  br i1 %171, label %274, label %190

; <label>:190                                     ; preds = %_ZNSsD1Ev.exit58
  %191 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i64 7)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %227

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %190
  %192 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !5
  %193 = getelementptr i8* %192, i64 -24
  %194 = bitcast i8* %193 to i64*
  %195 = load i64* %194, align 8
  %.sum124 = add i64 %195, 240
  %196 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum124
  %197 = bitcast i8* %196 to %"class.std::ctype"**
  %198 = load %"class.std::ctype"** %197, align 8, !tbaa !17
  %199 = icmp eq %"class.std::ctype"* %198, null
  br i1 %199, label %200, label %.noexc101

; <label>:200                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #7
          to label %.noexc115 unwind label %227

.noexc115:                                        ; preds = %200
  unreachable

.noexc101:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %201 = getelementptr inbounds %"class.std::ctype"* %198, i64 0, i32 6
  %202 = load i8* %201, align 1, !tbaa !20
  %203 = icmp eq i8 %202, 0
  br i1 %203, label %207, label %204

; <label>:204                                     ; preds = %.noexc101
  %205 = getelementptr inbounds %"class.std::ctype"* %198, i64 0, i32 7, i64 10
  %206 = load i8* %205, align 1, !tbaa !22
  br label %.noexc62

; <label>:207                                     ; preds = %.noexc101
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %198)
          to label %.noexc105 unwind label %227

.noexc105:                                        ; preds = %207
  %208 = bitcast %"class.std::ctype"* %198 to i8 (%"class.std::ctype"*, i8)***
  %209 = load i8 (%"class.std::ctype"*, i8)*** %208, align 8, !tbaa !5
  %210 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %209, i64 6
  %211 = load i8 (%"class.std::ctype"*, i8)** %210, align 8
  %212 = invoke signext i8 %211(%"class.std::ctype"* %198, i8 signext 10)
          to label %.noexc62 unwind label %227

.noexc62:                                         ; preds = %.noexc105, %204
  %.0.i104 = phi i8 [ %206, %204 ], [ %212, %.noexc105 ]
  %213 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i104)
          to label %.noexc63 unwind label %227

.noexc63:                                         ; preds = %.noexc62
  %214 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %213)
          to label %_ZNSolsEPFRSoS_E.exit61 unwind label %227

; <label>:215                                     ; preds = %0
  %216 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %217 = extractvalue { i8*, i32 } %216, 0
  %218 = extractvalue { i8*, i32 } %216, 1
  br label %_ZNSsD1Ev.exit

; <label>:219                                     ; preds = %18
  %220 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %221 = extractvalue { i8*, i32 } %220, 0
  %222 = extractvalue { i8*, i32 } %220, 1
  br label %317

; <label>:223                                     ; preds = %33, %20
  %224 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %225 = extractvalue { i8*, i32 } %224, 0
  %226 = extractvalue { i8*, i32 } %224, 1
  br label %316

; <label>:227                                     ; preds = %.noexc10, %.noexc, %.noexc78, %291, %284, %274, %.noexc63, %.noexc62, %.noexc105, %207, %200, %190, %_ZNSolsEPFRSoS_E.exit46, %.noexc48, %.noexc47, %.noexc98, %161, %154, %_ZNSolsEPFRSoS_E.exit36, %.noexc38, %.noexc37, %.noexc91, %130, %123, %101, %_ZNSolsEy.exit, %35
  %228 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %229 = extractvalue { i8*, i32 } %228, 0
  %230 = extractvalue { i8*, i32 } %228, 1
  br label %_ZNSsD1Ev.exit70

; <label>:231                                     ; preds = %.noexc19, %.noexc18, %.noexc84, %76, %69, %_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit
  %232 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %233 = extractvalue { i8*, i32 } %232, 0
  %234 = extractvalue { i8*, i32 } %232, 1
  %235 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %235) #2
  %236 = load i8** %53, align 8, !tbaa !9
  %237 = getelementptr inbounds i8* %236, i64 -24
  %238 = bitcast i8* %237 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %239 = icmp eq i8* %237, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %239, label %_ZNSsD1Ev.exit70, label %240, !prof !23

; <label>:240                                     ; preds = %231
  %241 = getelementptr inbounds i8* %236, i64 -8
  %242 = bitcast i8* %241 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %243, label %247

; <label>:243                                     ; preds = %240
  %244 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %244)
  %245 = atomicrmw volatile add i32* %242, i32 -1 acq_rel
  store i32 %245, i32* %3, align 4
  %246 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %244)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69

; <label>:247                                     ; preds = %240
  %248 = load i32* %242, align 4, !tbaa !24
  %249 = add nsw i32 %248, -1
  store i32 %249, i32* %242, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69: ; preds = %247, %243
  %.0.i.i.i.i68 = phi i32 [ %246, %243 ], [ %248, %247 ]
  %250 = icmp slt i32 %.0.i.i.i.i68, 1
  br i1 %250, label %251, label %_ZNSsD1Ev.exit70

; <label>:251                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %238, %"class.std::allocator"* %4) #2
  br label %_ZNSsD1Ev.exit70

; <label>:252                                     ; preds = %_ZNKSt18basic_stringstreamIcSt11char_traitsIcESaIcEE3strEv.exit54
  %253 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %254 = extractvalue { i8*, i32 } %253, 0
  %255 = extractvalue { i8*, i32 } %253, 1
  %256 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %256) #2
  %257 = getelementptr inbounds %"class.std::basic_string"* %15, i64 0, i32 0, i32 0
  %258 = load i8** %257, align 8, !tbaa !9
  %259 = getelementptr inbounds i8* %258, i64 -24
  %260 = bitcast i8* %259 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %261 = icmp eq i8* %259, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %261, label %_ZNSsD1Ev.exit70, label %262, !prof !23

; <label>:262                                     ; preds = %252
  %263 = getelementptr inbounds i8* %258, i64 -8
  %264 = bitcast i8* %263 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %265, label %269

; <label>:265                                     ; preds = %262
  %266 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %266)
  %267 = atomicrmw volatile add i32* %264, i32 -1 acq_rel
  store i32 %267, i32* %1, align 4
  %268 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %266)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72

; <label>:269                                     ; preds = %262
  %270 = load i32* %264, align 4, !tbaa !24
  %271 = add nsw i32 %270, -1
  store i32 %271, i32* %264, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72: ; preds = %269, %265
  %.0.i.i.i.i71 = phi i32 [ %268, %265 ], [ %270, %269 ]
  %272 = icmp slt i32 %.0.i.i.i.i71, 1
  br i1 %272, label %273, label %_ZNSsD1Ev.exit70

; <label>:273                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %260, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit70

; <label>:274                                     ; preds = %_ZNSsD1Ev.exit58
  %275 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([11 x i8]* @.str6, i64 0, i64 0), i64 10)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit75 unwind label %227

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit75: ; preds = %274
  %276 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !5
  %277 = getelementptr i8* %276, i64 -24
  %278 = bitcast i8* %277 to i64*
  %279 = load i64* %278, align 8
  %.sum123 = add i64 %279, 240
  %280 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum123
  %281 = bitcast i8* %280 to %"class.std::ctype"**
  %282 = load %"class.std::ctype"** %281, align 8, !tbaa !17
  %283 = icmp eq %"class.std::ctype"* %282, null
  br i1 %283, label %284, label %.noexc76

; <label>:284                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit75
  invoke void @_ZSt16__throw_bad_castv() #7
          to label %.noexc108 unwind label %227

.noexc108:                                        ; preds = %284
  unreachable

.noexc76:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit75
  %285 = getelementptr inbounds %"class.std::ctype"* %282, i64 0, i32 6
  %286 = load i8* %285, align 1, !tbaa !20
  %287 = icmp eq i8 %286, 0
  br i1 %287, label %291, label %288

; <label>:288                                     ; preds = %.noexc76
  %289 = getelementptr inbounds %"class.std::ctype"* %282, i64 0, i32 7, i64 10
  %290 = load i8* %289, align 1, !tbaa !22
  br label %.noexc

; <label>:291                                     ; preds = %.noexc76
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %282)
          to label %.noexc78 unwind label %227

.noexc78:                                         ; preds = %291
  %292 = bitcast %"class.std::ctype"* %282 to i8 (%"class.std::ctype"*, i8)***
  %293 = load i8 (%"class.std::ctype"*, i8)*** %292, align 8, !tbaa !5
  %294 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %293, i64 6
  %295 = load i8 (%"class.std::ctype"*, i8)** %294, align 8
  %296 = invoke signext i8 %295(%"class.std::ctype"* %282, i8 signext 10)
          to label %.noexc unwind label %227

.noexc:                                           ; preds = %.noexc78, %288
  %.0.i = phi i8 [ %290, %288 ], [ %296, %.noexc78 ]
  %297 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc10 unwind label %227

.noexc10:                                         ; preds = %.noexc
  %298 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %297)
          to label %_ZNSolsEPFRSoS_E.exit61 unwind label %227

_ZNSolsEPFRSoS_E.exit61:                          ; preds = %.noexc10, %.noexc63
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %out) #2
  call void @llvm.lifetime.end(i64 368, i8* %34) #2
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %s) #2
  call void @llvm.lifetime.end(i64 368, i8* %19) #2
  %299 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %299) #2
  %300 = load i8** %138, align 8, !tbaa !9
  %301 = getelementptr inbounds i8* %300, i64 -24
  %302 = bitcast i8* %301 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %303 = icmp eq i8* %301, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %303, label %_ZNSsD1Ev.exit7, label %304, !prof !23

; <label>:304                                     ; preds = %_ZNSolsEPFRSoS_E.exit61
  %305 = getelementptr inbounds i8* %300, i64 -8
  %306 = bitcast i8* %305 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %307, label %311

; <label>:307                                     ; preds = %304
  %308 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %308)
  %309 = atomicrmw volatile add i32* %306, i32 -1 acq_rel
  store i32 %309, i32* %9, align 4
  %310 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %308)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6

; <label>:311                                     ; preds = %304
  %312 = load i32* %306, align 4, !tbaa !24
  %313 = add nsw i32 %312, -1
  store i32 %313, i32* %306, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6: ; preds = %311, %307
  %.0.i.i.i.i5 = phi i32 [ %310, %307 ], [ %312, %311 ]
  %314 = icmp slt i32 %.0.i.i.i.i5, 1
  br i1 %314, label %315, label %_ZNSsD1Ev.exit7

; <label>:315                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %302, %"class.std::allocator"* %10) #2
  br label %_ZNSsD1Ev.exit7

_ZNSsD1Ev.exit7:                                  ; preds = %315, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i6, %_ZNSolsEPFRSoS_E.exit61
  call void @llvm.lifetime.end(i64 1, i8* %299) #2
  ret i32 0

_ZNSsD1Ev.exit70:                                 ; preds = %273, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72, %252, %251, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69, %231, %227
  %.01 = phi i8* [ %229, %227 ], [ %233, %231 ], [ %233, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69 ], [ %233, %251 ], [ %254, %252 ], [ %254, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72 ], [ %254, %273 ]
  %.0 = phi i32 [ %230, %227 ], [ %234, %231 ], [ %234, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i69 ], [ %234, %251 ], [ %255, %252 ], [ %255, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i72 ], [ %255, %273 ]
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %out) #2
  br label %316

; <label>:316                                     ; preds = %_ZNSsD1Ev.exit70, %223
  %.12 = phi i8* [ %.01, %_ZNSsD1Ev.exit70 ], [ %225, %223 ]
  %.1 = phi i32 [ %.0, %_ZNSsD1Ev.exit70 ], [ %226, %223 ]
  call void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %s) #2
  br label %317

; <label>:317                                     ; preds = %316, %219
  %.23 = phi i8* [ %.12, %316 ], [ %221, %219 ]
  %.2 = phi i32 [ %.1, %316 ], [ %222, %219 ]
  %318 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %318) #2
  %319 = getelementptr inbounds %"class.std::basic_string"* %string64bitInt, i64 0, i32 0, i32 0
  %320 = load i8** %319, align 8, !tbaa !9
  %321 = getelementptr inbounds i8* %320, i64 -24
  %322 = bitcast i8* %321 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %323 = icmp eq i8* %321, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %323, label %_ZNSsD1Ev.exit, label %324, !prof !23

; <label>:324                                     ; preds = %317
  %325 = getelementptr inbounds i8* %320, i64 -8
  %326 = bitcast i8* %325 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %327, label %331

; <label>:327                                     ; preds = %324
  %328 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %328)
  %329 = atomicrmw volatile add i32* %326, i32 -1 acq_rel
  store i32 %329, i32* %11, align 4
  %330 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %328)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:331                                     ; preds = %324
  %332 = load i32* %326, align 4, !tbaa !24
  %333 = add nsw i32 %332, -1
  store i32 %333, i32* %326, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %331, %327
  %.0.i.i.i.i = phi i32 [ %330, %327 ], [ %332, %331 ]
  %334 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %334, label %335, label %_ZNSsD1Ev.exit

; <label>:335                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %322, %"class.std::allocator"* %12) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %335, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %317, %215
  %.34 = phi i8* [ %217, %215 ], [ %.23, %317 ], [ %.23, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %.23, %335 ]
  %.3 = phi i32 [ %218, %215 ], [ %.2, %317 ], [ %.2, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %.2, %335 ]
  %336 = insertvalue { i8*, i32 } undef, i8* %.34, 0
  %337 = insertvalue { i8*, i32 } %336, i32 %.3, 1
  resume { i8*, i32 } %337
}

; Function Attrs: nounwind
declare i64 @strtoull(i8* readonly, i8** nocapture, i32) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: uwtable
define available_externally void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_stringstream"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__m) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = bitcast %"class.std::basic_stringstream"* %this to i8*
  %4 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2
  %5 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %5) #2
  %6 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !5
  %7 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %7, align 8, !tbaa !25
  %8 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %8, align 1, !tbaa !26
  %9 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %9, align 1, !tbaa !27
  %10 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2, i32 4
  %11 = bitcast %"class.std::basic_streambuf"** %10 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 32, i32 8, i1 false) #2
  %12 = bitcast %"class.std::basic_stringstream"* %this to %"class.std::basic_iostream"*
  invoke void @_ZNSdC2Ev(%"class.std::basic_iostream"* %12, i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1))
          to label %13 unwind label %26

; <label>:13                                      ; preds = %0
  %14 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !5
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 13) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !5
  %15 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %15, align 8, !tbaa !5
  %16 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1
  invoke void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %16, %"class.std::basic_string"* %__str, i32 %__m)
          to label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit unwind label %30

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit: ; preds = %13
  %17 = bitcast %"class.std::basic_stringstream"* %this to i8**
  %18 = load i8** %17, align 8, !tbaa !5
  %19 = getelementptr i8* %18, i64 -24
  %20 = bitcast i8* %19 to i64*
  %21 = load i64* %20, align 8
  %22 = getelementptr inbounds i8* %3, i64 %21
  %23 = bitcast i8* %22 to %"class.std::basic_ios"*
  %24 = getelementptr inbounds %"class.std::basic_stringbuf"* %16, i64 0, i32 0
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %23, %"class.std::basic_streambuf"* %24)
          to label %25 unwind label %34

; <label>:25                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit
  ret void

; <label>:26                                      ; preds = %0
  %27 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  %29 = extractvalue { i8*, i32 } %27, 1
  br label %67

; <label>:30                                      ; preds = %13
  %31 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %32 = extractvalue { i8*, i32 } %31, 0
  %33 = extractvalue { i8*, i32 } %31, 1
  br label %58

; <label>:34                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit
  %35 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %36 = extractvalue { i8*, i32 } %35, 0
  %37 = extractvalue { i8*, i32 } %35, 1
  %38 = getelementptr inbounds %"class.std::basic_stringbuf"* %16, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %38, align 8, !tbaa !5
  %39 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %39) #2
  %40 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %41 = load i8** %40, align 8, !tbaa !9
  %42 = getelementptr inbounds i8* %41, i64 -24
  %43 = bitcast i8* %42 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %44 = icmp eq i8* %42, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %44, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, label %45, !prof !23

; <label>:45                                      ; preds = %34
  %46 = getelementptr inbounds i8* %41, i64 -8
  %47 = bitcast i8* %46 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %48, label %52

; <label>:48                                      ; preds = %45
  %49 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %49)
  %50 = atomicrmw volatile add i32* %47, i32 -1 acq_rel
  store i32 %50, i32* %1, align 4
  %51 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %49)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:52                                      ; preds = %45
  %53 = load i32* %47, align 4, !tbaa !24
  %54 = add nsw i32 %53, -1
  store i32 %54, i32* %47, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %52, %48
  %.0.i.i.i.i.i = phi i32 [ %51, %48 ], [ %53, %52 ]
  %55 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %55, label %56, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:56                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %43, %"class.std::allocator"* %2) #2
  br label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %56, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %34
  call void @llvm.lifetime.end(i64 1, i8* %39) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %38, align 8, !tbaa !5
  %57 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %57) #2
  br label %58

; <label>:58                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, %30
  %.01 = phi i8* [ %36, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %32, %30 ]
  %.0 = phi i32 [ %37, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %33, %30 ]
  %59 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %.c.i.i = bitcast i8* %59 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %14, align 8, !tbaa !5
  %60 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %61 = getelementptr i8* %59, i64 -24
  %62 = bitcast i8* %61 to i64*
  %63 = load i64* %62, align 8
  %64 = getelementptr inbounds i8* %3, i64 %63
  %65 = bitcast i8* %64 to i8**
  store i8* %60, i8** %65, align 8, !tbaa !5
  %66 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %66, align 8, !tbaa !28
  br label %67

; <label>:67                                      ; preds = %58, %26
  %.12 = phi i8* [ %.01, %58 ], [ %28, %26 ]
  %.1 = phi i32 [ %.0, %58 ], [ %29, %26 ]
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %5) #2
  %68 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %69 = insertvalue { i8*, i32 } %68, i32 %.1, 1
  resume { i8*, i32 } %69
}

; Function Attrs: uwtable
define available_externally void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEEC1ESt13_Ios_Openmode(%"class.std::basic_stringstream"* %this, i32 %__m) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 2
  %4 = getelementptr inbounds %"class.std::basic_ios"* %3, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %4) #2
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
  call void @llvm.memset.p0i8.i64(i8* %10, i8 0, i64 32, i32 8, i1 false) #2
  %11 = bitcast %"class.std::basic_stringstream"* %this to %"class.std::basic_iostream"*
  invoke void @_ZNSdC2Ev(%"class.std::basic_iostream"* %11, i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1))
          to label %12 unwind label %32

; <label>:12                                      ; preds = %0
  %13 = bitcast %"class.std::basic_stringstream"* %this to i8*
  %14 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !5
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 13) to i32 (...)**), i32 (...)*** %5, align 8, !tbaa !5
  %15 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 1, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([15 x i8*]* @_ZTVSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %15, align 8, !tbaa !5
  %16 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1
  %17 = getelementptr inbounds %"class.std::basic_stringbuf"* %16, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %17, align 8, !tbaa !5
  %18 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 1
  %19 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 7
  %20 = bitcast i8** %18 to i8*
  call void @llvm.memset.p0i8.i64(i8* %20, i8 0, i64 48, i32 8, i1 false) #2
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %19) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %17, align 8, !tbaa !5
  %21 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 1
  store i32 %__m, i32* %21, align 4, !tbaa !30
  %22 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %22, align 8, !tbaa !33
  %23 = bitcast %"class.std::basic_stringstream"* %this to i8**
  %24 = load i8** %23, align 8, !tbaa !5
  %25 = getelementptr i8* %24, i64 -24
  %26 = bitcast i8* %25 to i64*
  %27 = load i64* %26, align 8
  %28 = getelementptr inbounds i8* %13, i64 %27
  %29 = bitcast i8* %28 to %"class.std::basic_ios"*
  %30 = getelementptr inbounds %"class.std::basic_stringbuf"* %16, i64 0, i32 0
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %29, %"class.std::basic_streambuf"* %30)
          to label %31 unwind label %36

; <label>:31                                      ; preds = %12
  ret void

; <label>:32                                      ; preds = %0
  %33 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %34 = extractvalue { i8*, i32 } %33, 0
  %35 = extractvalue { i8*, i32 } %33, 1
  br label %66

; <label>:36                                      ; preds = %12
  %37 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %38 = extractvalue { i8*, i32 } %37, 0
  %39 = extractvalue { i8*, i32 } %37, 1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %17, align 8, !tbaa !5
  %40 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %40) #2
  %41 = load i8** %22, align 8, !tbaa !9
  %42 = getelementptr inbounds i8* %41, i64 -24
  %43 = bitcast i8* %42 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %44 = icmp eq i8* %42, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %44, label %57, label %45, !prof !23

; <label>:45                                      ; preds = %36
  %46 = getelementptr inbounds i8* %41, i64 -8
  %47 = bitcast i8* %46 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %48, label %52

; <label>:48                                      ; preds = %45
  %49 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %49)
  %50 = atomicrmw volatile add i32* %47, i32 -1 acq_rel
  store i32 %50, i32* %1, align 4
  %51 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %49)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:52                                      ; preds = %45
  %53 = load i32* %47, align 4, !tbaa !24
  %54 = add nsw i32 %53, -1
  store i32 %54, i32* %47, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %52, %48
  %.0.i.i.i.i.i = phi i32 [ %51, %48 ], [ %53, %52 ]
  %55 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %55, label %56, label %57

; <label>:56                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %43, %"class.std::allocator"* %2) #2
  br label %57

; <label>:57                                      ; preds = %56, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %36
  call void @llvm.lifetime.end(i64 1, i8* %40) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %17, align 8, !tbaa !5
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %19) #2
  %58 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %.c.i.i = bitcast i8* %58 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %14, align 8, !tbaa !5
  %59 = load i8** getelementptr inbounds ([10 x i8*]* @_ZTTSt18basic_stringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %60 = getelementptr i8* %58, i64 -24
  %61 = bitcast i8* %60 to i64*
  %62 = load i64* %61, align 8
  %63 = getelementptr inbounds i8* %13, i64 %62
  %64 = bitcast i8* %63 to i8**
  store i8* %59, i8** %64, align 8, !tbaa !5
  %65 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 0, i32 0, i32 1
  store i64 0, i64* %65, align 8, !tbaa !28
  br label %66

; <label>:66                                      ; preds = %57, %32
  %.12 = phi i8* [ %38, %57 ], [ %34, %32 ]
  %.1 = phi i32 [ %39, %57 ], [ %35, %32 ]
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %4) #2
  %67 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %68 = insertvalue { i8*, i32 } %67, i32 %.1, 1
  resume { i8*, i32 } %68
}

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_stringstream"* %this) unnamed_addr #4 align 2 {
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
  call void @llvm.lifetime.start(i64 1, i8* %15) #2
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
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %19, %"class.std::allocator"* %2) #2
  br label %_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt18basic_stringstreamIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %32, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %15) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !5
  %33 = getelementptr inbounds %"class.std::basic_stringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %33) #2
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
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %42) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

declare i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"*, i8*) #0

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #5

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

; Function Attrs: uwtable
define available_externally void @_ZNKSt15basic_stringbufIcSt11char_traitsIcESaIcEE3strEv(%"class.std::basic_string"* noalias sret %agg.result, %"class.std::basic_stringbuf"* %this) #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::allocator", align 1
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::allocator", align 1
  %11 = alloca %"class.std::basic_string", align 8
  %12 = alloca %"class.std::allocator", align 1
  %13 = alloca %"class.std::basic_string", align 8
  %14 = alloca %"class.std::allocator", align 1
  %15 = getelementptr inbounds %"class.std::basic_string"* %agg.result, i64 0, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %15, align 8, !tbaa !33
  %16 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 5
  %17 = load i8** %16, align 8, !tbaa !34
  %18 = icmp eq i8* %17, null
  br i1 %18, label %157, label %19

; <label>:19                                      ; preds = %0
  %20 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 3
  %21 = load i8** %20, align 8, !tbaa !37
  %22 = icmp ugt i8* %17, %21
  %23 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 4
  %24 = load i8** %23, align 8, !tbaa !38
  br i1 %22, label %25, label %93

; <label>:25                                      ; preds = %19
  %26 = icmp eq i8* %24, %17
  br i1 %26, label %45, label %.critedge.i.i.i.i13

.critedge.i.i.i.i13:                              ; preds = %25
  %.not.i.i.i.i12 = icmp eq i8* %24, null
  br i1 %.not.i.i.i.i12, label %27, label %28

; <label>:27                                      ; preds = %.critedge.i.i.i.i13
  invoke void @_ZSt19__throw_logic_errorPKc(i8* getelementptr inbounds ([42 x i8]* @.str7, i64 0, i64 0)) #7
          to label %.noexc16 unwind label %68

.noexc16:                                         ; preds = %27
  unreachable

; <label>:28                                      ; preds = %.critedge.i.i.i.i13
  %29 = ptrtoint i8* %17 to i64
  %30 = ptrtoint i8* %24 to i64
  %31 = sub i64 %29, %30
  %32 = invoke %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* @_ZNSs4_Rep9_S_createEmmRKSaIcE(i64 %31, i64 0, %"class.std::allocator"* %12)
          to label %.noexc17 unwind label %68

.noexc17:                                         ; preds = %28
  %33 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %32, i64 1
  %34 = bitcast %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %33 to i8*
  %35 = icmp eq i64 %31, 1
  br i1 %35, label %36, label %38

; <label>:36                                      ; preds = %.noexc17
  %37 = load i8* %24, align 1, !tbaa !22
  store i8 %37, i8* %34, align 1, !tbaa !22
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i14

; <label>:38                                      ; preds = %.noexc17
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %34, i8* %24, i64 %31, i32 1, i1 false) #2
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i14

_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i14:       ; preds = %38, %36
  %39 = icmp eq %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %32, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*)
  br i1 %39, label %45, label %40, !prof !23

; <label>:40                                      ; preds = %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i14
  %41 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %32, i64 0, i32 0, i32 2
  store i32 0, i32* %41, align 4, !tbaa !39
  %42 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %32, i64 0, i32 0, i32 0
  store i64 %31, i64* %42, align 8, !tbaa !13
  %43 = getelementptr inbounds i8* %34, i64 %31
  %44 = load i8* @_ZNSs4_Rep11_S_terminalE, align 1, !tbaa !22
  store i8 %44, i8* %43, align 1, !tbaa !22
  br label %45

; <label>:45                                      ; preds = %40, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i14, %25
  %.0.i.i.i.i15 = phi i8* [ bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), %25 ], [ %34, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i14 ], [ %34, %40 ]
  %46 = getelementptr inbounds %"class.std::basic_string"* %11, i64 0, i32 0, i32 0
  store i8* %.0.i.i.i.i15, i8** %46, align 8, !tbaa !33
  invoke void @_ZNSs4swapERSs(%"class.std::basic_string"* %agg.result, %"class.std::basic_string"* %11)
          to label %_ZNSsaSEOSs.exit20 unwind label %72

_ZNSsaSEOSs.exit20:                               ; preds = %45
  %47 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %47) #2
  %48 = load i8** %46, align 8, !tbaa !9
  %49 = getelementptr inbounds i8* %48, i64 -24
  %50 = bitcast i8* %49 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %51 = icmp eq i8* %49, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %51, label %_ZNSsaSERKSs.exit, label %52, !prof !23

; <label>:52                                      ; preds = %_ZNSsaSEOSs.exit20
  %53 = getelementptr inbounds i8* %48, i64 -8
  %54 = bitcast i8* %53 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %55, label %59

; <label>:55                                      ; preds = %52
  %56 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %56)
  %57 = atomicrmw volatile add i32* %54, i32 -1 acq_rel
  store i32 %57, i32* %3, align 4
  %58 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %56)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i22

; <label>:59                                      ; preds = %52
  %60 = load i32* %54, align 4, !tbaa !24
  %61 = add nsw i32 %60, -1
  store i32 %61, i32* %54, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i22

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i22: ; preds = %59, %55
  %.0.i.i.i.i21 = phi i32 [ %58, %55 ], [ %60, %59 ]
  %62 = icmp slt i32 %.0.i.i.i.i21, 1
  br i1 %62, label %63, label %_ZNSsaSERKSs.exit

; <label>:63                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i22
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %50, %"class.std::allocator"* %4) #2
  br label %_ZNSsaSERKSs.exit

; <label>:64                                      ; preds = %157
  %65 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %66 = extractvalue { i8*, i32 } %65, 0
  %67 = extractvalue { i8*, i32 } %65, 1
  br label %_ZNSsD1Ev.exit26

; <label>:68                                      ; preds = %28, %27
  %69 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %70 = extractvalue { i8*, i32 } %69, 0
  %71 = extractvalue { i8*, i32 } %69, 1
  br label %_ZNSsD1Ev.exit26

; <label>:72                                      ; preds = %45
  %73 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %74 = extractvalue { i8*, i32 } %73, 0
  %75 = extractvalue { i8*, i32 } %73, 1
  %76 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %76) #2
  %77 = load i8** %46, align 8, !tbaa !9
  %78 = getelementptr inbounds i8* %77, i64 -24
  %79 = bitcast i8* %78 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %80 = icmp eq i8* %78, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %80, label %_ZNSsD1Ev.exit26, label %81, !prof !23

; <label>:81                                      ; preds = %72
  %82 = getelementptr inbounds i8* %77, i64 -8
  %83 = bitcast i8* %82 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %84, label %88

; <label>:84                                      ; preds = %81
  %85 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %85)
  %86 = atomicrmw volatile add i32* %83, i32 -1 acq_rel
  store i32 %86, i32* %1, align 4
  %87 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %85)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25

; <label>:88                                      ; preds = %81
  %89 = load i32* %83, align 4, !tbaa !24
  %90 = add nsw i32 %89, -1
  store i32 %90, i32* %83, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25: ; preds = %88, %84
  %.0.i.i.i.i24 = phi i32 [ %87, %84 ], [ %89, %88 ]
  %91 = icmp slt i32 %.0.i.i.i.i24, 1
  br i1 %91, label %92, label %_ZNSsD1Ev.exit26

; <label>:92                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %79, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit26

; <label>:93                                      ; preds = %19
  %94 = icmp eq i8* %24, %21
  br i1 %94, label %113, label %.critedge.i.i.i.i

.critedge.i.i.i.i:                                ; preds = %93
  %.not.i.i.i.i = icmp eq i8* %24, null
  br i1 %.not.i.i.i.i, label %95, label %96

; <label>:95                                      ; preds = %.critedge.i.i.i.i
  invoke void @_ZSt19__throw_logic_errorPKc(i8* getelementptr inbounds ([42 x i8]* @.str7, i64 0, i64 0)) #7
          to label %.noexc unwind label %132

.noexc:                                           ; preds = %95
  unreachable

; <label>:96                                      ; preds = %.critedge.i.i.i.i
  %97 = ptrtoint i8* %21 to i64
  %98 = ptrtoint i8* %24 to i64
  %99 = sub i64 %97, %98
  %100 = invoke %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* @_ZNSs4_Rep9_S_createEmmRKSaIcE(i64 %99, i64 0, %"class.std::allocator"* %14)
          to label %.noexc11 unwind label %132

.noexc11:                                         ; preds = %96
  %101 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %100, i64 1
  %102 = bitcast %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %101 to i8*
  %103 = icmp eq i64 %99, 1
  br i1 %103, label %104, label %106

; <label>:104                                     ; preds = %.noexc11
  %105 = load i8* %24, align 1, !tbaa !22
  store i8 %105, i8* %102, align 1, !tbaa !22
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i

; <label>:106                                     ; preds = %.noexc11
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %102, i8* %24, i64 %99, i32 1, i1 false) #2
  br label %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i

_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i:         ; preds = %106, %104
  %107 = icmp eq %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %100, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*)
  br i1 %107, label %113, label %108, !prof !23

; <label>:108                                     ; preds = %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i
  %109 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %100, i64 0, i32 0, i32 2
  store i32 0, i32* %109, align 4, !tbaa !39
  %110 = getelementptr inbounds %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %100, i64 0, i32 0, i32 0
  store i64 %99, i64* %110, align 8, !tbaa !13
  %111 = getelementptr inbounds i8* %102, i64 %99
  %112 = load i8* @_ZNSs4_Rep11_S_terminalE, align 1, !tbaa !22
  store i8 %112, i8* %111, align 1, !tbaa !22
  br label %113

; <label>:113                                     ; preds = %108, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i, %93
  %.0.i.i.i.i10 = phi i8* [ bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), %93 ], [ %102, %_ZNSs13_S_copy_charsEPcS_S_.exit.i.i.i.i ], [ %102, %108 ]
  %114 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  store i8* %.0.i.i.i.i10, i8** %114, align 8, !tbaa !33
  invoke void @_ZNSs4swapERSs(%"class.std::basic_string"* %agg.result, %"class.std::basic_string"* %13)
          to label %_ZNSsaSEOSs.exit unwind label %136

_ZNSsaSEOSs.exit:                                 ; preds = %113
  %115 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %115) #2
  %116 = load i8** %114, align 8, !tbaa !9
  %117 = getelementptr inbounds i8* %116, i64 -24
  %118 = bitcast i8* %117 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %119 = icmp eq i8* %117, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %119, label %_ZNSsaSERKSs.exit, label %120, !prof !23

; <label>:120                                     ; preds = %_ZNSsaSEOSs.exit
  %121 = getelementptr inbounds i8* %116, i64 -8
  %122 = bitcast i8* %121 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %123, label %127

; <label>:123                                     ; preds = %120
  %124 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %124)
  %125 = atomicrmw volatile add i32* %122, i32 -1 acq_rel
  store i32 %125, i32* %5, align 4
  %126 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %124)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i8

; <label>:127                                     ; preds = %120
  %128 = load i32* %122, align 4, !tbaa !24
  %129 = add nsw i32 %128, -1
  store i32 %129, i32* %122, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i8

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i8: ; preds = %127, %123
  %.0.i.i.i.i7 = phi i32 [ %126, %123 ], [ %128, %127 ]
  %130 = icmp slt i32 %.0.i.i.i.i7, 1
  br i1 %130, label %131, label %_ZNSsaSERKSs.exit

; <label>:131                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i8
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %118, %"class.std::allocator"* %6) #2
  br label %_ZNSsaSERKSs.exit

; <label>:132                                     ; preds = %96, %95
  %133 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %134 = extractvalue { i8*, i32 } %133, 0
  %135 = extractvalue { i8*, i32 } %133, 1
  br label %_ZNSsD1Ev.exit26

; <label>:136                                     ; preds = %113
  %137 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %138 = extractvalue { i8*, i32 } %137, 0
  %139 = extractvalue { i8*, i32 } %137, 1
  %140 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %140) #2
  %141 = load i8** %114, align 8, !tbaa !9
  %142 = getelementptr inbounds i8* %141, i64 -24
  %143 = bitcast i8* %142 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %144 = icmp eq i8* %142, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %144, label %_ZNSsD1Ev.exit26, label %145, !prof !23

; <label>:145                                     ; preds = %136
  %146 = getelementptr inbounds i8* %141, i64 -8
  %147 = bitcast i8* %146 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %148, label %152

; <label>:148                                     ; preds = %145
  %149 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %149)
  %150 = atomicrmw volatile add i32* %147, i32 -1 acq_rel
  store i32 %150, i32* %7, align 4
  %151 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %149)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5

; <label>:152                                     ; preds = %145
  %153 = load i32* %147, align 4, !tbaa !24
  %154 = add nsw i32 %153, -1
  store i32 %154, i32* %147, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5: ; preds = %152, %148
  %.0.i.i.i.i4 = phi i32 [ %151, %148 ], [ %153, %152 ]
  %155 = icmp slt i32 %.0.i.i.i.i4, 1
  br i1 %155, label %156, label %_ZNSsD1Ev.exit26

; <label>:156                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %143, %"class.std::allocator"* %8) #2
  br label %_ZNSsD1Ev.exit26

; <label>:157                                     ; preds = %0
  %158 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2
  %159 = invoke %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %agg.result, %"class.std::basic_string"* %158)
          to label %_ZNSsaSERKSs.exit unwind label %64

_ZNSsaSERKSs.exit:                                ; preds = %157, %131, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i8, %_ZNSsaSEOSs.exit, %63, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i22, %_ZNSsaSEOSs.exit20
  ret void

_ZNSsD1Ev.exit26:                                 ; preds = %156, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5, %136, %132, %92, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25, %72, %68, %64
  %.23 = phi i8* [ %66, %64 ], [ %70, %68 ], [ %134, %132 ], [ %74, %72 ], [ %74, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25 ], [ %74, %92 ], [ %138, %136 ], [ %138, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5 ], [ %138, %156 ]
  %.2 = phi i32 [ %67, %64 ], [ %71, %68 ], [ %135, %132 ], [ %75, %72 ], [ %75, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i25 ], [ %75, %92 ], [ %139, %136 ], [ %139, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i5 ], [ %139, %156 ]
  %160 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %160) #2
  %161 = load i8** %15, align 8, !tbaa !9
  %162 = getelementptr inbounds i8* %161, i64 -24
  %163 = bitcast i8* %162 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %164 = icmp eq i8* %162, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %164, label %_ZNSsD1Ev.exit, label %165, !prof !23

; <label>:165                                     ; preds = %_ZNSsD1Ev.exit26
  %166 = getelementptr inbounds i8* %161, i64 -8
  %167 = bitcast i8* %166 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %168, label %172

; <label>:168                                     ; preds = %165
  %169 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %169)
  %170 = atomicrmw volatile add i32* %167, i32 -1 acq_rel
  store i32 %170, i32* %9, align 4
  %171 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %169)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:172                                     ; preds = %165
  %173 = load i32* %167, align 4, !tbaa !24
  %174 = add nsw i32 %173, -1
  store i32 %174, i32* %167, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %172, %168
  %.0.i.i.i.i = phi i32 [ %171, %168 ], [ %173, %172 ]
  %175 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %175, label %176, label %_ZNSsD1Ev.exit

; <label>:176                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %163, %"class.std::allocator"* %10) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %176, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNSsD1Ev.exit26
  call void @llvm.lifetime.end(i64 1, i8* %160) #2
  %177 = insertvalue { i8*, i32 } undef, i8* %.23, 0
  %178 = insertvalue { i8*, i32 } %177, i32 %.2, 1
  resume { i8*, i32 } %178
}

declare %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

; Function Attrs: noreturn
declare void @_ZSt19__throw_logic_errorPKc(i8*) #5

declare %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* @_ZNSs4_Rep9_S_createEmmRKSaIcE(i64, i64, %"class.std::allocator"*) #0

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

declare void @_ZNSs4swapERSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

declare %"class.std::basic_ostream"* @_ZNSo9_M_insertIyEERSoT_(%"class.std::basic_ostream"*, i64) #0

; Function Attrs: uwtable
define available_externally void @_ZNSdC2Ev(%"class.std::basic_iostream"* %this, i8** nocapture readonly %vtt) unnamed_addr #3 align 2 {
  %1 = getelementptr inbounds i8** %vtt, i64 1
  %2 = load i8** %1, align 8
  %3 = bitcast %"class.std::basic_iostream"* %this to i8**
  %4 = getelementptr inbounds %"class.std::basic_iostream"* %this, i64 0, i32 0, i32 0
  %.c.i = bitcast i8* %2 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %4, align 8, !tbaa !5
  %5 = getelementptr inbounds i8** %vtt, i64 2
  %6 = load i8** %5, align 8
  %7 = getelementptr i8* %2, i64 -24
  %8 = bitcast i8* %7 to i64*
  %9 = load i64* %8, align 8
  %10 = bitcast %"class.std::basic_iostream"* %this to i8*
  %11 = getelementptr inbounds i8* %10, i64 %9
  %12 = bitcast i8* %11 to i8**
  store i8* %6, i8** %12, align 8, !tbaa !5
  %13 = getelementptr inbounds %"class.std::basic_iostream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %13, align 8, !tbaa !28
  %14 = load i8** %3, align 8, !tbaa !5
  %15 = getelementptr i8* %14, i64 -24
  %16 = bitcast i8* %15 to i64*
  %17 = load i64* %16, align 8
  %18 = getelementptr inbounds i8* %10, i64 %17
  %19 = bitcast i8* %18 to %"class.std::basic_ios"*
  tail call void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %19, %"class.std::basic_streambuf"* null)
  %20 = getelementptr inbounds %"class.std::basic_iostream"* %this, i64 0, i32 1
  %21 = getelementptr inbounds i8** %vtt, i64 3
  %22 = load i8** %21, align 8
  %23 = bitcast %"class.std::basic_ostream.base"* %20 to i8**
  %24 = getelementptr inbounds %"class.std::basic_ostream.base"* %20, i64 0, i32 0
  %.c.i2 = bitcast i8* %22 to i32 (...)**
  store i32 (...)** %.c.i2, i32 (...)*** %24, align 8, !tbaa !5
  %25 = getelementptr inbounds i8** %vtt, i64 4
  %26 = load i8** %25, align 8
  %27 = getelementptr i8* %22, i64 -24
  %28 = bitcast i8* %27 to i64*
  %29 = load i64* %28, align 8
  %30 = bitcast %"class.std::basic_ostream.base"* %20 to i8*
  %31 = getelementptr inbounds i8* %30, i64 %29
  %32 = bitcast i8* %31 to i8**
  store i8* %26, i8** %32, align 8, !tbaa !5
  %33 = load i8** %23, align 8, !tbaa !5
  %34 = getelementptr i8* %33, i64 -24
  %35 = bitcast i8* %34 to i64*
  %36 = load i64* %35, align 8
  %37 = getelementptr inbounds i8* %30, i64 %36
  %38 = bitcast i8* %37 to %"class.std::basic_ios"*
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %38, %"class.std::basic_streambuf"* null)
          to label %_ZNSoC2Ev.exit unwind label %49

_ZNSoC2Ev.exit:                                   ; preds = %0
  %39 = load i8** %vtt, align 8
  %.c = bitcast i8* %39 to i32 (...)**
  store i32 (...)** %.c, i32 (...)*** %4, align 8, !tbaa !5
  %40 = getelementptr inbounds i8** %vtt, i64 5
  %41 = load i8** %40, align 8
  %42 = getelementptr i8* %39, i64 -24
  %43 = bitcast i8* %42 to i64*
  %44 = load i64* %43, align 8
  %45 = getelementptr inbounds i8* %10, i64 %44
  %46 = bitcast i8* %45 to i8**
  store i8* %41, i8** %46, align 8, !tbaa !5
  %47 = getelementptr inbounds i8** %vtt, i64 6
  %48 = load i8** %47, align 8
  %.c1 = bitcast i8* %48 to i32 (...)**
  store i32 (...)** %.c1, i32 (...)*** %24, align 8, !tbaa !5
  ret void

; <label>:49                                      ; preds = %0
  %50 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %51 = load i8** %1, align 8
  %.c.i3 = bitcast i8* %51 to i32 (...)**
  store i32 (...)** %.c.i3, i32 (...)*** %4, align 8, !tbaa !5
  %52 = load i8** %5, align 8
  %53 = getelementptr i8* %51, i64 -24
  %54 = bitcast i8* %53 to i64*
  %55 = load i64* %54, align 8
  %56 = getelementptr inbounds i8* %10, i64 %55
  %57 = bitcast i8* %56 to i8**
  store i8* %52, i8** %57, align 8, !tbaa !5
  store i64 0, i64* %13, align 8, !tbaa !28
  resume { i8*, i32 } %50
}

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #1

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #1

; Function Attrs: nounwind
declare void @_ZNSt6localeC1Ev(%"class.std::locale"*) #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #1

declare %"class.std::basic_istream"* @_ZNSi10_M_extractIyEERSiRT_(%"class.std::basic_istream"*, i64*) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::allocator", align 1
  %4 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !5
  %5 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 1
  %6 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 7
  %7 = bitcast i8** %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 48, i32 8, i1 false) #2
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %6) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !5
  %8 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 1
  store i32 0, i32* %8, align 4, !tbaa !30
  %9 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2
  %10 = getelementptr inbounds %"class.std::basic_string"* %__str, i64 0, i32 0, i32 0
  %11 = load i8** %10, align 8, !tbaa !9
  %12 = getelementptr inbounds i8* %11, i64 -24
  %13 = bitcast i8* %12 to i64*
  %14 = load i64* %13, align 8, !tbaa !13
  invoke void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"* %9, i8* %11, i64 %14, %"class.std::allocator"* %3)
          to label %15 unwind label %22

; <label>:15                                      ; preds = %0
  store i32 %__mode, i32* %8, align 4, !tbaa !30
  %16 = and i32 %__mode, 3
  %17 = icmp eq i32 %16, 0
  %.phi.trans.insert.i = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2, i32 0, i32 0
  %.pre.i = load i8** %.phi.trans.insert.i, align 8, !tbaa !9
  br i1 %17, label %._crit_edge.i, label %18

; <label>:18                                      ; preds = %15
  %19 = getelementptr inbounds i8* %.pre.i, i64 -24
  %20 = bitcast i8* %19 to i64*
  %21 = load i64* %20, align 8, !tbaa !13
  br label %._crit_edge.i

._crit_edge.i:                                    ; preds = %18, %15
  %__len.0.i = phi i64 [ %21, %18 ], [ 0, %15 ]
  invoke void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"* %this, i8* %.pre.i, i64 0, i64 %__len.0.i)
          to label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE17_M_stringbuf_initESt13_Ios_Openmode.exit unwind label %26

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE17_M_stringbuf_initESt13_Ios_Openmode.exit: ; preds = %._crit_edge.i
  ret void

; <label>:22                                      ; preds = %0
  %23 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %24 = extractvalue { i8*, i32 } %23, 0
  %25 = extractvalue { i8*, i32 } %23, 1
  br label %_ZNSsD1Ev.exit

; <label>:26                                      ; preds = %._crit_edge.i
  %27 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %28 = extractvalue { i8*, i32 } %27, 0
  %29 = extractvalue { i8*, i32 } %27, 1
  %30 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %30) #2
  %31 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %32 = load i8** %31, align 8, !tbaa !9
  %33 = getelementptr inbounds i8* %32, i64 -24
  %34 = bitcast i8* %33 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %35 = icmp eq i8* %33, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %35, label %_ZNSsD1Ev.exit, label %36, !prof !23

; <label>:36                                      ; preds = %26
  %37 = getelementptr inbounds i8* %32, i64 -8
  %38 = bitcast i8* %37 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %39, label %43

; <label>:39                                      ; preds = %36
  %40 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %40)
  %41 = atomicrmw volatile add i32* %38, i32 -1 acq_rel
  store i32 %41, i32* %1, align 4
  %42 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %40)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:43                                      ; preds = %36
  %44 = load i32* %38, align 4, !tbaa !24
  %45 = add nsw i32 %44, -1
  store i32 %45, i32* %38, align 4, !tbaa !24
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %43, %39
  %.0.i.i.i.i = phi i32 [ %42, %39 ], [ %44, %43 ]
  %46 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %46, label %47, label %_ZNSsD1Ev.exit

; <label>:47                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %34, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %47, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %26, %22
  %.01 = phi i8* [ %24, %22 ], [ %28, %26 ], [ %28, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %28, %47 ]
  %.0 = phi i32 [ %25, %22 ], [ %29, %26 ], [ %29, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %29, %47 ]
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !5
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %6) #2
  %48 = insertvalue { i8*, i32 } undef, i8* %.01, 0
  %49 = insertvalue { i8*, i32 } %48, i32 %.0, 1
  resume { i8*, i32 } %49
}

declare void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"*, i8*, i64, %"class.std::allocator"*) #0

declare void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"*, i8*, i64, i64) #0

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: nounwind readnone
declare i64 @llvm.bswap.i64(i64) #6

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #2

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone }
attributes #7 = { noreturn }

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
