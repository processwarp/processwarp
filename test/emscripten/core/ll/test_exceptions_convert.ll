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
  call void @llvm.lifetime.start(i64 360, i8* %19) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %13, i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %14)
          to label %20 unwind label %77

; <label>:20                                      ; preds = %0
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss, %"class.std::basic_string"* %13, i32 8)
          to label %21 unwind label %80

; <label>:21                                      ; preds = %20
  %22 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %22) #2
  %23 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %24 = load i8** %23, align 8, !tbaa !1
  %25 = getelementptr inbounds i8* %24, i64 -24
  %26 = bitcast i8* %25 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %27 = icmp eq i8* %25, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %27, label %_ZNSsD1Ev.exit, label %28, !prof !7

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
  br i1 %38, label %39, label %_ZNSsD1Ev.exit

; <label>:39                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %26, %"class.std::allocator"* %12) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %39, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %21
  call void @llvm.lifetime.end(i64 1, i8* %22) #2
  store i32 0, i32* %value, align 4, !tbaa !10
  %40 = bitcast %"class.std::basic_istringstream"* %iss to %"class.std::basic_istream"*
  invoke fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %40, i32* %value)
          to label %41 unwind label %101

; <label>:41                                      ; preds = %_ZNSsD1Ev.exit
  %42 = bitcast %"class.std::basic_istringstream"* %iss to i8**
  %43 = load i8** %42, align 8, !tbaa !11
  %44 = getelementptr i8* %43, i64 -24
  %45 = bitcast i8* %44 to i64*
  %46 = load i64* %45, align 8
  %.sum226 = add i64 %46, 32
  %47 = getelementptr inbounds i8* %19, i64 %.sum226
  %48 = bitcast i8* %47 to i32*
  %49 = load i32* %48, align 4, !tbaa !13
  %50 = and i32 %49, 5
  %51 = icmp eq i32 %50, 0
  br i1 %51, label %188, label %52

; <label>:52                                      ; preds = %41
  %53 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([50 x i8]* @.str1, i64 0, i64 0), i64 49)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %101

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %52
  %54 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %55 = getelementptr i8* %54, i64 -24
  %56 = bitcast i8* %55 to i64*
  %57 = load i64* %56, align 8
  %.sum228 = add i64 %57, 240
  %58 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum228
  %59 = bitcast i8* %58 to %"class.std::ctype"**
  %60 = load %"class.std::ctype"** %59, align 8, !tbaa !20
  %61 = icmp eq %"class.std::ctype"* %60, null
  br i1 %61, label %62, label %.noexc147

; <label>:62                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc201 unwind label %101

.noexc201:                                        ; preds = %62
  unreachable

.noexc147:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %63 = getelementptr inbounds %"class.std::ctype"* %60, i64 0, i32 6
  %64 = load i8* %63, align 1, !tbaa !23
  %65 = icmp eq i8 %64, 0
  br i1 %65, label %69, label %66

; <label>:66                                      ; preds = %.noexc147
  %67 = getelementptr inbounds %"class.std::ctype"* %60, i64 0, i32 7, i64 10
  %68 = load i8* %67, align 1, !tbaa !10
  br label %.noexc14

; <label>:69                                      ; preds = %.noexc147
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %60)
          to label %.noexc151 unwind label %101

.noexc151:                                        ; preds = %69
  %70 = bitcast %"class.std::ctype"* %60 to i8 (%"class.std::ctype"*, i8)***
  %71 = load i8 (%"class.std::ctype"*, i8)*** %70, align 8, !tbaa !11
  %72 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %71, i64 6
  %73 = load i8 (%"class.std::ctype"*, i8)** %72, align 8
  %74 = invoke signext i8 %73(%"class.std::ctype"* %60, i8 signext 10)
          to label %.noexc14 unwind label %101

.noexc14:                                         ; preds = %.noexc151, %66
  %.0.i150 = phi i8 [ %68, %66 ], [ %74, %.noexc151 ]
  %75 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i150)
          to label %.noexc15 unwind label %101

.noexc15:                                         ; preds = %.noexc14
  %76 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %75)
          to label %_ZNSolsEPFRSoS_E.exit13 unwind label %101

; <label>:77                                      ; preds = %0
  %78 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %79 = extractvalue { i8*, i32 } %78, 0
  br label %_ZNSsD1Ev.exit22

; <label>:80                                      ; preds = %20
  %81 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %82 = extractvalue { i8*, i32 } %81, 0
  %83 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %83) #2
  %84 = getelementptr inbounds %"class.std::basic_string"* %13, i64 0, i32 0, i32 0
  %85 = load i8** %84, align 8, !tbaa !1
  %86 = getelementptr inbounds i8* %85, i64 -24
  %87 = bitcast i8* %86 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %88 = icmp eq i8* %86, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %88, label %_ZNSsD1Ev.exit22, label %89, !prof !7

; <label>:89                                      ; preds = %80
  %90 = getelementptr inbounds i8* %85, i64 -8
  %91 = bitcast i8* %90 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %92, label %96

; <label>:92                                      ; preds = %89
  %93 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %93)
  %94 = atomicrmw volatile add i32* %91, i32 -1 acq_rel
  store i32 %94, i32* %9, align 4
  %95 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %93)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21

; <label>:96                                      ; preds = %89
  %97 = load i32* %91, align 4, !tbaa !8
  %98 = add nsw i32 %97, -1
  store i32 %98, i32* %91, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21: ; preds = %96, %92
  %.0.i.i.i.i20 = phi i32 [ %95, %92 ], [ %97, %96 ]
  %99 = icmp slt i32 %.0.i.i.i.i20, 1
  br i1 %99, label %100, label %_ZNSsD1Ev.exit22

; <label>:100                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %87, %"class.std::allocator"* %10) #2
  br label %_ZNSsD1Ev.exit22

; <label>:101                                     ; preds = %.noexc57, %.noexc56, %.noexc166, %211, %204, %192, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51, %188, %.noexc15, %.noexc14, %.noexc151, %69, %62, %52, %_ZNSsD1Ev.exit
  %102 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %103 = extractvalue { i8*, i32 } %102, 0
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss) #2
  br label %_ZNSsD1Ev.exit22

_ZNSsD1Ev.exit22:                                 ; preds = %101, %100, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21, %80, %77
  %.1 = phi i8* [ %103, %101 ], [ %79, %77 ], [ %82, %80 ], [ %82, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i21 ], [ %82, %100 ]
  %104 = call i8* @__cxa_begin_catch(i8* %.1) #2
  %105 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([62 x i8]* @.str4, i64 0, i64 0), i64 61)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24 unwind label %219

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24: ; preds = %_ZNSsD1Ev.exit22
  %106 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %107 = getelementptr i8* %106, i64 -24
  %108 = bitcast i8* %107 to i64*
  %109 = load i64* %108, align 8
  %.sum = add i64 %109, 240
  %110 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %111 = bitcast i8* %110 to %"class.std::ctype"**
  %112 = load %"class.std::ctype"** %111, align 8, !tbaa !20
  %113 = icmp eq %"class.std::ctype"* %112, null
  br i1 %113, label %114, label %.noexc36

; <label>:114                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc154 unwind label %219

.noexc154:                                        ; preds = %114
  unreachable

