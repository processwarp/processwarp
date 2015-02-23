; ModuleID = 'test_exceptions_convert.bc'
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
%"class.std::basic_istringstream" = type { %"class.std::basic_istream.base", %"class.std::basic_stringbuf", %"class.std::basic_ios" }
%"class.std::basic_istream.base" = type { i32 (...)**, i64 }
%"class.std::basic_stringbuf" = type { %"class.std::basic_streambuf", i32, %"class.std::basic_string" }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }
%"class.std::basic_istream" = type { i32 (...)**, i64, %"class.std::basic_ios" }
%"class.std::ios_base::failure" = type { %"class.std::exception", %"class.std::basic_string" }
%"class.std::exception" = type { i32 (...)** }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str = private unnamed_addr constant [4 x i8] c"One\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str1 = private unnamed_addr constant [50 x i8] c"Failed to convert 'One' to TestEnum::type... fail\00", align 1
@.str2 = private unnamed_addr constant [49 x i8] c"Successfully converted 'One' to TestEnum::type: \00", align 1
@.str3 = private unnamed_addr constant [7 x i8] c"... ok\00", align 1
@.str4 = private unnamed_addr constant [62 x i8] c"Unknown exception caught converting 'One' to TestEnum... fail\00", align 1
@.str5 = private unnamed_addr constant [4 x i8] c"Two\00", align 1
@.str6 = private unnamed_addr constant [48 x i8] c"Failed to convert 'Two' to TestEnum::type... ok\00", align 1
@.str7 = private unnamed_addr constant [49 x i8] c"Successfully converted 'Two' to TestEnum::type: \00", align 1
@.str8 = private unnamed_addr constant [9 x i8] c"... fail\00", align 1
@.str9 = private unnamed_addr constant [62 x i8] c"Unknown exception caught converting 'Two' to TestEnum... fail\00", align 1
@_ZTINSt8ios_base7failureE = external constant i8*
@.str10 = private unnamed_addr constant [6 x i8] c"Three\00", align 1
@.str11 = private unnamed_addr constant [72 x i8] c"No exception thrown; Failed to convert 'Three' to TestEnum::type...fail\00", align 1
@.str12 = private unnamed_addr constant [51 x i8] c"Successfully converted 'Three' to TestEnum::type: \00", align 1
@.str13 = private unnamed_addr constant [64 x i8] c"Unknown exception caught converting 'Three' to TestEnum... fail\00", align 1
@.str14 = private unnamed_addr constant [19 x i8] c"Caught exception: \00", align 1
@_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [10 x i8*]
@_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [4 x i8*]
@_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt15basic_streambufIcSt11char_traitsIcEE = external unnamed_addr constant [16 x i8*]
@_ZTVSt9basic_iosIcSt11char_traitsIcEE = external unnamed_addr constant [4 x i8*]
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@.str15 = private unnamed_addr constant [5 x i8] c"Zero\00", align 1
@_ZTISt9exception = external constant i8*
@_ZTVSt9exception = external unnamed_addr constant [5 x i8*]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: uwtable
define i32 @main() #2 {
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
  %iss = alloca %"class.std::basic_istringstream", align 8
  %13 = alloca %"class.std::basic_string", align 8
  %14 = alloca %"class.std::allocator", align 1
  %value = alloca i32, align 4
  %iss1 = alloca %"class.std::basic_istringstream", align 8
  %15 = alloca %"class.std::basic_string", align 8
  %16 = alloca %"class.std::allocator", align 1
  %value2 = alloca i32, align 4
  %iss3 = alloca %"class.std::basic_istringstream", align 8
  %17 = alloca %"class.std::basic_string", align 8
  %18 = alloca %"class.std::allocator", align 1
  %value4 = alloca i32, align 4
  %19 = bitcast %"class.std::basic_istringstream"* %iss to i8*
  call void @llvm.lifetime.start(i64 360, i8* %19) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %13, i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %14)
          to label %20 unwind label %78

; <label>:20                                      ; preds = %0
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss, %"class.std::basic_string"* %13, i32 8)
          to label %21 unwind label %81

; <label>:21                                      ; preds = %20
  %22 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %22)
  %23 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %24 = load i8** %23, align 8, !tbaa !1
  %25 = getelementptr inbounds i8* %24, i64 -24
  %26 = bitcast i8* %25 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %27 = icmp eq i8* %25, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %27, label %40, label %28, !prof !7

; <label>:28                                      ; preds = %21
  %29 = getelementptr inbounds i8* %24, i64 -8
  %30 = bitcast i8* %29 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %31, label %35

; <label>:31                                      ; preds = %28
  %32 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %32)
  %33 = atomicrmw volatile add i32* %30, i32 -1 acq_rel
  store i32 %33, i32* %11, align 4
  %34 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %32)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:35                                      ; preds = %28
  %36 = load i32* %30, align 4, !tbaa !8
  %37 = add nsw i32 %36, -1
  store i32 %37, i32* %30, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %35, %31
  %.0.i.i.i.i = phi i32 [ %34, %31 ], [ %36, %35 ]
  %38 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %38, label %39, label %40

; <label>:39                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %26, %"class.std::allocator"* %12) #1
  br label %40

; <label>:40                                      ; preds = %39, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %21
  call void @llvm.lifetime.end(i64 1, i8* %22)
  store i32 0, i32* %value, align 4, !tbaa !10
  %41 = bitcast %"class.std::basic_istringstream"* %iss to %"class.std::basic_istream"*
  invoke fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %41, i32* %value)
          to label %42 unwind label %102

; <label>:42                                      ; preds = %40
  %43 = bitcast %"class.std::basic_istringstream"* %iss to i8**
  %44 = load i8** %43, align 8, !tbaa !11
  %45 = getelementptr i8* %44, i64 -24
  %46 = bitcast i8* %45 to i64*
  %47 = load i64* %46, align 8
  %.sum226 = add i64 %47, 32
  %48 = getelementptr inbounds i8* %19, i64 %.sum226
  %49 = bitcast i8* %48 to i32*
  %50 = load i32* %49, align 4, !tbaa !13
  %51 = and i32 %50, 5
  %52 = icmp eq i32 %51, 0
  br i1 %52, label %105, label %53

; <label>:53                                      ; preds = %42
  %54 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([50 x i8]* @.str1, i64 0, i64 0), i64 49)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %102

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %53
  %55 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %56 = getelementptr i8* %55, i64 -24
  %57 = bitcast i8* %56 to i64*
  %58 = load i64* %57, align 8
  %.sum228 = add i64 %58, 240
  %59 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum228
  %60 = bitcast i8* %59 to %"class.std::ctype"**
  %61 = load %"class.std::ctype"** %60, align 8, !tbaa !20
  %62 = icmp eq %"class.std::ctype"* %61, null
  br i1 %62, label %63, label %.noexc147

; <label>:63                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc201 unwind label %102

.noexc201:                                        ; preds = %63
  unreachable

.noexc147:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %64 = getelementptr inbounds %"class.std::ctype"* %61, i64 0, i32 6
  %65 = load i8* %64, align 1, !tbaa !23
  %66 = icmp eq i8 %65, 0
  br i1 %66, label %70, label %67

; <label>:67                                      ; preds = %.noexc147
  %68 = getelementptr inbounds %"class.std::ctype"* %61, i64 0, i32 7, i64 10
  %69 = load i8* %68, align 1, !tbaa !10
  br label %.noexc14

; <label>:70                                      ; preds = %.noexc147
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %61)
          to label %.noexc151 unwind label %102

.noexc151:                                        ; preds = %70
  %71 = bitcast %"class.std::ctype"* %61 to i8 (%"class.std::ctype"*, i8)***
  %72 = load i8 (%"class.std::ctype"*, i8)*** %71, align 8, !tbaa !11
  %73 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %72, i64 6
  %74 = load i8 (%"class.std::ctype"*, i8)** %73, align 8
  %75 = invoke signext i8 %74(%"class.std::ctype"* %61, i8 signext 10)
          to label %.noexc14 unwind label %102

.noexc14:                                         ; preds = %.noexc151, %67
  %.0.i150 = phi i8 [ %69, %67 ], [ %75, %.noexc151 ]
  %76 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i150)
          to label %.noexc15 unwind label %102

.noexc15:                                         ; preds = %.noexc14
  %77 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %76)
          to label %_ZNSolsEPFRSoS_E.exit13 unwind label %102

; <label>:78                                      ; preds = %0
  %79 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %80 = extractvalue { i8*, i32 } %79, 0
  br label %_ZNSsD1Ev.exit22

; <label>:81                                      ; preds = %20
  %82 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %83 = extractvalue { i8*, i32 } %82, 0
  %84 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %84)
  %85 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %86 = load i8** %85, align 8, !tbaa !1
  %87 = getelementptr inbounds i8* %86, i64 -24
  %88 = bitcast i8* %87 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %89 = icmp eq i8* %87, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %89, label %_ZNSsD1Ev.exit22, label %90, !prof !7

; <label>:90                                      ; preds = %81
  %91 = getelementptr inbounds i8* %86, i64 -8
  %92 = bitcast i8* %91 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %93, label %97

