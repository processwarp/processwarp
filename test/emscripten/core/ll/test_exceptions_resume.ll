; ModuleID = 'test_exceptions_resume.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::allocator" = type { i8 }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }
%"class.std::runtime_error" = type { %"class.std::exception", %"class.std::basic_string" }
%"class.std::exception" = type { i32 (...)** }
%"class.std::type_info" = type { i32 (...)**, i8* }
%class.MathError = type { %"class.std::runtime_error" }

@_latest_err_msg = global %"class.std::basic_string" zeroinitializer, align 8
@__dso_handle = external global i8
@_result = global i32 0, align 4
@.str = private unnamed_addr constant [25 x i8] c"a cannot be less than b.\00", align 1
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTS9MathError = linkonce_odr constant [11 x i8] c"9MathError\00"
@_ZTISt13runtime_error = external constant i8*
@_ZTI9MathError = linkonce_odr unnamed_addr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([11 x i8]* @_ZTS9MathError, i32 0, i32 0), i8* bitcast (i8** @_ZTISt13runtime_error to i8*) }
@_ZTISt9exception = external constant i8*
@.str1 = private unnamed_addr constant [15 x i8] c"not-found-here\00", align 1
@.str2 = private unnamed_addr constant [27 x i8] c"Special exception caught: \00", align 1
@.str3 = private unnamed_addr constant [3 x i8] c": \00", align 1
@.str4 = private unnamed_addr constant [23 x i8] c"2nd call, result = %d\0A\00", align 1
@.str5 = private unnamed_addr constant [23 x i8] c"2nd call, sadface: %s\0A\00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@_ZTV9MathError = linkonce_odr unnamed_addr constant [5 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*), i8* bitcast (void (%"class.std::runtime_error"*)* @_ZNSt13runtime_errorD2Ev to i8*), i8* bitcast (void (%class.MathError*)* @_ZN9MathErrorD0Ev to i8*), i8* bitcast (i8* (%"class.std::runtime_error"*)* @_ZNKSt13runtime_error4whatEv to i8*)]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

; Function Attrs: nounwind uwtable
define available_externally void @_ZNSsD1Ev(%"class.std::basic_string"* nocapture readonly %this) unnamed_addr #0 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3) #1
  %4 = getelementptr inbounds %"class.std::basic_string"* %this, i64 0, i32 0, i32 0
  %5 = load i8** %4, align 8, !tbaa !1
  %6 = getelementptr inbounds i8* %5, i64 -24
  %7 = bitcast i8* %6 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %8 = icmp eq i8* %6, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %8, label %_ZNSsD2Ev.exit, label %9, !prof !7

; <label>:9                                       ; preds = %0
  %10 = getelementptr inbounds i8* %5, i64 -8
  %11 = bitcast i8* %10 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %12, label %16

; <label>:12                                      ; preds = %9
  %13 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %13)
  %14 = atomicrmw volatile add i32* %11, i32 -1 acq_rel
  store i32 %14, i32* %1, align 4
  %15 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %13)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i

; <label>:16                                      ; preds = %9
  %17 = load i32* %11, align 4, !tbaa !8
  %18 = add nsw i32 %17, -1
  store i32 %18, i32* %11, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i: ; preds = %16, %12
  %.0.i.i.i = phi i32 [ %15, %12 ], [ %17, %16 ]
  %19 = icmp slt i32 %.0.i.i.i, 1
  br i1 %19, label %20, label %_ZNSsD2Ev.exit

; <label>:20                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %7, %"class.std::allocator"* %2) #1
  br label %_ZNSsD2Ev.exit

_ZNSsD2Ev.exit:                                   ; preds = %20, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i, %0
  call void @llvm.lifetime.end(i64 1, i8* %3) #1
  ret void
}

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: uwtable
define i32 @_Z9cpp_adderii(i32 %a, i32 %b) #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::basic_string", align 8
  %4 = alloca %"class.std::allocator", align 1
  %5 = icmp slt i32 %a, %b
  br i1 %5, label %6, label %39

; <label>:6                                       ; preds = %0
  %7 = call i8* @__cxa_allocate_exception(i64 16) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %3, i8* getelementptr inbounds ([25 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %4)
          to label %8 unwind label %.thread

; <label>:8                                       ; preds = %6
  %9 = bitcast i8* %7 to %"class.std::runtime_error"*
  invoke void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"* %9, %"class.std::basic_string"* %3)
          to label %10 unwind label %15

; <label>:10                                      ; preds = %8
  %11 = bitcast i8* %7 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTV9MathError, i64 0, i64 2) to i32 (...)**), i32 (...)*** %11, align 8, !tbaa !10
  invoke void @__cxa_throw(i8* %7, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*), i8* bitcast (void (%"class.std::runtime_error"*)* @_ZNSt13runtime_errorD2Ev to i8*)) #11
          to label %44 unwind label %15

.thread:                                          ; preds = %6
  %12 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %13 = extractvalue { i8*, i32 } %12, 0
  %14 = extractvalue { i8*, i32 } %12, 1
  br label %38

; <label>:15                                      ; preds = %10, %8
  %.0 = phi i1 [ false, %10 ], [ true, %8 ]
  %16 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %17 = extractvalue { i8*, i32 } %16, 0
  %18 = extractvalue { i8*, i32 } %16, 1
  %19 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %19) #1
  %20 = getelementptr inbounds %"class.std::basic_string"* %3, i64 0, i32 0, i32 0
  %21 = load i8** %20, align 8, !tbaa !1
  %22 = getelementptr inbounds i8* %21, i64 -24
  %23 = bitcast i8* %22 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %24 = icmp eq i8* %22, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %24, label %37, label %25, !prof !7

; <label>:25                                      ; preds = %15
  %26 = getelementptr inbounds i8* %21, i64 -8
  %27 = bitcast i8* %26 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %28, label %32

; <label>:28                                      ; preds = %25
  %29 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %29)
  %30 = atomicrmw volatile add i32* %27, i32 -1 acq_rel
  store i32 %30, i32* %1, align 4
  %31 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %29)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:32                                      ; preds = %25
  %33 = load i32* %27, align 4, !tbaa !8
  %34 = add nsw i32 %33, -1
  store i32 %34, i32* %27, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %32, %28
  %.0.i.i.i.i = phi i32 [ %31, %28 ], [ %33, %32 ]
  %35 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %35, label %36, label %37

; <label>:36                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %23, %"class.std::allocator"* %2) #1
  br label %37

; <label>:37                                      ; preds = %36, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %15
  call void @llvm.lifetime.end(i64 1, i8* %19) #1
  br i1 %.0, label %38, label %41

; <label>:38                                      ; preds = %37, %.thread
  %.016 = phi i32 [ %14, %.thread ], [ %18, %37 ]
  %.024 = phi i8* [ %13, %.thread ], [ %17, %37 ]
  call void @__cxa_free_exception(i8* %7) #1
  br label %41

; <label>:39                                      ; preds = %0
  %40 = add nsw i32 %b, %a
  ret i32 %40