.noexc36:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit24
  %115 = getelementptr inbounds %"class.std::ctype"* %112, i64 0, i32 6
  %116 = load i8* %115, align 1, !tbaa !23
  %117 = icmp eq i8 %116, 0
  br i1 %117, label %121, label %118

; <label>:118                                     ; preds = %.noexc36
  %119 = getelementptr inbounds %"class.std::ctype"* %112, i64 0, i32 7, i64 10
  %120 = load i8* %119, align 1, !tbaa !10
  br label %.noexc27

; <label>:121                                     ; preds = %.noexc36
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %112)
          to label %.noexc38 unwind label %219

.noexc38:                                         ; preds = %121
  %122 = bitcast %"class.std::ctype"* %112 to i8 (%"class.std::ctype"*, i8)***
  %123 = load i8 (%"class.std::ctype"*, i8)*** %122, align 8, !tbaa !11
  %124 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %123, i64 6
  %125 = load i8 (%"class.std::ctype"*, i8)** %124, align 8
  %126 = invoke signext i8 %125(%"class.std::ctype"* %112, i8 signext 10)
          to label %.noexc27 unwind label %219

.noexc27:                                         ; preds = %.noexc38, %118
  %.0.i = phi i8 [ %120, %118 ], [ %126, %.noexc38 ]
  %127 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc28 unwind label %219

.noexc28:                                         ; preds = %.noexc27
  %128 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %127)
          to label %_ZNSolsEPFRSoS_E.exit26 unwind label %219

_ZNSolsEPFRSoS_E.exit26:                          ; preds = %.noexc28
  call void @__cxa_end_catch()
  br label %129

; <label>:129                                     ; preds = %_ZNSolsEPFRSoS_E.exit13, %_ZNSolsEPFRSoS_E.exit26
  %130 = bitcast %"class.std::basic_istringstream"* %iss1 to i8*
  call void @llvm.lifetime.start(i64 360, i8* %130) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %15, i8* getelementptr inbounds ([4 x i8]* @.str5, i64 0, i64 0), %"class.std::allocator"* %16)
          to label %131 unwind label %223

; <label>:131                                     ; preds = %129
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss1, %"class.std::basic_string"* %15, i32 8)
          to label %132 unwind label %226

; <label>:132                                     ; preds = %131
  %133 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %133) #2
  %134 = getelementptr inbounds %"class.std::basic_string"* %15, i64 0, i32 0, i32 0
  %135 = load i8** %134, align 8, !tbaa !1
  %136 = getelementptr inbounds i8* %135, i64 -24
  %137 = bitcast i8* %136 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %138 = icmp eq i8* %136, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %138, label %_ZNSsD1Ev.exit35, label %139, !prof !7

; <label>:139                                     ; preds = %132
  %140 = getelementptr inbounds i8* %135, i64 -8
  %141 = bitcast i8* %140 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %142, label %146

; <label>:142                                     ; preds = %139
  %143 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %143)
  %144 = atomicrmw volatile add i32* %141, i32 -1 acq_rel
  store i32 %144, i32* %7, align 4
  %145 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %143)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34

; <label>:146                                     ; preds = %139
  %147 = load i32* %141, align 4, !tbaa !8
  %148 = add nsw i32 %147, -1
  store i32 %148, i32* %141, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34: ; preds = %146, %142
  %.0.i.i.i.i33 = phi i32 [ %145, %142 ], [ %147, %146 ]
  %149 = icmp slt i32 %.0.i.i.i.i33, 1
  br i1 %149, label %150, label %_ZNSsD1Ev.exit35

; <label>:150                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %137, %"class.std::allocator"* %8) #2
  br label %_ZNSsD1Ev.exit35

_ZNSsD1Ev.exit35:                                 ; preds = %150, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34, %132
  call void @llvm.lifetime.end(i64 1, i8* %133) #2
  store i32 0, i32* %value2, align 4, !tbaa !10
  %151 = bitcast %"class.std::basic_istringstream"* %iss1 to %"class.std::basic_istream"*
  invoke fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %151, i32* %value2)
          to label %152 unwind label %247

; <label>:152                                     ; preds = %_ZNSsD1Ev.exit35
  %153 = bitcast %"class.std::basic_istringstream"* %iss1 to i8**
  %154 = load i8** %153, align 8, !tbaa !11
  %155 = getelementptr i8* %154, i64 -24
  %156 = bitcast i8* %155 to i64*
  %157 = load i64* %156, align 8
  %.sum223 = add i64 %157, 32
  %158 = getelementptr inbounds i8* %130, i64 %.sum223
  %159 = bitcast i8* %158 to i32*
  %160 = load i32* %159, align 4, !tbaa !13
  %161 = and i32 %160, 5
  %162 = icmp eq i32 %161, 0
  br i1 %162, label %345, label %163

; <label>:163                                     ; preds = %152
  %164 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([48 x i8]* @.str6, i64 0, i64 0), i64 47)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41 unwind label %247

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41: ; preds = %163
  %165 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %166 = getelementptr i8* %165, i64 -24
  %167 = bitcast i8* %166 to i64*
  %168 = load i64* %167, align 8
  %.sum225 = add i64 %168, 240
  %169 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum225
  %170 = bitcast i8* %169 to %"class.std::ctype"**
  %171 = load %"class.std::ctype"** %170, align 8, !tbaa !20
  %172 = icmp eq %"class.std::ctype"* %171, null
  br i1 %172, label %173, label %.noexc155

; <label>:173                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc203 unwind label %247

.noexc203:                                        ; preds = %173
  unreachable

.noexc155:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit41
  %174 = getelementptr inbounds %"class.std::ctype"* %171, i64 0, i32 6
  %175 = load i8* %174, align 1, !tbaa !23
  %176 = icmp eq i8 %175, 0
  br i1 %176, label %180, label %177

; <label>:177                                     ; preds = %.noexc155
  %178 = getelementptr inbounds %"class.std::ctype"* %171, i64 0, i32 7, i64 10
  %179 = load i8* %178, align 1, !tbaa !10
  br label %.noexc44

; <label>:180                                     ; preds = %.noexc155
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %171)
          to label %.noexc159 unwind label %247

.noexc159:                                        ; preds = %180
  %181 = bitcast %"class.std::ctype"* %171 to i8 (%"class.std::ctype"*, i8)***
  %182 = load i8 (%"class.std::ctype"*, i8)*** %181, align 8, !tbaa !11
  %183 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %182, i64 6
  %184 = load i8 (%"class.std::ctype"*, i8)** %183, align 8
  %185 = invoke signext i8 %184(%"class.std::ctype"* %171, i8 signext 10)
          to label %.noexc44 unwind label %247

.noexc44:                                         ; preds = %.noexc159, %177
  %.0.i158 = phi i8 [ %179, %177 ], [ %185, %.noexc159 ]
  %186 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i158)
          to label %.noexc45 unwind label %247

.noexc45:                                         ; preds = %.noexc44
  %187 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %186)
          to label %_ZNSolsEPFRSoS_E.exit43 unwind label %247

; <label>:188                                     ; preds = %41
  %189 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([49 x i8]* @.str2, i64 0, i64 0), i64 48)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51 unwind label %101

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51: ; preds = %188
  %190 = load i32* %value, align 4, !tbaa !10
  %191 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %190)
          to label %192 unwind label %101