; <label>:93                                      ; preds = %90
  %94 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %94)
  %95 = atomicrmw volatile add i32* %92, i32 -1 acq_rel
  store i32 %95, i32* %9, align 4
  %96 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %94)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21

; <label>:97                                      ; preds = %90
  %98 = load i32* %92, align 4, !tbaa !8
  %99 = add nsw i32 %98, -1
  store i32 %99, i32* %92, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21: ; preds = %97, %93
  %.0.i.i.i.i20 = phi i32 [ %96, %93 ], [ %98, %97 ]
  %100 = icmp slt i32 %.0.i.i.i.i20, 1
  br i1 %100, label %101, label %_ZNSsD1Ev.exit22

; <label>:101                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %88, %"class.std::allocator"* %10) #1
  br label %_ZNSsD1Ev.exit22

; <label>:102                                     ; preds = %.noexc30, %.noexc29, %.noexc158, %128, %121, %109, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24, %105, %.noexc15, %.noexc14, %.noexc151, %70, %63, %53, %40
  %103 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %104 = extractvalue { i8*, i32 } %103, 0
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss)
          to label %_ZNSsD1Ev.exit22 unwind label %541

; <label>:105                                     ; preds = %42
  %106 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([49 x i8]* @.str2, i64 0, i64 0), i64 48)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24 unwind label %102

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24: ; preds = %105
  %107 = load i32* %value, align 4, !tbaa !10
  %108 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %107)
          to label %109 unwind label %102

; <label>:109                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24
  %110 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %108, i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 6)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit26 unwind label %102

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit26: ; preds = %109
  %111 = bitcast %"class.std::basic_ostream"* %108 to i8**
  %112 = load i8** %111, align 8, !tbaa !11
  %113 = getelementptr i8* %112, i64 -24
  %114 = bitcast i8* %113 to i64*
  %115 = load i64* %114, align 8
  %116 = bitcast %"class.std::basic_ostream"* %108 to i8*
  %.sum227 = add i64 %115, 240
  %117 = getelementptr inbounds i8* %116, i64 %.sum227
  %118 = bitcast i8* %117 to %"class.std::ctype"**
  %119 = load %"class.std::ctype"** %118, align 8, !tbaa !20
  %120 = icmp eq %"class.std::ctype"* %119, null
  br i1 %120, label %121, label %.noexc154

; <label>:121                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit26
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc203 unwind label %102

.noexc203:                                        ; preds = %121
  unreachable

.noexc154:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit26
  %122 = getelementptr inbounds %"class.std::ctype"* %119, i64 0, i32 6
  %123 = load i8* %122, align 1, !tbaa !23
  %124 = icmp eq i8 %123, 0
  br i1 %124, label %128, label %125

; <label>:125                                     ; preds = %.noexc154
  %126 = getelementptr inbounds %"class.std::ctype"* %119, i64 0, i32 7, i64 10
  %127 = load i8* %126, align 1, !tbaa !10
  br label %.noexc29

; <label>:128                                     ; preds = %.noexc154
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %119)
          to label %.noexc158 unwind label %102

.noexc158:                                        ; preds = %128
  %129 = bitcast %"class.std::ctype"* %119 to i8 (%"class.std::ctype"*, i8)***
  %130 = load i8 (%"class.std::ctype"*, i8)*** %129, align 8, !tbaa !11
  %131 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %130, i64 6
  %132 = load i8 (%"class.std::ctype"*, i8)** %131, align 8
  %133 = invoke signext i8 %132(%"class.std::ctype"* %119, i8 signext 10)
          to label %.noexc29 unwind label %102

.noexc29:                                         ; preds = %.noexc158, %125
  %.0.i157 = phi i8 [ %127, %125 ], [ %133, %.noexc158 ]
  %134 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %108, i8 signext %.0.i157)
          to label %.noexc30 unwind label %102

.noexc30:                                         ; preds = %.noexc29
  %135 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %134)
          to label %_ZNSolsEPFRSoS_E.exit13 unwind label %102

_ZNSolsEPFRSoS_E.exit13:                          ; preds = %.noexc30, %.noexc15
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss)
          to label %164 unwind label %136

; <label>:136                                     ; preds = %_ZNSolsEPFRSoS_E.exit13
  %137 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %138 = extractvalue { i8*, i32 } %137, 0
  br label %_ZNSsD1Ev.exit22

_ZNSsD1Ev.exit22:                                 ; preds = %136, %102, %101, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21, %81, %78
  %.1 = phi i8* [ %138, %136 ], [ %104, %102 ], [ %80, %78 ], [ %83, %81 ], [ %83, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21 ], [ %83, %101 ]
  %139 = call i8* @__cxa_begin_catch(i8* %.1) #1
  %140 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([62 x i8]* @.str4, i64 0, i64 0), i64 61)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit36 unwind label %224

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit36: ; preds = %_ZNSsD1Ev.exit22
  %141 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %142 = getelementptr i8* %141, i64 -24
  %143 = bitcast i8* %142 to i64*
  %144 = load i64* %143, align 8
  %.sum = add i64 %144, 240
  %145 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %146 = bitcast i8* %145 to %"class.std::ctype"**
  %147 = load %"class.std::ctype"** %146, align 8, !tbaa !20
  %148 = icmp eq %"class.std::ctype"* %147, null
  br i1 %148, label %149, label %.noexc48

; <label>:149                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit36
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc161 unwind label %224

.noexc161:                                        ; preds = %149
  unreachable

.noexc48:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit36
  %150 = getelementptr inbounds %"class.std::ctype"* %147, i64 0, i32 6
  %151 = load i8* %150, align 1, !tbaa !23
  %152 = icmp eq i8 %151, 0
  br i1 %152, label %156, label %153

; <label>:153                                     ; preds = %.noexc48
  %154 = getelementptr inbounds %"class.std::ctype"* %147, i64 0, i32 7, i64 10
  %155 = load i8* %154, align 1, !tbaa !10
  br label %.noexc39

; <label>:156                                     ; preds = %.noexc48
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %147)
          to label %.noexc50 unwind label %224

.noexc50:                                         ; preds = %156
  %157 = bitcast %"class.std::ctype"* %147 to i8 (%"class.std::ctype"*, i8)***
  %158 = load i8 (%"class.std::ctype"*, i8)*** %157, align 8, !tbaa !11
  %159 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %158, i64 6
  %160 = load i8 (%"class.std::ctype"*, i8)** %159, align 8
  %161 = invoke signext i8 %160(%"class.std::ctype"* %147, i8 signext 10)
          to label %.noexc39 unwind label %224

.noexc39:                                         ; preds = %.noexc50, %153
  %.0.i = phi i8 [ %155, %153 ], [ %161, %.noexc50 ]
  %162 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc40 unwind label %224

.noexc40:                                         ; preds = %.noexc39
  %163 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %162)
          to label %_ZNSolsEPFRSoS_E.exit38 unwind label %224

_ZNSolsEPFRSoS_E.exit38:                          ; preds = %.noexc40
  call void @__cxa_end_catch()
  br label %164

; <label>:164                                     ; preds = %_ZNSolsEPFRSoS_E.exit38, %_ZNSolsEPFRSoS_E.exit13
  %165 = bitcast %"class.std::basic_istringstream"* %iss1 to i8*
  call void @llvm.lifetime.start(i64 360, i8* %165) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %15, i8* getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), %"class.std::allocator"* %16)
          to label %166 unwind label %228

; <label>:166                                     ; preds = %164
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss1, %"class.std::basic_string"* %15, i32 8)
          to label %167 unwind label %231

; <label>:167                                     ; preds = %166
  %168 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %168)
  %169 = getelementptr inbounds %"class.std::basic_string"* %15, i64 0, i32 0, i32 0
  %170 = load i8** %169, align 8, !tbaa !1
  %171 = getelementptr inbounds i8* %170, i64 -24
  %172 = bitcast i8* %171 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %173 = icmp eq i8* %171, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %173, label %186, label %174, !prof !7

; <label>:174                                     ; preds = %167
  %175 = getelementptr inbounds i8* %170, i64 -8
  %176 = bitcast i8* %175 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %177, label %181

; <label>:177                                     ; preds = %174
  %178 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %178)
  %179 = atomicrmw volatile add i32* %176, i32 -1 acq_rel
  store i32 %179, i32* %7, align 4
  %180 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %178)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46

; <label>:181                                     ; preds = %174
  %182 = load i32* %176, align 4, !tbaa !8
  %183 = add nsw i32 %182, -1
  store i32 %183, i32* %176, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46: ; preds = %181, %177
  %.0.i.i.i.i45 = phi i32 [ %180, %177 ], [ %182, %181 ]
  %184 = icmp slt i32 %.0.i.i.i.i45, 1
  br i1 %184, label %185, label %186

; <label>:185                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %172, %"class.std::allocator"* %8) #1
  br label %186

; <label>:186                                     ; preds = %185, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46, %167
  call void @llvm.lifetime.end(i64 1, i8* %168)
  store i32 0, i32* %value2, align 4, !tbaa !10
  %187 = bitcast %"class.std::basic_istringstream"* %iss1 to %"class.std::basic_istream"*
  invoke fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %187, i32* %value2)
          to label %188 unwind label %252