; <label>:41                                      ; preds = %38, %37
  %.015 = phi i32 [ %18, %37 ], [ %.016, %38 ]
  %.023 = phi i8* [ %17, %37 ], [ %.024, %38 ]
  %42 = insertvalue { i8*, i32 } undef, i8* %.023, 0
  %43 = insertvalue { i8*, i32 } %42, i32 %.015, 1
  resume { i8*, i32 } %43

; <label>:44                                      ; preds = %10
  unreachable
}

declare i8* @__cxa_allocate_exception(i64)

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #3

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"*) #4

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #5 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #12
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind readonly uwtable
define i8* @latest_err_msg() #6 {
  %1 = load i8** getelementptr inbounds (%"class.std::basic_string"* @_latest_err_msg, i64 0, i32 0, i32 0), align 8, !tbaa !1
  ret i8* %1
}

; Function Attrs: nounwind readonly uwtable
define i32 @result() #6 {
  %1 = load i32* @_result, align 4, !tbaa !8
  ret i32 %1
}

; Function Attrs: uwtable
define i32 @c_adder(i32 %a, i32 %b) #2 {
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
  %13 = alloca i32, align 4
  %14 = alloca %"class.std::allocator", align 1
  %15 = alloca i32, align 4
  %16 = alloca %"class.std::allocator", align 1
  %17 = alloca i32, align 4
  %18 = alloca %"class.std::allocator", align 1
  %19 = alloca i32, align 4
  %20 = alloca %"class.std::allocator", align 1
  %21 = alloca i32, align 4
  %22 = alloca %"class.std::allocator", align 1
  %23 = alloca i32, align 4
  %24 = alloca %"class.std::allocator", align 1
  %25 = alloca i32, align 4
  %26 = alloca %"class.std::allocator", align 1
  %27 = alloca i32, align 4
  %28 = alloca %"class.std::allocator", align 1
  %29 = alloca i32, align 4
  %30 = alloca %"class.std::allocator", align 1
  %31 = alloca i32, align 4
  %32 = alloca %"class.std::allocator", align 1
  %33 = alloca i32, align 4
  %34 = alloca %"class.std::allocator", align 1
  %35 = alloca %"class.std::basic_string", align 8
  %36 = alloca %"class.std::allocator", align 1
  %37 = alloca %"class.std::basic_string", align 8
  %38 = alloca %"class.std::basic_string", align 8
  %39 = alloca %"class.std::basic_string", align 8
  %40 = alloca %"class.std::basic_string", align 8
  %41 = alloca %"class.std::allocator", align 1
  %42 = alloca %"class.std::basic_string", align 8
  %43 = alloca %"class.std::basic_string", align 8
  %44 = alloca %"class.std::basic_string", align 8
  %45 = alloca %"class.std::allocator", align 1
  %46 = invoke i32 @_Z9cpp_adderii(i32 %a, i32 %b)
          to label %47 unwind label %48

; <label>:47                                      ; preds = %0
  store i32 %46, i32* @_result, align 4, !tbaa !8
  br label %502

; <label>:48                                      ; preds = %0
  %49 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %50 = extractvalue { i8*, i32 } %49, 0
  %51 = extractvalue { i8*, i32 } %49, 1
  %52 = call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*)) #1
  %53 = icmp eq i32 %51, %52
  br i1 %53, label %54, label %169

; <label>:54                                      ; preds = %48
  %55 = call i8* @__cxa_begin_catch(i8* %50) #1
  %56 = bitcast i8* %55 to %"class.std::runtime_error"*
  %57 = bitcast i8* %55 to i8* (%"class.std::runtime_error"*)***
  %58 = load i8* (%"class.std::runtime_error"*)*** %57, align 8, !tbaa !10
  %59 = getelementptr inbounds i8* (%"class.std::runtime_error"*)** %58, i64 2
  %60 = load i8* (%"class.std::runtime_error"*)** %59, align 8
  %61 = call i8* %60(%"class.std::runtime_error"* %56) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %35, i8* %61, %"class.std::allocator"* %36)
          to label %62 unwind label %178

; <label>:62                                      ; preds = %54
  %63 = invoke i64 @_ZNKSs4findEPKcmm(%"class.std::basic_string"* %35, i8* getelementptr inbounds ([15 x i8]* @.str1, i64 0, i64 0), i64 0, i64 14)
          to label %_ZNKSs4findEPKcm.exit unwind label %182

_ZNKSs4findEPKcm.exit:                            ; preds = %62
  %64 = getelementptr inbounds %"class.std::allocator"* %34, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %64) #1
  %65 = getelementptr inbounds %"class.std::basic_string"* %35, i64 0, i32 0, i32 0
  %66 = load i8** %65, align 8, !tbaa !1
  %67 = getelementptr inbounds i8* %66, i64 -24
  %68 = bitcast i8* %67 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %69 = icmp eq i8* %67, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %69, label %82, label %70, !prof !7

; <label>:70                                      ; preds = %_ZNKSs4findEPKcm.exit
  %71 = getelementptr inbounds i8* %66, i64 -8
  %72 = bitcast i8* %71 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %73, label %77

; <label>:73                                      ; preds = %70
  %74 = bitcast i32* %33 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %74)
  %75 = atomicrmw volatile add i32* %72, i32 -1 acq_rel
  store i32 %75, i32* %33, align 4
  %76 = load volatile i32* %33, align 4
  call void @llvm.lifetime.end(i64 4, i8* %74)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:77                                      ; preds = %70
  %78 = load i32* %72, align 4, !tbaa !8
  %79 = add nsw i32 %78, -1
  store i32 %79, i32* %72, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %77, %73
  %.0.i.i.i.i = phi i32 [ %76, %73 ], [ %78, %77 ]
  %80 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %80, label %81, label %82

; <label>:81                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %68, %"class.std::allocator"* %34) #1
  br label %82

; <label>:82                                      ; preds = %81, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNKSs4findEPKcm.exit
  call void @llvm.lifetime.end(i64 1, i8* %64) #1
  %83 = icmp eq i64 %63, -1
  br i1 %83, label %84, label %297

; <label>:84                                      ; preds = %82
  %85 = call i8* @__cxa_allocate_exception(i64 16) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %40, i8* getelementptr inbounds ([27 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator"* %41)
          to label %86 unwind label %.thread

; <label>:86                                      ; preds = %84
  %87 = bitcast i8* %55 to %"class.std::type_info"***
  %88 = load %"class.std::type_info"*** %87, align 8, !tbaa !10
  %89 = getelementptr inbounds %"class.std::type_info"** %88, i64 -1
  %90 = load %"class.std::type_info"** %89, align 8
  %91 = getelementptr inbounds %"class.std::type_info"* %90, i64 0, i32 1
  %92 = load i8** %91, align 8, !tbaa !12
  %93 = load i8* %92, align 1, !tbaa !14
  %94 = icmp eq i8 %93, 42
  %95 = getelementptr inbounds i8* %92, i64 1
  %96 = select i1 %94, i8* %95, i8* %92
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %39, %"class.std::basic_string"* %40)
          to label %.noexc unwind label %207

.noexc:                                           ; preds = %86
  %97 = call i64 @strlen(i8* %96) #1
  %98 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %39, i8* %96, i64 %97)
          to label %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit unwind label %99

