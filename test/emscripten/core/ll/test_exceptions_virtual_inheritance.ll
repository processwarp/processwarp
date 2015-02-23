; ModuleID = 'test_exceptions_virtual_inheritance.bc'
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
%struct.my_exception = type { i32 (...)**, %"class.std::runtime_error" }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@_ZTISt13runtime_error = external constant i8*
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str = private unnamed_addr constant [24 x i8] c"Throwing ::my_exception\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"my_what\00", align 1
@_ZTVN10__cxxabiv121__vmi_class_type_infoE = external global i8*
@_ZTS12my_exception = linkonce_odr constant [15 x i8] c"12my_exception\00"
@_ZTI12my_exception = linkonce_odr unnamed_addr constant { i8*, i8*, i32, i32, i8*, i64 } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv121__vmi_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([15 x i8]* @_ZTS12my_exception, i32 0, i32 0), i32 0, i32 1, i8* bitcast (i8** @_ZTISt13runtime_error to i8*), i64 -6141 }
@.str2 = private unnamed_addr constant [28 x i8] c"Caught std::runtime_error: \00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@_ZTV12my_exception = linkonce_odr unnamed_addr constant [12 x i8*] [i8* inttoptr (i64 8 to i8*), i8* null, i8* bitcast ({ i8*, i8*, i32, i32, i8*, i64 }* @_ZTI12my_exception to i8*), i8* bitcast (void (%struct.my_exception*)* @_ZN12my_exceptionD1Ev to i8*), i8* bitcast (void (%struct.my_exception*)* @_ZN12my_exceptionD0Ev to i8*), i8* null, i8* inttoptr (i64 -8 to i8*), i8* inttoptr (i64 -8 to i8*), i8* bitcast ({ i8*, i8*, i32, i32, i8*, i64 }* @_ZTI12my_exception to i8*), i8* bitcast (void (%struct.my_exception*)* @_ZTv0_n24_N12my_exceptionD1Ev to i8*), i8* bitcast (void (%struct.my_exception*)* @_ZTv0_n24_N12my_exceptionD0Ev to i8*), i8* bitcast (i8* (%"class.std::runtime_error"*)* @_ZNKSt13runtime_error4whatEv to i8*)]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::basic_string", align 8
  %4 = alloca %"class.std::allocator", align 1
  %5 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([24 x i8]* @.str, i64 0, i64 0), i64 23)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %36

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %0
  %6 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %7 = getelementptr i8* %6, i64 -24
  %8 = bitcast i8* %7 to i64*
  %9 = load i64* %8, align 8
  %.sum39 = add i64 %9, 240
  %10 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum39
  %11 = bitcast i8* %10 to %"class.std::ctype"**
  %12 = load %"class.std::ctype"** %11, align 8, !tbaa !4
  %13 = icmp eq %"class.std::ctype"* %12, null
  br i1 %13, label %14, label %.noexc10

; <label>:14                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #11
          to label %.noexc27 unwind label %36

.noexc27:                                         ; preds = %14
  unreachable

.noexc10:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %15 = getelementptr inbounds %"class.std::ctype"* %12, i64 0, i32 6
  %16 = load i8* %15, align 1, !tbaa !9
  %17 = icmp eq i8 %16, 0
  br i1 %17, label %21, label %18

; <label>:18                                      ; preds = %.noexc10
  %19 = getelementptr inbounds %"class.std::ctype"* %12, i64 0, i32 7, i64 10
  %20 = load i8* %19, align 1, !tbaa !11
  br label %.noexc

; <label>:21                                      ; preds = %.noexc10
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %12)
          to label %.noexc12 unwind label %36

.noexc12:                                         ; preds = %21
  %22 = bitcast %"class.std::ctype"* %12 to i8 (%"class.std::ctype"*, i8)***
  %23 = load i8 (%"class.std::ctype"*, i8)*** %22, align 8, !tbaa !1
  %24 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %23, i64 6
  %25 = load i8 (%"class.std::ctype"*, i8)** %24, align 8
  %26 = invoke signext i8 %25(%"class.std::ctype"* %12, i8 signext 10)
          to label %.noexc unwind label %36

