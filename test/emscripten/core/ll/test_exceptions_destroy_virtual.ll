; ModuleID = 'test_exceptions_destroy_virtual.bc'
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
%"class.std::runtime_error" = type { %"class.std::exception", %"class.std::basic_string" }
%"class.std::exception" = type { i32 (...)** }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }
%"class.<anonymous namespace>::test_exception" = type { i32 (...)**, %"class.std::runtime_error" }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@_ZTISt9exception = external constant i8*
@_ZTVN10__cxxabiv121__vmi_class_type_infoE = external global i8*
@_ZTSN12_GLOBAL__N_114test_exceptionE = internal constant [33 x i8] c"N12_GLOBAL__N_114test_exceptionE\00"
@_ZTISt13runtime_error = external constant i8*
@_ZTIN12_GLOBAL__N_114test_exceptionE = internal unnamed_addr constant { i8*, i8*, i32, i32, i8*, i64 } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv121__vmi_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([33 x i8]* @_ZTSN12_GLOBAL__N_114test_exceptionE, i32 0, i32 0), i32 0, i32 1, i8* bitcast (i8** @_ZTISt13runtime_error to i8*), i64 -6141 }
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str = private unnamed_addr constant [19 x i8] c"Caught exception: \00", align 1
@.str1 = private unnamed_addr constant [23 x i8] c"TestClass::Destruction\00", align 1
@_ZTVN12_GLOBAL__N_114test_exceptionE = internal unnamed_addr constant [12 x i8*] [i8* inttoptr (i64 8 to i8*), i8* null, i8* bitcast ({ i8*, i8*, i32, i32, i8*, i64 }* @_ZTIN12_GLOBAL__N_114test_exceptionE to i8*), i8* bitcast (void (%"class.<anonymous namespace>::test_exception"*)* @_ZN12_GLOBAL__N_114test_exceptionD1Ev to i8*), i8* bitcast (void (%"class.<anonymous namespace>::test_exception"*)* @_ZN12_GLOBAL__N_114test_exceptionD0Ev to i8*), i8* null, i8* inttoptr (i64 -8 to i8*), i8* inttoptr (i64 -8 to i8*), i8* bitcast ({ i8*, i8*, i32, i32, i8*, i64 }* @_ZTIN12_GLOBAL__N_114test_exceptionE to i8*), i8* bitcast (void (%"class.<anonymous namespace>::test_exception"*)* @_ZTv0_n24_N12_GLOBAL__N_114test_exceptionD1Ev to i8*), i8* bitcast (void (%"class.<anonymous namespace>::test_exception"*)* @_ZTv0_n24_N12_GLOBAL__N_114test_exceptionD0Ev to i8*), i8* bitcast (i8* (%"class.std::runtime_error"*)* @_ZNKSt13runtime_error4whatEv to i8*)]
@.str2 = private unnamed_addr constant [15 x i8] c"test_exception\00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@.str3 = private unnamed_addr constant [24 x i8] c"TestClass::Construction\00", align 1
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
  %5 = alloca %"class.std::basic_string", align 8
  %6 = alloca %"class.std::allocator", align 1
  %7 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([24 x i8]* @.str3, i64 0, i64 0), i64 23)
          to label %.noexc unwind label %85

.noexc:                                           ; preds = %0
  %8 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %9 = getelementptr i8* %8, i64 -24
  %10 = bitcast i8* %9 to i64*
  %11 = load i64* %10, align 8
  %.sum.i = add i64 %11, 240
  %12 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %13 = bitcast i8* %12 to %"class.std::ctype"**
  %14 = load %"class.std::ctype"** %13, align 8, !tbaa !4
  %15 = icmp eq %"class.std::ctype"* %14, null
  br i1 %15, label %16, label %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i

; <label>:16                                      ; preds = %.noexc
  invoke void @_ZSt16__throw_bad_castv() #11
          to label %.noexc4 unwind label %85

.noexc4:                                          ; preds = %16
  unreachable

_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i:  ; preds = %.noexc
  %17 = getelementptr inbounds %"class.std::ctype"* %14, i64 0, i32 6
  %18 = load i8* %17, align 1, !tbaa !9
  %19 = icmp eq i8 %18, 0
  br i1 %19, label %23, label %20

