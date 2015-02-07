; ModuleID = 'test_exceptions_primary.bc'
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
%"class.std::__exception_ptr::exception_ptr" = type { i8* }
%"class.std::allocator" = type { i8 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::logic_error" = type { %"class.std::exception", %"class.std::basic_string" }
%"class.std::exception" = type { i32 (...)** }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@_ZTISt9exception = external constant i8*
@.str = private unnamed_addr constant [27 x i8] c"some logic_error exception\00", align 1
@_ZTISt11logic_error = external constant i8*
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str1 = private unnamed_addr constant [37 x i8] c"exception caught, but continuing...\0A\00", align 1
@.str2 = private unnamed_addr constant [19 x i8] c"(after exception)\0A\00", align 1
@.str3 = private unnamed_addr constant [19 x i8] c"exception caught: \00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #1

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #2

; Function Attrs: uwtable
define i32 @main() #3 {
  %1 = alloca %"class.std::__exception_ptr::exception_ptr", align 8
  %2 = alloca i8, align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator", align 1
  %p = alloca %"class.std::__exception_ptr::exception_ptr", align 8
  %5 = alloca %"class.std::basic_string", align 8
  %6 = alloca %"class.std::allocator", align 1
  %7 = alloca %"class.std::__exception_ptr::exception_ptr", align 8
  %8 = alloca %"class.std::__exception_ptr::exception_ptr", align 8
  call void @_ZNSt15__exception_ptr13exception_ptrC1Ev(%"class.std::__exception_ptr::exception_ptr"* %p) #2
  %9 = call i8* @__cxa_allocate_exception(i64 16) #2
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %5, i8* getelementptr inbounds ([27 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %6)
          to label %10 unwind label %.thread

; <label>:10                                      ; preds = %0
  %11 = bitcast i8* %9 to %"class.std::logic_error"*
  invoke void @_ZNSt11logic_errorC1ERKSs(%"class.std::logic_error"* %11, %"class.std::basic_string"* %5)
          to label %12 unwind label %16

; <label>:12                                      ; preds = %10
  invoke void @__cxa_throw(i8* %9, i8* bitcast (i8** @_ZTISt11logic_error to i8*), i8* bitcast (void (%"class.std::logic_error"*)* @_ZNSt11logic_errorD1Ev to i8*)) #8
          to label %103 unwind label %16

.thread:                                          ; preds = %0
  %13 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %14 = extractvalue { i8*, i32 } %13, 0
  %15 = extractvalue { i8*, i32 } %13, 1
  br label %39

; <label>:16                                      ; preds = %12, %10
  %.04 = phi i1 [ false, %12 ], [ true, %10 ]
  %17 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %18 = extractvalue { i8*, i32 } %17, 0
  %19 = extractvalue { i8*, i32 } %17, 1
  %20 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %20) #2
  %21 = getelementptr inbounds %"class.std::basic_string"* %5, i64 0, i32 0, i32 0
  %22 = load i8** %21, align 8, !tbaa !1
  %23 = getelementptr inbounds i8* %22, i64 -24
  %24 = bitcast i8* %23 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %25 = icmp eq i8* %23, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %25, label %38, label %26, !prof !7

; <label>:26                                      ; preds = %16
  %27 = getelementptr inbounds i8* %22, i64 -8
  %28 = bitcast i8* %27 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %29, label %33

; <label>:29                                      ; preds = %26
  %30 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %30)
  %31 = atomicrmw volatile add i32* %28, i32 -1 acq_rel
  store i32 %31, i32* %3, align 4
  %32 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %30)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:33                                      ; preds = %26
  %34 = load i32* %28, align 4, !tbaa !8
  %35 = add nsw i32 %34, -1
  store i32 %35, i32* %28, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %33, %29
  %.0.i.i.i.i = phi i32 [ %32, %29 ], [ %34, %33 ]
  %36 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %36, label %37, label %38

; <label>:37                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %24, %"class.std::allocator"* %4) #2
  br label %38

; <label>:38                                      ; preds = %37, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %16
  call void @llvm.lifetime.end(i64 1, i8* %20) #2
  br i1 %.04, label %39, label %40

; <label>:39                                      ; preds = %38, %.thread
  %.013 = phi i8* [ %14, %.thread ], [ %18, %38 ]
  %.0211 = phi i32 [ %15, %.thread ], [ %19, %38 ]
  call void @__cxa_free_exception(i8* %9) #2
  br label %40

; <label>:40                                      ; preds = %39, %38
  %.012 = phi i8* [ %18, %38 ], [ %.013, %39 ]
  %.0210 = phi i32 [ %19, %38 ], [ %.0211, %39 ]
  %41 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #2
  %42 = icmp eq i32 %.0210, %41
  br i1 %42, label %43, label %97