; <label>:188                                     ; preds = %186
  %189 = bitcast %"class.std::basic_istringstream"* %iss1 to i8**
  %190 = load i8** %189, align 8, !tbaa !11
  %191 = getelementptr i8* %190, i64 -24
  %192 = bitcast i8* %191 to i64*
  %193 = load i64* %192, align 8
  %.sum223 = add i64 %193, 32
  %194 = getelementptr inbounds i8* %165, i64 %.sum223
  %195 = bitcast i8* %194 to i32*
  %196 = load i32* %195, align 4, !tbaa !13
  %197 = and i32 %196, 5
  %198 = icmp eq i32 %197, 0
  br i1 %198, label %255, label %199

; <label>:199                                     ; preds = %188
  %200 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([48 x i8]* @.str6, i64 0, i64 0), i64 47)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53 unwind label %252

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53: ; preds = %199
  %201 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %202 = getelementptr i8* %201, i64 -24
  %203 = bitcast i8* %202 to i64*
  %204 = load i64* %203, align 8
  %.sum225 = add i64 %204, 240
  %205 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum225
  %206 = bitcast i8* %205 to %"class.std::ctype"**
  %207 = load %"class.std::ctype"** %206, align 8, !tbaa !20
  %208 = icmp eq %"class.std::ctype"* %207, null
  br i1 %208, label %209, label %.noexc162

; <label>:209                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc205 unwind label %252

.noexc205:                                        ; preds = %209
  unreachable

.noexc162:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53
  %210 = getelementptr inbounds %"class.std::ctype"* %207, i64 0, i32 6
  %211 = load i8* %210, align 1, !tbaa !23
  %212 = icmp eq i8 %211, 0
  br i1 %212, label %216, label %213

; <label>:213                                     ; preds = %.noexc162
  %214 = getelementptr inbounds %"class.std::ctype"* %207, i64 0, i32 7, i64 10
  %215 = load i8* %214, align 1, !tbaa !10
  br label %.noexc56

; <label>:216                                     ; preds = %.noexc162
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %207)
          to label %.noexc166 unwind label %252

.noexc166:                                        ; preds = %216
  %217 = bitcast %"class.std::ctype"* %207 to i8 (%"class.std::ctype"*, i8)***
  %218 = load i8 (%"class.std::ctype"*, i8)*** %217, align 8, !tbaa !11
  %219 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %218, i64 6
  %220 = load i8 (%"class.std::ctype"*, i8)** %219, align 8
  %221 = invoke signext i8 %220(%"class.std::ctype"* %207, i8 signext 10)
          to label %.noexc56 unwind label %252

.noexc56:                                         ; preds = %.noexc166, %213
  %.0.i165 = phi i8 [ %215, %213 ], [ %221, %.noexc166 ]
  %222 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i165)
          to label %.noexc57 unwind label %252

.noexc57:                                         ; preds = %.noexc56
  %223 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %222)
          to label %_ZNSolsEPFRSoS_E.exit55 unwind label %252

; <label>:224                                     ; preds = %.noexc40, %.noexc39, %.noexc50, %156, %149, %_ZNSsD1Ev.exit22
  %225 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %226 = extractvalue { i8*, i32 } %225, 0
  %227 = extractvalue { i8*, i32 } %225, 1
  invoke void @__cxa_end_catch()
          to label %538 unwind label %541

; <label>:228                                     ; preds = %164
  %229 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %230 = extractvalue { i8*, i32 } %229, 0
  br label %_ZNSsD1Ev.exit64

; <label>:231                                     ; preds = %166
  %232 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %233 = extractvalue { i8*, i32 } %232, 0
  %234 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %234)
  %235 = getelementptr inbounds %"class.std::basic_string"* %15, i64 0, i32 0, i32 0
  %236 = load i8** %235, align 8, !tbaa !1
  %237 = getelementptr inbounds i8* %236, i64 -24
  %238 = bitcast i8* %237 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %239 = icmp eq i8* %237, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %239, label %_ZNSsD1Ev.exit64, label %240, !prof !7

; <label>:240                                     ; preds = %231
  %241 = getelementptr inbounds i8* %236, i64 -8
  %242 = bitcast i8* %241 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %243, label %247

; <label>:243                                     ; preds = %240
  %244 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %244)
  %245 = atomicrmw volatile add i32* %242, i32 -1 acq_rel
  store i32 %245, i32* %5, align 4
  %246 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %244)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63

; <label>:247                                     ; preds = %240
  %248 = load i32* %242, align 4, !tbaa !8
  %249 = add nsw i32 %248, -1
  store i32 %249, i32* %242, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63: ; preds = %247, %243
  %.0.i.i.i.i62 = phi i32 [ %246, %243 ], [ %248, %247 ]
  %250 = icmp slt i32 %.0.i.i.i.i62, 1
  br i1 %250, label %251, label %_ZNSsD1Ev.exit64

; <label>:251                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %238, %"class.std::allocator"* %6) #1
  br label %_ZNSsD1Ev.exit64

; <label>:252                                     ; preds = %.noexc72, %.noexc71, %.noexc173, %278, %271, %259, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66, %255, %.noexc57, %.noexc56, %.noexc166, %216, %209, %199, %186
  %253 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %254 = extractvalue { i8*, i32 } %253, 0
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss1)
          to label %_ZNSsD1Ev.exit64 unwind label %541

; <label>:255                                     ; preds = %188
  %256 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([49 x i8]* @.str7, i64 0, i64 0), i64 48)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66 unwind label %252

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66: ; preds = %255
  %257 = load i32* %value2, align 4, !tbaa !10
  %258 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %257)
          to label %259 unwind label %252

; <label>:259                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66
  %260 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %258, i8* getelementptr inbounds ([9 x i8]* @.str8, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit68 unwind label %252

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit68: ; preds = %259
  %261 = bitcast %"class.std::basic_ostream"* %258 to i8**
  %262 = load i8** %261, align 8, !tbaa !11
  %263 = getelementptr i8* %262, i64 -24
  %264 = bitcast i8* %263 to i64*
  %265 = load i64* %264, align 8
  %266 = bitcast %"class.std::basic_ostream"* %258 to i8*
  %.sum224 = add i64 %265, 240
  %267 = getelementptr inbounds i8* %266, i64 %.sum224
  %268 = bitcast i8* %267 to %"class.std::ctype"**
  %269 = load %"class.std::ctype"** %268, align 8, !tbaa !20
  %270 = icmp eq %"class.std::ctype"* %269, null
  br i1 %270, label %271, label %.noexc169

; <label>:271                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit68
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc207 unwind label %252

.noexc207:                                        ; preds = %271
  unreachable

.noexc169:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit68
  %272 = getelementptr inbounds %"class.std::ctype"* %269, i64 0, i32 6
  %273 = load i8* %272, align 1, !tbaa !23
  %274 = icmp eq i8 %273, 0
  br i1 %274, label %278, label %275

; <label>:275                                     ; preds = %.noexc169
  %276 = getelementptr inbounds %"class.std::ctype"* %269, i64 0, i32 7, i64 10
  %277 = load i8* %276, align 1, !tbaa !10
  br label %.noexc71

; <label>:278                                     ; preds = %.noexc169
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %269)
          to label %.noexc173 unwind label %252

.noexc173:                                        ; preds = %278
  %279 = bitcast %"class.std::ctype"* %269 to i8 (%"class.std::ctype"*, i8)***
  %280 = load i8 (%"class.std::ctype"*, i8)*** %279, align 8, !tbaa !11
  %281 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %280, i64 6
  %282 = load i8 (%"class.std::ctype"*, i8)** %281, align 8
  %283 = invoke signext i8 %282(%"class.std::ctype"* %269, i8 signext 10)
          to label %.noexc71 unwind label %252

.noexc71:                                         ; preds = %.noexc173, %275
  %.0.i172 = phi i8 [ %277, %275 ], [ %283, %.noexc173 ]
  %284 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %258, i8 signext %.0.i172)
          to label %.noexc72 unwind label %252

.noexc72:                                         ; preds = %.noexc71
  %285 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %284)
          to label %_ZNSolsEPFRSoS_E.exit55 unwind label %252

_ZNSolsEPFRSoS_E.exit55:                          ; preds = %.noexc72, %.noexc57
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss1)
          to label %314 unwind label %286

; <label>:286                                     ; preds = %_ZNSolsEPFRSoS_E.exit55
  %287 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %288 = extractvalue { i8*, i32 } %287, 0
  br label %_ZNSsD1Ev.exit64