; <label>:20                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i
  %21 = getelementptr inbounds %"class.std::ctype"* %14, i64 0, i32 7, i64 10
  %22 = load i8* %21, align 1, !tbaa !11
  br label %_ZNKSt5ctypeIcE5widenEc.exit.i

; <label>:23                                      ; preds = %_ZSt13__check_facetISt5ctypeIcEERKT_PS3_.exit.i
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %14)
          to label %.noexc5 unwind label %85

.noexc5:                                          ; preds = %23
  %24 = bitcast %"class.std::ctype"* %14 to i8 (%"class.std::ctype"*, i8)***
  %25 = load i8 (%"class.std::ctype"*, i8)*** %24, align 8, !tbaa !1
  %26 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %25, i64 6
  %27 = load i8 (%"class.std::ctype"*, i8)** %26, align 8
  %28 = invoke signext i8 %27(%"class.std::ctype"* %14, i8 signext 10)
          to label %_ZNKSt5ctypeIcE5widenEc.exit.i unwind label %85

_ZNKSt5ctypeIcE5widenEc.exit.i:                   ; preds = %.noexc5, %20
  %.0.i.i = phi i8 [ %22, %20 ], [ %28, %.noexc5 ]
  %29 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i.i)
          to label %.noexc7 unwind label %85

.noexc7:                                          ; preds = %_ZNKSt5ctypeIcE5widenEc.exit.i
  %30 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %29)
          to label %_ZN12_GLOBAL__N_19TestClassC2Ev.exit unwind label %85

_ZN12_GLOBAL__N_19TestClassC2Ev.exit:             ; preds = %.noexc7
  %31 = call i8* @__cxa_allocate_exception(i64 24) #2
  %32 = bitcast %"class.std::basic_string"* %5 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %32)
  %33 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %33)
  %34 = getelementptr inbounds i8* %31, i64 8
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %5, i8* getelementptr inbounds ([15 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator"* %6)
          to label %35 unwind label %56

; <label>:35                                      ; preds = %_ZN12_GLOBAL__N_19TestClassC2Ev.exit
  %36 = bitcast i8* %34 to %"class.std::runtime_error"*
  invoke void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"* %36, %"class.std::basic_string"* %5)
          to label %37 unwind label %60

; <label>:37                                      ; preds = %35
  %38 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %38) #2
  %39 = getelementptr inbounds %"class.std::basic_string"* %5, i64 0, i32 0, i32 0
  %40 = load i8** %39, align 8, !tbaa !12
  %41 = getelementptr inbounds i8* %40, i64 -24
  %42 = bitcast i8* %41 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %43 = icmp eq i8* %41, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %43, label %82, label %44, !prof !15

; <label>:44                                      ; preds = %37
  %45 = getelementptr inbounds i8* %40, i64 -8
  %46 = bitcast i8* %45 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %47, label %51

; <label>:47                                      ; preds = %44
  %48 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %48)
  %49 = atomicrmw volatile add i32* %46, i32 -1 acq_rel
  store i32 %49, i32* %1, align 4
  %50 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %48)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3.i

; <label>:51                                      ; preds = %44
  %52 = load i32* %46, align 4, !tbaa !16
  %53 = add nsw i32 %52, -1
  store i32 %53, i32* %46, align 4, !tbaa !16
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3.i: ; preds = %51, %47
  %.0.i.i.i.i2.i = phi i32 [ %50, %47 ], [ %52, %51 ]
  %54 = icmp slt i32 %.0.i.i.i.i2.i, 1
  br i1 %54, label %55, label %82

; <label>:55                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %42, %"class.std::allocator"* %2) #2
  br label %82

; <label>:56                                      ; preds = %_ZN12_GLOBAL__N_19TestClassC2Ev.exit
  %57 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %58 = extractvalue { i8*, i32 } %57, 0
  %59 = extractvalue { i8*, i32 } %57, 1
  br label %.body