; <label>:43                                      ; preds = %40
  %44 = call i8* @__cxa_begin_catch(i8* %.012) #2
  call void @_ZSt17current_exceptionv(%"class.std::__exception_ptr::exception_ptr"* sret %7) #2
  %45 = bitcast %"class.std::__exception_ptr::exception_ptr"* %1 to i8*
  call void @llvm.lifetime.start(i64 8, i8* %45) #2
  %46 = getelementptr inbounds %"class.std::__exception_ptr::exception_ptr"* %1, i64 0, i32 0
  %47 = getelementptr inbounds %"class.std::__exception_ptr::exception_ptr"* %7, i64 0, i32 0
  %48 = load i8** %47, align 8, !tbaa !10
  store i8* %48, i8** %46, align 8, !tbaa !10
  store i8* null, i8** %47, align 8, !tbaa !10
  call void @_ZNSt15__exception_ptr13exception_ptr4swapERS0_(%"class.std::__exception_ptr::exception_ptr"* %1, %"class.std::__exception_ptr::exception_ptr"* %p) #2
  call void @_ZNSt15__exception_ptr13exception_ptrD1Ev(%"class.std::__exception_ptr::exception_ptr"* %1) #2
  call void @llvm.lifetime.end(i64 8, i8* %45) #2
  call void @_ZNSt15__exception_ptr13exception_ptrD1Ev(%"class.std::__exception_ptr::exception_ptr"* %7) #2
  %49 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([37 x i8]* @.str1, i64 0, i64 0), i64 36)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %53

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %43
  invoke void @__cxa_end_catch()
          to label %50 unwind label %57

; <label>:50                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %51 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str2, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6 unwind label %57

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6: ; preds = %50
  call void @_ZNSt15__exception_ptr13exception_ptrC1ERKS0_(%"class.std::__exception_ptr::exception_ptr"* %8, %"class.std::__exception_ptr::exception_ptr"* %p) #2
  invoke void @_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE(%"class.std::__exception_ptr::exception_ptr"* %8) #8
          to label %52 unwind label %61

; <label>:52                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6
  unreachable

; <label>:53                                      ; preds = %43
  %54 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %55 = extractvalue { i8*, i32 } %54, 0
  %56 = extractvalue { i8*, i32 } %54, 1
  invoke void @__cxa_end_catch()
          to label %97 unwind label %100

; <label>:57                                      ; preds = %91, %50, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %58 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %59 = extractvalue { i8*, i32 } %58, 0
  %60 = extractvalue { i8*, i32 } %58, 1
  br label %97

; <label>:61                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit6
  %62 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %63 = extractvalue { i8*, i32 } %62, 0
  %64 = extractvalue { i8*, i32 } %62, 1
  call void @_ZNSt15__exception_ptr13exception_ptrD1Ev(%"class.std::__exception_ptr::exception_ptr"* %8) #2
  %65 = icmp eq i32 %64, %.0210
  br i1 %65, label %66, label %97

; <label>:66                                      ; preds = %61
  %67 = call i8* @__cxa_begin_catch(i8* %63) #2
  %68 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str3, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7 unwind label %93

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7: ; preds = %66
  %69 = bitcast i8* %67 to %"class.std::exception"*
  %70 = bitcast i8* %67 to i8* (%"class.std::exception"*)***
  %71 = load i8* (%"class.std::exception"*)*** %70, align 8, !tbaa !12
  %72 = getelementptr inbounds i8* (%"class.std::exception"*)** %71, i64 2
  %73 = load i8* (%"class.std::exception"*)** %72, align 8
  %74 = call i8* %73(%"class.std::exception"* %69) #2
  %75 = icmp eq i8* %74, null
  br i1 %75, label %76, label %87

; <label>:76                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7
  %77 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !12
  %78 = getelementptr i8* %77, i64 -24
  %79 = bitcast i8* %78 to i64*
  %80 = load i64* %79, align 8
  %81 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %80
  %82 = bitcast i8* %81 to %"class.std::basic_ios"*
  %.sum.i = add i64 %80, 32
  %83 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum.i
  %84 = bitcast i8* %83 to i32*
  %85 = load i32* %84, align 4, !tbaa !14
  %86 = or i32 %85, 1
  invoke void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"* %82, i32 %86)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9 unwind label %93

; <label>:87                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit7
  %88 = call i64 @strlen(i8* %74) #2
  %89 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %74, i64 %88)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9 unwind label %93

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9: ; preds = %87, %76
  call void @llvm.lifetime.start(i64 1, i8* %2)
  store i8 10, i8* %2, align 1, !tbaa !21
  %90 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %2, i64 1)
          to label %91 unwind label %93