_ZNSsD1Ev.exit64:                                 ; preds = %286, %252, %251, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63, %231, %228
  %.3 = phi i8* [ %288, %286 ], [ %254, %252 ], [ %230, %228 ], [ %233, %231 ], [ %233, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63 ], [ %233, %251 ]
  %289 = call i8* @__cxa_begin_catch(i8* %.3) #1
  %290 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([62 x i8]* @.str9, i64 0, i64 0), i64 61)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit78 unwind label %385

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit78: ; preds = %_ZNSsD1Ev.exit64
  %291 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %292 = getelementptr i8* %291, i64 -24
  %293 = bitcast i8* %292 to i64*
  %294 = load i64* %293, align 8
  %.sum215 = add i64 %294, 240
  %295 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum215
  %296 = bitcast i8* %295 to %"class.std::ctype"**
  %297 = load %"class.std::ctype"** %296, align 8, !tbaa !20
  %298 = icmp eq %"class.std::ctype"* %297, null
  br i1 %298, label %299, label %.noexc90

; <label>:299                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit78
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc176 unwind label %385

.noexc176:                                        ; preds = %299
  unreachable

.noexc90:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit78
  %300 = getelementptr inbounds %"class.std::ctype"* %297, i64 0, i32 6
  %301 = load i8* %300, align 1, !tbaa !23
  %302 = icmp eq i8 %301, 0
  br i1 %302, label %306, label %303

; <label>:303                                     ; preds = %.noexc90
  %304 = getelementptr inbounds %"class.std::ctype"* %297, i64 0, i32 7, i64 10
  %305 = load i8* %304, align 1, !tbaa !10
  br label %.noexc81

; <label>:306                                     ; preds = %.noexc90
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %297)
          to label %.noexc94 unwind label %385

.noexc94:                                         ; preds = %306
  %307 = bitcast %"class.std::ctype"* %297 to i8 (%"class.std::ctype"*, i8)***
  %308 = load i8 (%"class.std::ctype"*, i8)*** %307, align 8, !tbaa !11
  %309 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %308, i64 6
  %310 = load i8 (%"class.std::ctype"*, i8)** %309, align 8
  %311 = invoke signext i8 %310(%"class.std::ctype"* %297, i8 signext 10)
          to label %.noexc81 unwind label %385

.noexc81:                                         ; preds = %.noexc94, %303
  %.0.i93 = phi i8 [ %305, %303 ], [ %311, %.noexc94 ]
  %312 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i93)
          to label %.noexc82 unwind label %385

.noexc82:                                         ; preds = %.noexc81
  %313 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %312)
          to label %_ZNSolsEPFRSoS_E.exit80 unwind label %385

_ZNSolsEPFRSoS_E.exit80:                          ; preds = %.noexc82
  call void @__cxa_end_catch()
  br label %314

; <label>:314                                     ; preds = %_ZNSolsEPFRSoS_E.exit80, %_ZNSolsEPFRSoS_E.exit55
  %315 = bitcast %"class.std::basic_istringstream"* %iss3 to i8*
  call void @llvm.lifetime.start(i64 360, i8* %315) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %17, i8* getelementptr inbounds ([6 x i8]* @.str10, i64 0, i64 0), %"class.std::allocator"* %18)
          to label %316 unwind label %389

; <label>:316                                     ; preds = %314
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss3, %"class.std::basic_string"* %17, i32 8)
          to label %317 unwind label %393

; <label>:317                                     ; preds = %316
  %318 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %318)
  %319 = getelementptr inbounds %"class.std::basic_string"* %17, i64 0, i32 0, i32 0
  %320 = load i8** %319, align 8, !tbaa !1
  %321 = getelementptr inbounds i8* %320, i64 -24
  %322 = bitcast i8* %321 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %323 = icmp eq i8* %321, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %323, label %336, label %324, !prof !7

; <label>:324                                     ; preds = %317
  %325 = getelementptr inbounds i8* %320, i64 -8
  %326 = bitcast i8* %325 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %327, label %331

; <label>:327                                     ; preds = %324
  %328 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %328)
  %329 = atomicrmw volatile add i32* %326, i32 -1 acq_rel
  store i32 %329, i32* %3, align 4
  %330 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %328)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i88

; <label>:331                                     ; preds = %324
  %332 = load i32* %326, align 4, !tbaa !8
  %333 = add nsw i32 %332, -1
  store i32 %333, i32* %326, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i88

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i88: ; preds = %331, %327
  %.0.i.i.i.i87 = phi i32 [ %330, %327 ], [ %332, %331 ]
  %334 = icmp slt i32 %.0.i.i.i.i87, 1
  br i1 %334, label %335, label %336

; <label>:335                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i88
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %322, %"class.std::allocator"* %4) #1
  br label %336

; <label>:336                                     ; preds = %335, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i88, %317
  call void @llvm.lifetime.end(i64 1, i8* %318)
  store i32 0, i32* %value4, align 4, !tbaa !10
  %337 = bitcast %"class.std::basic_istringstream"* %iss3 to i8**
  %338 = load i8** %337, align 8, !tbaa !11
  %339 = getelementptr i8* %338, i64 -24
  %340 = bitcast i8* %339 to i64*
  %341 = load i64* %340, align 8
  %342 = getelementptr inbounds i8* %315, i64 %341
  %343 = bitcast i8* %342 to %"class.std::basic_ios"*
  %.sum218 = add i64 %341, 28
  %344 = getelementptr inbounds i8* %315, i64 %.sum218
  %345 = bitcast i8* %344 to i32*
  store i32 4, i32* %345, align 4, !tbaa !25
  %.sum219 = add i64 %341, 32
  %346 = getelementptr inbounds i8* %315, i64 %.sum219
  %347 = bitcast i8* %346 to i32*
  %348 = load i32* %347, align 4, !tbaa !13
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %343, i32 %348)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit unwind label %415

_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit: ; preds = %336
  %349 = bitcast %"class.std::basic_istringstream"* %iss3 to %"class.std::basic_istream"*
  invoke fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %349, i32* %value4)
          to label %350 unwind label %415

; <label>:350                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit
  %351 = load i8** %337, align 8, !tbaa !11
  %352 = getelementptr i8* %351, i64 -24
  %353 = bitcast i8* %352 to i64*
  %354 = load i64* %353, align 8
  %.sum220 = add i64 %354, 32
  %355 = getelementptr inbounds i8* %315, i64 %.sum220
  %356 = bitcast i8* %355 to i32*
  %357 = load i32* %356, align 4, !tbaa !13
  %358 = and i32 %357, 5
  %359 = icmp eq i32 %358, 0
  br i1 %359, label %419, label %360

; <label>:360                                     ; preds = %350
  %361 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0), i64 71)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99 unwind label %415

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99: ; preds = %360
  %362 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %363 = getelementptr i8* %362, i64 -24
  %364 = bitcast i8* %363 to i64*
  %365 = load i64* %364, align 8
  %.sum222 = add i64 %365, 240
  %366 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum222
  %367 = bitcast i8* %366 to %"class.std::ctype"**
  %368 = load %"class.std::ctype"** %367, align 8, !tbaa !20
  %369 = icmp eq %"class.std::ctype"* %368, null
  br i1 %369, label %370, label %.noexc178

; <label>:370                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc209 unwind label %415

.noexc209:                                        ; preds = %370
  unreachable

.noexc178:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99
  %371 = getelementptr inbounds %"class.std::ctype"* %368, i64 0, i32 6
  %372 = load i8* %371, align 1, !tbaa !23
  %373 = icmp eq i8 %372, 0
  br i1 %373, label %377, label %374

; <label>:374                                     ; preds = %.noexc178
  %375 = getelementptr inbounds %"class.std::ctype"* %368, i64 0, i32 7, i64 10
  %376 = load i8* %375, align 1, !tbaa !10
  br label %.noexc102

; <label>:377                                     ; preds = %.noexc178
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %368)
          to label %.noexc182 unwind label %415

.noexc182:                                        ; preds = %377
  %378 = bitcast %"class.std::ctype"* %368 to i8 (%"class.std::ctype"*, i8)***
  %379 = load i8 (%"class.std::ctype"*, i8)*** %378, align 8, !tbaa !11
  %380 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %379, i64 6
  %381 = load i8 (%"class.std::ctype"*, i8)** %380, align 8
  %382 = invoke signext i8 %381(%"class.std::ctype"* %368, i8 signext 10)
          to label %.noexc102 unwind label %415

.noexc102:                                        ; preds = %.noexc182, %374
  %.0.i181 = phi i8 [ %376, %374 ], [ %382, %.noexc182 ]
  %383 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i181)
          to label %.noexc103 unwind label %415

.noexc103:                                        ; preds = %.noexc102
  %384 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %383)
          to label %_ZNSolsEPFRSoS_E.exit101 unwind label %415

; <label>:385                                     ; preds = %.noexc82, %.noexc81, %.noexc94, %306, %299, %_ZNSsD1Ev.exit64
  %386 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %387 = extractvalue { i8*, i32 } %386, 0
  %388 = extractvalue { i8*, i32 } %386, 1
  invoke void @__cxa_end_catch()
          to label %538 unwind label %541

; <label>:389                                     ; preds = %314
  %390 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %391 = extractvalue { i8*, i32 } %390, 0
  %392 = extractvalue { i8*, i32 } %390, 1
  br label %_ZNSsD1Ev.exit110

