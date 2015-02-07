; ModuleID = 'test_exceptions_std.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::exception" = type { i32 (...)** }
%"class.std::bad_exception" = type { %"class.std::exception" }

@_ZTISt9exception = external constant i8*
@_ZTIi = external constant i8*
@_ZTISt13bad_exception = external constant i8*
@.str = private unnamed_addr constant [10 x i8] c"what? %s\0A\00", align 1
@_ZTVSt13bad_exception = external unnamed_addr constant [5 x i8*]
@_ZTVSt9exception = external unnamed_addr constant [5 x i8*]
@str = private unnamed_addr constant [22 x i8] c"caught std::exception\00"

; Function Attrs: uwtable
define i32 @main() #0 {
  %e = alloca %"class.std::exception", align 8
  %e1 = alloca %"class.std::exception", align 8
  %1 = getelementptr inbounds %"class.std::exception"* %e, i64 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVSt9exception, i64 0, i64 2) to i32 (...)**), i32 (...)*** %1, align 8, !tbaa !1
  %2 = call i8* @__cxa_allocate_exception(i64 8) #3
  %3 = bitcast i8* %2 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVSt9exception, i64 0, i64 2) to i32 (...)**), i32 (...)*** %3, align 8, !tbaa !1
  invoke void @__cxa_throw(i8* %2, i8* bitcast (i8** @_ZTISt9exception to i8*), i8* bitcast (void (%"class.std::exception"*)* @_ZNSt9exceptionD1Ev to i8*)) #4
          to label %35 unwind label %4

; <label>:4                                       ; preds = %0
  %5 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
          catch i8* bitcast (i8** @_ZTISt9exception to i8*)
          catch i8* bitcast (i8** @_ZTIi to i8*)
  %6 = extractvalue { i8*, i32 } %5, 0
  %7 = extractvalue { i8*, i32 } %5, 1
  %8 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTISt9exception to i8*)) #3
  %9 = icmp eq i32 %7, %8
  br i1 %9, label %10, label %17

; <label>:10                                      ; preds = %4
  %11 = call i8* @__cxa_get_exception_ptr(i8* %6) #3
  %12 = getelementptr inbounds %"class.std::exception"* %e1, i64 0, i32 0
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVSt9exception, i64 0, i64 2) to i32 (...)**), i32 (...)*** %12, align 8, !tbaa !1
  %13 = call i8* @__cxa_begin_catch(i8* %6) #3
  %14 = call i8* @_ZNKSt9exception4whatEv(%"class.std::exception"* %e1) #3
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0), i8* %14)
  %puts = call i32 @puts(i8* getelementptr inbounds ([22 x i8]* @str, i64 0, i64 0))
  call void @_ZNSt9exceptionD1Ev(%"class.std::exception"* %e1) #3
  invoke void @__cxa_end_catch()
          to label %16 unwind label %28

; <label>:16                                      ; preds = %10
  call void @_ZNSt9exceptionD1Ev(%"class.std::exception"* %e) #3
  ret i32 0

; <label>:17                                      ; preds = %4
  %18 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTIi to i8*)) #3
  %19 = icmp eq i32 %7, %18
  br i1 %19, label %20, label %32

; <label>:20                                      ; preds = %17
  %21 = call i8* @__cxa_begin_catch(i8* %6) #3
  %22 = call i8* @__cxa_allocate_exception(i64 8) #3
  %23 = bitcast i8* %22 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([5 x i8*]* @_ZTVSt13bad_exception, i64 0, i64 2) to i32 (...)**), i32 (...)*** %23, align 8, !tbaa !1
  invoke void @__cxa_throw(i8* %22, i8* bitcast (i8** @_ZTISt13bad_exception to i8*), i8* bitcast (void (%"class.std::bad_exception"*)* @_ZNSt13bad_exceptionD1Ev to i8*)) #4
          to label %35 unwind label %24

; <label>:24                                      ; preds = %20
  %25 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %26 = extractvalue { i8*, i32 } %25, 0
  %27 = extractvalue { i8*, i32 } %25, 1
  call void @__cxa_end_catch() #3
  br label %32

; <label>:28                                      ; preds = %10
  %29 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %30 = extractvalue { i8*, i32 } %29, 0
  %31 = extractvalue { i8*, i32 } %29, 1
  br label %32

; <label>:32                                      ; preds = %28, %24, %17
  %.02 = phi i32 [ %31, %28 ], [ %27, %24 ], [ %7, %17 ]
  %.0 = phi i8* [ %30, %28 ], [ %26, %24 ], [ %6, %17 ]
  call void @_ZNSt9exceptionD1Ev(%"class.std::exception"* %e) #3
  %33 = insertvalue { i8*, i32 } undef, i8* %.0, 0
  %34 = insertvalue { i8*, i32 } %33, i32 %.02, 1
  resume { i8*, i32 } %34

; <label>:35                                      ; preds = %20, %0
  unreachable
}

declare i8* @__cxa_allocate_exception(i64)

; Function Attrs: nounwind
declare void @_ZNSt9exceptionD1Ev(%"class.std::exception"*) #1

declare void @__cxa_throw(i8*, i8*, i8*)

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #2

declare i8* @__cxa_begin_catch(i8*)

; Function Attrs: nounwind
declare void @_ZNSt13bad_exceptionD1Ev(%"class.std::bad_exception"*) #1

declare void @__cxa_end_catch()

declare i8* @__cxa_get_exception_ptr(i8*)

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i8* @_ZNKSt9exception4whatEv(%"class.std::exception"*) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #3

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }
attributes #4 = { noreturn }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"vtable pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
