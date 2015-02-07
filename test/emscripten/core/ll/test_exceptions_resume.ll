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

declare void @__cxa_free_exception(i8*)

; Function Attrs: nounwind readonly uwtable
define i8* @latest_err_msg() #5 {
  %1 = load i8** getelementptr inbounds (%"class.std::basic_string"* @_latest_err_msg, i64 0, i32 0, i32 0), align 8, !tbaa !1
  ret i8* %1
}

; Function Attrs: nounwind readonly uwtable
define i32 @result() #5 {
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
  %25 = alloca %"class.std::basic_string", align 8
  %26 = alloca %"class.std::allocator", align 1
  %27 = alloca %"class.std::basic_string", align 8
  %28 = alloca %"class.std::basic_string", align 8
  %29 = alloca %"class.std::basic_string", align 8
  %30 = alloca %"class.std::basic_string", align 8
  %31 = alloca %"class.std::allocator", align 1
  %32 = alloca %"class.std::basic_string", align 8
  %33 = alloca %"class.std::basic_string", align 8
  %34 = alloca %"class.std::basic_string", align 8
  %35 = alloca %"class.std::allocator", align 1
  %36 = invoke i32 @_Z9cpp_adderii(i32 %a, i32 %b)
          to label %37 unwind label %38

; <label>:37                                      ; preds = %0
  store i32 %36, i32* @_result, align 4, !tbaa !8
  br label %400

; <label>:38                                      ; preds = %0
  %39 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*)
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %40 = extractvalue { i8*, i32 } %39, 0
  %41 = extractvalue { i8*, i32 } %39, 1
  %42 = call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*)) #1
  %43 = icmp eq i32 %41, %42
  br i1 %43, label %44, label %110

; <label>:44                                      ; preds = %38
  %45 = call i8* @__cxa_begin_catch(i8* %40) #1
  %46 = bitcast i8* %45 to %"class.std::runtime_error"*
  %47 = bitcast i8* %45 to i8* (%"class.std::runtime_error"*)***
  %48 = load i8* (%"class.std::runtime_error"*)*** %47, align 8, !tbaa !10
  %49 = getelementptr inbounds i8* (%"class.std::runtime_error"*)** %48, i64 2
  %50 = load i8* (%"class.std::runtime_error"*)** %49, align 8
  %51 = call i8* %50(%"class.std::runtime_error"* %46) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %25, i8* %51, %"class.std::allocator"* %26)
          to label %52 unwind label %119

; <label>:52                                      ; preds = %44
  %53 = invoke i64 @_ZNKSs4findEPKcmm(%"class.std::basic_string"* %25, i8* getelementptr inbounds ([15 x i8]* @.str1, i64 0, i64 0), i64 0, i64 14)
          to label %_ZNKSs4findEPKcm.exit unwind label %123

_ZNKSs4findEPKcm.exit:                            ; preds = %52
  %54 = icmp eq i64 %53, -1
  %55 = getelementptr inbounds %"class.std::allocator"* %24, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %55) #1
  %56 = getelementptr inbounds %"class.std::basic_string"* %25, i64 0, i32 0, i32 0
  %57 = load i8** %56, align 8, !tbaa !1
  %58 = getelementptr inbounds i8* %57, i64 -24
  %59 = bitcast i8* %58 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %60 = icmp eq i8* %58, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %60, label %_ZNSsD1Ev.exit, label %61, !prof !7

; <label>:61                                      ; preds = %_ZNKSs4findEPKcm.exit
  %62 = getelementptr inbounds i8* %57, i64 -8
  %63 = bitcast i8* %62 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %64, label %68

; <label>:64                                      ; preds = %61
  %65 = bitcast i32* %23 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %65)
  %66 = atomicrmw volatile add i32* %63, i32 -1 acq_rel
  store i32 %66, i32* %23, align 4
  %67 = load volatile i32* %23, align 4
  call void @llvm.lifetime.end(i64 4, i8* %65)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:68                                      ; preds = %61
  %69 = load i32* %63, align 4, !tbaa !8
  %70 = add nsw i32 %69, -1
  store i32 %70, i32* %63, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %68, %64
  %.0.i.i.i.i = phi i32 [ %67, %64 ], [ %69, %68 ]
  %71 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %71, label %72, label %_ZNSsD1Ev.exit

; <label>:72                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %59, %"class.std::allocator"* %24) #1
  br label %_ZNSsD1Ev.exit

_ZNSsD1Ev.exit:                                   ; preds = %72, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %_ZNKSs4findEPKcm.exit
  call void @llvm.lifetime.end(i64 1, i8* %55) #1
  br i1 %54, label %73, label %235