; <label>:393                                     ; preds = %316
  %394 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %395 = extractvalue { i8*, i32 } %394, 0
  %396 = extractvalue { i8*, i32 } %394, 1
  %397 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %397)
  %398 = getelementptr inbounds %"class.std::basic_string"* %17, i64 0, i32 0, i32 0
  %399 = load i8** %398, align 8, !tbaa !1
  %400 = getelementptr inbounds i8* %399, i64 -24
  %401 = bitcast i8* %400 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %402 = icmp eq i8* %400, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %402, label %_ZNSsD1Ev.exit110, label %403, !prof !7

; <label>:403                                     ; preds = %393
  %404 = getelementptr inbounds i8* %399, i64 -8
  %405 = bitcast i8* %404 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %406, label %410

; <label>:406                                     ; preds = %403
  %407 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %407)
  %408 = atomicrmw volatile add i32* %405, i32 -1 acq_rel
  store i32 %408, i32* %1, align 4
  %409 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %407)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109

; <label>:410                                     ; preds = %403
  %411 = load i32* %405, align 4, !tbaa !8
  %412 = add nsw i32 %411, -1
  store i32 %412, i32* %405, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109: ; preds = %410, %406
  %.0.i.i.i.i108 = phi i32 [ %409, %406 ], [ %411, %410 ]
  %413 = icmp slt i32 %.0.i.i.i.i108, 1
  br i1 %413, label %414, label %_ZNSsD1Ev.exit110

; <label>:414                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %401, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit110

; <label>:415                                     ; preds = %.noexc118, %.noexc117, %.noexc189, %442, %435, %423, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112, %419, %.noexc103, %.noexc102, %.noexc182, %377, %370, %360, %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit, %336
  %416 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %417 = extractvalue { i8*, i32 } %416, 0
  %418 = extractvalue { i8*, i32 } %416, 1
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss3)
          to label %_ZNSsD1Ev.exit110 unwind label %541

; <label>:419                                     ; preds = %350
  %420 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([51 x i8]* @.str12, i64 0, i64 0), i64 50)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112 unwind label %415

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112: ; preds = %419
  %421 = load i32* %value4, align 4, !tbaa !10
  %422 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %421)
          to label %423 unwind label %415

; <label>:423                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112
  %424 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %422, i8* getelementptr inbounds ([9 x i8]* @.str8, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit114 unwind label %415

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit114: ; preds = %423
  %425 = bitcast %"class.std::basic_ostream"* %422 to i8**
  %426 = load i8** %425, align 8, !tbaa !11
  %427 = getelementptr i8* %426, i64 -24
  %428 = bitcast i8* %427 to i64*
  %429 = load i64* %428, align 8
  %430 = bitcast %"class.std::basic_ostream"* %422 to i8*
  %.sum221 = add i64 %429, 240
  %431 = getelementptr inbounds i8* %430, i64 %.sum221
  %432 = bitcast i8* %431 to %"class.std::ctype"**
  %433 = load %"class.std::ctype"** %432, align 8, !tbaa !20
  %434 = icmp eq %"class.std::ctype"* %433, null
  br i1 %434, label %435, label %.noexc185

; <label>:435                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit114
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc211 unwind label %415

.noexc211:                                        ; preds = %435
  unreachable

.noexc185:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit114
  %436 = getelementptr inbounds %"class.std::ctype"* %433, i64 0, i32 6
  %437 = load i8* %436, align 1, !tbaa !23
  %438 = icmp eq i8 %437, 0
  br i1 %438, label %442, label %439

; <label>:439                                     ; preds = %.noexc185
  %440 = getelementptr inbounds %"class.std::ctype"* %433, i64 0, i32 7, i64 10
  %441 = load i8* %440, align 1, !tbaa !10
  br label %.noexc117

; <label>:442                                     ; preds = %.noexc185
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %433)
          to label %.noexc189 unwind label %415

.noexc189:                                        ; preds = %442
  %443 = bitcast %"class.std::ctype"* %433 to i8 (%"class.std::ctype"*, i8)***
  %444 = load i8 (%"class.std::ctype"*, i8)*** %443, align 8, !tbaa !11
  %445 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %444, i64 6
  %446 = load i8 (%"class.std::ctype"*, i8)** %445, align 8
  %447 = invoke signext i8 %446(%"class.std::ctype"* %433, i8 signext 10)
          to label %.noexc117 unwind label %415

.noexc117:                                        ; preds = %.noexc189, %439
  %.0.i188 = phi i8 [ %441, %439 ], [ %447, %.noexc189 ]
  %448 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %422, i8 signext %.0.i188)
          to label %.noexc118 unwind label %415

.noexc118:                                        ; preds = %.noexc117
  %449 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %448)
          to label %_ZNSolsEPFRSoS_E.exit101 unwind label %415

_ZNSolsEPFRSoS_E.exit101:                         ; preds = %.noexc118, %.noexc103
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss3)
          to label %504 unwind label %450

; <label>:450                                     ; preds = %_ZNSolsEPFRSoS_E.exit101
  %451 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %452 = extractvalue { i8*, i32 } %451, 0
  %453 = extractvalue { i8*, i32 } %451, 1
  br label %_ZNSsD1Ev.exit110

_ZNSsD1Ev.exit110:                                ; preds = %450, %415, %414, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109, %393, %389
  %.16 = phi i32 [ %453, %450 ], [ %418, %415 ], [ %392, %389 ], [ %396, %393 ], [ %396, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109 ], [ %396, %414 ]
  %.5 = phi i8* [ %452, %450 ], [ %417, %415 ], [ %391, %389 ], [ %395, %393 ], [ %395, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109 ], [ %395, %414 ]
  %454 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #1
  %455 = icmp eq i32 %.16, %454
  %456 = call i8* @__cxa_begin_catch(i8* %.5) #1
  br i1 %455, label %457, label %505

; <label>:457                                     ; preds = %_ZNSsD1Ev.exit110
  %458 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str14, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit124 unwind label %534

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit124: ; preds = %457
  %459 = bitcast i8* %456 to %"class.std::ios_base::failure"*
  %460 = bitcast i8* %456 to i8* (%"class.std::ios_base::failure"*)***
  %461 = load i8* (%"class.std::ios_base::failure"*)*** %460, align 8, !tbaa !11
  %462 = getelementptr inbounds i8* (%"class.std::ios_base::failure"*)** %461, i64 2
  %463 = load i8* (%"class.std::ios_base::failure"*)** %462, align 8
  %464 = call i8* %463(%"class.std::ios_base::failure"* %459) #1
  %465 = icmp eq i8* %464, null
  br i1 %465, label %466, label %477

; <label>:466                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit124
  %467 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %468 = getelementptr i8* %467, i64 -24
  %469 = bitcast i8* %468 to i64*
  %470 = load i64* %469, align 8
  %471 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %470
  %472 = bitcast i8* %471 to %"class.std::basic_ios"*
  %.sum.i = add i64 %470, 32
  %473 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %474 = bitcast i8* %473 to i32*
  %475 = load i32* %474, align 4, !tbaa !13
  %476 = or i32 %475, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %472, i32 %476)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127 unwind label %534

; <label>:477                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit124
  %478 = call i64 @strlen(i8* %464) #1
  %479 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %464, i64 %478)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127 unwind label %534

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127: ; preds = %477, %466
  %480 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 6)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit129 unwind label %534

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit129: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127
  %481 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %482 = getelementptr i8* %481, i64 -24
  %483 = bitcast i8* %482 to i64*
  %484 = load i64* %483, align 8
  %.sum217 = add i64 %484, 240
  %485 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum217
  %486 = bitcast i8* %485 to %"class.std::ctype"**
  %487 = load %"class.std::ctype"** %486, align 8, !tbaa !20
  %488 = icmp eq %"class.std::ctype"* %487, null
  br i1 %488, label %489, label %.noexc192

; <label>:489                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit129
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc213 unwind label %534

.noexc213:                                        ; preds = %489
  unreachable

.noexc192:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit129
  %490 = getelementptr inbounds %"class.std::ctype"* %487, i64 0, i32 6
  %491 = load i8* %490, align 1, !tbaa !23
  %492 = icmp eq i8 %491, 0
  br i1 %492, label %496, label %493

; <label>:493                                     ; preds = %.noexc192
  %494 = getelementptr inbounds %"class.std::ctype"* %487, i64 0, i32 7, i64 10
  %495 = load i8* %494, align 1, !tbaa !10
  br label %.noexc132

; <label>:496                                     ; preds = %.noexc192
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %487)
          to label %.noexc196 unwind label %534

.noexc196:                                        ; preds = %496
  %497 = bitcast %"class.std::ctype"* %487 to i8 (%"class.std::ctype"*, i8)***
  %498 = load i8 (%"class.std::ctype"*, i8)*** %497, align 8, !tbaa !11
  %499 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %498, i64 6
  %500 = load i8 (%"class.std::ctype"*, i8)** %499, align 8
  %501 = invoke signext i8 %500(%"class.std::ctype"* %487, i8 signext 10)
          to label %.noexc132 unwind label %534

.noexc132:                                        ; preds = %.noexc196, %493
  %.0.i195 = phi i8 [ %495, %493 ], [ %501, %.noexc196 ]
  %502 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i195)
          to label %.noexc133 unwind label %534