; <label>:60                                      ; preds = %35
  %61 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %62 = extractvalue { i8*, i32 } %61, 0
  %63 = extractvalue { i8*, i32 } %61, 1
  %64 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %64) #2
  %65 = getelementptr inbounds %"class.std::basic_string"* %5, i64 0, i32 0, i32 0
  %66 = load i8** %65, align 8, !tbaa !12
  %67 = getelementptr inbounds i8* %66, i64 -24
  %68 = bitcast i8* %67 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %69 = icmp eq i8* %67, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %69, label %.body, label %70, !prof !15

; <label>:70                                      ; preds = %60
  %71 = getelementptr inbounds i8* %66, i64 -8
  %72 = bitcast i8* %71 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %73, label %77

; <label>:73                                      ; preds = %70
  %74 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %74)
  %75 = atomicrmw volatile add i32* %72, i32 -1 acq_rel
  store i32 %75, i32* %3, align 4
  %76 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %74)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:77                                      ; preds = %70
  %78 = load i32* %72, align 4, !tbaa !16
  %79 = add nsw i32 %78, -1
  store i32 %79, i32* %72, align 4, !tbaa !16
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %77, %73
  %.0.i.i.i.i.i = phi i32 [ %76, %73 ], [ %78, %77 ]
  %80 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %80, label %81, label %.body

; <label>:81                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %68, %"class.std::allocator"* %4) #2
  br label %.body

; <label>:82                                      ; preds = %55, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i3.i, %37
  call void @llvm.lifetime.end(i64 1, i8* %38) #2
  %83 = bitcast i8* %31 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([12 x i8*]* @_ZTVN12_GLOBAL__N_114test_exceptionE, i64 0, i64 3) to i32 (...)**), i32 (...)*** %83, align 8, !tbaa !1
  %84 = bitcast i8* %34 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([12 x i8*]* @_ZTVN12_GLOBAL__N_114test_exceptionE, i64 0, i64 9) to i32 (...)**), i32 (...)*** %84, align 8, !tbaa !1
  call void @llvm.lifetime.end(i64 8, i8* %32)
  call void @llvm.lifetime.end(i64 1, i8* %33)
  invoke void @__cxa_throw(i8* %31, i8* bitcast ({ i8*, i8*, i32, i32, i8*, i64 }* @_ZTIN12_GLOBAL__N_114test_exceptionE to i8*), i8* bitcast (void (%"class.<anonymous namespace>::test_exception"*)* @_ZN12_GLOBAL__N_114test_exceptionD1Ev to i8*)) #11
          to label %180 unwind label %89

; <label>:85                                      ; preds = %.noexc7, %_ZNKSt5ctypeIcE5widenEc.exit.i, %.noexc5, %23, %16, %0
  %86 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %87 = extractvalue { i8*, i32 } %86, 0
  %88 = extractvalue { i8*, i32 } %86, 1
  br label %_ZN12_GLOBAL__N_19TestClassD2Ev.exit

.body:                                            ; preds = %81, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %60, %56
  %.01.i = phi i8* [ %58, %56 ], [ %62, %60 ], [ %62, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i ], [ %62, %81 ]
  %.0.i = phi i32 [ %59, %56 ], [ %63, %60 ], [ %63, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i ], [ %63, %81 ]
  call void @__cxa_free_exception(i8* %31) #2
  br label %93

; <label>:89                                      ; preds = %82
  %90 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %91 = extractvalue { i8*, i32 } %90, 0
  %92 = extractvalue { i8*, i32 } %90, 1
  br label %93

; <label>:93                                      ; preds = %89, %.body
  %.01 = phi i32 [ %92, %89 ], [ %.0.i, %.body ]
  %.0 = phi i8* [ %91, %89 ], [ %.01.i, %.body ]
  %94 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([23 x i8]* @.str1, i64 0, i64 0), i64 22)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i unwind label %118

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i: ; preds = %93
  %95 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %96 = getelementptr i8* %95, i64 -24
  %97 = bitcast i8* %96 to i64*
  %98 = load i64* %97, align 8
  %.sum.i9 = add i64 %98, 240
  %99 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i9
  %100 = bitcast i8* %99 to %"class.std::ctype"**
  %101 = load %"class.std::ctype"** %100, align 8, !tbaa !4
  %102 = icmp eq %"class.std::ctype"* %101, null
  br i1 %102, label %103, label %.noexc4.i