; <label>:99                                      ; preds = %.noexc
  %100 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %101 = getelementptr inbounds %"class.std::allocator"* %28, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %101) #1
  %102 = getelementptr inbounds %"class.std::basic_string"* %39, i64 0, i32 0, i32 0
  %103 = load i8** %102, align 8, !tbaa !1
  %104 = getelementptr inbounds i8* %103, i64 -24
  %105 = bitcast i8* %104 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %106 = icmp eq i8* %104, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %106, label %.body, label %107, !prof !7

; <label>:107                                     ; preds = %99
  %108 = getelementptr inbounds i8* %103, i64 -8
  %109 = bitcast i8* %108 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %110, label %114

; <label>:110                                     ; preds = %107
  %111 = bitcast i32* %27 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %111)
  %112 = atomicrmw volatile add i32* %109, i32 -1 acq_rel
  store i32 %112, i32* %27, align 4
  %113 = load volatile i32* %27, align 4
  call void @llvm.lifetime.end(i64 4, i8* %111)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:114                                     ; preds = %107
  %115 = load i32* %109, align 4, !tbaa !8
  %116 = add nsw i32 %115, -1
  store i32 %116, i32* %109, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %114, %110
  %.0.i.i.i.i.i = phi i32 [ %113, %110 ], [ %115, %114 ]
  %117 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %117, label %118, label %.body

; <label>:118                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %105, %"class.std::allocator"* %28) #1
  br label %.body

_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit: ; preds = %.noexc
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %38, %"class.std::basic_string"* %39)
          to label %.noexc30 unwind label %211

.noexc30:                                         ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit
  %119 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %38, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i64 2)
          to label %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit33 unwind label %120

; <label>:120                                     ; preds = %.noexc30
  %121 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %122 = getelementptr inbounds %"class.std::allocator"* %26, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %122) #1
  %123 = getelementptr inbounds %"class.std::basic_string"* %38, i64 0, i32 0, i32 0
  %124 = load i8** %123, align 8, !tbaa !1
  %125 = getelementptr inbounds i8* %124, i64 -24
  %126 = bitcast i8* %125 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %127 = icmp eq i8* %125, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %127, label %.body31, label %128, !prof !7

; <label>:128                                     ; preds = %120
  %129 = getelementptr inbounds i8* %124, i64 -8
  %130 = bitcast i8* %129 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %131, label %135

; <label>:131                                     ; preds = %128
  %132 = bitcast i32* %25 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %132)
  %133 = atomicrmw volatile add i32* %130, i32 -1 acq_rel
  store i32 %133, i32* %25, align 4
  %134 = load volatile i32* %25, align 4
  call void @llvm.lifetime.end(i64 4, i8* %132)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i29

; <label>:135                                     ; preds = %128
  %136 = load i32* %130, align 4, !tbaa !8
  %137 = add nsw i32 %136, -1
  store i32 %137, i32* %130, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i29

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i29: ; preds = %135, %131
  %.0.i.i.i.i.i28 = phi i32 [ %134, %131 ], [ %136, %135 ]
  %138 = icmp slt i32 %.0.i.i.i.i.i28, 1
  br i1 %138, label %139, label %.body31

; <label>:139                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i29
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %126, %"class.std::allocator"* %26) #1
  br label %.body31

_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit33: ; preds = %.noexc30
  %140 = load i8* (%"class.std::runtime_error"*)*** %57, align 8, !tbaa !10
  %141 = getelementptr inbounds i8* (%"class.std::runtime_error"*)** %140, i64 2
  %142 = load i8* (%"class.std::runtime_error"*)** %141, align 8
  %143 = call i8* %142(%"class.std::runtime_error"* %56) #1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %37, %"class.std::basic_string"* %38)
          to label %.noexc36 unwind label %215

.noexc36:                                         ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit33
  %144 = call i64 @strlen(i8* %143) #1
  %145 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %37, i8* %143, i64 %144)
          to label %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit39 unwind label %146

; <label>:146                                     ; preds = %.noexc36
  %147 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %148 = getelementptr inbounds %"class.std::allocator"* %24, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %148) #1
  %149 = getelementptr inbounds %"class.std::basic_string"* %37, i64 0, i32 0, i32 0
  %150 = load i8** %149, align 8, !tbaa !1
  %151 = getelementptr inbounds i8* %150, i64 -24
  %152 = bitcast i8* %151 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %153 = icmp eq i8* %151, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %153, label %.body37, label %154, !prof !7

; <label>:154                                     ; preds = %146
  %155 = getelementptr inbounds i8* %150, i64 -8
  %156 = bitcast i8* %155 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %157, label %161

; <label>:157                                     ; preds = %154
  %158 = bitcast i32* %23 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %158)
  %159 = atomicrmw volatile add i32* %156, i32 -1 acq_rel
  store i32 %159, i32* %23, align 4
  %160 = load volatile i32* %23, align 4
  call void @llvm.lifetime.end(i64 4, i8* %158)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i35

; <label>:161                                     ; preds = %154
  %162 = load i32* %156, align 4, !tbaa !8
  %163 = add nsw i32 %162, -1
  store i32 %163, i32* %156, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i35

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i35: ; preds = %161, %157
  %.0.i.i.i.i.i34 = phi i32 [ %160, %157 ], [ %162, %161 ]
  %164 = icmp slt i32 %.0.i.i.i.i.i34, 1
  br i1 %164, label %165, label %.body37

; <label>:165                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i35
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %152, %"class.std::allocator"* %24) #1
  br label %.body37

_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit39: ; preds = %.noexc36
  %166 = bitcast i8* %85 to %"class.std::runtime_error"*
  invoke void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"* %166, %"class.std::basic_string"* %37)
          to label %167 unwind label %219

; <label>:167                                     ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit39
  %168 = bitcast i8* %85 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTV9MathError, i64 0, i64 2) to i32 (...)**), i32 (...)*** %168, align 8, !tbaa !10
  invoke void @__cxa_throw(i8* %85, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*), i8* bitcast (void (%"class.std::runtime_error"*)* @_ZNSt13runtime_errorD2Ev to i8*)) #11
          to label %509 unwind label %219

; <label>:169                                     ; preds = %48
  %170 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #1
  %171 = icmp eq i32 %51, %170
  br i1 %171, label %172, label %302

; <label>:172                                     ; preds = %169
  %173 = call i8* @__cxa_begin_catch(i8* %50) #1
  invoke void @__cxa_rethrow() #11
          to label %509 unwind label %174

; <label>:174                                     ; preds = %172
  %175 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %176 = extractvalue { i8*, i32 } %175, 0
  %177 = extractvalue { i8*, i32 } %175, 1
  invoke void @__cxa_end_catch()
          to label %302 unwind label %506

; <label>:178                                     ; preds = %54
  %179 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %180 = extractvalue { i8*, i32 } %179, 0
  %181 = extractvalue { i8*, i32 } %179, 1
  br label %_ZNSsD1Ev.exit43