; <label>:91                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9
  call void @llvm.lifetime.end(i64 1, i8* %2)
  invoke void @__cxa_end_catch()
          to label %92 unwind label %57

; <label>:92                                      ; preds = %91
  call void @_ZNSt15__exception_ptr13exception_ptrD1Ev(%"class.std::__exception_ptr::exception_ptr"* %p) #2
  ret i32 0

; <label>:93                                      ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit9, %87, %76, %66
  %94 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %95 = extractvalue { i8*, i32 } %94, 0
  %96 = extractvalue { i8*, i32 } %94, 1
  invoke void @__cxa_end_catch()
          to label %97 unwind label %100

; <label>:97                                      ; preds = %93, %61, %57, %53, %40
  %.13 = phi i32 [ %60, %57 ], [ %96, %93 ], [ %64, %61 ], [ %56, %53 ], [ %.0210, %40 ]
  %.1 = phi i8* [ %59, %57 ], [ %95, %93 ], [ %63, %61 ], [ %55, %53 ], [ %.012, %40 ]
  call void @_ZNSt15__exception_ptr13exception_ptrD1Ev(%"class.std::__exception_ptr::exception_ptr"* %p) #2
  %98 = insertvalue { i8*, i32 } undef, i8* %.1, 0
  %99 = insertvalue { i8*, i32 } %98, i32 %.13, 1
  resume { i8*, i32 } %99

; <label>:100                                     ; preds = %93, %53
  %101 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %102 = extractvalue { i8*, i32 } %101, 0
  call void @__clang_call_terminate(i8* %102) #9
  unreachable

; <label>:103                                     ; preds = %12
  unreachable
}

; Function Attrs: nounwind
declare void @_ZNSt15__exception_ptr13exception_ptrC1Ev(%"class.std::__exception_ptr::exception_ptr"*) #1

declare i8* @__cxa_allocate_exception(i64)

declare void @_ZNSt11logic_errorC1ERKSs(%"class.std::logic_error"*, %"class.std::basic_string"*) #0

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @_ZNSt11logic_errorD1Ev(%"class.std::logic_error"*) #1

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4

declare i8* @__cxa_begin_catch(i8*)

; Function Attrs: nounwind
declare void @_ZSt17current_exceptionv(%"class.std::__exception_ptr::exception_ptr"* sret) #1

; Function Attrs: nounwind
declare void @_ZNSt15__exception_ptr13exception_ptrD1Ev(%"class.std::__exception_ptr::exception_ptr"*) #1

declare void @__cxa_end_catch()

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #5 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #2
  tail call void @_ZSt9terminatev() #9
  unreachable
}

declare void @_ZSt9terminatev()

; Function Attrs: noreturn
declare void @_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE(%"class.std::__exception_ptr::exception_ptr"*) #6

; Function Attrs: nounwind
declare void @_ZNSt15__exception_ptr13exception_ptrC1ERKS0_(%"class.std::__exception_ptr::exception_ptr"*, %"class.std::__exception_ptr::exception_ptr"*) #1

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #7

declare void @_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate(%"class.std::basic_ios"*, i32) #0

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #1

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #1

; Function Attrs: nounwind
declare void @_ZNSt15__exception_ptr13exception_ptr4swapERS0_(%"class.std::__exception_ptr::exception_ptr"*, %"class.std::__exception_ptr::exception_ptr"*) #1

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
attributes #4 = { nounwind readnone }
attributes #5 = { noinline noreturn nounwind }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
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
!10 = metadata !{metadata !11, metadata !4, i64 0}
!11 = metadata !{metadata !"_ZTSNSt15__exception_ptr13exception_ptrE", metadata !4, i64 0}
!12 = metadata !{metadata !13, metadata !13, i64 0}
!13 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!14 = metadata !{metadata !15, metadata !18, i64 32}
!15 = metadata !{metadata !"_ZTSSt8ios_base", metadata !16, i64 8, metadata !16, i64 16, metadata !17, i64 24, metadata !18, i64 28, metadata !18, i64 32, metadata !4, i64 40, metadata !19, i64 48, metadata !5, i64 64, metadata !9, i64 192, metadata !4, i64 200, metadata !20, i64 208}
!16 = metadata !{metadata !"long", metadata !5, i64 0}
!17 = metadata !{metadata !"_ZTSSt13_Ios_Fmtflags", metadata !5, i64 0}
!18 = metadata !{metadata !"_ZTSSt12_Ios_Iostate", metadata !5, i64 0}
!19 = metadata !{metadata !"_ZTSNSt8ios_base6_WordsE", metadata !4, i64 0, metadata !16, i64 8}
!20 = metadata !{metadata !"_ZTSSt6locale", metadata !4, i64 0}
!21 = metadata !{metadata !5, metadata !5, i64 0}