; <label>:103                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i
  invoke void @_ZSt16__throw_bad_castv() #11
          to label %.noexc8.i unwind label %118

.noexc8.i:                                        ; preds = %103
  unreachable

.noexc4.i:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit.i
  %104 = getelementptr inbounds %"class.std::ctype"* %101, i64 0, i32 6
  %105 = load i8* %104, align 1, !tbaa !9
  %106 = icmp eq i8 %105, 0
  br i1 %106, label %110, label %107

; <label>:107                                     ; preds = %.noexc4.i
  %108 = getelementptr inbounds %"class.std::ctype"* %101, i64 0, i32 7, i64 10
  %109 = load i8* %108, align 1, !tbaa !11
  br label %.noexc.i

; <label>:110                                     ; preds = %.noexc4.i
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %101)
          to label %.noexc6.i unwind label %118

.noexc6.i:                                        ; preds = %110
  %111 = bitcast %"class.std::ctype"* %101 to i8 (%"class.std::ctype"*, i8)***
  %112 = load i8 (%"class.std::ctype"*, i8)*** %111, align 8, !tbaa !1
  %113 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %112, i64 6
  %114 = load i8 (%"class.std::ctype"*, i8)** %113, align 8
  %115 = invoke signext i8 %114(%"class.std::ctype"* %101, i8 signext 10)
          to label %.noexc.i unwind label %118

.noexc.i:                                         ; preds = %.noexc6.i, %107
  %.0.i.i10 = phi i8 [ %109, %107 ], [ %115, %.noexc6.i ]
  %116 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i.i10)
          to label %.noexc1.i unwind label %118

.noexc1.i:                                        ; preds = %.noexc.i
  %117 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %116)
          to label %_ZN12_GLOBAL__N_19TestClassD2Ev.exit unwind label %118

; <label>:118                                     ; preds = %.noexc1.i, %.noexc.i, %.noexc6.i, %110, %103, %93
  %119 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %120 = extractvalue { i8*, i32 } %119, 0
  call void @__clang_call_terminate(i8* %120) #12
  unreachable

_ZN12_GLOBAL__N_19TestClassD2Ev.exit:             ; preds = %.noexc1.i, %85
  %.12 = phi i32 [ %88, %85 ], [ %.01, %.noexc1.i ]
  %.1 = phi i8* [ %87, %85 ], [ %.0, %.noexc1.i ]
  %121 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #2
  %122 = icmp eq i32 %.12, %121
  br i1 %122, label %123, label %174

; <label>:123                                     ; preds = %_ZN12_GLOBAL__N_19TestClassD2Ev.exit
  %124 = call i8* @__cxa_begin_catch(i8* %.1) #2
  %125 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %170

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %123
  %126 = bitcast i8* %124 to %"class.std::exception"*
  %127 = bitcast i8* %124 to i8* (%"class.std::exception"*)***
  %128 = load i8* (%"class.std::exception"*)*** %127, align 8, !tbaa !1
  %129 = getelementptr inbounds i8* (%"class.std::exception"*)** %128, i64 2
  %130 = load i8* (%"class.std::exception"*)** %129, align 8
  %131 = call i8* %130(%"class.std::exception"* %126) #2
  %132 = icmp eq i8* %131, null
  br i1 %132, label %133, label %144

; <label>:133                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %134 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %135 = getelementptr i8* %134, i64 -24
  %136 = bitcast i8* %135 to i64*
  %137 = load i64* %136, align 8
  %138 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %137
  %139 = bitcast i8* %138 to %"class.std::basic_ios"*
  %.sum.i12 = add i64 %137, 32
  %140 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i12
  %141 = bitcast i8* %140 to i32*
  %142 = load i32* %141, align 4, !tbaa !18
  %143 = or i32 %142, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %139, i32 %143)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15 unwind label %170

; <label>:144                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %145 = call i64 @strlen(i8* %131) #2
  %146 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %131, i64 %145)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15 unwind label %170

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15: ; preds = %144, %133
  %147 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %148 = getelementptr i8* %147, i64 -24
  %149 = bitcast i8* %148 to i64*
  %150 = load i64* %149, align 8
  %.sum = add i64 %150, 240
  %151 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %152 = bitcast i8* %151 to %"class.std::ctype"**
  %153 = load %"class.std::ctype"** %152, align 8, !tbaa !4
  %154 = icmp eq %"class.std::ctype"* %153, null
  br i1 %154, label %155, label %.noexc21