; <label>:192                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit51
  %193 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %191, i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 6)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53 unwind label %101

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53: ; preds = %192
  %194 = bitcast %"class.std::basic_ostream"* %191 to i8**
  %195 = load i8** %194, align 8, !tbaa !11
  %196 = getelementptr i8* %195, i64 -24
  %197 = bitcast i8* %196 to i64*
  %198 = load i64* %197, align 8
  %199 = bitcast %"class.std::basic_ostream"* %191 to i8*
  %.sum227 = add i64 %198, 240
  %200 = getelementptr inbounds i8* %199, i64 %.sum227
  %201 = bitcast i8* %200 to %"class.std::ctype"**
  %202 = load %"class.std::ctype"** %201, align 8, !tbaa !20
  %203 = icmp eq %"class.std::ctype"* %202, null
  br i1 %203, label %204, label %.noexc162

; <label>:204                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc205 unwind label %101

.noexc205:                                        ; preds = %204
  unreachable

.noexc162:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit53
  %205 = getelementptr inbounds %"class.std::ctype"* %202, i64 0, i32 6
  %206 = load i8* %205, align 1, !tbaa !23
  %207 = icmp eq i8 %206, 0
  br i1 %207, label %211, label %208

; <label>:208                                     ; preds = %.noexc162
  %209 = getelementptr inbounds %"class.std::ctype"* %202, i64 0, i32 7, i64 10
  %210 = load i8* %209, align 1, !tbaa !10
  br label %.noexc56

; <label>:211                                     ; preds = %.noexc162
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %202)
          to label %.noexc166 unwind label %101

.noexc166:                                        ; preds = %211
  %212 = bitcast %"class.std::ctype"* %202 to i8 (%"class.std::ctype"*, i8)***
  %213 = load i8 (%"class.std::ctype"*, i8)*** %212, align 8, !tbaa !11
  %214 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %213, i64 6
  %215 = load i8 (%"class.std::ctype"*, i8)** %214, align 8
  %216 = invoke signext i8 %215(%"class.std::ctype"* %202, i8 signext 10)
          to label %.noexc56 unwind label %101

.noexc56:                                         ; preds = %.noexc166, %208
  %.0.i165 = phi i8 [ %210, %208 ], [ %216, %.noexc166 ]
  %217 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %191, i8 signext %.0.i165)
          to label %.noexc57 unwind label %101

.noexc57:                                         ; preds = %.noexc56
  %218 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %217)
          to label %_ZNSolsEPFRSoS_E.exit13 unwind label %101

_ZNSolsEPFRSoS_E.exit13:                          ; preds = %.noexc57, %.noexc15
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss) #2
  call void @llvm.lifetime.end(i64 360, i8* %19) #2
  br label %129

; <label>:219                                     ; preds = %.noexc28, %.noexc27, %.noexc38, %121, %114, %_ZNSsD1Ev.exit22
  %220 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %221 = extractvalue { i8*, i32 } %220, 0
  %222 = extractvalue { i8*, i32 } %220, 1
  invoke void @__cxa_end_catch()
          to label %525 unwind label %528

; <label>:223                                     ; preds = %129
  %224 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %225 = extractvalue { i8*, i32 } %224, 0
  br label %_ZNSsD1Ev.exit64

; <label>:226                                     ; preds = %131
  %227 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %228 = extractvalue { i8*, i32 } %227, 0
  %229 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %229) #2
  %230 = getelementptr inbounds %"class.std::basic_string"* %15, i64 0, i32 0, i32 0
  %231 = load i8** %230, align 8, !tbaa !1
  %232 = getelementptr inbounds i8* %231, i64 -24
  %233 = bitcast i8* %232 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %234 = icmp eq i8* %232, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %234, label %_ZNSsD1Ev.exit64, label %235, !prof !7

; <label>:235                                     ; preds = %226
  %236 = getelementptr inbounds i8* %231, i64 -8
  %237 = bitcast i8* %236 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %238, label %242

; <label>:238                                     ; preds = %235
  %239 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %239)
  %240 = atomicrmw volatile add i32* %237, i32 -1 acq_rel
  store i32 %240, i32* %5, align 4
  %241 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %239)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63

; <label>:242                                     ; preds = %235
  %243 = load i32* %237, align 4, !tbaa !8
  %244 = add nsw i32 %243, -1
  store i32 %244, i32* %237, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63: ; preds = %242, %238
  %.0.i.i.i.i62 = phi i32 [ %241, %238 ], [ %243, %242 ]
  %245 = icmp slt i32 %.0.i.i.i.i62, 1
  br i1 %245, label %246, label %_ZNSsD1Ev.exit64

; <label>:246                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %233, %"class.std::allocator"* %6) #2
  br label %_ZNSsD1Ev.exit64

; <label>:247                                     ; preds = %.noexc103, %.noexc102, %.noexc182, %368, %361, %349, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit97, %345, %.noexc45, %.noexc44, %.noexc159, %180, %173, %163, %_ZNSsD1Ev.exit35
  %248 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %249 = extractvalue { i8*, i32 } %248, 0
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss1) #2
  br label %_ZNSsD1Ev.exit64

_ZNSsD1Ev.exit64:                                 ; preds = %247, %246, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63, %226, %223
  %.3 = phi i8* [ %249, %247 ], [ %225, %223 ], [ %228, %226 ], [ %228, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i63 ], [ %228, %246 ]
  %250 = call i8* @__cxa_begin_catch(i8* %.3) #2
  %251 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([62 x i8]* @.str9, i64 0, i64 0), i64 61)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66 unwind label %376

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66: ; preds = %_ZNSsD1Ev.exit64
  %252 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %253 = getelementptr i8* %252, i64 -24
  %254 = bitcast i8* %253 to i64*
  %255 = load i64* %254, align 8
  %.sum215 = add i64 %255, 240
  %256 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum215
  %257 = bitcast i8* %256 to %"class.std::ctype"**
  %258 = load %"class.std::ctype"** %257, align 8, !tbaa !20
  %259 = icmp eq %"class.std::ctype"* %258, null
  br i1 %259, label %260, label %.noexc78

; <label>:260                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc169 unwind label %376

.noexc169:                                        ; preds = %260
  unreachable

.noexc78:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit66
  %261 = getelementptr inbounds %"class.std::ctype"* %258, i64 0, i32 6
  %262 = load i8* %261, align 1, !tbaa !23
  %263 = icmp eq i8 %262, 0
  br i1 %263, label %267, label %264

; <label>:264                                     ; preds = %.noexc78
  %265 = getelementptr inbounds %"class.std::ctype"* %258, i64 0, i32 7, i64 10
  %266 = load i8* %265, align 1, !tbaa !10
  br label %.noexc69

; <label>:267                                     ; preds = %.noexc78
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %258)
          to label %.noexc82 unwind label %376

.noexc82:                                         ; preds = %267
  %268 = bitcast %"class.std::ctype"* %258 to i8 (%"class.std::ctype"*, i8)***
  %269 = load i8 (%"class.std::ctype"*, i8)*** %268, align 8, !tbaa !11
  %270 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %269, i64 6
  %271 = load i8 (%"class.std::ctype"*, i8)** %270, align 8
  %272 = invoke signext i8 %271(%"class.std::ctype"* %258, i8 signext 10)
          to label %.noexc69 unwind label %376

