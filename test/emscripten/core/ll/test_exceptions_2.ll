; ModuleID = 'test_exceptions_2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::allocator" = type { i8 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"class.std::runtime_error" = type { %"class.std::exception", %"class.std::basic_string" }
%"class.std::exception" = type { i32 (...)** }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@.str = private unnamed_addr constant [10 x i8] c"catch me!\00", align 1
@_ZTISt13runtime_error = external constant i8*
@ptr = global void ()* @_Z14ThrowExceptionv, align 8
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@str = private unnamed_addr constant [31 x i8] c"Exception caught successfully!\00"

; Function Attrs: noreturn uwtable
define void @_Z14ThrowExceptionv() #0 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator", align 1
  %3 = alloca %"class.std::basic_string", align 8
  %4 = alloca %"class.std::allocator", align 1
  %5 = call i8* @__cxa_allocate_exception(i64 16) #4
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %3, i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), %"class.std::allocator"* %4)
          to label %6 unwind label %.thread

; <label>:6                                       ; preds = %0
  %7 = bitcast i8* %5 to %"class.std::runtime_error"*
  invoke void @_ZNSt13runtime_errorC1ERKSs(%"class.std::runtime_error"* %7, %"class.std::basic_string"* %3)
          to label %8 unwind label %12

; <label>:8                                       ; preds = %6
  invoke void @__cxa_throw(i8* %5, i8* bitcast (i8** @_ZTISt13runtime_error to i8*), i8* bitcast (void (%"class.std::runtime_error"*)* @_ZNSt13runtime_errorD1Ev to i8*)) #5
          to label %39 unwind label %12

.thread:                                          ; preds = %0
  %9 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %10 = extractvalue { i8*, i32 } %9, 0
  %11 = extractvalue { i8*, i32 } %9, 1
  br label %35

; <label>:12                                      ; preds = %8, %6
  %.0 = phi i1 [ false, %8 ], [ true, %6 ]
  %13 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %14 = extractvalue { i8*, i32 } %13, 0
  %15 = extractvalue { i8*, i32 } %13, 1
  %16 = getelementptr inbounds %"class.std::allocator"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %16) #4
  %17 = getelementptr inbounds %"class.std::basic_string"* %3, i64 0, i32 0, i32 0
  %18 = load i8** %17, align 8, !tbaa !1
  %19 = getelementptr inbounds i8* %18, i64 -24
  %20 = bitcast i8* %19 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %21 = icmp eq i8* %19, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %21, label %34, label %22, !prof !7

; <label>:22                                      ; preds = %12
  %23 = getelementptr inbounds i8* %18, i64 -8
  %24 = bitcast i8* %23 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %25, label %29

; <label>:25                                      ; preds = %22
  %26 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %26)
  %27 = atomicrmw volatile add i32* %24, i32 -1 acq_rel
  store i32 %27, i32* %1, align 4
  %28 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %26)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:29                                      ; preds = %22
  %30 = load i32* %24, align 4, !tbaa !8
  %31 = add nsw i32 %30, -1
  store i32 %31, i32* %24, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %29, %25
  %.0.i.i.i.i = phi i32 [ %28, %25 ], [ %30, %29 ]
  %32 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %32, label %33, label %34

; <label>:33                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %20, %"class.std::allocator"* %2) #4
  br label %34

; <label>:34                                      ; preds = %33, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %12
  call void @llvm.lifetime.end(i64 1, i8* %16) #4
  br i1 %.0, label %35, label %36

; <label>:35                                      ; preds = %34, %.thread
  %.016 = phi i32 [ %11, %.thread ], [ %15, %34 ]
  %.024 = phi i8* [ %10, %.thread ], [ %14, %34 ]
  call void @__cxa_free_exception(i8* %5) #4
  br label %36

; <label>:36                                      ; preds = %35, %34
  %.015 = phi i32 [ %15, %34 ], [ %.016, %35 ]
  %.023 = phi i8* [ %14, %34 ], [ %.024, %35 ]
  %37 = insertvalue { i8*, i32 } undef, i8* %.023, 0
  %38 = insertvalue { i8*, i32 } %37, i32 %.015, 1
  resume { i8*, i32 } %38

; <label>:39                                      ; preds = %8
  unreachable
}

declare i8* @__cxa_allocate_exception(i64)

declare void @_ZNSt13runtime_errorC1ERKSs(%"class.std::runtime_error"*, %"class.std::basic_string"*) #1

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator"*) #1

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind
declare void @_ZNSt13runtime_errorD1Ev(%"class.std::runtime_error"*) #2

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @__cxa_free_exception(i8*)

; Function Attrs: uwtable
define i32 @main() #3 {
  %1 = load void ()** @ptr, align 8, !tbaa !10
  invoke void %1()
          to label %6 unwind label %2

; <label>:2                                       ; preds = %0
  %3 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %4 = extractvalue { i8*, i32 } %3, 0
  %5 = tail call i8* @__cxa_begin_catch(i8* %4) #4
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([31 x i8]* @str, i64 0, i64 0))
  tail call void @__cxa_end_catch()
  br label %6

; <label>:6                                       ; preds = %2, %0
  ret i32 0
}

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator"*) #2

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #4

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #4

attributes #0 = { noreturn uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn }

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
!10 = metadata !{metadata !4, metadata !4, i64 0}