; <label>:73                                      ; preds = %_ZNSsD1Ev.exit
  %74 = call i8* @__cxa_allocate_exception(i64 16) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %30, i8* getelementptr inbounds ([27 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator"* %31)
          to label %75 unwind label %.thread

; <label>:75                                      ; preds = %73
  %76 = bitcast i8* %45 to %"class.std::type_info"***
  %77 = load %"class.std::type_info"*** %76, align 8, !tbaa !10
  %78 = getelementptr inbounds %"class.std::type_info"** %77, i64 -1
  %79 = load %"class.std::type_info"** %78, align 8
  %80 = getelementptr inbounds %"class.std::type_info"* %79, i64 0, i32 1
  %81 = load i8** %80, align 8, !tbaa !12
  %82 = load i8* %81, align 1, !tbaa !14
  %83 = icmp eq i8 %82, 42
  %84 = getelementptr inbounds i8* %81, i64 1
  %85 = select i1 %83, i8* %84, i8* %81
  %86 = call i64 @strlen(i8* %85) #1
  %87 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %30, i8* %85, i64 %86)
          to label %88 unwind label %148

; <label>:88                                      ; preds = %75
  %89 = getelementptr inbounds %"class.std::basic_string"* %29, i64 0, i32 0, i32 0
  %90 = getelementptr inbounds %"class.std::basic_string"* %87, i64 0, i32 0, i32 0
  %91 = load i8** %90, align 8, !tbaa !15
  store i8* %91, i8** %89, align 8, !tbaa !15
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %90, align 8, !tbaa !1
  %92 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %29, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i64 2)
          to label %93 unwind label %152

; <label>:93                                      ; preds = %88
  %94 = getelementptr inbounds %"class.std::basic_string"* %28, i64 0, i32 0, i32 0
  %95 = getelementptr inbounds %"class.std::basic_string"* %92, i64 0, i32 0, i32 0
  %96 = load i8** %95, align 8, !tbaa !15
  store i8* %96, i8** %94, align 8, !tbaa !15
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %95, align 8, !tbaa !1
  %97 = load i8* (%"class.std::runtime_error"*)*** %47, align 8, !tbaa !10
  %98 = getelementptr inbounds i8* (%"class.std::runtime_error"*)** %97, i64 2
  %99 = load i8* (%"class.std::runtime_error"*)** %98, align 8
  %100 = call i8* %99(%"class.std::runtime_error"* %46) #1
  %101 = call i64 @strlen(i8* %100) #1
  %102 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %28, i8* %100, i64 %101)
          to label %103 unwind label %156

; <label>:103                                     ; preds = %93
  %104 = getelementptr inbounds %"class.std::basic_string"* %27, i64 0, i32 0, i32 0
  %105 = getelementptr inbounds %"class.std::basic_string"* %102, i64 0, i32 0, i32 0
  %106 = load i8** %105, align 8, !tbaa !15
  store i8* %106, i8** %104, align 8, !tbaa !15
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %105, align 8, !tbaa !1
  %107 = bitcast i8* %74 to %"class.std::runtime_error"*
  invoke void @_ZNSt13runtime_errorC2ERKSs(%"class.std::runtime_error"* %107, %"class.std::basic_string"* %27)
          to label %108 unwind label %160

; <label>:108                                     ; preds = %103
  %109 = bitcast i8* %74 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTV9MathError, i64 0, i64 2) to i32 (...)**), i32 (...)*** %109, align 8, !tbaa !10
  invoke void @__cxa_throw(i8* %74, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI9MathError to i8*), i8* bitcast (void (%"class.std::runtime_error"*)* @_ZNSt13runtime_errorD2Ev to i8*)) #11
          to label %407 unwind label %160

; <label>:110                                     ; preds = %38
  %111 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #1
  %112 = icmp eq i32 %41, %111
  br i1 %112, label %113, label %240

; <label>:113                                     ; preds = %110
  %114 = call i8* @__cxa_begin_catch(i8* %40) #1
  invoke void @__cxa_rethrow() #11
          to label %407 unwind label %115

; <label>:115                                     ; preds = %113
  %116 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %117 = extractvalue { i8*, i32 } %116, 0
  %118 = extractvalue { i8*, i32 } %116, 1
  invoke void @__cxa_end_catch()
          to label %240 unwind label %404

; <label>:119                                     ; preds = %44
  %120 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %121 = extractvalue { i8*, i32 } %120, 0
  %122 = extractvalue { i8*, i32 } %120, 1
  br label %_ZNSsD1Ev.exit32

; <label>:123                                     ; preds = %52
  %124 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %125 = extractvalue { i8*, i32 } %124, 0
  %126 = extractvalue { i8*, i32 } %124, 1
  %127 = getelementptr inbounds %"class.std::allocator"* %18, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %127) #1
  %128 = getelementptr inbounds %"class.std::basic_string"* %25, i64 0, i32 0, i32 0
  %129 = load i8** %128, align 8, !tbaa !1
  %130 = getelementptr inbounds i8* %129, i64 -24
  %131 = bitcast i8* %130 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %132 = icmp eq i8* %130, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %132, label %_ZNSsD1Ev.exit32, label %133, !prof !7