.noexc69:                                         ; preds = %.noexc82, %264
  %.0.i81 = phi i8 [ %266, %264 ], [ %272, %.noexc82 ]
  %273 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i81)
          to label %.noexc70 unwind label %376

.noexc70:                                         ; preds = %.noexc69
  %274 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %273)
          to label %_ZNSolsEPFRSoS_E.exit68 unwind label %376

_ZNSolsEPFRSoS_E.exit68:                          ; preds = %.noexc70
  call void @__cxa_end_catch()
  br label %275

; <label>:275                                     ; preds = %_ZNSolsEPFRSoS_E.exit43, %_ZNSolsEPFRSoS_E.exit68
  %276 = bitcast %"class.std::basic_istringstream"* %iss3 to i8*
  call void @llvm.lifetime.start(i64 360, i8* %276) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %17, i8* getelementptr inbounds ([6 x i8]* @.str10, i64 0, i64 0), %"class.std::allocator"* %18)
          to label %277 unwind label %380

; <label>:277                                     ; preds = %275
  invoke void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %iss3, %"class.std::basic_string"* %17, i32 8)
          to label %278 unwind label %384

; <label>:278                                     ; preds = %277
  %279 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %279) #2
  %280 = getelementptr inbounds %"class.std::basic_string"* %17, i64 0, i32 0, i32 0
  %281 = load i8** %280, align 8, !tbaa !1
  %282 = getelementptr inbounds i8* %281, i64 -24
  %283 = bitcast i8* %282 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %284 = icmp eq i8* %282, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %284, label %_ZNSsD1Ev.exit77, label %285, !prof !7

; <label>:285                                     ; preds = %278
  %286 = getelementptr inbounds i8* %281, i64 -8
  %287 = bitcast i8* %286 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %288, label %292

; <label>:288                                     ; preds = %285
  %289 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %289)
  %290 = atomicrmw volatile add i32* %287, i32 -1 acq_rel
  store i32 %290, i32* %3, align 4
  %291 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %289)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76

; <label>:292                                     ; preds = %285
  %293 = load i32* %287, align 4, !tbaa !8
  %294 = add nsw i32 %293, -1
  store i32 %294, i32* %287, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76: ; preds = %292, %288
  %.0.i.i.i.i75 = phi i32 [ %291, %288 ], [ %293, %292 ]
  %295 = icmp slt i32 %.0.i.i.i.i75, 1
  br i1 %295, label %296, label %_ZNSsD1Ev.exit77

; <label>:296                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %283, %"class.std::allocator"* %4) #2
  br label %_ZNSsD1Ev.exit77

_ZNSsD1Ev.exit77:                                 ; preds = %296, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76, %278
  call void @llvm.lifetime.end(i64 1, i8* %279) #2
  store i32 0, i32* %value4, align 4, !tbaa !10
  %297 = bitcast %"class.std::basic_istringstream"* %iss3 to i8**
  %298 = load i8** %297, align 8, !tbaa !11
  %299 = getelementptr i8* %298, i64 -24
  %300 = bitcast i8* %299 to i64*
  %301 = load i64* %300, align 8
  %302 = getelementptr inbounds i8* %276, i64 %301
  %303 = bitcast i8* %302 to %"class.std::basic_ios"*
  %.sum218 = add i64 %301, 28
  %304 = getelementptr inbounds i8* %276, i64 %.sum218
  %305 = bitcast i8* %304 to i32*
  store i32 4, i32* %305, align 4, !tbaa !25
  %.sum219 = add i64 %301, 32
  %306 = getelementptr inbounds i8* %276, i64 %.sum219
  %307 = bitcast i8* %306 to i32*
  %308 = load i32* %307, align 4, !tbaa !13
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %303, i32 %308)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit unwind label %406

_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit: ; preds = %_ZNSsD1Ev.exit77
  %309 = bitcast %"class.std::basic_istringstream"* %iss3 to %"class.std::basic_istream"*
  invoke fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %309, i32* %value4)
          to label %310 unwind label %406

; <label>:310                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit
  %311 = load i8** %297, align 8, !tbaa !11
  %312 = getelementptr i8* %311, i64 -24
  %313 = bitcast i8* %312 to i64*
  %314 = load i64* %313, align 8
  %.sum220 = add i64 %314, 32
  %315 = getelementptr inbounds i8* %276, i64 %.sum220
  %316 = bitcast i8* %315 to i32*
  %317 = load i32* %316, align 4, !tbaa !13
  %318 = and i32 %317, 5
  %319 = icmp eq i32 %318, 0
  br i1 %319, label %486, label %320

; <label>:320                                     ; preds = %310
  %321 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0), i64 71)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit87 unwind label %406

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit87: ; preds = %320
  %322 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %323 = getelementptr i8* %322, i64 -24
  %324 = bitcast i8* %323 to i64*
  %325 = load i64* %324, align 8
  %.sum222 = add i64 %325, 240
  %326 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum222
  %327 = bitcast i8* %326 to %"class.std::ctype"**
  %328 = load %"class.std::ctype"** %327, align 8, !tbaa !20
  %329 = icmp eq %"class.std::ctype"* %328, null
  br i1 %329, label %330, label %.noexc171

; <label>:330                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit87
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc207 unwind label %406

.noexc207:                                        ; preds = %330
  unreachable

.noexc171:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit87
  %331 = getelementptr inbounds %"class.std::ctype"* %328, i64 0, i32 6
  %332 = load i8* %331, align 1, !tbaa !23
  %333 = icmp eq i8 %332, 0
  br i1 %333, label %337, label %334

; <label>:334                                     ; preds = %.noexc171
  %335 = getelementptr inbounds %"class.std::ctype"* %328, i64 0, i32 7, i64 10
  %336 = load i8* %335, align 1, !tbaa !10
  br label %.noexc90

; <label>:337                                     ; preds = %.noexc171
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %328)
          to label %.noexc175 unwind label %406

.noexc175:                                        ; preds = %337
  %338 = bitcast %"class.std::ctype"* %328 to i8 (%"class.std::ctype"*, i8)***
  %339 = load i8 (%"class.std::ctype"*, i8)*** %338, align 8, !tbaa !11
  %340 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %339, i64 6
  %341 = load i8 (%"class.std::ctype"*, i8)** %340, align 8
  %342 = invoke signext i8 %341(%"class.std::ctype"* %328, i8 signext 10)
          to label %.noexc90 unwind label %406

.noexc90:                                         ; preds = %.noexc175, %334
  %.0.i174 = phi i8 [ %336, %334 ], [ %342, %.noexc175 ]
  %343 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i174)
          to label %.noexc91 unwind label %406

.noexc91:                                         ; preds = %.noexc90
  %344 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %343)
          to label %_ZNSolsEPFRSoS_E.exit89 unwind label %406

; <label>:345                                     ; preds = %152
  %346 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([49 x i8]* @.str7, i64 0, i64 0), i64 48)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit97 unwind label %247

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit97: ; preds = %345
  %347 = load i32* %value2, align 4, !tbaa !10
  %348 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %347)
          to label %349 unwind label %247

