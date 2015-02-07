; ModuleID = 'test_exceptions_multi.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.jmp_state = type { i32 }

@_ZTIi = external constant i8*
@_ZL20current_exception_id = internal unnamed_addr global i32 0, align 4
@.str1 = private unnamed_addr constant [55 x i8] c"setjmp normal execution path, level: %d, prev_jmp: %d\0A\00", align 1
@.str2 = private unnamed_addr constant [11 x i8] c"caught %d\0A\00", align 1
@.str3 = private unnamed_addr constant [58 x i8] c"setjmp exception execution path, level: %d, prev_jmp: %d\0A\00", align 1
@.str5 = private unnamed_addr constant [50 x i8] c"Exiting setjmp function, level: %d, prev_jmp: %d\0A\00", align 1
@str = private unnamed_addr constant [29 x i8] c"level is 2, perform longjmp!\00"
@str6 = private unnamed_addr constant [46 x i8] c"prev_jmp is not empty, continue with longjmp!\00"

; Function Attrs: uwtable
define void @_Z11setjmp_funcP9jmp_statei(%struct.jmp_state* nocapture %s, i32 %level) #0 {
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !1
  %3 = icmp eq i32 %level, 2
  br i1 %3, label %4, label %7

; <label>:4                                       ; preds = %0
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([29 x i8]* @str, i64 0, i64 0))
  %5 = tail call i8* @__cxa_allocate_exception(i64 4) #3
  %6 = bitcast i8* %5 to i32*
  store i32 1, i32* %6, align 4, !tbaa !6
  tail call void @__cxa_throw(i8* %5, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #4
  unreachable

; <label>:7                                       ; preds = %0
  %8 = load i32* @_ZL20current_exception_id, align 4, !tbaa !6
  %9 = add nsw i32 %8, 1
  store i32 %9, i32* @_ZL20current_exception_id, align 4, !tbaa !6
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([55 x i8]* @.str1, i64 0, i64 0), i32 %level, i32 %2)
  store i32 %8, i32* %1, align 4, !tbaa !1
  %11 = add nsw i32 %level, 1
  invoke void @_Z11setjmp_funcP9jmp_statei(%struct.jmp_state* %s, i32 %11)
          to label %37 unwind label %12

; <label>:12                                      ; preds = %7
  %13 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTIi to i8*)
  %14 = extractvalue { i8*, i32 } %13, 0
  %15 = extractvalue { i8*, i32 } %13, 1
  %16 = tail call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTIi to i8*)) #3
  %17 = icmp eq i32 %15, %16
  br i1 %17, label %18, label %39

; <label>:18                                      ; preds = %12
  %19 = tail call i8* @__cxa_begin_catch(i8* %14) #3
  %20 = bitcast i8* %19 to i32*
  %21 = load i32* %20, align 4, !tbaa !6
  %22 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str2, i64 0, i64 0), i32 %21)
  %23 = icmp eq i32 %21, %8
  br i1 %23, label %24, label %35

; <label>:24                                      ; preds = %18
  %25 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([58 x i8]* @.str3, i64 0, i64 0), i32 %level, i32 %2)
  %26 = icmp eq i32 %2, -1
  br i1 %26, label %36, label %27

; <label>:27                                      ; preds = %24
  %puts2 = tail call i32 @puts(i8* getelementptr inbounds ([46 x i8]* @str6, i64 0, i64 0))
  store i32 %2, i32* %1, align 4, !tbaa !1
  %28 = tail call i8* @__cxa_allocate_exception(i64 4) #3
  %29 = bitcast i8* %28 to i32*
  %30 = load i32* %1, align 4, !tbaa !1
  store i32 %30, i32* %29, align 4, !tbaa !6
  invoke void @__cxa_throw(i8* %28, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #4
          to label %42 unwind label %31

; <label>:31                                      ; preds = %35, %27
  %32 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %33 = extractvalue { i8*, i32 } %32, 0
  %34 = extractvalue { i8*, i32 } %32, 1
  tail call void @__cxa_end_catch() #3
  br label %39

; <label>:35                                      ; preds = %18
  invoke void @__cxa_rethrow() #4
          to label %42 unwind label %31

; <label>:36                                      ; preds = %24
  tail call void @__cxa_end_catch() #3
  br label %37

; <label>:37                                      ; preds = %36, %7
  %38 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([50 x i8]* @.str5, i64 0, i64 0), i32 %level, i32 %2)
  ret void

; <label>:39                                      ; preds = %31, %12
  %.01 = phi i32 [ %34, %31 ], [ %15, %12 ]
  %.0 = phi i8* [ %33, %31 ], [ %14, %12 ]
  %40 = insertvalue { i8*, i32 } undef, i8* %.0, 0
  %41 = insertvalue { i8*, i32 } %40, i32 %.01, 1
  resume { i8*, i32 } %41

; <label>:42                                      ; preds = %35, %27
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_throw(i8*, i8*, i8*)

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #2

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_rethrow()

declare void @__cxa_end_catch()

; Function Attrs: uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %s = alloca %struct.jmp_state, align 4
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  store i32 -1, i32* %1, align 4, !tbaa !1
  call void @_Z11setjmp_funcP9jmp_statei(%struct.jmp_state* %s, i32 0)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }
attributes #4 = { noreturn }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS9jmp_state", metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !3, metadata !3, i64 0}