.noexc133:                                        ; preds = %.noexc132
  %503 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %502)
          to label %_ZNSolsEPFRSoS_E.exit131 unwind label %534

_ZNSolsEPFRSoS_E.exit131:                         ; preds = %.noexc133
  call void @__cxa_end_catch()
  br label %504

; <label>:504                                     ; preds = %_ZNSolsEPFRSoS_E.exit, %_ZNSolsEPFRSoS_E.exit131, %_ZNSolsEPFRSoS_E.exit101
  ret i32 0

; <label>:505                                     ; preds = %_ZNSsD1Ev.exit110
  %506 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([64 x i8]* @.str13, i64 0, i64 0), i64 63)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139 unwind label %530

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139: ; preds = %505
  %507 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %508 = getelementptr i8* %507, i64 -24
  %509 = bitcast i8* %508 to i64*
  %510 = load i64* %509, align 8
  %.sum216 = add i64 %510, 240
  %511 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum216
  %512 = bitcast i8* %511 to %"class.std::ctype"**
  %513 = load %"class.std::ctype"** %512, align 8, !tbaa !20
  %514 = icmp eq %"class.std::ctype"* %513, null
  br i1 %514, label %515, label %.noexc140

; <label>:515                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139
  invoke void @_ZSt16__throw_bad_castv() #8
          to label %.noexc199 unwind label %530

.noexc199:                                        ; preds = %515
  unreachable

.noexc140:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139
  %516 = getelementptr inbounds %"class.std::ctype"* %513, i64 0, i32 6
  %517 = load i8* %516, align 1, !tbaa !23
  %518 = icmp eq i8 %517, 0
  br i1 %518, label %522, label %519

; <label>:519                                     ; preds = %.noexc140
  %520 = getelementptr inbounds %"class.std::ctype"* %513, i64 0, i32 7, i64 10
  %521 = load i8* %520, align 1, !tbaa !10
  br label %.noexc

; <label>:522                                     ; preds = %.noexc140
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %513)
          to label %.noexc144 unwind label %530

.noexc144:                                        ; preds = %522
  %523 = bitcast %"class.std::ctype"* %513 to i8 (%"class.std::ctype"*, i8)***
  %524 = load i8 (%"class.std::ctype"*, i8)*** %523, align 8, !tbaa !11
  %525 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %524, i64 6
  %526 = load i8 (%"class.std::ctype"*, i8)** %525, align 8
  %527 = invoke signext i8 %526(%"class.std::ctype"* %513, i8 signext 10)
          to label %.noexc unwind label %530

.noexc:                                           ; preds = %.noexc144, %519
  %.0.i143 = phi i8 [ %521, %519 ], [ %527, %.noexc144 ]
  %528 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i143)
          to label %.noexc8 unwind label %530

.noexc8:                                          ; preds = %.noexc
  %529 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %528)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %530

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc8
  call void @__cxa_end_catch()
  br label %504

; <label>:530                                     ; preds = %.noexc8, %.noexc, %.noexc144, %522, %515, %505
  %531 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %532 = extractvalue { i8*, i32 } %531, 0
  %533 = extractvalue { i8*, i32 } %531, 1
  invoke void @__cxa_end_catch()
          to label %538 unwind label %541

; <label>:534                                     ; preds = %.noexc133, %.noexc132, %.noexc196, %496, %489, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127, %477, %466, %457
  %535 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %536 = extractvalue { i8*, i32 } %535, 0
  %537 = extractvalue { i8*, i32 } %535, 1
  invoke void @__cxa_end_catch()
          to label %538 unwind label %541

; <label>:538                                     ; preds = %534, %530, %385, %224
  %.27 = phi i32 [ %537, %534 ], [ %533, %530 ], [ %388, %385 ], [ %227, %224 ]
  %.6 = phi i8* [ %536, %534 ], [ %532, %530 ], [ %387, %385 ], [ %226, %224 ]
  %539 = insertvalue { i8*, i32 } undef, i8* %.6, 0
  %540 = insertvalue { i8*, i32 } %539, i32 %.27, 1
  resume { i8*, i32 } %540

; <label>:541                                     ; preds = %534, %530, %415, %385, %252, %224, %102
  %542 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %543 = extractvalue { i8*, i32 } %542, 0
  call void @__clang_call_terminate(i8* %543) #9
  unreachable
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = bitcast %"class.std::basic_istringstream"* %this to i8*
  %4 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2
  %5 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %5) #1
  %6 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([4 x i8*]* @_ZTVSt9basic_iosIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !11
  %7 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 1
  store %"class.std::basic_ostream"* null, %"class.std::basic_ostream"** %7, align 8, !tbaa !26
  %8 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 2
  store i8 0, i8* %8, align 1, !tbaa !27
  %9 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 3
  store i8 0, i8* %9, align 1, !tbaa !28
  %10 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 4
  %11 = bitcast %"class.std::basic_streambuf"** %10 to i8*
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 32, i32 8, i1 false) #1
  %12 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %13 = bitcast %"class.std::basic_istringstream"* %this to i8**
  %14 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 0
  %.c.i = bitcast i8* %12 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %14, align 8, !tbaa !11
  %15 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %16 = getelementptr i8* %12, i64 -24
  %17 = bitcast i8* %16 to i64*
  %18 = load i64* %17, align 8
  %19 = getelementptr inbounds i8* %3, i64 %18
  %20 = bitcast i8* %19 to i8**
  store i8* %15, i8** %20, align 8, !tbaa !11
  %21 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %21, align 8, !tbaa !29
  %22 = load i8** %13, align 8, !tbaa !11
  %23 = getelementptr i8* %22, i64 -24
  %24 = bitcast i8* %23 to i64*
  %25 = load i64* %24, align 8
  %26 = getelementptr inbounds i8* %3, i64 %25
  %27 = bitcast i8* %26 to %"class.std::basic_ios"*
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %27, %"class.std::basic_streambuf"* null)
          to label %_ZNSiC2Ev.exit unwind label %38

_ZNSiC2Ev.exit:                                   ; preds = %0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*]* @_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %14, align 8, !tbaa !11
  store i32 (...)** bitcast (i8** getelementptr inbounds ([10 x i8*]* @_ZTVSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 8) to i32 (...)**), i32 (...)*** %6, align 8, !tbaa !11
  %28 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1
  %29 = or i32 %__mode, 8
  invoke void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %28, %"class.std::basic_string"* %__str, i32 %29)
          to label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit unwind label %42

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit: ; preds = %_ZNSiC2Ev.exit
  %30 = load i8** %13, align 8, !tbaa !11
  %31 = getelementptr i8* %30, i64 -24
  %32 = bitcast i8* %31 to i64*
  %33 = load i64* %32, align 8
  %34 = getelementptr inbounds i8* %3, i64 %33
  %35 = bitcast i8* %34 to %"class.std::basic_ios"*
  %36 = getelementptr inbounds %"class.std::basic_stringbuf"* %28, i64 0, i32 0
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"* %35, %"class.std::basic_streambuf"* %36)
          to label %37 unwind label %46

; <label>:37                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit
  ret void

; <label>:38                                      ; preds = %0
  %39 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %40 = extractvalue { i8*, i32 } %39, 0
  %41 = extractvalue { i8*, i32 } %39, 1
  br label %78

; <label>:42                                      ; preds = %_ZNSiC2Ev.exit
  %43 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %44 = extractvalue { i8*, i32 } %43, 0
  %45 = extractvalue { i8*, i32 } %43, 1
  br label %70

; <label>:46                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode.exit
  %47 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %48 = extractvalue { i8*, i32 } %47, 0
  %49 = extractvalue { i8*, i32 } %47, 1
  %50 = getelementptr inbounds %"class.std::basic_stringbuf"* %28, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !11
  %51 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %51)
  %52 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %53 = load i8** %52, align 8, !tbaa !1
  %54 = getelementptr inbounds i8* %53, i64 -24
  %55 = bitcast i8* %54 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %56 = icmp eq i8* %54, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %56, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, label %57, !prof !7

; <label>:57                                      ; preds = %46
  %58 = getelementptr inbounds i8* %53, i64 -8
  %59 = bitcast i8* %58 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %60, label %64

; <label>:60                                      ; preds = %57
  %61 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %61)
  %62 = atomicrmw volatile add i32* %59, i32 -1 acq_rel
  store i32 %62, i32* %1, align 4
  %63 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %61)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:64                                      ; preds = %57
  %65 = load i32* %59, align 4, !tbaa !8
  %66 = add nsw i32 %65, -1
  store i32 %66, i32* %59, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %64, %60
  %.0.i.i.i.i.i = phi i32 [ %63, %60 ], [ %65, %64 ]
  %67 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %67, label %68, label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:68                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %55, %"class.std::allocator"* %2) #1
  br label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %68, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %46
  call void @llvm.lifetime.end(i64 1, i8* %51)
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !11
  %69 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %69) #1
  %.pre = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.pre4 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  br label %70