; <label>:349                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit97
  %350 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %348, i8* getelementptr inbounds ([9 x i8]* @.str8, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99 unwind label %247

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99: ; preds = %349
  %351 = bitcast %"class.std::basic_ostream"* %348 to i8**
  %352 = load i8** %351, align 8, !tbaa !11
  %353 = getelementptr i8* %352, i64 -24
  %354 = bitcast i8* %353 to i64*
  %355 = load i64* %354, align 8
  %356 = bitcast %"class.std::basic_ostream"* %348 to i8*
  %.sum224 = add i64 %355, 240
  %357 = getelementptr inbounds i8* %356, i64 %.sum224
  %358 = bitcast i8* %357 to %"class.std::ctype"**
  %359 = load %"class.std::ctype"** %358, align 8, !tbaa !20
  %360 = icmp eq %"class.std::ctype"* %359, null
  br i1 %360, label %361, label %.noexc178

; <label>:361                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc209 unwind label %247

.noexc209:                                        ; preds = %361
  unreachable

.noexc178:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit99
  %362 = getelementptr inbounds %"class.std::ctype"* %359, i64 0, i32 6
  %363 = load i8* %362, align 1, !tbaa !23
  %364 = icmp eq i8 %363, 0
  br i1 %364, label %368, label %365

; <label>:365                                     ; preds = %.noexc178
  %366 = getelementptr inbounds %"class.std::ctype"* %359, i64 0, i32 7, i64 10
  %367 = load i8* %366, align 1, !tbaa !10
  br label %.noexc102

; <label>:368                                     ; preds = %.noexc178
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %359)
          to label %.noexc182 unwind label %247

.noexc182:                                        ; preds = %368
  %369 = bitcast %"class.std::ctype"* %359 to i8 (%"class.std::ctype"*, i8)***
  %370 = load i8 (%"class.std::ctype"*, i8)*** %369, align 8, !tbaa !11
  %371 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %370, i64 6
  %372 = load i8 (%"class.std::ctype"*, i8)** %371, align 8
  %373 = invoke signext i8 %372(%"class.std::ctype"* %359, i8 signext 10)
          to label %.noexc102 unwind label %247

.noexc102:                                        ; preds = %.noexc182, %365
  %.0.i181 = phi i8 [ %367, %365 ], [ %373, %.noexc182 ]
  %374 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %348, i8 signext %.0.i181)
          to label %.noexc103 unwind label %247

.noexc103:                                        ; preds = %.noexc102
  %375 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %374)
          to label %_ZNSolsEPFRSoS_E.exit43 unwind label %247

_ZNSolsEPFRSoS_E.exit43:                          ; preds = %.noexc103, %.noexc45
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss1) #2
  call void @llvm.lifetime.end(i64 360, i8* %130) #2
  br label %275

; <label>:376                                     ; preds = %.noexc70, %.noexc69, %.noexc82, %267, %260, %_ZNSsD1Ev.exit64
  %377 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %378 = extractvalue { i8*, i32 } %377, 0
  %379 = extractvalue { i8*, i32 } %377, 1
  invoke void @__cxa_end_catch()
          to label %525 unwind label %528

; <label>:380                                     ; preds = %275
  %381 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %382 = extractvalue { i8*, i32 } %381, 0
  %383 = extractvalue { i8*, i32 } %381, 1
  br label %_ZNSsD1Ev.exit110

; <label>:384                                     ; preds = %277
  %385 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %386 = extractvalue { i8*, i32 } %385, 0
  %387 = extractvalue { i8*, i32 } %385, 1
  %388 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %388) #2
  %389 = getelementptr inbounds %"class.std::basic_string"* %17, i64 0, i32 0, i32 0
  %390 = load i8** %389, align 8, !tbaa !1
  %391 = getelementptr inbounds i8* %390, i64 -24
  %392 = bitcast i8* %391 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %393 = icmp eq i8* %391, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %393, label %_ZNSsD1Ev.exit110, label %394, !prof !7

; <label>:394                                     ; preds = %384
  %395 = getelementptr inbounds i8* %390, i64 -8
  %396 = bitcast i8* %395 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %397, label %401

; <label>:397                                     ; preds = %394
  %398 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %398)
  %399 = atomicrmw volatile add i32* %396, i32 -1 acq_rel
  store i32 %399, i32* %1, align 4
  %400 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %398)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109

; <label>:401                                     ; preds = %394
  %402 = load i32* %396, align 4, !tbaa !8
  %403 = add nsw i32 %402, -1
  store i32 %403, i32* %396, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109: ; preds = %401, %397
  %.0.i.i.i.i108 = phi i32 [ %400, %397 ], [ %402, %401 ]
  %404 = icmp slt i32 %.0.i.i.i.i108, 1
  br i1 %404, label %405, label %_ZNSsD1Ev.exit110

; <label>:405                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %392, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit110

; <label>:406                                     ; preds = %.noexc8, %.noexc, %.noexc144, %509, %502, %490, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit137, %486, %.noexc91, %.noexc90, %.noexc175, %337, %330, %320, %_ZNSt9basic_iosIcSt11char_traitsIcEE10exceptionsESt12_Ios_Iostate.exit, %_ZNSsD1Ev.exit77
  %407 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
          catch i8* null
  %408 = extractvalue { i8*, i32 } %407, 0
  %409 = extractvalue { i8*, i32 } %407, 1
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss3) #2
  br label %_ZNSsD1Ev.exit110

_ZNSsD1Ev.exit110:                                ; preds = %406, %405, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109, %384, %380
  %.16 = phi i32 [ %409, %406 ], [ %383, %380 ], [ %387, %384 ], [ %387, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109 ], [ %387, %405 ]
  %.5 = phi i8* [ %408, %406 ], [ %382, %380 ], [ %386, %384 ], [ %386, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i109 ], [ %386, %405 ]
  %410 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #2
  %411 = icmp eq i32 %.16, %410
  %412 = call i8* @__cxa_begin_catch(i8* %.5) #2
  br i1 %411, label %413, label %461

; <label>:413                                     ; preds = %_ZNSsD1Ev.exit110
  %414 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str14, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112 unwind label %521

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112: ; preds = %413
  %415 = bitcast i8* %412 to %"class.std::ios_base::failure"*
  %416 = bitcast i8* %412 to i8* (%"class.std::ios_base::failure"*)***
  %417 = load i8* (%"class.std::ios_base::failure"*)*** %416, align 8, !tbaa !11
  %418 = getelementptr inbounds i8* (%"class.std::ios_base::failure"*)** %417, i64 2
  %419 = load i8* (%"class.std::ios_base::failure"*)** %418, align 8
  %420 = call i8* %419(%"class.std::ios_base::failure"* %415) #2
  %421 = icmp eq i8* %420, null
  br i1 %421, label %422, label %433

; <label>:422                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112
  %423 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %424 = getelementptr i8* %423, i64 -24
  %425 = bitcast i8* %424 to i64*
  %426 = load i64* %425, align 8
  %427 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %426
  %428 = bitcast i8* %427 to %"class.std::basic_ios"*
  %.sum.i = add i64 %426, 32
  %429 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %430 = bitcast i8* %429 to i32*
  %431 = load i32* %430, align 4, !tbaa !13
  %432 = or i32 %431, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %428, i32 %432)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit115 unwind label %521

; <label>:433                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit112
  %434 = call i64 @strlen(i8* %420) #2
  %435 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %420, i64 %434)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit115 unwind label %521

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit115: ; preds = %433, %422
  %436 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 6)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit117 unwind label %521

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit117: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit115
  %437 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %438 = getelementptr i8* %437, i64 -24
  %439 = bitcast i8* %438 to i64*
  %440 = load i64* %439, align 8
  %.sum217 = add i64 %440, 240
  %441 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum217
  %442 = bitcast i8* %441 to %"class.std::ctype"**
  %443 = load %"class.std::ctype"** %442, align 8, !tbaa !20
  %444 = icmp eq %"class.std::ctype"* %443, null
  br i1 %444, label %445, label %.noexc185