.noexc:                                           ; preds = %.noexc12, %18
  %.0.i = phi i8 [ %20, %18 ], [ %26, %.noexc12 ]
  %27 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc6 unwind label %36

.noexc6:                                          ; preds = %.noexc
  %28 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %27)
          to label %_ZNSolsEPFRSoS_E.exit unwind label %36

_ZNSolsEPFRSoS_E.exit:                            ; preds = %.noexc6
  %29 = call i8* @__cxa_allocate_exception(i64 24) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %3, i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), %"class.std::allocator"* %4)
          to label %30 unwind label %.thread

; <label>:30                                      ; preds = %_ZNSolsEPFRSoS_E.exit
  %31 = getelementptr inbounds i8* %29, i64 8
  %32 = bitcast i8* %31 to %"class.std::runtime_error"*
  invoke void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"* %32, %"class.std::basic_string"* %3)
          to label %33 unwind label %43

; <label>:33                                      ; preds = %30
  %34 = bitcast i8* %29 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([12 x i8*]* @_ZTV12my_exception, i64 0, i64 3) to i32 (...)**), i32 (...)*** %34, align 8, !tbaa !1
  %35 = bitcast i8* %31 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([12 x i8*]* @_ZTV12my_exception, i64 0, i64 9) to i32 (...)**), i32 (...)*** %35, align 8, !tbaa !1
  invoke void @__cxa_throw(i8* %29, i8* bitcast ({ i8*, i8*, i32, i32, i8*, i64 }* @_ZTI12my_exception to i8*), i8* bitcast (void (%struct.my_exception*)* @_ZN12my_exceptionD1Ev to i8*)) #11
          to label %127 unwind label %43

; <label>:36                                      ; preds = %.noexc6, %.noexc, %.noexc12, %21, %14, %0
  %37 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTISt13runtime_error to i8*)
  %38 = extractvalue { i8*, i32 } %37, 0
  %39 = extractvalue { i8*, i32 } %37, 1
  br label %67

.thread:                                          ; preds = %_ZNSolsEPFRSoS_E.exit
  %40 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt13runtime_error to i8*)
  %41 = extractvalue { i8*, i32 } %40, 0
  %42 = extractvalue { i8*, i32 } %40, 1
  br label %66

; <label>:43                                      ; preds = %33, %30
  %.01 = phi i1 [ false, %33 ], [ true, %30 ]
  %44 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt13runtime_error to i8*)
  %45 = extractvalue { i8*, i32 } %44, 0
  %46 = extractvalue { i8*, i32 } %44, 1
  %47 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %47)
  %48 = getelementptr inbounds %"class.std::basic_string"* %3, i64 0, i32 0, i32 0
  %49 = load i8** %48, align 8, !tbaa !12
  %50 = getelementptr inbounds i8* %49, i64 -24
  %51 = bitcast i8* %50 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %52 = icmp eq i8* %50, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %52, label %65, label %53, !prof !15

; <label>:53                                      ; preds = %43
  %54 = getelementptr inbounds i8* %49, i64 -8
  %55 = bitcast i8* %54 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %56, label %60

; <label>:56                                      ; preds = %53
  %57 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %57)
  %58 = atomicrmw volatile add i32* %55, i32 -1 acq_rel
  store i32 %58, i32* %1, align 4
  %59 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %57)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:60                                      ; preds = %53
  %61 = load i32* %55, align 4, !tbaa !16
  %62 = add nsw i32 %61, -1
  store i32 %62, i32* %55, align 4, !tbaa !16
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %60, %56
  %.0.i.i.i.i = phi i32 [ %59, %56 ], [ %61, %60 ]
  %63 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %63, label %64, label %65

; <label>:64                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %51, %"class.std::allocator"* %2) #1
  br label %65

; <label>:65                                      ; preds = %64, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %43
  call void @llvm.lifetime.end(i64 1, i8* %47)
  br i1 %.01, label %66, label %67