; <label>:70                                      ; preds = %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit, %42
  %71 = phi i8* [ %.pre4, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %15, %42 ]
  %72 = phi i8* [ %.pre, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %12, %42 ]
  %.01 = phi i8* [ %48, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %44, %42 ]
  %.0 = phi i32 [ %49, %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit ], [ %45, %42 ]
  %.c.i3 = bitcast i8* %72 to i32 (...)**
  store i32 (...)** %.c.i3, i32 (...)*** %14, align 8, !tbaa !11
  %73 = getelementptr i8* %72, i64 -24
  %74 = bitcast i8* %73 to i64*
  %75 = load i64* %74, align 8
  %76 = getelementptr inbounds i8* %3, i64 %75
  %77 = bitcast i8* %76 to i8**
  store i8* %71, i8** %77, align 8, !tbaa !11
  store i64 0, i64* %21, align 8, !tbaa !29
  br label %78

; <label>:78                                      ; preds = %70, %38
  %.12 = phi i8* [ %.01, %70 ], [ %40, %38 ]
  %.1 = phi i32 [ %.0, %70 ], [ %41, %38 ]
  invoke void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %5)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEED2Ev.exit unwind label %81

_ZNSt9basic_iosIcSt11char_traitsIcEED2Ev.exit:    ; preds = %78
  %79 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %80 = insertvalue { i8*, i32 } %79, i32 %.1, 1
  resume { i8*, i32 } %80

; <label>:81                                      ; preds = %78
  %82 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %83 = extractvalue { i8*, i32 } %82, 0
  call void @__clang_call_terminate(i8* %83) #9
  unreachable
}

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #3 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #9
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

; Function Attrs: uwtable
define internal fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %in, i32* nocapture %value) #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %raw = alloca %"class.std::basic_string", align 8
  %5 = getelementptr inbounds %"class.std::basic_string"* %raw, i64 0, i32 0, i32 0
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %5, align 8, !tbaa !31
  %6 = invoke %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"* %in, %"class.std::basic_string"* %raw)
          to label %7 unwind label %19

; <label>:7                                       ; preds = %0
  %8 = bitcast %"class.std::basic_istream"* %6 to i8**
  %9 = load i8** %8, align 8, !tbaa !11
  %10 = getelementptr i8* %9, i64 -24
  %11 = bitcast i8* %10 to i64*
  %12 = load i64* %11, align 8
  %13 = bitcast %"class.std::basic_istream"* %6 to i8*
  %.sum7 = add i64 %12, 32
  %14 = getelementptr inbounds i8* %13, i64 %.sum7
  %15 = bitcast i8* %14 to i32*
  %16 = load i32* %15, align 4, !tbaa !13
  %17 = and i32 %16, 5
  %18 = icmp eq i32 %17, 0
  br i1 %18, label %39, label %52

; <label>:19                                      ; preds = %49, %44, %39, %0
  %20 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %21 = extractvalue { i8*, i32 } %20, 0
  %22 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %22)
  %23 = load i8** %5, align 8, !tbaa !1
  %24 = getelementptr inbounds i8* %23, i64 -24
  %25 = bitcast i8* %24 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %26 = icmp eq i8* %24, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %26, label %70, label %27, !prof !7

; <label>:27                                      ; preds = %19
  %28 = getelementptr inbounds i8* %23, i64 -8
  %29 = bitcast i8* %28 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %30, label %34

; <label>:30                                      ; preds = %27
  %31 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %31)
  %32 = atomicrmw volatile add i32* %29, i32 -1 acq_rel
  store i32 %32, i32* %3, align 4
  %33 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %31)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:34                                      ; preds = %27
  %35 = load i32* %29, align 4, !tbaa !8
  %36 = add nsw i32 %35, -1
  store i32 %36, i32* %29, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %34, %30
  %.0.i.i.i.i = phi i32 [ %33, %30 ], [ %35, %34 ]
  %37 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %37, label %38, label %70

; <label>:38                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %25, %"class.std::allocator"* %4) #1
  br label %70

; <label>:39                                      ; preds = %7
  %40 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw, i8* getelementptr inbounds ([5 x i8]* @.str15, i64 0, i64 0))
          to label %41 unwind label %19

; <label>:41                                      ; preds = %39
  %42 = icmp eq i32 %40, 0
  br i1 %42, label %43, label %44

; <label>:43                                      ; preds = %41
  store i32 0, i32* %value, align 4, !tbaa !10
  br label %52

; <label>:44                                      ; preds = %41
  %45 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw, i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0))
          to label %46 unwind label %19

; <label>:46                                      ; preds = %44
  %47 = icmp eq i32 %45, 0
  br i1 %47, label %48, label %49

; <label>:48                                      ; preds = %46
  store i32 1, i32* %value, align 4, !tbaa !10
  br label %52

; <label>:49                                      ; preds = %46
  %50 = call i8* @__cxa_allocate_exception(i64 8) #1
  %51 = bitcast i8* %50 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVSt9exception, i64 0, i64 2) to i32 (...)**), i32 (...)*** %51, align 8, !tbaa !11
  invoke void @__cxa_throw(i8* %50, i8* bitcast (i8** @_ZTISt9exception to i8*), i8* bitcast (void (%"class.std::exception"*)* @_ZNSt9exceptionD1Ev to i8*)) #8
          to label %110 unwind label %19

; <label>:52                                      ; preds = %48, %43, %7
  %53 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %53)
  %54 = load i8** %5, align 8, !tbaa !1
  %55 = getelementptr inbounds i8* %54, i64 -24
  %56 = bitcast i8* %55 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %57 = icmp eq i8* %55, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %57, label %_ZNSsD1Ev.exit5, label %58, !prof !7

; <label>:58                                      ; preds = %52
  %59 = getelementptr inbounds i8* %54, i64 -8
  %60 = bitcast i8* %59 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %61, label %65

; <label>:61                                      ; preds = %58
  %62 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %62)
  %63 = atomicrmw volatile add i32* %60, i32 -1 acq_rel
  store i32 %63, i32* %1, align 4
  %64 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %62)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

; <label>:65                                      ; preds = %58
  %66 = load i32* %60, align 4, !tbaa !8
  %67 = add nsw i32 %66, -1
  store i32 %67, i32* %60, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4: ; preds = %65, %61
  %.0.i.i.i.i3 = phi i32 [ %64, %61 ], [ %66, %65 ]
  %68 = icmp slt i32 %.0.i.i.i.i3, 1
  br i1 %68, label %69, label %_ZNSsD1Ev.exit5

; <label>:69                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %56, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit5

; <label>:70                                      ; preds = %38, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %19
  call void @llvm.lifetime.end(i64 1, i8* %22)
  %71 = call i8* @__cxa_begin_catch(i8* %21) #1
  %72 = bitcast %"class.std::basic_istream"* %in to i8**
  %73 = load i8** %72, align 8, !tbaa !11
  %74 = getelementptr i8* %73, i64 -24
  %75 = bitcast i8* %74 to i64*
  %76 = load i64* %75, align 8
  %77 = bitcast %"class.std::basic_istream"* %in to i8*
  %78 = getelementptr inbounds i8* %77, i64 %76
  %79 = bitcast i8* %78 to %"class.std::basic_ios"*
  %.sum = add i64 %76, 28
  %80 = getelementptr inbounds i8* %77, i64 %.sum
  %81 = bitcast i8* %80 to i32*
  %82 = load i32* %81, align 4, !tbaa !25
  %83 = and i32 %82, 4
  %84 = icmp eq i32 %83, 0
  %.sum6 = add i64 %76, 32
  %85 = getelementptr inbounds i8* %77, i64 %.sum6
  %86 = bitcast i8* %85 to i32*
  %87 = load i32* %86, align 4, !tbaa !13
  %88 = or i32 %87, 4
  br i1 %84, label %102, label %89

; <label>:89                                      ; preds = %70
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %79, i32 %88)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2 unwind label %94

; <label>:90                                      ; preds = %102, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2, %100
  %91 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %92 = extractvalue { i8*, i32 } %91, 0
  %93 = extractvalue { i8*, i32 } %91, 1
  br label %103

; <label>:94                                      ; preds = %89
  %95 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
  %96 = extractvalue { i8*, i32 } %95, 0
  %97 = extractvalue { i8*, i32 } %95, 1
  %98 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #1
  %99 = icmp eq i32 %97, %98
  br i1 %99, label %100, label %103

; <label>:100                                     ; preds = %94
  %101 = call i8* @__cxa_begin_catch(i8* %96) #1
  invoke void @__cxa_end_catch()
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2 unwind label %90

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2: ; preds = %100, %89
  invoke void @__cxa_rethrow() #8
          to label %110 unwind label %90

; <label>:102                                     ; preds = %70
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %79, i32 %88)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit unwind label %90

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit: ; preds = %102
  call void @__cxa_end_catch()
  br label %_ZNSsD1Ev.exit5

; <label>:103                                     ; preds = %94, %90
  %.03 = phi i32 [ %93, %90 ], [ %97, %94 ]
  %.12 = phi i8* [ %92, %90 ], [ %96, %94 ]
  invoke void @__cxa_end_catch()
          to label %104 unwind label %107

_ZNSsD1Ev.exit5:                                  ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit, %69, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i4, %52
  ret void