; <label>:445                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit117
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc211 unwind label %521

.noexc211:                                        ; preds = %445
  unreachable

.noexc185:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit117
  %446 = getelementptr inbounds %"class.std::ctype"* %443, i64 0, i32 6
  %447 = load i8* %446, align 1, !tbaa !23
  %448 = icmp eq i8 %447, 0
  br i1 %448, label %452, label %449

; <label>:449                                     ; preds = %.noexc185
  %450 = getelementptr inbounds %"class.std::ctype"* %443, i64 0, i32 7, i64 10
  %451 = load i8* %450, align 1, !tbaa !10
  br label %.noexc120

; <label>:452                                     ; preds = %.noexc185
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %443)
          to label %.noexc189 unwind label %521

.noexc189:                                        ; preds = %452
  %453 = bitcast %"class.std::ctype"* %443 to i8 (%"class.std::ctype"*, i8)***
  %454 = load i8 (%"class.std::ctype"*, i8)*** %453, align 8, !tbaa !11
  %455 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %454, i64 6
  %456 = load i8 (%"class.std::ctype"*, i8)** %455, align 8
  %457 = invoke signext i8 %456(%"class.std::ctype"* %443, i8 signext 10)
          to label %.noexc120 unwind label %521

.noexc120:                                        ; preds = %.noexc189, %449
  %.0.i188 = phi i8 [ %451, %449 ], [ %457, %.noexc189 ]
  %458 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i188)
          to label %.noexc121 unwind label %521

.noexc121:                                        ; preds = %.noexc120
  %459 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %458)
          to label %_ZNSolsEPFRSoS_E.exit119 unwind label %521

_ZNSolsEPFRSoS_E.exit119:                         ; preds = %.noexc121
  call void @__cxa_end_catch()
  br label %460

; <label>:460                                     ; preds = %_ZNSolsEPFRSoS_E.exit89, %_ZNSolsEPFRSoS_E.exit129, %_ZNSolsEPFRSoS_E.exit119
  ret i32 0

; <label>:461                                     ; preds = %_ZNSsD1Ev.exit110
  %462 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([64 x i8]* @.str13, i64 0, i64 0), i64 63)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127 unwind label %517

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127: ; preds = %461
  %463 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !11
  %464 = getelementptr i8* %463, i64 -24
  %465 = bitcast i8* %464 to i64*
  %466 = load i64* %465, align 8
  %.sum216 = add i64 %466, 240
  %467 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum216
  %468 = bitcast i8* %467 to %"class.std::ctype"**
  %469 = load %"class.std::ctype"** %468, align 8, !tbaa !20
  %470 = icmp eq %"class.std::ctype"* %469, null
  br i1 %470, label %471, label %.noexc192

; <label>:471                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc213 unwind label %517

.noexc213:                                        ; preds = %471
  unreachable

.noexc192:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit127
  %472 = getelementptr inbounds %"class.std::ctype"* %469, i64 0, i32 6
  %473 = load i8* %472, align 1, !tbaa !23
  %474 = icmp eq i8 %473, 0
  br i1 %474, label %478, label %475

; <label>:475                                     ; preds = %.noexc192
  %476 = getelementptr inbounds %"class.std::ctype"* %469, i64 0, i32 7, i64 10
  %477 = load i8* %476, align 1, !tbaa !10
  br label %.noexc130

; <label>:478                                     ; preds = %.noexc192
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %469)
          to label %.noexc196 unwind label %517

.noexc196:                                        ; preds = %478
  %479 = bitcast %"class.std::ctype"* %469 to i8 (%"class.std::ctype"*, i8)***
  %480 = load i8 (%"class.std::ctype"*, i8)*** %479, align 8, !tbaa !11
  %481 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %480, i64 6
  %482 = load i8 (%"class.std::ctype"*, i8)** %481, align 8
  %483 = invoke signext i8 %482(%"class.std::ctype"* %469, i8 signext 10)
          to label %.noexc130 unwind label %517

.noexc130:                                        ; preds = %.noexc196, %475
  %.0.i195 = phi i8 [ %477, %475 ], [ %483, %.noexc196 ]
  %484 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i195)
          to label %.noexc131 unwind label %517

.noexc131:                                        ; preds = %.noexc130
  %485 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %484)
          to label %_ZNSolsEPFRSoS_E.exit129 unwind label %517

_ZNSolsEPFRSoS_E.exit129:                         ; preds = %.noexc131
  call void @__cxa_end_catch()
  br label %460

; <label>:486                                     ; preds = %310
  %487 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([51 x i8]* @.str12, i64 0, i64 0), i64 50)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit137 unwind label %406

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit137: ; preds = %486
  %488 = load i32* %value4, align 4, !tbaa !10
  %489 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* @_ZSt4cout, i32 %488)
          to label %490 unwind label %406

; <label>:490                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit137
  %491 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %489, i8* getelementptr inbounds ([9 x i8]* @.str8, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139 unwind label %406

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139: ; preds = %490
  %492 = bitcast %"class.std::basic_ostream"* %489 to i8**
  %493 = load i8** %492, align 8, !tbaa !11
  %494 = getelementptr i8* %493, i64 -24
  %495 = bitcast i8* %494 to i64*
  %496 = load i64* %495, align 8
  %497 = bitcast %"class.std::basic_ostream"* %489 to i8*
  %.sum221 = add i64 %496, 240
  %498 = getelementptr inbounds i8* %497, i64 %.sum221
  %499 = bitcast i8* %498 to %"class.std::ctype"**
  %500 = load %"class.std::ctype"** %499, align 8, !tbaa !20
  %501 = icmp eq %"class.std::ctype"* %500, null
  br i1 %501, label %502, label %.noexc140

; <label>:502                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc199 unwind label %406

.noexc199:                                        ; preds = %502
  unreachable

.noexc140:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit139
  %503 = getelementptr inbounds %"class.std::ctype"* %500, i64 0, i32 6
  %504 = load i8* %503, align 1, !tbaa !23
  %505 = icmp eq i8 %504, 0
  br i1 %505, label %509, label %506

; <label>:506                                     ; preds = %.noexc140
  %507 = getelementptr inbounds %"class.std::ctype"* %500, i64 0, i32 7, i64 10
  %508 = load i8* %507, align 1, !tbaa !10
  br label %.noexc

; <label>:509                                     ; preds = %.noexc140
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %500)
          to label %.noexc144 unwind label %406

.noexc144:                                        ; preds = %509
  %510 = bitcast %"class.std::ctype"* %500 to i8 (%"class.std::ctype"*, i8)***
  %511 = load i8 (%"class.std::ctype"*, i8)*** %510, align 8, !tbaa !11
  %512 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %511, i64 6
  %513 = load i8 (%"class.std::ctype"*, i8)** %512, align 8
  %514 = invoke signext i8 %513(%"class.std::ctype"* %500, i8 signext 10)
          to label %.noexc unwind label %406