; <label>:155                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15
  invoke void @_ZSt16__throw_bad_castv() #11
          to label %.noexc26 unwind label %170

.noexc26:                                         ; preds = %155
  unreachable

.noexc21:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15
  %156 = getelementptr inbounds %"class.std::ctype"* %153, i64 0, i32 6
  %157 = load i8* %156, align 1, !tbaa !9
  %158 = icmp eq i8 %157, 0
  br i1 %158, label %162, label %159

; <label>:159                                     ; preds = %.noexc21
  %160 = getelementptr inbounds %"class.std::ctype"* %153, i64 0, i32 7, i64 10
  %161 = load i8* %160, align 1, !tbaa !11
  br label %.noexc17

; <label>:162                                     ; preds = %.noexc21
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %153)
          to label %.noexc24 unwind label %170

.noexc24:                                         ; preds = %162
  %163 = bitcast %"class.std::ctype"* %153 to i8 (%"class.std::ctype"*, i8)***
  %164 = load i8 (%"class.std::ctype"*, i8)*** %163, align 8, !tbaa !1
  %165 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %164, i64 6
  %166 = load i8 (%"class.std::ctype"*, i8)** %165, align 8
  %167 = invoke signext i8 %166(%"class.std::ctype"* %153, i8 signext 10)
          to label %.noexc17 unwind label %170

.noexc17:                                         ; preds = %.noexc24, %159
  %.0.i23 = phi i8 [ %161, %159 ], [ %167, %.noexc24 ]
  %168 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i23)
          to label %.noexc18 unwind label %170

.noexc18:                                         ; preds = %.noexc17
  %169 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %168)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %170

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc18
  call void @__cxa_end_catch()
  ret i32 0

; <label>:170                                     ; preds = %.noexc18, %.noexc17, %.noexc24, %162, %155, %144, %133, %123
  %171 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %172 = extractvalue { i8*, i32 } %171, 0
  %173 = extractvalue { i8*, i32 } %171, 1
  invoke void @__cxa_end_catch()
          to label %174 unwind label %177

; <label>:174                                     ; preds = %170, %_ZN12_GLOBAL__N_19TestClassD2Ev.exit
  %.23 = phi i32 [ %173, %170 ], [ %.12, %_ZN12_GLOBAL__N_19TestClassD2Ev.exit ]
  %.2 = phi i8* [ %172, %170 ], [ %.1, %_ZN12_GLOBAL__N_19TestClassD2Ev.exit ]
  %175 = insertvalue { i8*, i32 } undef, i8* %.2, 0
  %176 = insertvalue { i8*, i32 } %175, i32 %.23, 1
  resume { i8*, i32 } %176

; <label>:177                                     ; preds = %170
  %178 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %179 = extractvalue { i8*, i32 } %178, 0
  call void @__clang_call_terminate(i8* %179) #12
  unreachable

; <label>:180                                     ; preds = %82
  unreachable
}

declare i32 @__gxx_personality_v0(...)

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_free_exception(i8*)

; Function Attrs: inlinehint nounwind uwtable
define internal void @_ZN12_GLOBAL__N_114test_exceptionD1Ev(%"class.<anonymous namespace>::test_exception"* %this) unnamed_addr #4 align 2 {
  %1 = getelementptr inbounds %"class.<anonymous namespace>::test_exception"* %this, i64 0, i32 1
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %1) #2
  ret void
}

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #5

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #6 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #2
  tail call void @_ZSt9terminatev() #12
  unreachable
}

declare void @_ZSt9terminatev()

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #7

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #8

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind
declare void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"*) #1