; <label>:182                                     ; preds = %62
  %183 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %184 = extractvalue { i8*, i32 } %183, 0
  %185 = extractvalue { i8*, i32 } %183, 1
  %186 = getelementptr inbounds %"class.std::allocator"* %22, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %186) #1
  %187 = getelementptr inbounds %"class.std::basic_string"* %35, i64 0, i32 0, i32 0
  %188 = load i8** %187, align 8, !tbaa !1
  %189 = getelementptr inbounds i8* %188, i64 -24
  %190 = bitcast i8* %189 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %191 = icmp eq i8* %189, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %191, label %_ZNSsD1Ev.exit43, label %192, !prof !7

; <label>:192                                     ; preds = %182
  %193 = getelementptr inbounds i8* %188, i64 -8
  %194 = bitcast i8* %193 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %195, label %199

; <label>:195                                     ; preds = %192
  %196 = bitcast i32* %21 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %196)
  %197 = atomicrmw volatile add i32* %194, i32 -1 acq_rel
  store i32 %197, i32* %21, align 4
  %198 = load volatile i32* %21, align 4
  call void @llvm.lifetime.end(i64 4, i8* %196)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42

; <label>:199                                     ; preds = %192
  %200 = load i32* %194, align 4, !tbaa !8
  %201 = add nsw i32 %200, -1
  store i32 %201, i32* %194, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42: ; preds = %199, %195
  %.0.i.i.i.i41 = phi i32 [ %198, %195 ], [ %200, %199 ]
  %202 = icmp slt i32 %.0.i.i.i.i41, 1
  br i1 %202, label %203, label %_ZNSsD1Ev.exit43

; <label>:203                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %190, %"class.std::allocator"* %22) #1
  br label %_ZNSsD1Ev.exit43

.thread:                                          ; preds = %84
  %204 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %205 = extractvalue { i8*, i32 } %204, 0
  %206 = extractvalue { i8*, i32 } %204, 1
  br label %296

; <label>:207                                     ; preds = %86
  %208 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  br label %.body

.body:                                            ; preds = %207, %118, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %99
  %eh.lpad-body = phi { i8*, i32 } [ %208, %207 ], [ %100, %118 ], [ %100, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i ], [ %100, %99 ]
  %209 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  %210 = extractvalue { i8*, i32 } %eh.lpad-body, 1
  br label %_ZNSsD1Ev.exit52

; <label>:211                                     ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit
  %212 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  br label %.body31

.body31:                                          ; preds = %211, %139, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i29, %120
  %eh.lpad-body32 = phi { i8*, i32 } [ %212, %211 ], [ %121, %139 ], [ %121, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i29 ], [ %121, %120 ]
  %213 = extractvalue { i8*, i32 } %eh.lpad-body32, 0
  %214 = extractvalue { i8*, i32 } %eh.lpad-body32, 1
  br label %_ZNSsD1Ev.exit49

; <label>:215                                     ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit33
  %216 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  br label %.body37

.body37:                                          ; preds = %215, %165, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i35, %146
  %eh.lpad-body38 = phi { i8*, i32 } [ %216, %215 ], [ %147, %165 ], [ %147, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i35 ], [ %147, %146 ]
  %217 = extractvalue { i8*, i32 } %eh.lpad-body38, 0
  %218 = extractvalue { i8*, i32 } %eh.lpad-body38, 1
  br label %_ZNSsD1Ev.exit46

; <label>:219                                     ; preds = %167, %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit39
  %.017 = phi i1 [ false, %167 ], [ true, %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit39 ]
  %220 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %221 = extractvalue { i8*, i32 } %220, 0
  %222 = extractvalue { i8*, i32 } %220, 1
  %223 = getelementptr inbounds %"class.std::allocator"* %20, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %223) #1
  %224 = getelementptr inbounds %"class.std::basic_string"* %37, i64 0, i32 0, i32 0
  %225 = load i8** %224, align 8, !tbaa !1
  %226 = getelementptr inbounds i8* %225, i64 -24
  %227 = bitcast i8* %226 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %228 = icmp eq i8* %226, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %228, label %_ZNSsD1Ev.exit46, label %229, !prof !7

; <label>:229                                     ; preds = %219
  %230 = getelementptr inbounds i8* %225, i64 -8
  %231 = bitcast i8* %230 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %232, label %236

; <label>:232                                     ; preds = %229
  %233 = bitcast i32* %19 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %233)
  %234 = atomicrmw volatile add i32* %231, i32 -1 acq_rel
  store i32 %234, i32* %19, align 4
  %235 = load volatile i32* %19, align 4
  call void @llvm.lifetime.end(i64 4, i8* %233)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45

; <label>:236                                     ; preds = %229
  %237 = load i32* %231, align 4, !tbaa !8
  %238 = add nsw i32 %237, -1
  store i32 %238, i32* %231, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45: ; preds = %236, %232
  %.0.i.i.i.i44 = phi i32 [ %235, %232 ], [ %237, %236 ]
  %239 = icmp slt i32 %.0.i.i.i.i44, 1
  br i1 %239, label %240, label %_ZNSsD1Ev.exit46

; <label>:240                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %227, %"class.std::allocator"* %20) #1
  br label %_ZNSsD1Ev.exit46

_ZNSsD1Ev.exit46:                                 ; preds = %240, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45, %219, %.body37
  %.118 = phi i1 [ true, %.body37 ], [ %.017, %219 ], [ %.017, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45 ], [ %.017, %240 ]
  %.16 = phi i32 [ %218, %.body37 ], [ %222, %219 ], [ %222, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45 ], [ %222, %240 ]
  %.1 = phi i8* [ %217, %.body37 ], [ %221, %219 ], [ %221, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i45 ], [ %221, %240 ]
  %241 = getelementptr inbounds %"class.std::allocator"* %18, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %241) #1
  %242 = getelementptr inbounds %"class.std::basic_string"* %38, i64 0, i32 0, i32 0
  %243 = load i8** %242, align 8, !tbaa !1
  %244 = getelementptr inbounds i8* %243, i64 -24
  %245 = bitcast i8* %244 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %246 = icmp eq i8* %244, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %246, label %_ZNSsD1Ev.exit49, label %247, !prof !7

; <label>:247                                     ; preds = %_ZNSsD1Ev.exit46
  %248 = getelementptr inbounds i8* %243, i64 -8
  %249 = bitcast i8* %248 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %250, label %254

; <label>:250                                     ; preds = %247
  %251 = bitcast i32* %17 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %251)
  %252 = atomicrmw volatile add i32* %249, i32 -1 acq_rel
  store i32 %252, i32* %17, align 4
  %253 = load volatile i32* %17, align 4
  call void @llvm.lifetime.end(i64 4, i8* %251)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48

; <label>:254                                     ; preds = %247
  %255 = load i32* %249, align 4, !tbaa !8
  %256 = add nsw i32 %255, -1
  store i32 %256, i32* %249, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48: ; preds = %254, %250
  %.0.i.i.i.i47 = phi i32 [ %253, %250 ], [ %255, %254 ]
  %257 = icmp slt i32 %.0.i.i.i.i47, 1
  br i1 %257, label %258, label %_ZNSsD1Ev.exit49