; <label>:133                                     ; preds = %123
  %134 = getelementptr inbounds i8* %129, i64 -8
  %135 = bitcast i8* %134 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %136, label %140

; <label>:136                                     ; preds = %133
  %137 = bitcast i32* %17 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %137)
  %138 = atomicrmw volatile add i32* %135, i32 -1 acq_rel
  store i32 %138, i32* %17, align 4
  %139 = load volatile i32* %17, align 4
  call void @llvm.lifetime.end(i64 4, i8* %137)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31

; <label>:140                                     ; preds = %133
  %141 = load i32* %135, align 4, !tbaa !8
  %142 = add nsw i32 %141, -1
  store i32 %142, i32* %135, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31: ; preds = %140, %136
  %.0.i.i.i.i30 = phi i32 [ %139, %136 ], [ %141, %140 ]
  %143 = icmp slt i32 %.0.i.i.i.i30, 1
  br i1 %143, label %144, label %_ZNSsD1Ev.exit32

; <label>:144                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %131, %"class.std::allocator"* %18) #1
  br label %_ZNSsD1Ev.exit32

.thread:                                          ; preds = %73
  %145 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %146 = extractvalue { i8*, i32 } %145, 0
  %147 = extractvalue { i8*, i32 } %145, 1
  br label %234

; <label>:148                                     ; preds = %75
  %149 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %150 = extractvalue { i8*, i32 } %149, 0
  %151 = extractvalue { i8*, i32 } %149, 1
  br label %_ZNSsD1Ev.exit41

; <label>:152                                     ; preds = %88
  %153 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %154 = extractvalue { i8*, i32 } %153, 0
  %155 = extractvalue { i8*, i32 } %153, 1
  br label %_ZNSsD1Ev.exit38

; <label>:156                                     ; preds = %93
  %157 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %158 = extractvalue { i8*, i32 } %157, 0
  %159 = extractvalue { i8*, i32 } %157, 1
  br label %_ZNSsD1Ev.exit35

; <label>:160                                     ; preds = %108, %103
  %.017 = phi i1 [ false, %108 ], [ true, %103 ]
  %161 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %162 = extractvalue { i8*, i32 } %161, 0
  %163 = extractvalue { i8*, i32 } %161, 1
  %164 = getelementptr inbounds %"class.std::allocator"* %16, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %164) #1
  %165 = load i8** %104, align 8, !tbaa !1
  %166 = getelementptr inbounds i8* %165, i64 -24
  %167 = bitcast i8* %166 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %168 = icmp eq i8* %166, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %168, label %_ZNSsD1Ev.exit35, label %169, !prof !7

; <label>:169                                     ; preds = %160
  %170 = getelementptr inbounds i8* %165, i64 -8
  %171 = bitcast i8* %170 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %172, label %176

; <label>:172                                     ; preds = %169
  %173 = bitcast i32* %15 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %173)
  %174 = atomicrmw volatile add i32* %171, i32 -1 acq_rel
  store i32 %174, i32* %15, align 4
  %175 = load volatile i32* %15, align 4
  call void @llvm.lifetime.end(i64 4, i8* %173)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34

; <label>:176                                     ; preds = %169
  %177 = load i32* %171, align 4, !tbaa !8
  %178 = add nsw i32 %177, -1
  store i32 %178, i32* %171, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34: ; preds = %176, %172
  %.0.i.i.i.i33 = phi i32 [ %175, %172 ], [ %177, %176 ]
  %179 = icmp slt i32 %.0.i.i.i.i33, 1
  br i1 %179, label %180, label %_ZNSsD1Ev.exit35

; <label>:180                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %167, %"class.std::allocator"* %16) #1
  br label %_ZNSsD1Ev.exit35

_ZNSsD1Ev.exit35:                                 ; preds = %180, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34, %160, %156
  %.118 = phi i1 [ true, %156 ], [ %.017, %160 ], [ %.017, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34 ], [ %.017, %180 ]
  %.16 = phi i32 [ %159, %156 ], [ %163, %160 ], [ %163, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34 ], [ %163, %180 ]
  %.1 = phi i8* [ %158, %156 ], [ %162, %160 ], [ %162, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i34 ], [ %162, %180 ]
  %181 = getelementptr inbounds %"class.std::allocator"* %14, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %181) #1
  %182 = load i8** %94, align 8, !tbaa !1
  %183 = getelementptr inbounds i8* %182, i64 -24
  %184 = bitcast i8* %183 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %185 = icmp eq i8* %183, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %185, label %_ZNSsD1Ev.exit38, label %186, !prof !7

; <label>:186                                     ; preds = %_ZNSsD1Ev.exit35
  %187 = getelementptr inbounds i8* %182, i64 -8
  %188 = bitcast i8* %187 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %189, label %193