; <label>:66                                      ; preds = %65, %.thread
  %.038 = phi i8* [ %41, %.thread ], [ %45, %65 ]
  %.0337 = phi i32 [ %42, %.thread ], [ %46, %65 ]
  call void @__cxa_free_exception(i8* %29) #1
  br label %67

; <label>:67                                      ; preds = %66, %65, %36
  %.14 = phi i32 [ %.0337, %66 ], [ %46, %65 ], [ %39, %36 ]
  %.1 = phi i8* [ %.038, %66 ], [ %45, %65 ], [ %38, %36 ]
  %68 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt13runtime_error to i8*)) #1
  %69 = icmp eq i32 %.14, %68
  br i1 %69, label %70, label %121

; <label>:70                                      ; preds = %67
  %71 = call i8* @__cxa_begin_catch(i8* %.1) #1
  %72 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([28 x i8]* @.str2, i64 0, i64 0), i64 27)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15 unwind label %117

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15: ; preds = %70
  %73 = bitcast i8* %71 to %"class.std::runtime_error"*
  %74 = bitcast i8* %71 to i8* (%"class.std::runtime_error"*)***
  %75 = load i8* (%"class.std::runtime_error"*)*** %74, align 8, !tbaa !1
  %76 = getelementptr inbounds i8* (%"class.std::runtime_error"*)** %75, i64 2
  %77 = load i8* (%"class.std::runtime_error"*)** %76, align 8
  %78 = call i8* %77(%"class.std::runtime_error"* %73) #1
  %79 = icmp eq i8* %78, null
  br i1 %79, label %80, label %91

; <label>:80                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15
  %81 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %82 = getelementptr i8* %81, i64 -24
  %83 = bitcast i8* %82 to i64*
  %84 = load i64* %83, align 8
  %85 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %84
  %86 = bitcast i8* %85 to %"class.std::basic_ios"*
  %.sum.i = add i64 %84, 32
  %87 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %88 = bitcast i8* %87 to i32*
  %89 = load i32* %88, align 4, !tbaa !18
  %90 = or i32 %89, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %86, i32 %90)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit18 unwind label %117

; <label>:91                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit15
  %92 = call i64 @strlen(i8* %78) #1
  %93 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %78, i64 %92)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit18 unwind label %117

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit18: ; preds = %91, %80
  %94 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !1
  %95 = getelementptr i8* %94, i64 -24
  %96 = bitcast i8* %95 to i64*
  %97 = load i64* %96, align 8
  %.sum = add i64 %97, 240
  %98 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %99 = bitcast i8* %98 to %"class.std::ctype"**
  %100 = load %"class.std::ctype"** %99, align 8, !tbaa !4
  %101 = icmp eq %"class.std::ctype"* %100, null
  br i1 %101, label %102, label %.noexc28

; <label>:102                                     ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit18
  invoke void @_ZSt16__throw_bad_castv() #11
          to label %.noexc35 unwind label %117

.noexc35:                                         ; preds = %102
  unreachable

.noexc28:                                         ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit18
  %103 = getelementptr inbounds %"class.std::ctype"* %100, i64 0, i32 6
  %104 = load i8* %103, align 1, !tbaa !9
  %105 = icmp eq i8 %104, 0
  br i1 %105, label %109, label %106

; <label>:106                                     ; preds = %.noexc28
  %107 = getelementptr inbounds %"class.std::ctype"* %100, i64 0, i32 7, i64 10
  %108 = load i8* %107, align 1, !tbaa !11
  br label %.noexc21

; <label>:109                                     ; preds = %.noexc28
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %100)
          to label %.noexc32 unwind label %117

.noexc32:                                         ; preds = %109
  %110 = bitcast %"class.std::ctype"* %100 to i8 (%"class.std::ctype"*, i8)***
  %111 = load i8 (%"class.std::ctype"*, i8)*** %110, align 8, !tbaa !1
  %112 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %111, i64 6
  %113 = load i8 (%"class.std::ctype"*, i8)** %112, align 8
  %114 = invoke signext i8 %113(%"class.std::ctype"* %100, i8 signext 10)
          to label %.noexc21 unwind label %117