; <label>:258                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %245, %"class.std::allocator"* %18) #1
  br label %_ZNSsD1Ev.exit49

_ZNSsD1Ev.exit49:                                 ; preds = %258, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48, %_ZNSsD1Ev.exit46, %.body31
  %.219 = phi i1 [ true, %.body31 ], [ %.118, %_ZNSsD1Ev.exit46 ], [ %.118, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48 ], [ %.118, %258 ]
  %.27 = phi i32 [ %214, %.body31 ], [ %.16, %_ZNSsD1Ev.exit46 ], [ %.16, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48 ], [ %.16, %258 ]
  %.2 = phi i8* [ %213, %.body31 ], [ %.1, %_ZNSsD1Ev.exit46 ], [ %.1, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i48 ], [ %.1, %258 ]
  %259 = getelementptr inbounds %"class.std::allocator"* %16, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %259) #1
  %260 = getelementptr inbounds %"class.std::basic_string"* %39, i64 0, i32 0, i32 0
  %261 = load i8** %260, align 8, !tbaa !1
  %262 = getelementptr inbounds i8* %261, i64 -24
  %263 = bitcast i8* %262 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %264 = icmp eq i8* %262, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %264, label %_ZNSsD1Ev.exit52, label %265, !prof !7

; <label>:265                                     ; preds = %_ZNSsD1Ev.exit49
  %266 = getelementptr inbounds i8* %261, i64 -8
  %267 = bitcast i8* %266 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %268, label %272

; <label>:268                                     ; preds = %265
  %269 = bitcast i32* %15 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %269)
  %270 = atomicrmw volatile add i32* %267, i32 -1 acq_rel
  store i32 %270, i32* %15, align 4
  %271 = load volatile i32* %15, align 4
  call void @llvm.lifetime.end(i64 4, i8* %269)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51

; <label>:272                                     ; preds = %265
  %273 = load i32* %267, align 4, !tbaa !8
  %274 = add nsw i32 %273, -1
  store i32 %274, i32* %267, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51: ; preds = %272, %268
  %.0.i.i.i.i50 = phi i32 [ %271, %268 ], [ %273, %272 ]
  %275 = icmp slt i32 %.0.i.i.i.i50, 1
  br i1 %275, label %276, label %_ZNSsD1Ev.exit52

; <label>:276                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %263, %"class.std::allocator"* %16) #1
  br label %_ZNSsD1Ev.exit52

_ZNSsD1Ev.exit52:                                 ; preds = %276, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51, %_ZNSsD1Ev.exit49, %.body
  %.320 = phi i1 [ true, %.body ], [ %.219, %_ZNSsD1Ev.exit49 ], [ %.219, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51 ], [ %.219, %276 ]
  %.38 = phi i32 [ %210, %.body ], [ %.27, %_ZNSsD1Ev.exit49 ], [ %.27, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51 ], [ %.27, %276 ]
  %.3 = phi i8* [ %209, %.body ], [ %.2, %_ZNSsD1Ev.exit49 ], [ %.2, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51 ], [ %.2, %276 ]
  %277 = getelementptr inbounds %"class.std::allocator"* %14, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %277) #1
  %278 = getelementptr inbounds %"class.std::basic_string"* %40, i64 0, i32 0, i32 0
  %279 = load i8** %278, align 8, !tbaa !1
  %280 = getelementptr inbounds i8* %279, i64 -24
  %281 = bitcast i8* %280 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %282 = icmp eq i8* %280, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %282, label %295, label %283, !prof !7

; <label>:283                                     ; preds = %_ZNSsD1Ev.exit52
  %284 = getelementptr inbounds i8* %279, i64 -8
  %285 = bitcast i8* %284 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %286, label %290

; <label>:286                                     ; preds = %283
  %287 = bitcast i32* %13 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %287)
  %288 = atomicrmw volatile add i32* %285, i32 -1 acq_rel
  store i32 %288, i32* %13, align 4
  %289 = load volatile i32* %13, align 4
  call void @llvm.lifetime.end(i64 4, i8* %287)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54

; <label>:290                                     ; preds = %283
  %291 = load i32* %285, align 4, !tbaa !8
  %292 = add nsw i32 %291, -1
  store i32 %292, i32* %285, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54: ; preds = %290, %286
  %.0.i.i.i.i53 = phi i32 [ %289, %286 ], [ %291, %290 ]
  %293 = icmp slt i32 %.0.i.i.i.i53, 1
  br i1 %293, label %294, label %295

; <label>:294                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %281, %"class.std::allocator"* %14) #1
  br label %295

; <label>:295                                     ; preds = %294, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54, %_ZNSsD1Ev.exit52
  call void @llvm.lifetime.end(i64 1, i8* %277) #1
  br i1 %.320, label %296, label %_ZNSsD1Ev.exit43

; <label>:296                                     ; preds = %295, %.thread
  %.482 = phi i8* [ %205, %.thread ], [ %.3, %295 ]
  %.4981 = phi i32 [ %206, %.thread ], [ %.38, %295 ]
  call void @__cxa_free_exception(i8* %85) #1
  br label %_ZNSsD1Ev.exit43

; <label>:297                                     ; preds = %82
  invoke void @__cxa_rethrow() #11
          to label %509 unwind label %298

; <label>:298                                     ; preds = %297
  %299 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %300 = extractvalue { i8*, i32 } %299, 0
  %301 = extractvalue { i8*, i32 } %299, 1
  br label %_ZNSsD1Ev.exit43

_ZNSsD1Ev.exit43:                                 ; preds = %298, %296, %295, %203, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42, %182, %178
  %.510 = phi i32 [ %.4981, %296 ], [ %.38, %295 ], [ %301, %298 ], [ %181, %178 ], [ %185, %182 ], [ %185, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42 ], [ %185, %203 ]
  %.5 = phi i8* [ %.482, %296 ], [ %.3, %295 ], [ %300, %298 ], [ %180, %178 ], [ %184, %182 ], [ %184, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i42 ], [ %184, %203 ]
  invoke void @__cxa_end_catch()
          to label %_ZNSsD1Ev.exit43._crit_edge unwind label %506

_ZNSsD1Ev.exit43._crit_edge:                      ; preds = %_ZNSsD1Ev.exit43
  %.pre = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #1
  br label %302

; <label>:302                                     ; preds = %_ZNSsD1Ev.exit43._crit_edge, %174, %169
  %.pre-phi = phi i32 [ %.pre, %_ZNSsD1Ev.exit43._crit_edge ], [ %170, %174 ], [ %170, %169 ]
  %.611 = phi i32 [ %.510, %_ZNSsD1Ev.exit43._crit_edge ], [ %177, %174 ], [ %51, %169 ]
  %.6 = phi i8* [ %.5, %_ZNSsD1Ev.exit43._crit_edge ], [ %176, %174 ], [ %50, %169 ]
  %303 = icmp eq i32 %.611, %.pre-phi
  br i1 %303, label %304, label %310

; <label>:304                                     ; preds = %302
  %305 = call i8* @__cxa_begin_catch(i8* %.6) #1
  invoke void @__cxa_rethrow() #11
          to label %509 unwind label %306