; <label>:189                                     ; preds = %186
  %190 = bitcast i32* %13 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %190)
  %191 = atomicrmw volatile add i32* %188, i32 -1 acq_rel
  store i32 %191, i32* %13, align 4
  %192 = load volatile i32* %13, align 4
  call void @llvm.lifetime.end(i64 4, i8* %190)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37

; <label>:193                                     ; preds = %186
  %194 = load i32* %188, align 4, !tbaa !8
  %195 = add nsw i32 %194, -1
  store i32 %195, i32* %188, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37: ; preds = %193, %189
  %.0.i.i.i.i36 = phi i32 [ %192, %189 ], [ %194, %193 ]
  %196 = icmp slt i32 %.0.i.i.i.i36, 1
  br i1 %196, label %197, label %_ZNSsD1Ev.exit38

; <label>:197                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %184, %"class.std::allocator"* %14) #1
  br label %_ZNSsD1Ev.exit38

_ZNSsD1Ev.exit38:                                 ; preds = %197, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37, %_ZNSsD1Ev.exit35, %152
  %.219 = phi i1 [ true, %152 ], [ %.118, %_ZNSsD1Ev.exit35 ], [ %.118, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37 ], [ %.118, %197 ]
  %.27 = phi i32 [ %155, %152 ], [ %.16, %_ZNSsD1Ev.exit35 ], [ %.16, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37 ], [ %.16, %197 ]
  %.2 = phi i8* [ %154, %152 ], [ %.1, %_ZNSsD1Ev.exit35 ], [ %.1, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i37 ], [ %.1, %197 ]
  %198 = getelementptr inbounds %"class.std::allocator"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %198) #1
  %199 = load i8** %89, align 8, !tbaa !1
  %200 = getelementptr inbounds i8* %199, i64 -24
  %201 = bitcast i8* %200 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %202 = icmp eq i8* %200, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %202, label %_ZNSsD1Ev.exit41, label %203, !prof !7

; <label>:203                                     ; preds = %_ZNSsD1Ev.exit38
  %204 = getelementptr inbounds i8* %199, i64 -8
  %205 = bitcast i8* %204 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %206, label %210

; <label>:206                                     ; preds = %203
  %207 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %207)
  %208 = atomicrmw volatile add i32* %205, i32 -1 acq_rel
  store i32 %208, i32* %11, align 4
  %209 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %207)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40

; <label>:210                                     ; preds = %203
  %211 = load i32* %205, align 4, !tbaa !8
  %212 = add nsw i32 %211, -1
  store i32 %212, i32* %205, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40: ; preds = %210, %206
  %.0.i.i.i.i39 = phi i32 [ %209, %206 ], [ %211, %210 ]
  %213 = icmp slt i32 %.0.i.i.i.i39, 1
  br i1 %213, label %214, label %_ZNSsD1Ev.exit41

; <label>:214                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %201, %"class.std::allocator"* %12) #1
  br label %_ZNSsD1Ev.exit41

_ZNSsD1Ev.exit41:                                 ; preds = %214, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40, %_ZNSsD1Ev.exit38, %148
  %.320 = phi i1 [ true, %148 ], [ %.219, %_ZNSsD1Ev.exit38 ], [ %.219, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40 ], [ %.219, %214 ]
  %.38 = phi i32 [ %151, %148 ], [ %.27, %_ZNSsD1Ev.exit38 ], [ %.27, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40 ], [ %.27, %214 ]
  %.3 = phi i8* [ %150, %148 ], [ %.2, %_ZNSsD1Ev.exit38 ], [ %.2, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i40 ], [ %.2, %214 ]
  %215 = getelementptr inbounds %"class.std::allocator"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %215) #1
  %216 = getelementptr inbounds %"class.std::basic_string"* %30, i64 0, i32 0, i32 0
  %217 = load i8** %216, align 8, !tbaa !1
  %218 = getelementptr inbounds i8* %217, i64 -24
  %219 = bitcast i8* %218 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %220 = icmp eq i8* %218, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %220, label %233, label %221, !prof !7

; <label>:221                                     ; preds = %_ZNSsD1Ev.exit41
  %222 = getelementptr inbounds i8* %217, i64 -8
  %223 = bitcast i8* %222 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %224, label %228

; <label>:224                                     ; preds = %221
  %225 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %225)
  %226 = atomicrmw volatile add i32* %223, i32 -1 acq_rel
  store i32 %226, i32* %9, align 4
  %227 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %225)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i43

; <label>:228                                     ; preds = %221
  %229 = load i32* %223, align 4, !tbaa !8
  %230 = add nsw i32 %229, -1
  store i32 %230, i32* %223, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i43

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i43: ; preds = %228, %224
  %.0.i.i.i.i42 = phi i32 [ %227, %224 ], [ %229, %228 ]
  %231 = icmp slt i32 %.0.i.i.i.i42, 1
  br i1 %231, label %232, label %233