; Function Attrs: nounwind uwtable
define internal void @_ZTv0_n24_N12_GLOBAL__N_114test_exceptionD1Ev(%"class.<anonymous namespace>::test_exception"* %this) unnamed_addr #9 align 2 {
  %1 = bitcast %"class.<anonymous namespace>::test_exception"* %this to i8*
  %2 = bitcast %"class.<anonymous namespace>::test_exception"* %this to i8**
  %3 = load i8** %2, align 8
  %4 = getelementptr inbounds i8* %3, i64 -24
  %5 = bitcast i8* %4 to i64*
  %6 = load i64* %5, align 8
  %.sum = add i64 %6, 8
  %7 = getelementptr inbounds i8* %1, i64 %.sum
  %8 = bitcast i8* %7 to %"class.std::runtime_error"*
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %8) #2
  ret void
}

; Function Attrs: inlinehint nounwind uwtable
define internal void @_ZN12_GLOBAL__N_114test_exceptionD0Ev(%"class.<anonymous namespace>::test_exception"* %this) unnamed_addr #4 align 2 {
  %1 = getelementptr inbounds %"class.<anonymous namespace>::test_exception"* %this, i64 0, i32 1
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %1) #2
  %2 = bitcast %"class.<anonymous namespace>::test_exception"* %this to i8*
  tail call void @_ZdlPv(i8* %2) #13
  ret void
}

; Function Attrs: nounwind uwtable
define internal void @_ZTv0_n24_N12_GLOBAL__N_114test_exceptionD0Ev(%"class.<anonymous namespace>::test_exception"* %this) unnamed_addr #9 align 2 {
  %1 = bitcast %"class.<anonymous namespace>::test_exception"* %this to i8*
  %2 = bitcast %"class.<anonymous namespace>::test_exception"* %this to i8**
  %3 = load i8** %2, align 8
  %4 = getelementptr inbounds i8* %3, i64 -24
  %5 = bitcast i8* %4 to i64*
  %6 = load i64* %5, align 8
  %7 = getelementptr inbounds i8* %1, i64 %6
  %.sum = add i64 %6, 8
  %8 = getelementptr inbounds i8* %1, i64 %.sum
  %9 = bitcast i8* %8 to %"class.std::runtime_error"*
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %9) #2
  tail call void @_ZdlPv(i8* %7) #13
  ret void
}

; Function Attrs: nounwind
declare i8* @_ZNKSt13runtime_error4whatEv(%"class.std::runtime_error"*) #1

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #10

declare void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"*, %"class.std::basic_string"*) #0

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #2
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { inlinehint nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { noinline noreturn nounwind }
attributes #7 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #11 = { noreturn }
attributes #12 = { noreturn nounwind }
attributes #13 = { builtin nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"vtable pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !6, i64 240}
!5 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !6, i64 216, metadata !7, i64 224, metadata !8, i64 225, metadata !6, i64 232, metadata !6, i64 240, metadata !6, i64 248, metadata !6, i64 256}
!6 = metadata !{metadata !"any pointer", metadata !7, i64 0}
!7 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!8 = metadata !{metadata !"bool", metadata !7, i64 0}
!9 = metadata !{metadata !10, metadata !7, i64 56}
!10 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !6, i64 16, metadata !8, i64 24, metadata !6, i64 32, metadata !6, i64 40, metadata !6, i64 48, metadata !7, i64 56, metadata !7, i64 57, metadata !7, i64 313, metadata !7, i64 569}
!11 = metadata !{metadata !7, metadata !7, i64 0}
!12 = metadata !{metadata !13, metadata !6, i64 0}
!13 = metadata !{metadata !"_ZTSSs", metadata !14, i64 0}
!14 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !6, i64 0}
!15 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!16 = metadata !{metadata !17, metadata !17, i64 0}
!17 = metadata !{metadata !"int", metadata !7, i64 0}
!18 = metadata !{metadata !19, metadata !22, i64 32}
!19 = metadata !{metadata !"_ZTSSt8ios_base", metadata !20, i64 8, metadata !20, i64 16, metadata !21, i64 24, metadata !22, i64 28, metadata !22, i64 32, metadata !6, i64 40, metadata !23, i64 48, metadata !7, i64 64, metadata !17, i64 192, metadata !6, i64 200, metadata !24, i64 208}
!20 = metadata !{metadata !"long", metadata !7, i64 0}
!21 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !7, i64 0}
!22 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !7, i64 0}
!23 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !6, i64 0, metadata !20, i64 8}
!24 = metadata !{metadata !"_ZTSSt6locale", metadata !6, i64 0}