; <label>:306                                     ; preds = %304
  %307 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %308 = extractvalue { i8*, i32 } %307, 0
  %309 = extractvalue { i8*, i32 } %307, 1
  invoke void @__cxa_end_catch()
          to label %310 unwind label %506

; <label>:310                                     ; preds = %306, %302
  %.712 = phi i32 [ %309, %306 ], [ %.611, %302 ]
  %.7 = phi i8* [ %308, %306 ], [ %.6, %302 ]
  %311 = icmp eq i32 %.712, %.pre-phi
  br i1 %311, label %312, label %503

; <label>:312                                     ; preds = %310
  %313 = call i8* @__cxa_begin_catch(i8* %.7) #1
  %314 = bitcast i8* %313 to %"class.std::exception"*
  %315 = bitcast i8* %313 to %"class.std::type_info"***
  %316 = load %"class.std::type_info"*** %315, align 8, !tbaa !10
  %317 = getelementptr inbounds %"class.std::type_info"** %316, i64 -1
  %318 = load %"class.std::type_info"** %317, align 8
  %319 = getelementptr inbounds %"class.std::type_info"* %318, i64 0, i32 1
  %320 = load i8** %319, align 8, !tbaa !12
  %321 = load i8* %320, align 1, !tbaa !14
  %322 = icmp eq i8 %321, 42
  %323 = getelementptr inbounds i8* %320, i64 1
  %324 = select i1 %322, i8* %323, i8* %320
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %44, i8* %324, %"class.std::allocator"* %45)
          to label %325 unwind label %432

; <label>:325                                     ; preds = %312
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %43, %"class.std::basic_string"* %44)
          to label %.noexc58 unwind label %436

.noexc58:                                         ; preds = %325
  %326 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %43, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i64 2)
          to label %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit61 unwind label %327

; <label>:327                                     ; preds = %.noexc58
  %328 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %329 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %329) #1
  %330 = getelementptr inbounds %"class.std::basic_string"* %43, i64 0, i32 0, i32 0
  %331 = load i8** %330, align 8, !tbaa !1
  %332 = getelementptr inbounds i8* %331, i64 -24
  %333 = bitcast i8* %332 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %334 = icmp eq i8* %332, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %334, label %.body59, label %335, !prof !7

; <label>:335                                     ; preds = %327
  %336 = getelementptr inbounds i8* %331, i64 -8
  %337 = bitcast i8* %336 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %338, label %342

; <label>:338                                     ; preds = %335
  %339 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %339)
  %340 = atomicrmw volatile add i32* %337, i32 -1 acq_rel
  store i32 %340, i32* %11, align 4
  %341 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %339)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i57

; <label>:342                                     ; preds = %335
  %343 = load i32* %337, align 4, !tbaa !8
  %344 = add nsw i32 %343, -1
  store i32 %344, i32* %337, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i57

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i57: ; preds = %342, %338
  %.0.i.i.i.i.i56 = phi i32 [ %341, %338 ], [ %343, %342 ]
  %345 = icmp slt i32 %.0.i.i.i.i.i56, 1
  br i1 %345, label %346, label %.body59

; <label>:346                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i57
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %333, %"class.std::allocator"* %12) #1
  br label %.body59

_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit61: ; preds = %.noexc58
  %347 = bitcast i8* %313 to i8* (%"class.std::exception"*)***
  %348 = load i8* (%"class.std::exception"*)*** %347, align 8, !tbaa !10
  %349 = getelementptr inbounds i8* (%"class.std::exception"*)** %348, i64 2
  %350 = load i8* (%"class.std::exception"*)** %349, align 8
  %351 = call i8* %350(%"class.std::exception"* %314) #1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %42, %"class.std::basic_string"* %43)
          to label %.noexc64 unwind label %440

.noexc64:                                         ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit61
  %352 = call i64 @strlen(i8* %351) #1
  %353 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %42, i8* %351, i64 %352)
          to label %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit67 unwind label %354

; <label>:354                                     ; preds = %.noexc64
  %355 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %356 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %356) #1
  %357 = getelementptr inbounds %"class.std::basic_string"* %42, i64 0, i32 0, i32 0
  %358 = load i8** %357, align 8, !tbaa !1
  %359 = getelementptr inbounds i8* %358, i64 -24
  %360 = bitcast i8* %359 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %361 = icmp eq i8* %359, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %361, label %.body65, label %362, !prof !7

; <label>:362                                     ; preds = %354
  %363 = getelementptr inbounds i8* %358, i64 -8
  %364 = bitcast i8* %363 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %365, label %369

; <label>:365                                     ; preds = %362
  %366 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %366)
  %367 = atomicrmw volatile add i32* %364, i32 -1 acq_rel
  store i32 %367, i32* %9, align 4
  %368 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %366)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i63

; <label>:369                                     ; preds = %362
  %370 = load i32* %364, align 4, !tbaa !8
  %371 = add nsw i32 %370, -1
  store i32 %371, i32* %364, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i63

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i63: ; preds = %369, %365
  %.0.i.i.i.i.i62 = phi i32 [ %368, %365 ], [ %370, %369 ]
  %372 = icmp slt i32 %.0.i.i.i.i.i62, 1
  br i1 %372, label %373, label %.body65

; <label>:373                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i63
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %360, %"class.std::allocator"* %10) #1
  br label %.body65

_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit67: ; preds = %.noexc64
  %374 = invoke %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* @_latest_err_msg, %"class.std::basic_string"* %42)
          to label %_ZNSsaSERKSs.exit unwind label %444

_ZNSsaSERKSs.exit:                                ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit67
  %375 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %375) #1
  %376 = getelementptr inbounds %"class.std::basic_string"* %42, i64 0, i32 0, i32 0
  %377 = load i8** %376, align 8, !tbaa !1
  %378 = getelementptr inbounds i8* %377, i64 -24
  %379 = bitcast i8* %378 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %380 = icmp eq i8* %378, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %380, label %393, label %381, !prof !7

; <label>:381                                     ; preds = %_ZNSsaSERKSs.exit
  %382 = getelementptr inbounds i8* %377, i64 -8
  %383 = bitcast i8* %382 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %384, label %388

; <label>:384                                     ; preds = %381
  %385 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %385)
  %386 = atomicrmw volatile add i32* %383, i32 -1 acq_rel
  store i32 %386, i32* %7, align 4
  %387 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %385)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i70

; <label>:388                                     ; preds = %381
  %389 = load i32* %383, align 4, !tbaa !8
  %390 = add nsw i32 %389, -1
  store i32 %390, i32* %383, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i70

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i70: ; preds = %388, %384
  %.0.i.i.i.i69 = phi i32 [ %387, %384 ], [ %389, %388 ]
  %391 = icmp slt i32 %.0.i.i.i.i69, 1
  br i1 %391, label %392, label %393

; <label>:392                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i70
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %379, %"class.std::allocator"* %8) #1
  br label %393