; <label>:232                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i43
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %219, %"class.std::allocator"* %10) #1
  br label %233

; <label>:233                                     ; preds = %232, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i43, %_ZNSsD1Ev.exit41
  call void @llvm.lifetime.end(i64 1, i8* %215) #1
  br i1 %.320, label %234, label %_ZNSsD1Ev.exit32

; <label>:234                                     ; preds = %233, %.thread
  %.460 = phi i8* [ %146, %.thread ], [ %.3, %233 ]
  %.4959 = phi i32 [ %147, %.thread ], [ %.38, %233 ]
  call void @__cxa_free_exception(i8* %74) #1
  br label %_ZNSsD1Ev.exit32

; <label>:235                                     ; preds = %_ZNSsD1Ev.exit
  invoke void @__cxa_rethrow() #11
          to label %407 unwind label %236

; <label>:236                                     ; preds = %235
  %237 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %238 = extractvalue { i8*, i32 } %237, 0
  %239 = extractvalue { i8*, i32 } %237, 1
  br label %_ZNSsD1Ev.exit32

_ZNSsD1Ev.exit32:                                 ; preds = %236, %234, %233, %144, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31, %123, %119
  %.510 = phi i32 [ %.4959, %234 ], [ %.38, %233 ], [ %239, %236 ], [ %122, %119 ], [ %126, %123 ], [ %126, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31 ], [ %126, %144 ]
  %.5 = phi i8* [ %.460, %234 ], [ %.3, %233 ], [ %238, %236 ], [ %121, %119 ], [ %125, %123 ], [ %125, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i31 ], [ %125, %144 ]
  invoke void @__cxa_end_catch()
          to label %_ZNSsD1Ev.exit32._crit_edge unwind label %404

_ZNSsD1Ev.exit32._crit_edge:                      ; preds = %_ZNSsD1Ev.exit32
  %.pre = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #1
  br label %240

; <label>:240                                     ; preds = %_ZNSsD1Ev.exit32._crit_edge, %115, %110
  %.pre-phi = phi i32 [ %.pre, %_ZNSsD1Ev.exit32._crit_edge ], [ %111, %115 ], [ %111, %110 ]
  %.611 = phi i32 [ %.510, %_ZNSsD1Ev.exit32._crit_edge ], [ %118, %115 ], [ %41, %110 ]
  %.6 = phi i8* [ %.5, %_ZNSsD1Ev.exit32._crit_edge ], [ %117, %115 ], [ %40, %110 ]
  %241 = icmp eq i32 %.611, %.pre-phi
  br i1 %241, label %242, label %248

; <label>:242                                     ; preds = %240
  %243 = call i8* @__cxa_begin_catch(i8* %.6) #1
  invoke void @__cxa_rethrow() #11
          to label %407 unwind label %244

; <label>:244                                     ; preds = %242
  %245 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
  %246 = extractvalue { i8*, i32 } %245, 0
  %247 = extractvalue { i8*, i32 } %245, 1
  invoke void @__cxa_end_catch()
          to label %248 unwind label %404

; <label>:248                                     ; preds = %244, %240
  %.712 = phi i32 [ %247, %244 ], [ %.611, %240 ]
  %.7 = phi i8* [ %246, %244 ], [ %.6, %240 ]
  %249 = icmp eq i32 %.712, %.pre-phi
  br i1 %249, label %250, label %401

; <label>:250                                     ; preds = %248
  %251 = call i8* @__cxa_begin_catch(i8* %.7) #1
  %252 = bitcast i8* %251 to %"class.std::exception"*
  %253 = bitcast i8* %251 to %"class.std::type_info"***
  %254 = load %"class.std::type_info"*** %253, align 8, !tbaa !10
  %255 = getelementptr inbounds %"class.std::type_info"** %254, i64 -1
  %256 = load %"class.std::type_info"** %255, align 8
  %257 = getelementptr inbounds %"class.std::type_info"* %256, i64 0, i32 1
  %258 = load i8** %257, align 8, !tbaa !12
  %259 = load i8* %258, align 1, !tbaa !14
  %260 = icmp eq i8 %259, 42
  %261 = getelementptr inbounds i8* %258, i64 1
  %262 = select i1 %260, i8* %261, i8* %258
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %34, i8* %262, %"class.std::allocator"* %35)
          to label %263 unwind label %332

; <label>:263                                     ; preds = %250
  %264 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %34, i8* getelementptr inbounds ([3 x i8]* @.str3, i64 0, i64 0), i64 2)
          to label %265 unwind label %336