; <label>:104                                     ; preds = %103
  %105 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %106 = insertvalue { i8*, i32 } %105, i32 %.03, 1
  resume { i8*, i32 } %106

; <label>:107                                     ; preds = %103
  %108 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %109 = extractvalue { i8*, i32 } %108, 0
  call void @__clang_call_terminate(i8* %109) #9
  unreachable

; <label>:110                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit2, %49
  unreachable
}

declare %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %this) unnamed_addr #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 0), align 8
  %4 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 0
  %.c.i = bitcast i8* %3 to i32 (...)**
  store i32 (...)** %.c.i, i32 (...)*** %4, align 8, !tbaa !11
  %5 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 3), align 8
  %6 = getelementptr i8* %3, i64 -24
  %7 = bitcast i8* %6 to i64*
  %8 = load i64* %7, align 8
  %9 = bitcast %"class.std::basic_istringstream"* %this to i8*
  %10 = getelementptr inbounds i8* %9, i64 %8
  %11 = bitcast i8* %10 to i8**
  store i8* %5, i8** %11, align 8, !tbaa !11
  %12 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !11
  %13 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %13)
  %14 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %15 = load i8** %14, align 8, !tbaa !1
  %16 = getelementptr inbounds i8* %15, i64 -24
  %17 = bitcast i8* %16 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %18 = icmp eq i8* %16, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %18, label %31, label %19, !prof !7

; <label>:19                                      ; preds = %0
  %20 = getelementptr inbounds i8* %15, i64 -8
  %21 = bitcast i8* %20 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %22, label %26

; <label>:22                                      ; preds = %19
  %23 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %23)
  %24 = atomicrmw volatile add i32* %21, i32 -1 acq_rel
  store i32 %24, i32* %1, align 4
  %25 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %23)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

; <label>:26                                      ; preds = %19
  %27 = load i32* %21, align 4, !tbaa !8
  %28 = add nsw i32 %27, -1
  store i32 %28, i32* %21, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i: ; preds = %26, %22
  %.0.i.i.i.i.i.i = phi i32 [ %25, %22 ], [ %27, %26 ]
  %29 = icmp slt i32 %.0.i.i.i.i.i.i, 1
  br i1 %29, label %30, label %31

; <label>:30                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %17, %"class.std::allocator"* %2) #1
  br label %31

; <label>:31                                      ; preds = %30, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %13)
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !11
  %32 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %32) #1
  %33 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.c.i.i = bitcast i8* %33 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %4, align 8, !tbaa !11
  %34 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %35 = getelementptr i8* %33, i64 -24
  %36 = bitcast i8* %35 to i64*
  %37 = load i64* %36, align 8
  %38 = getelementptr inbounds i8* %9, i64 %37
  %39 = bitcast i8* %38 to i8**
  store i8* %34, i8** %39, align 8, !tbaa !11
  %40 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %40, align 8, !tbaa !29
  %41 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %41)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

declare void @__cxa_end_catch()

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #5

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #6

declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #7

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::allocator", align 1
  %4 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !11
  %5 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 1
  %6 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 7
  %7 = bitcast i8** %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 48, i32 8, i1 false) #1
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %6) #1
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_stringbufIcSt11char_traitsIcESaIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !11
  %8 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 1
  store i32 0, i32* %8, align 4, !tbaa !32
  %9 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2
  %10 = getelementptr inbounds %"class.std::basic_string"* %__str, i64 0, i32 0, i32 0
  %11 = load i8** %10, align 8, !tbaa !1
  %12 = getelementptr inbounds i8* %11, i64 -24
  %13 = bitcast i8* %12 to i64*
  %14 = load i64* %13, align 8, !tbaa !35
  invoke void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"* %9, i8* %11, i64 %14, %"class.std::allocator"* %3)
          to label %15 unwind label %22

; <label>:15                                      ; preds = %0
  store i32 %__mode, i32* %8, align 4, !tbaa !32
  %16 = and i32 %__mode, 3
  %17 = icmp eq i32 %16, 0
  %.phi.trans.insert.i = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 2, i32 0, i32 0
  %.pre.i = load i8** %.phi.trans.insert.i, align 8, !tbaa !1
  br i1 %17, label %._crit_edge.i, label %18

; <label>:18                                      ; preds = %15
  %19 = getelementptr inbounds i8* %.pre.i, i64 -24
  %20 = bitcast i8* %19 to i64*
  %21 = load i64* %20, align 8, !tbaa !35
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
  call void @llvm.lifetime.start(i64 1, i8* %30)
  %31 = getelementptr inbounds %"class.std::basic_string"* %9, i64 0, i32 0, i32 0
  %32 = load i8** %31, align 8, !tbaa !1
  %33 = getelementptr inbounds i8* %32, i64 -24
  %34 = bitcast i8* %33 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %35 = icmp eq i8* %33, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %35, label %_ZNSsD1Ev.exit, label %36, !prof !7

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
  %44 = load i32* %38, align 4, !tbaa !8
  %45 = add nsw i32 %44, -1
  store i32 %45, i32* %38, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %43, %39
  %.0.i.i.i.i = phi i32 [ %42, %39 ], [ %44, %43 ]
  %46 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %46, label %47, label %_ZNSsD1Ev.exit

; <label>:47                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %34, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %47, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %26, %22
  %.01 = phi i8* [ %24, %22 ], [ %28, %26 ], [ %28, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %28, %47 ]
  %.0 = phi i32 [ %25, %22 ], [ %29, %26 ], [ %29, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %29, %47 ]
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !11
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %6) #1
  %48 = insertvalue { i8*, i32 } undef, i8* %.01, 0
  %49 = insertvalue { i8*, i32 } %48, i32 %.0, 1
  resume { i8*, i32 } %49
}

declare void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"*, i8*, i64, %"class.std::allocator"*) #0

declare void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"*, i8*, i64, i64) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeC1Ev(%"class.std::locale"*) #7

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #7

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #7

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #7

declare %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"*, %"class.std::basic_string"*) #0

declare i8* @__cxa_allocate_exception(i64)

; Function Attrs: nounwind
declare void @_ZNSt9exceptionD1Ev(%"class.std::exception"*) #7

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @__cxa_rethrow()

declare i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"*, i8*) #0

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline noreturn nounwind }
attributes #4 = { nounwind readnone }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { noreturn }
attributes #9 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !4, i64 0}
!2 = metadata !{metadata !"_ZTSSs", metadata !3, i64 0}
!3 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !4, i64 0}
!4 = metadata !{metadata !"any pointer", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"int", metadata !5, i64 0}
!10 = metadata !{metadata !5, metadata !5, i64 0}
!11 = metadata !{metadata !12, metadata !12, i64 0}
!12 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!13 = metadata !{metadata !14, metadata !17, i64 32}
!14 = metadata !{metadata !"_ZTSSt8ios_base", metadata !15, i64 8, metadata !15, i64 16, metadata !16, i64 24, metadata !17, i64 28, metadata !17, i64 32, metadata !4, i64 40, metadata !18, i64 48, metadata !5, i64 64, metadata !9, i64 192, metadata !4, i64 200, metadata !19, i64 208}
!15 = metadata !{metadata !"long", metadata !5, i64 0}
!16 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !5, i64 0}
!17 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !5, i64 0}
!18 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !4, i64 0, metadata !15, i64 8}
!19 = metadata !{metadata !"_ZTSSt6locale", metadata !4, i64 0}
!20 = metadata !{metadata !21, metadata !4, i64 240}
!21 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !4, i64 216, metadata !5, i64 224, metadata !22, i64 225, metadata !4, i64 232, metadata !4, i64 240, metadata !4, i64 248, metadata !4, i64 256}
!22 = metadata !{metadata !"bool", metadata !5, i64 0}
!23 = metadata !{metadata !24, metadata !5, i64 56}
!24 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !4, i64 16, metadata !22, i64 24, metadata !4, i64 32, metadata !4, i64 40, metadata !4, i64 48, metadata !5, i64 56, metadata !5, i64 57, metadata !5, i64 313, metadata !5, i64 569}
!25 = metadata !{metadata !14, metadata !17, i64 28}
!26 = metadata !{metadata !21, metadata !4, i64 216}
!27 = metadata !{metadata !21, metadata !5, i64 224}
!28 = metadata !{metadata !21, metadata !22, i64 225}
!29 = metadata !{metadata !30, metadata !15, i64 8}
!30 = metadata !{metadata !"_ZTSSi", metadata !15, i64 8}
!31 = metadata !{metadata !3, metadata !4, i64 0}
!32 = metadata !{metadata !33, metadata !34, i64 64}
!33 = metadata !{metadata !"_ZTSSt15basic_stringbufIcSt11char_traitsIcESaIcEE", metadata !34, i64 64, metadata !2, i64 72}
!34 = metadata !{metadata !"_ZTSSt13_Ios_Openmode", metadata !5, i64 0}
!35 = metadata !{metadata !36, metadata !15, i64 0}
!36 = metadata !{metadata !"_ZTSNSs9_Rep_baseE", metadata !15, i64 0, metadata !15, i64 8, metadata !9, i64 16}