; <label>:393                                     ; preds = %392, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i70, %_ZNSsaSERKSs.exit
  call void @llvm.lifetime.end(i64 1, i8* %375) #1
  %394 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %394) #1
  %395 = getelementptr inbounds %"class.std::basic_string"* %43, i64 0, i32 0, i32 0
  %396 = load i8** %395, align 8, !tbaa !1
  %397 = getelementptr inbounds i8* %396, i64 -24
  %398 = bitcast i8* %397 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %399 = icmp eq i8* %397, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %399, label %412, label %400, !prof !7

; <label>:400                                     ; preds = %393
  %401 = getelementptr inbounds i8* %396, i64 -8
  %402 = bitcast i8* %401 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %403, label %407

; <label>:403                                     ; preds = %400
  %404 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %404)
  %405 = atomicrmw volatile add i32* %402, i32 -1 acq_rel
  store i32 %405, i32* %5, align 4
  %406 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %404)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i73

; <label>:407                                     ; preds = %400
  %408 = load i32* %402, align 4, !tbaa !8
  %409 = add nsw i32 %408, -1
  store i32 %409, i32* %402, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i73

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i73: ; preds = %407, %403
  %.0.i.i.i.i72 = phi i32 [ %406, %403 ], [ %408, %407 ]
  %410 = icmp slt i32 %.0.i.i.i.i72, 1
  br i1 %410, label %411, label %412

; <label>:411                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i73
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %398, %"class.std::allocator"* %6) #1
  br label %412

; <label>:412                                     ; preds = %411, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i73, %393
  call void @llvm.lifetime.end(i64 1, i8* %394) #1
  %413 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %413) #1
  %414 = getelementptr inbounds %"class.std::basic_string"* %44, i64 0, i32 0, i32 0
  %415 = load i8** %414, align 8, !tbaa !1
  %416 = getelementptr inbounds i8* %415, i64 -24
  %417 = bitcast i8* %416 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %418 = icmp eq i8* %416, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %418, label %431, label %419, !prof !7

; <label>:419                                     ; preds = %412
  %420 = getelementptr inbounds i8* %415, i64 -8
  %421 = bitcast i8* %420 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %422, label %426

; <label>:422                                     ; preds = %419
  %423 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %423)
  %424 = atomicrmw volatile add i32* %421, i32 -1 acq_rel
  store i32 %424, i32* %3, align 4
  %425 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %423)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76

; <label>:426                                     ; preds = %419
  %427 = load i32* %421, align 4, !tbaa !8
  %428 = add nsw i32 %427, -1
  store i32 %428, i32* %421, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76: ; preds = %426, %422
  %.0.i.i.i.i75 = phi i32 [ %425, %422 ], [ %427, %426 ]
  %429 = icmp slt i32 %.0.i.i.i.i75, 1
  br i1 %429, label %430, label %431

; <label>:430                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %417, %"class.std::allocator"* %4) #1
  br label %431

; <label>:431                                     ; preds = %430, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i76, %412
  call void @llvm.lifetime.end(i64 1, i8* %413) #1
  call void @__cxa_end_catch()
  br label %502

; <label>:432                                     ; preds = %312
  %433 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %434 = extractvalue { i8*, i32 } %433, 0
  %435 = extractvalue { i8*, i32 } %433, 1
  br label %_ZNSsD1Ev.exit24

; <label>:436                                     ; preds = %325
  %437 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body59

.body59:                                          ; preds = %436, %346, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i57, %327
  %eh.lpad-body60 = phi { i8*, i32 } [ %437, %436 ], [ %328, %346 ], [ %328, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i57 ], [ %328, %327 ]
  %438 = extractvalue { i8*, i32 } %eh.lpad-body60, 0
  %439 = extractvalue { i8*, i32 } %eh.lpad-body60, 1
  br label %_ZNSsD1Ev.exit27

; <label>:440                                     ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit61
  %441 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body65

.body65:                                          ; preds = %440, %373, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i63, %354
  %eh.lpad-body66 = phi { i8*, i32 } [ %441, %440 ], [ %355, %373 ], [ %355, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i63 ], [ %355, %354 ]
  %442 = extractvalue { i8*, i32 } %eh.lpad-body66, 0
  %443 = extractvalue { i8*, i32 } %eh.lpad-body66, 1
  br label %_ZNSsD1Ev.exit80

; <label>:444                                     ; preds = %_ZStplIcSt11char_traitsIcESaIcEESbIT_T0_T1_ERKS6_PKS3_.exit67
  %445 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %446 = extractvalue { i8*, i32 } %445, 0
  %447 = extractvalue { i8*, i32 } %445, 1
  %448 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %448) #1
  %449 = getelementptr inbounds %"class.std::basic_string"* %42, i64 0, i32 0, i32 0
  %450 = load i8** %449, align 8, !tbaa !1
  %451 = getelementptr inbounds i8* %450, i64 -24
  %452 = bitcast i8* %451 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %453 = icmp eq i8* %451, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %453, label %_ZNSsD1Ev.exit80, label %454, !prof !7

; <label>:454                                     ; preds = %444
  %455 = getelementptr inbounds i8* %450, i64 -8
  %456 = bitcast i8* %455 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %457, label %461

; <label>:457                                     ; preds = %454
  %458 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %458)
  %459 = atomicrmw volatile add i32* %456, i32 -1 acq_rel
  store i32 %459, i32* %1, align 4
  %460 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %458)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79

; <label>:461                                     ; preds = %454
  %462 = load i32* %456, align 4, !tbaa !8
  %463 = add nsw i32 %462, -1
  store i32 %463, i32* %456, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79: ; preds = %461, %457
  %.0.i.i.i.i78 = phi i32 [ %460, %457 ], [ %462, %461 ]
  %464 = icmp slt i32 %.0.i.i.i.i78, 1
  br i1 %464, label %465, label %_ZNSsD1Ev.exit80

; <label>:465                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %452, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit80

_ZNSsD1Ev.exit80:                                 ; preds = %465, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79, %444, %.body65
  %.813 = phi i32 [ %443, %.body65 ], [ %447, %444 ], [ %447, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79 ], [ %447, %465 ]
  %.8 = phi i8* [ %442, %.body65 ], [ %446, %444 ], [ %446, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i79 ], [ %446, %465 ]
  %466 = getelementptr inbounds %"class.std::allocator"* %30, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %466) #1
  %467 = getelementptr inbounds %"class.std::basic_string"* %43, i64 0, i32 0, i32 0
  %468 = load i8** %467, align 8, !tbaa !1
  %469 = getelementptr inbounds i8* %468, i64 -24
  %470 = bitcast i8* %469 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %471 = icmp eq i8* %469, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %471, label %_ZNSsD1Ev.exit27, label %472, !prof !7

; <label>:472                                     ; preds = %_ZNSsD1Ev.exit80
  %473 = getelementptr inbounds i8* %468, i64 -8
  %474 = bitcast i8* %473 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %475, label %479

; <label>:475                                     ; preds = %472
  %476 = bitcast i32* %29 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %476)
  %477 = atomicrmw volatile add i32* %474, i32 -1 acq_rel
  store i32 %477, i32* %29, align 4
  %478 = load volatile i32* %29, align 4
  call void @llvm.lifetime.end(i64 4, i8* %476)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26