; <label>:265                                     ; preds = %263
  %266 = getelementptr inbounds %"class.std::basic_string"* %33, i64 0, i32 0, i32 0
  %267 = getelementptr inbounds %"class.std::basic_string"* %264, i64 0, i32 0, i32 0
  %268 = load i8** %267, align 8, !tbaa !15
  store i8* %268, i8** %266, align 8, !tbaa !15
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %267, align 8, !tbaa !1
  %269 = bitcast i8* %251 to i8* (%"class.std::exception"*)***
  %270 = load i8* (%"class.std::exception"*)*** %269, align 8, !tbaa !10
  %271 = getelementptr inbounds i8* (%"class.std::exception"*)** %270, i64 2
  %272 = load i8* (%"class.std::exception"*)** %271, align 8
  %273 = call i8* %272(%"class.std::exception"* %252) #1
  %274 = call i64 @strlen(i8* %273) #1
  %275 = invoke %"class.std::basic_string"* @_ZNSs6appendEPKcm(%"class.std::basic_string"* %33, i8* %273, i64 %274)
          to label %276 unwind label %340

; <label>:276                                     ; preds = %265
  %277 = getelementptr inbounds %"class.std::basic_string"* %32, i64 0, i32 0, i32 0
  %278 = getelementptr inbounds %"class.std::basic_string"* %275, i64 0, i32 0, i32 0
  %279 = load i8** %278, align 8, !tbaa !15
  store i8* %279, i8** %277, align 8, !tbaa !15
  store i8* bitcast (i64* getelementptr inbounds ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE, i64 0, i64 3) to i8*), i8** %278, align 8, !tbaa !1
  invoke void @_ZNSs4swapERSs(%"class.std::basic_string"* @_latest_err_msg, %"class.std::basic_string"* %32)
          to label %_ZNSsaSEOSs.exit unwind label %344

_ZNSsaSEOSs.exit:                                 ; preds = %276
  %280 = getelementptr inbounds %"class.std::allocator"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %280) #1
  %281 = load i8** %277, align 8, !tbaa !1
  %282 = getelementptr inbounds i8* %281, i64 -24
  %283 = bitcast i8* %282 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %284 = icmp eq i8* %282, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %284, label %_ZNSsD1Ev.exit52, label %285, !prof !7

; <label>:285                                     ; preds = %_ZNSsaSEOSs.exit
  %286 = getelementptr inbounds i8* %281, i64 -8
  %287 = bitcast i8* %286 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %288, label %292

; <label>:288                                     ; preds = %285
  %289 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %289)
  %290 = atomicrmw volatile add i32* %287, i32 -1 acq_rel
  store i32 %290, i32* %5, align 4
  %291 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %289)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51

; <label>:292                                     ; preds = %285
  %293 = load i32* %287, align 4, !tbaa !8
  %294 = add nsw i32 %293, -1
  store i32 %294, i32* %287, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51: ; preds = %292, %288
  %.0.i.i.i.i50 = phi i32 [ %291, %288 ], [ %293, %292 ]
  %295 = icmp slt i32 %.0.i.i.i.i50, 1
  br i1 %295, label %296, label %_ZNSsD1Ev.exit52

; <label>:296                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %283, %"class.std::allocator"* %6) #1
  br label %_ZNSsD1Ev.exit52

_ZNSsD1Ev.exit52:                                 ; preds = %296, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i51, %_ZNSsaSEOSs.exit
  call void @llvm.lifetime.end(i64 1, i8* %280) #1
  %297 = getelementptr inbounds %"class.std::allocator"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %297) #1
  %298 = load i8** %266, align 8, !tbaa !1
  %299 = getelementptr inbounds i8* %298, i64 -24
  %300 = bitcast i8* %299 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %301 = icmp eq i8* %299, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %301, label %_ZNSsD1Ev.exit55, label %302, !prof !7

; <label>:302                                     ; preds = %_ZNSsD1Ev.exit52
  %303 = getelementptr inbounds i8* %298, i64 -8
  %304 = bitcast i8* %303 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %305, label %309

; <label>:305                                     ; preds = %302
  %306 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %306)
  %307 = atomicrmw volatile add i32* %304, i32 -1 acq_rel
  store i32 %307, i32* %3, align 4
  %308 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %306)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54

; <label>:309                                     ; preds = %302
  %310 = load i32* %304, align 4, !tbaa !8
  %311 = add nsw i32 %310, -1
  store i32 %311, i32* %304, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54: ; preds = %309, %305
  %.0.i.i.i.i53 = phi i32 [ %308, %305 ], [ %310, %309 ]
  %312 = icmp slt i32 %.0.i.i.i.i53, 1
  br i1 %312, label %313, label %_ZNSsD1Ev.exit55

; <label>:313                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %300, %"class.std::allocator"* %4) #1
  br label %_ZNSsD1Ev.exit55