.noexc21:                                         ; preds = %.noexc32, %106
  %.0.i31 = phi i8 [ %108, %106 ], [ %114, %.noexc32 ]
  %115 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i31)
          to label %.noexc22 unwind label %117

.noexc22:                                         ; preds = %.noexc21
  %116 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %115)
          to label %_ZNSolsEPFRSoS_E.exit20 unwind label %117

_ZNSolsEPFRSoS_E.exit20:                          ; preds = %.noexc22
  call void @__cxa_end_catch()
  ret i32 0

; <label>:117                                     ; preds = %.noexc22, %.noexc21, %.noexc32, %109, %102, %91, %80, %70
  %118 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %119 = extractvalue { i8*, i32 } %118, 0
  %120 = extractvalue { i8*, i32 } %118, 1
  invoke void @__cxa_end_catch()
          to label %121 unwind label %124

; <label>:121                                     ; preds = %117, %67
  %.25 = phi i32 [ %120, %117 ], [ %.14, %67 ]
  %.2 = phi i8* [ %119, %117 ], [ %.1, %67 ]
  %122 = insertvalue { i8*, i32 } undef, i8* %.2, 0
  %123 = insertvalue { i8*, i32 } %122, i32 %.25, 1
  resume { i8*, i32 } %123

; <label>:124                                     ; preds = %117
  %125 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %126 = extractvalue { i8*, i32 } %125, 0
  call void @__clang_call_terminate(i8* %126) #12
  unreachable

; <label>:127                                     ; preds = %33
  unreachable
}

declare i32 @__gxx_personality_v0(...)

declare i8* @__cxa_allocate_exception(i64)

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZN12my_exceptionD1Ev(%struct.my_exception* %this) unnamed_addr #3 align 2 {
  %1 = getelementptr inbounds %struct.my_exception* %this, i64 0, i32 1
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %1) #1
  ret void
}

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #4 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #12
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #5

declare void @__cxa_end_catch()

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #6

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #7

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #8

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #8

; Function Attrs: nounwind
declare void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"*) #8

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZTv0_n24_N12my_exceptionD1Ev(%struct.my_exception* %this) unnamed_addr #9 align 2 {
  %1 = bitcast %struct.my_exception* %this to i8*
  %2 = bitcast %struct.my_exception* %this to i8**
  %3 = load i8** %2, align 8
  %4 = getelementptr inbounds i8* %3, i64 -24
  %5 = bitcast i8* %4 to i64*
  %6 = load i64* %5, align 8
  %.sum = add i64 %6, 8
  %7 = getelementptr inbounds i8* %1, i64 %.sum
  %8 = bitcast i8* %7 to %"class.std::runtime_error"*
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %8) #1
  ret void
}

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZN12my_exceptionD0Ev(%struct.my_exception* %this) unnamed_addr #3 align 2 {
  %1 = getelementptr inbounds %struct.my_exception* %this, i64 0, i32 1
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %1) #1
  %2 = bitcast %struct.my_exception* %this to i8*
  tail call void @_ZdlPv(i8* %2) #13
  ret void
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZTv0_n24_N12my_exceptionD0Ev(%struct.my_exception* %this) unnamed_addr #9 align 2 {
  %1 = bitcast %struct.my_exception* %this to i8*
  %2 = bitcast %struct.my_exception* %this to i8**
  %3 = load i8** %2, align 8
  %4 = getelementptr inbounds i8* %3, i64 -24
  %5 = bitcast i8* %4 to i64*
  %6 = load i64* %5, align 8
  %7 = getelementptr inbounds i8* %1, i64 %6
  %.sum = add i64 %6, 8
  %8 = getelementptr inbounds i8* %1, i64 %.sum
  %9 = bitcast i8* %8 to %"class.std::runtime_error"*
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %9) #1
  tail call void @_ZdlPv(i8* %7) #13
  ret void
}

; Function Attrs: nounwind
declare i8* @_ZNKSt13runtime_error4whatEv(%"class.std::runtime_error"*) #8

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #10

declare void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"*, %"class.std::basic_string"*) #0

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { inlinehint nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline noreturn nounwind }
attributes #5 = { nounwind readnone }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
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