.noexc:                                           ; preds = %.noexc144, %506
  %.0.i143 = phi i8 [ %508, %506 ], [ %514, %.noexc144 ]
  %515 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %489, i8 signext %.0.i143)
          to label %.noexc8 unwind label %406

.noexc8:                                          ; preds = %.noexc
  %516 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %515)
          to label %_ZNSolsEPFRSoS_E.exit89 unwind label %406

_ZNSolsEPFRSoS_E.exit89:                          ; preds = %.noexc8, %.noexc91
  call void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %iss3) #2
  call void @llvm.lifetime.end(i64 360, i8* %276) #2
  br label %460

; <label>:517                                     ; preds = %.noexc131, %.noexc130, %.noexc196, %478, %471, %461
  %518 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %519 = extractvalue { i8*, i32 } %518, 0
  %520 = extractvalue { i8*, i32 } %518, 1
  invoke void @__cxa_end_catch()
          to label %525 unwind label %528

; <label>:521                                     ; preds = %.noexc121, %.noexc120, %.noexc189, %452, %445, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit115, %433, %422, %413
  %522 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %523 = extractvalue { i8*, i32 } %522, 0
  %524 = extractvalue { i8*, i32 } %522, 1
  invoke void @__cxa_end_catch()
          to label %525 unwind label %528

; <label>:525                                     ; preds = %521, %517, %376, %219
  %.27 = phi i32 [ %524, %521 ], [ %520, %517 ], [ %379, %376 ], [ %222, %219 ]
  %.6 = phi i8* [ %523, %521 ], [ %519, %517 ], [ %378, %376 ], [ %221, %219 ]
  %526 = insertvalue { i8*, i32 } undef, i8* %.6, 0
  %527 = insertvalue { i8*, i32 } %526, i32 %.27, 1
  resume { i8*, i32 } %527

; <label>:528                                     ; preds = %521, %517, %376, %219
  %529 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %530 = extractvalue { i8*, i32 } %529, 0
  call void @__clang_call_terminate(i8* %530) #10
  unreachable
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEEC1ERKSsSt13_Ios_Openmode(%"class.std::basic_istringstream"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = bitcast %"class.std::basic_istringstream"* %this to i8*
  %4 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2
  %5 = getelementptr inbounds %"class.std::basic_ios"* %4, i64 0, i32 0
  call void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"* %5) #2
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
  call void @llvm.memset.p0i8.i64(i8* %11, i8 0, i64 32, i32 8, i1 false) #2
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
  call void @llvm.lifetime.start(i64 1, i8* %51) #2
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
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %55, %"class.std::allocator"* %2) #2
  br label %_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %68, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %46
  call void @llvm.lifetime.end(i64 1, i8* %51) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %50, align 8, !tbaa !11
  %69 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %69) #2
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
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %5) #2
  %79 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %80 = insertvalue { i8*, i32 } %79, i32 %.1, 1
  resume { i8*, i32 } %80
}

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: uwtable
define internal fastcc void @_ZN12_GLOBAL__N_1rsERSiRNS_8TestEnum4typeE(%"class.std::basic_istream"* %in, i32* nocapture %value) #3 {
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
  br i1 %18, label %59, label %72

; <label>:19                                      ; preds = %69, %64, %59, %0
  %20 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %21 = extractvalue { i8*, i32 } %20, 0
  %22 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %22) #2
  %23 = load i8** %5, align 8, !tbaa !1
  %24 = getelementptr inbounds i8* %23, i64 -24
  %25 = bitcast i8* %24 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %26 = icmp eq i8* %24, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %26, label %39, label %27, !prof !7

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
  br i1 %37, label %38, label %39

; <label>:38                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %25, %"class.std::allocator"* %4) #2
  br label %39

; <label>:39                                      ; preds = %38, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %19
  call void @llvm.lifetime.end(i64 1, i8* %22) #2
  %40 = call i8* @__cxa_begin_catch(i8* %21) #2
  %41 = bitcast %"class.std::basic_istream"* %in to i8**
  %42 = load i8** %41, align 8, !tbaa !11
  %43 = getelementptr i8* %42, i64 -24
  %44 = bitcast i8* %43 to i64*
  %45 = load i64* %44, align 8
  %46 = bitcast %"class.std::basic_istream"* %in to i8*
  %47 = getelementptr inbounds i8* %46, i64 %45
  %48 = bitcast i8* %47 to %"class.std::basic_ios"*
  %.sum = add i64 %45, 28
  %49 = getelementptr inbounds i8* %46, i64 %.sum
  %50 = bitcast i8* %49 to i32*
  %51 = load i32* %50, align 4, !tbaa !25
  %52 = and i32 %51, 4
  %53 = icmp eq i32 %52, 0
  %.sum6 = add i64 %45, 32
  %54 = getelementptr inbounds i8* %46, i64 %.sum6
  %55 = bitcast i8* %54 to i32*
  %56 = load i32* %55, align 4, !tbaa !13
  %57 = or i32 %56, 4
  br i1 %53, label %102, label %58

; <label>:58                                      ; preds = %39
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %48, i32 %57)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit4 unwind label %94

; <label>:59                                      ; preds = %7
  %60 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw, i8* getelementptr inbounds ([5 x i8]* @.str15, i64 0, i64 0))
          to label %61 unwind label %19

; <label>:61                                      ; preds = %59
  %62 = icmp eq i32 %60, 0
  br i1 %62, label %63, label %64

; <label>:63                                      ; preds = %61
  store i32 0, i32* %value, align 4, !tbaa !10
  br label %72

; <label>:64                                      ; preds = %61
  %65 = invoke i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"* %raw, i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0))
          to label %66 unwind label %19

; <label>:66                                      ; preds = %64
  %67 = icmp eq i32 %65, 0
  br i1 %67, label %68, label %69

; <label>:68                                      ; preds = %66
  store i32 1, i32* %value, align 4, !tbaa !10
  br label %72

; <label>:69                                      ; preds = %66
  %70 = call i8* @__cxa_allocate_exception(i64 8) #2
  %71 = bitcast i8* %70 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVSt9exception, i64 0, i64 2) to i32 (...)**), i32 (...)*** %71, align 8, !tbaa !11
  invoke void @__cxa_throw(i8* %70, i8* bitcast (i8** @_ZTISt9exception to i8*), i8* bitcast (void (%"class.std::exception"*)* @_ZNSt9exceptionD1Ev to i8*)) #9
          to label %110 unwind label %19

; <label>:72                                      ; preds = %68, %63, %7
  %73 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %73) #2
  %74 = load i8** %5, align 8, !tbaa !1
  %75 = getelementptr inbounds i8* %74, i64 -24
  %76 = bitcast i8* %75 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %77 = icmp eq i8* %75, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %77, label %_ZNSsD1Ev.exit3, label %78, !prof !7

; <label>:78                                      ; preds = %72
  %79 = getelementptr inbounds i8* %74, i64 -8
  %80 = bitcast i8* %79 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %81, label %85

; <label>:81                                      ; preds = %78
  %82 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %82)
  %83 = atomicrmw volatile add i32* %80, i32 -1 acq_rel
  store i32 %83, i32* %1, align 4
  %84 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %82)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2

; <label>:85                                      ; preds = %78
  %86 = load i32* %80, align 4, !tbaa !8
  %87 = add nsw i32 %86, -1
  store i32 %87, i32* %80, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2: ; preds = %85, %81
  %.0.i.i.i.i1 = phi i32 [ %84, %81 ], [ %86, %85 ]
  %88 = icmp slt i32 %.0.i.i.i.i1, 1
  br i1 %88, label %89, label %_ZNSsD1Ev.exit3