_ZNSsD1Ev.exit55:                                 ; preds = %313, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i54, %_ZNSsD1Ev.exit52
  call void @llvm.lifetime.end(i64 1, i8* %297) #1
  %314 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %314) #1
  %315 = getelementptr inbounds %"class.std::basic_string"* %34, i64 0, i32 0, i32 0
  %316 = load i8** %315, align 8, !tbaa !1
  %317 = getelementptr inbounds i8* %316, i64 -24
  %318 = bitcast i8* %317 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %319 = icmp eq i8* %317, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %319, label %_ZNSsD1Ev.exit58, label %320, !prof !7

; <label>:320                                     ; preds = %_ZNSsD1Ev.exit55
  %321 = getelementptr inbounds i8* %316, i64 -8
  %322 = bitcast i8* %321 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %323, label %327

; <label>:323                                     ; preds = %320
  %324 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %324)
  %325 = atomicrmw volatile add i32* %322, i32 -1 acq_rel
  store i32 %325, i32* %1, align 4
  %326 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %324)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57

; <label>:327                                     ; preds = %320
  %328 = load i32* %322, align 4, !tbaa !8
  %329 = add nsw i32 %328, -1
  store i32 %329, i32* %322, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57: ; preds = %327, %323
  %.0.i.i.i.i56 = phi i32 [ %326, %323 ], [ %328, %327 ]
  %330 = icmp slt i32 %.0.i.i.i.i56, 1
  br i1 %330, label %331, label %_ZNSsD1Ev.exit58

; <label>:331                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %318, %"class.std::allocator"* %2) #1
  br label %_ZNSsD1Ev.exit58

_ZNSsD1Ev.exit58:                                 ; preds = %331, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i57, %_ZNSsD1Ev.exit55
  call void @llvm.lifetime.end(i64 1, i8* %314) #1
  call void @__cxa_end_catch()
  br label %400

; <label>:332                                     ; preds = %250
  %333 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %334 = extractvalue { i8*, i32 } %333, 0
  %335 = extractvalue { i8*, i32 } %333, 1
  br label %_ZNSsD1Ev.exit24

; <label>:336                                     ; preds = %263
  %337 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %338 = extractvalue { i8*, i32 } %337, 0
  %339 = extractvalue { i8*, i32 } %337, 1
  br label %_ZNSsD1Ev.exit27

; <label>:340                                     ; preds = %265
  %341 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %342 = extractvalue { i8*, i32 } %341, 0
  %343 = extractvalue { i8*, i32 } %341, 1
  br label %_ZNSsD1Ev.exit47

; <label>:344                                     ; preds = %276
  %345 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %346 = extractvalue { i8*, i32 } %345, 0
  %347 = extractvalue { i8*, i32 } %345, 1
  %348 = getelementptr inbounds %"class.std::allocator"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %348) #1
  %349 = load i8** %277, align 8, !tbaa !1
  %350 = getelementptr inbounds i8* %349, i64 -24
  %351 = bitcast i8* %350 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %352 = icmp eq i8* %350, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %352, label %_ZNSsD1Ev.exit47, label %353, !prof !7

; <label>:353                                     ; preds = %344
  %354 = getelementptr inbounds i8* %349, i64 -8
  %355 = bitcast i8* %354 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %356, label %360

; <label>:356                                     ; preds = %353
  %357 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %357)
  %358 = atomicrmw volatile add i32* %355, i32 -1 acq_rel
  store i32 %358, i32* %7, align 4
  %359 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %357)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46

; <label>:360                                     ; preds = %353
  %361 = load i32* %355, align 4, !tbaa !8
  %362 = add nsw i32 %361, -1
  store i32 %362, i32* %355, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46: ; preds = %360, %356
  %.0.i.i.i.i45 = phi i32 [ %359, %356 ], [ %361, %360 ]
  %363 = icmp slt i32 %.0.i.i.i.i45, 1
  br i1 %363, label %364, label %_ZNSsD1Ev.exit47

; <label>:364                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %351, %"class.std::allocator"* %8) #1
  br label %_ZNSsD1Ev.exit47

_ZNSsD1Ev.exit47:                                 ; preds = %364, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46, %344, %340
  %.813 = phi i32 [ %343, %340 ], [ %347, %344 ], [ %347, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46 ], [ %347, %364 ]
  %.8 = phi i8* [ %342, %340 ], [ %346, %344 ], [ %346, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i46 ], [ %346, %364 ]
  %365 = getelementptr inbounds %"class.std::allocator"* %20, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %365) #1
  %366 = load i8** %266, align 8, !tbaa !1
  %367 = getelementptr inbounds i8* %366, i64 -24
  %368 = bitcast i8* %367 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %369 = icmp eq i8* %367, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %369, label %_ZNSsD1Ev.exit27, label %370, !prof !7

; <label>:370                                     ; preds = %_ZNSsD1Ev.exit47
  %371 = getelementptr inbounds i8* %366, i64 -8
  %372 = bitcast i8* %371 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %373, label %377