; <label>:479                                     ; preds = %472
  %480 = load i32* %474, align 4, !tbaa !8
  %481 = add nsw i32 %480, -1
  store i32 %481, i32* %474, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26: ; preds = %479, %475
  %.0.i.i.i.i25 = phi i32 [ %478, %475 ], [ %480, %479 ]
  %482 = icmp slt i32 %.0.i.i.i.i25, 1
  br i1 %482, label %483, label %_ZNSsD1Ev.exit27

; <label>:483                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %470, %"class.std::allocator"* %30) #1
  br label %_ZNSsD1Ev.exit27

_ZNSsD1Ev.exit27:                                 ; preds = %483, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26, %_ZNSsD1Ev.exit80, %.body59
  %.914 = phi i32 [ %439, %.body59 ], [ %.813, %_ZNSsD1Ev.exit80 ], [ %.813, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26 ], [ %.813, %483 ]
  %.9 = phi i8* [ %438, %.body59 ], [ %.8, %_ZNSsD1Ev.exit80 ], [ %.8, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26 ], [ %.8, %483 ]
  %484 = getelementptr inbounds %"class.std::allocator"* %32, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %484) #1
  %485 = getelementptr inbounds %"class.std::basic_string"* %44, i64 0, i32 0, i32 0
  %486 = load i8** %485, align 8, !tbaa !1
  %487 = getelementptr inbounds i8* %486, i64 -24
  %488 = bitcast i8* %487 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %489 = icmp eq i8* %487, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %489, label %_ZNSsD1Ev.exit24, label %490, !prof !7

; <label>:490                                     ; preds = %_ZNSsD1Ev.exit27
  %491 = getelementptr inbounds i8* %486, i64 -8
  %492 = bitcast i8* %491 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %493, label %497

; <label>:493                                     ; preds = %490
  %494 = bitcast i32* %31 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %494)
  %495 = atomicrmw volatile add i32* %492, i32 -1 acq_rel
  store i32 %495, i32* %31, align 4
  %496 = load volatile i32* %31, align 4
  call void @llvm.lifetime.end(i64 4, i8* %494)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23

; <label>:497                                     ; preds = %490
  %498 = load i32* %492, align 4, !tbaa !8
  %499 = add nsw i32 %498, -1
  store i32 %499, i32* %492, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23: ; preds = %497, %493
  %.0.i.i.i.i22 = phi i32 [ %496, %493 ], [ %498, %497 ]
  %500 = icmp slt i32 %.0.i.i.i.i22, 1
  br i1 %500, label %501, label %_ZNSsD1Ev.exit24

; <label>:501                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %488, %"class.std::allocator"* %32) #1
  br label %_ZNSsD1Ev.exit24

_ZNSsD1Ev.exit24:                                 ; preds = %501, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23, %_ZNSsD1Ev.exit27, %432
  %.1015 = phi i32 [ %435, %432 ], [ %.914, %_ZNSsD1Ev.exit27 ], [ %.914, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23 ], [ %.914, %501 ]
  %.10 = phi i8* [ %434, %432 ], [ %.9, %_ZNSsD1Ev.exit27 ], [ %.9, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23 ], [ %.9, %501 ]
  invoke void @__cxa_end_catch()
          to label %503 unwind label %506

; <label>:502                                     ; preds = %431, %47
  %.0 = phi i32 [ 0, %47 ], [ 1, %431 ]
  ret i32 %.0

; <label>:503                                     ; preds = %_ZNSsD1Ev.exit24, %310
  %.1116 = phi i32 [ %.1015, %_ZNSsD1Ev.exit24 ], [ %.712, %310 ]
  %.11 = phi i8* [ %.10, %_ZNSsD1Ev.exit24 ], [ %.7, %310 ]
  %504 = insertvalue { i8*, i32 } undef, i8* %.11, 0
  %505 = insertvalue { i8*, i32 } %504, i32 %.1116, 1
  resume { i8*, i32 } %505

; <label>:506                                     ; preds = %_ZNSsD1Ev.exit24, %306, %_ZNSsD1Ev.exit43, %174
  %507 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %508 = extractvalue { i8*, i32 } %507, 0
  call void @__clang_call_terminate(i8* %508) #12
  unreachable

; <label>:509                                     ; preds = %304, %297, %172, %167
  unreachable
}

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #7

declare void @__cxa_rethrow()

declare void @__cxa_end_catch()

; Function Attrs: uwtable
define i32 @main() #2 {
  %1 = tail call i32 @c_adder(i32 20, i32 35)
  %2 = icmp eq i32 %1, 0
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = load i32* @_result, align 4, !tbaa !8
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str4, i64 0, i64 0), i32 %4)
  br label %9

; <label>:6                                       ; preds = %0
  %7 = load i8** getelementptr inbounds (%"class.std::basic_string"* @_latest_err_msg, i64 0, i32 0, i32 0), align 8, !tbaa !1
  %8 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([23 x i8]* @.str5, i64 0, i64 0), i8* %7)
  br label %9

; <label>:9                                       ; preds = %6, %3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #4

declare %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #3

declare void @_ZNSsC1ERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #3

declare %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"*, i8*, i64) #3

; Function Attrs: nounwind readonly
declare i64 @strlen(i8* nocapture) #8

declare i64 @_ZNKSs4findEPKcmm(%"class.std::basic_string"*, i8*, i64, i64) #3

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #4

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #4

declare void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"*, %"class.std::basic_string"*) #3

; Function Attrs: inlinehint nounwind uwtable
define linkonce_odr void @_ZN9MathErrorD0Ev(%class.MathError* %this) unnamed_addr #9 align 2 {
  %1 = getelementptr inbounds %class.MathError* %this, i64 0, i32 0
  tail call void @_ZNSt13runtime_errorD2Ev(%"class.std::runtime_error"* %1) #1
  %2 = bitcast %class.MathError* %this to i8*
  tail call void @_ZdlPv(i8* %2) #13
  ret void
}

; Function Attrs: nounwind
declare i8* @_ZNKSt13runtime_error4whatEv(%"class.std::runtime_error"*) #4

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #10

; Function Attrs: nounwind
define internal void @_GLOBAL__I_a() #1 section ".text.startup" {
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** getelementptr inbounds (%"class.std::basic_string"* @_latest_err_msg, i64 0, i32 0, i32 0), align 8, !tbaa !15
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::basic_string"*)* @_ZNSsD1Ev to void (i8*)*), i8* bitcast (%"class.std::basic_string"* @_latest_err_msg to i8*), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noinline noreturn nounwind }
attributes #6 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind readnone }
attributes #8 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { inlinehint nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #10 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #11 = { noreturn }
attributes #12 = { noreturn nounwind }
attributes #13 = { builtin nounwind }

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
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!12 = metadata !{metadata !13, metadata !4, i64 8}
!13 = metadata !{metadata !"_ZTSSt9type_info", metadata !4, i64 8}
!14 = metadata !{metadata !5, metadata !5, i64 0}
!15 = metadata !{metadata !3, metadata !4, i64 0}