; <label>:89                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %76, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit3

; <label>:90                                      ; preds = %102, %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit4, %100
  %91 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %92 = extractvalue { i8*, i32 } %91, 0
  %93 = extractvalue { i8*, i32 } %91, 1
  br label %103

; <label>:94                                      ; preds = %58
  %95 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)
  %96 = extractvalue { i8*, i32 } %95, 0
  %97 = extractvalue { i8*, i32 } %95, 1
  %98 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTINSt8ios_base7failureE to i8*)) #2
  %99 = icmp eq i32 %97, %98
  br i1 %99, label %100, label %103

; <label>:100                                     ; preds = %94
  %101 = call i8* @__cxa_begin_catch(i8* %96) #2
  invoke void @__cxa_end_catch()
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit4 unwind label %90

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit4: ; preds = %100, %58
  invoke void @__cxa_rethrow() #9
          to label %110 unwind label %90

; <label>:102                                     ; preds = %39
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %48, i32 %57)
          to label %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit unwind label %90

_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit: ; preds = %102
  call void @__cxa_end_catch()
  br label %_ZNSsD1Ev.exit3

; <label>:103                                     ; preds = %94, %90
  %.03 = phi i32 [ %93, %90 ], [ %97, %94 ]
  %.12 = phi i8* [ %92, %90 ], [ %96, %94 ]
  invoke void @__cxa_end_catch()
          to label %104 unwind label %107

_ZNSsD1Ev.exit3:                                  ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit, %89, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2, %72
  ret void

; <label>:104                                     ; preds = %103
  %105 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %106 = insertvalue { i8*, i32 } %105, i32 %.03, 1
  resume { i8*, i32 } %106

; <label>:107                                     ; preds = %103
  %108 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %109 = extractvalue { i8*, i32 } %108, 0
  call void @__clang_call_terminate(i8* %109) #10
  unreachable

; <label>:110                                     ; preds = %_ZNSt9basic_iosIcSt11char_traitsIcEE8setstateESt12_Ios_Iostate.exit4, %69
  unreachable
}

declare %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #0

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED1Ev(%"class.std::basic_istringstream"* %this) unnamed_addr #4 align 2 {
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
  call void @llvm.lifetime.start(i64 1, i8* %13) #2
  %14 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 2, i32 0, i32 0
  %15 = load i8** %14, align 8, !tbaa !1
  %16 = getelementptr inbounds i8* %15, i64 -24
  %17 = bitcast i8* %16 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %18 = icmp eq i8* %16, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %18, label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit, label %19, !prof !7

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
  br i1 %29, label %30, label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

; <label>:30                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %17, %"class.std::allocator"* %2) #2
  br label %_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit

_ZNSt19basic_istringstreamIcSt11char_traitsIcESaIcEED2Ev.exit: ; preds = %30, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %13) #2
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !11
  %31 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 1, i32 0, i32 7
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %31) #2
  %32 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 1), align 8
  %.c.i.i = bitcast i8* %32 to i32 (...)**
  store i32 (...)** %.c.i.i, i32 (...)*** %4, align 8, !tbaa !11
  %33 = load i8** getelementptr inbounds ([4 x i8*]* @_ZTTSt19basic_istringstreamIcSt11char_traitsIcESaIcEE, i64 0, i64 2), align 8
  %34 = getelementptr i8* %32, i64 -24
  %35 = bitcast i8* %34 to i64*
  %36 = load i64* %35, align 8
  %37 = getelementptr inbounds i8* %9, i64 %36
  %38 = bitcast i8* %37 to i8**
  store i8* %33, i8** %38, align 8, !tbaa !11
  %39 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 0, i32 1
  store i64 0, i64* %39, align 8, !tbaa !29
  %40 = getelementptr inbounds %"class.std::basic_istringstream"* %this, i64 0, i32 2, i32 0
  call void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"* %40) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #5 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #2
  tail call void @_ZSt9terminatev() #10
  unreachable
}

declare void @_ZSt9terminatev()

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #6

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #7

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #8

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseD2Ev(%"class.std::ios_base"*) #1

; Function Attrs: nounwind
declare void @_ZNSt6localeD1Ev(%"class.std::locale"*) #1

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E(%"class.std::basic_ios"*, %"class.std::basic_streambuf"*) #0

; Function Attrs: uwtable
define available_externally void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEEC2ERKSsSt13_Ios_Openmode(%"class.std::basic_stringbuf"* %this, %"class.std::basic_string"* nocapture readonly %__str, i32 %__mode) unnamed_addr #3 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::allocator", align 1
  %4 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !11
  %5 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 1
  %6 = getelementptr inbounds %"class.std::basic_stringbuf"* %this, i64 0, i32 0, i32 7
  %7 = bitcast i8** %5 to i8*
  call void @llvm.memset.p0i8.i64(i8* %7, i8 0, i64 48, i32 8, i1 false) #2
  call void @_ZNSt6localeC1Ev(%"class.std::locale"* %6) #2
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
  call void @llvm.lifetime.start(i64 1, i8* %30) #2
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
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %34, %"class.std::allocator"* %2) #2
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %47, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %26, %22
  %.01 = phi i8* [ %24, %22 ], [ %28, %26 ], [ %28, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %28, %47 ]
  %.0 = phi i32 [ %25, %22 ], [ %29, %26 ], [ %29, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i ], [ %29, %47 ]
  store i32 (...)** bitcast (i8** getelementptr inbounds ([16 x i8*]* @_ZTVSt15basic_streambufIcSt11char_traitsIcEE, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !11
  call void @_ZNSt6localeD1Ev(%"class.std::locale"* %6) #2
  %48 = insertvalue { i8*, i32 } undef, i8* %.01, 0
  %49 = insertvalue { i8*, i32 } %48, i32 %.0, 1
  resume { i8*, i32 } %49
}

declare void @_ZNSsC1EPKcmRKSaIcE(%"class.std::basic_string"*, i8*, i64, %"class.std::allocator"*) #0

declare void @_ZNSt15basic_stringbufIcSt11char_traitsIcESaIcEE7_M_syncEPcmm(%"class.std::basic_stringbuf"*, i8*, i64, i64) #0

; Function Attrs: nounwind
declare void @_ZNSt6localeC1Ev(%"class.std::locale"*) #1

; Function Attrs: nounwind
declare void @_ZNSt8ios_baseC2Ev(%"class.std::ios_base"*) #1

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

declare %"class.std::basic_istream"* @_ZStrsIcSt11char_traitsIcESaIcEERSt13basic_istreamIT_T0_ES7_RSbIS4_S5_T1_E(%"class.std::basic_istream"*, %"class.std::basic_string"*) #0

declare i8* @__cxa_allocate_exception(i64)

; Function Attrs: nounwind
declare void @_ZNSt9exceptionD1Ev(%"class.std::exception"*) #1

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @__cxa_rethrow()

declare i32 @_ZNKSs7compareEPKc(%"class.std::basic_string"*, i8*) #0

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline noreturn nounwind }
attributes #6 = { nounwind readnone }
attributes #7 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { noreturn }
attributes #10 = { noreturn nounwind }

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