; <label>:373                                     ; preds = %370
  %374 = bitcast i32* %19 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %374)
  %375 = atomicrmw volatile add i32* %372, i32 -1 acq_rel
  store i32 %375, i32* %19, align 4
  %376 = load volatile i32* %19, align 4
  call void @llvm.lifetime.end(i64 4, i8* %374)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26

; <label>:377                                     ; preds = %370
  %378 = load i32* %372, align 4, !tbaa !8
  %379 = add nsw i32 %378, -1
  store i32 %379, i32* %372, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26: ; preds = %377, %373
  %.0.i.i.i.i25 = phi i32 [ %376, %373 ], [ %378, %377 ]
  %380 = icmp slt i32 %.0.i.i.i.i25, 1
  br i1 %380, label %381, label %_ZNSsD1Ev.exit27

; <label>:381                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %368, %"class.std::allocator"* %20) #1
  br label %_ZNSsD1Ev.exit27

_ZNSsD1Ev.exit27:                                 ; preds = %381, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26, %_ZNSsD1Ev.exit47, %336
  %.914 = phi i32 [ %339, %336 ], [ %.813, %_ZNSsD1Ev.exit47 ], [ %.813, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26 ], [ %.813, %381 ]
  %.9 = phi i8* [ %338, %336 ], [ %.8, %_ZNSsD1Ev.exit47 ], [ %.8, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i26 ], [ %.8, %381 ]
  %382 = getelementptr inbounds %"class.std::allocator"* %22, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %382) #1
  %383 = getelementptr inbounds %"class.std::basic_string"* %34, i64 0, i32 0, i32 0
  %384 = load i8** %383, align 8, !tbaa !1
  %385 = getelementptr inbounds i8* %384, i64 -24
  %386 = bitcast i8* %385 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %387 = icmp eq i8* %385, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %387, label %_ZNSsD1Ev.exit24, label %388, !prof !7

; <label>:388                                     ; preds = %_ZNSsD1Ev.exit27
  %389 = getelementptr inbounds i8* %384, i64 -8
  %390 = bitcast i8* %389 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %391, label %395

; <label>:391                                     ; preds = %388
  %392 = bitcast i32* %21 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %392)
  %393 = atomicrmw volatile add i32* %390, i32 -1 acq_rel
  store i32 %393, i32* %21, align 4
  %394 = load volatile i32* %21, align 4
  call void @llvm.lifetime.end(i64 4, i8* %392)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23

; <label>:395                                     ; preds = %388
  %396 = load i32* %390, align 4, !tbaa !8
  %397 = add nsw i32 %396, -1
  store i32 %397, i32* %390, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23: ; preds = %395, %391
  %.0.i.i.i.i22 = phi i32 [ %394, %391 ], [ %396, %395 ]
  %398 = icmp slt i32 %.0.i.i.i.i22, 1
  br i1 %398, label %399, label %_ZNSsD1Ev.exit24

; <label>:399                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %386, %"class.std::allocator"* %22) #1
  br label %_ZNSsD1Ev.exit24

_ZNSsD1Ev.exit24:                                 ; preds = %399, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23, %_ZNSsD1Ev.exit27, %332
  %.1015 = phi i32 [ %335, %332 ], [ %.914, %_ZNSsD1Ev.exit27 ], [ %.914, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23 ], [ %.914, %399 ]
  %.10 = phi i8* [ %334, %332 ], [ %.9, %_ZNSsD1Ev.exit27 ], [ %.9, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i23 ], [ %.9, %399 ]
  invoke void @__cxa_end_catch()
          to label %401 unwind label %404

; <label>:400                                     ; preds = %_ZNSsD1Ev.exit58, %37
  %.0 = phi i32 [ 0, %37 ], [ 1, %_ZNSsD1Ev.exit58 ]
  ret i32 %.0

; <label>:401                                     ; preds = %_ZNSsD1Ev.exit24, %248
  %.1116 = phi i32 [ %.1015, %_ZNSsD1Ev.exit24 ], [ %.712, %248 ]
  %.11 = phi i8* [ %.10, %_ZNSsD1Ev.exit24 ], [ %.7, %248 ]
  %402 = insertvalue { i8*, i32 } undef, i8* %.11, 0
  %403 = insertvalue { i8*, i32 } %402, i32 %.1116, 1
  resume { i8*, i32 } %403

; <label>:404                                     ; preds = %_ZNSsD1Ev.exit24, %244, %_ZNSsD1Ev.exit32, %115
  %405 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %406 = extractvalue { i8*, i32 } %405, 0
  call void @__clang_call_terminate(i8* %406) #12
  unreachable

; <label>:407                                     ; preds = %242, %235, %113, %108
  unreachable
}

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #6

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_rethrow()

declare void @__cxa_end_catch()

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #7 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #12
  unreachable
}

declare void @_ZSt9terminatev()

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

declare void @_ZNSs4swapERSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #3

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
attributes #5 = { nounwind readonly uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind readnone }
attributes #7 = { noinline noreturn nounwind }
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
