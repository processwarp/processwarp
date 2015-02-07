; ModuleID = 'test_longjmp_throw.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf_tag = type { [8 x i64], i32, %struct.__sigset_t }
%struct.__sigset_t = type { [16 x i64] }

@x = global i32 0, align 4
@_ZTIi = external constant i8*
@_ZL3buf = internal global [1 x %struct.__jmp_buf_tag] zeroinitializer, align 16
@.str3 = private unnamed_addr constant [15 x i8] c"result: %d %d\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"second\00"
@str4 = private unnamed_addr constant [6 x i8] c"first\00"

; Function Attrs: noreturn uwtable
define void @_Z6secondv() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %1 = load volatile i32* @x, align 4, !tbaa !1
  %2 = icmp eq i32 %1, 17
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = tail call i8* @__cxa_allocate_exception(i64 4) #6
  %5 = bitcast i8* %4 to i32*
  store i32 5, i32* %5, align 4, !tbaa !1
  tail call void @__cxa_throw(i8* %4, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #7
  unreachable

; <label>:6                                       ; preds = %0
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 -1) #8
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: noreturn nounwind
declare void @longjmp(%struct.__jmp_buf_tag*, i32) #2

; Function Attrs: noreturn nounwind uwtable
define void @_Z5firstv() #3 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str4, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 1) #8
  unreachable
}

; Function Attrs: uwtable
define i32 @main() #4 {
  %1 = tail call i32 @_setjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0)) #6
  switch i32 %1, label %39 [
    i32 0, label %2
    i32 1, label %5
    i32 -1, label %36
  ]

; <label>:2                                       ; preds = %0
  %3 = load volatile i32* @x, align 4, !tbaa !1
  %4 = add nsw i32 %3, 1
  store volatile i32 %4, i32* @x, align 4, !tbaa !1
  tail call void @_Z5firstv()
  unreachable

; <label>:5                                       ; preds = %0
  %6 = load volatile i32* @x, align 4, !tbaa !1
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %6, i32 1)
  %8 = load volatile i32* @x, align 4, !tbaa !1
  %9 = add nsw i32 %8, 1
  store volatile i32 %9, i32* @x, align 4, !tbaa !1
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %10 = load volatile i32* @x, align 4, !tbaa !1
  %11 = icmp eq i32 %10, 17
  br i1 %11, label %12, label %15

; <label>:12                                      ; preds = %5
  %13 = tail call i8* @__cxa_allocate_exception(i64 4) #6
  %14 = bitcast i8* %13 to i32*
  store i32 5, i32* %14, align 4, !tbaa !1
  invoke void @__cxa_throw(i8* %13, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #7
          to label %.noexc unwind label %16

.noexc:                                           ; preds = %12
  unreachable

; <label>:15                                      ; preds = %5
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 -1) #8
  unreachable

; <label>:16                                      ; preds = %12
  %17 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTIi to i8*)
  %18 = extractvalue { i8*, i32 } %17, 0
  %19 = extractvalue { i8*, i32 } %17, 1
  %20 = tail call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTIi to i8*)) #6
  %21 = icmp eq i32 %19, %20
  br i1 %21, label %22, label %40

; <label>:22                                      ; preds = %16
  %23 = tail call i8* @__cxa_begin_catch(i8* %18) #6
  %24 = load volatile i32* @x, align 4, !tbaa !1
  %25 = add nsw i32 %24, -1
  store volatile i32 %25, i32* @x, align 4, !tbaa !1
  %puts.i2 = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %26 = load volatile i32* @x, align 4, !tbaa !1
  %27 = icmp eq i32 %26, 17
  br i1 %27, label %28, label %31

; <label>:28                                      ; preds = %22
  %29 = tail call i8* @__cxa_allocate_exception(i64 4) #6
  %30 = bitcast i8* %29 to i32*
  store i32 5, i32* %30, align 4, !tbaa !1
  invoke void @__cxa_throw(i8* %29, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #7
          to label %.noexc3 unwind label %32

.noexc3:                                          ; preds = %28
  unreachable

; <label>:31                                      ; preds = %22
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 -1) #8
  unreachable

; <label>:32                                      ; preds = %28
  %33 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %34 = extractvalue { i8*, i32 } %33, 0
  %35 = extractvalue { i8*, i32 } %33, 1
  tail call void @__cxa_end_catch() #6
  br label %40

; <label>:36                                      ; preds = %0
  %37 = load volatile i32* @x, align 4, !tbaa !1
  %38 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %37, i32 -1)
  br label %39

; <label>:39                                      ; preds = %36, %0
  ret i32 0

; <label>:40                                      ; preds = %32, %16
  %.01 = phi i32 [ %35, %32 ], [ %19, %16 ]
  %.0 = phi i8* [ %34, %32 ], [ %18, %16 ]
  %41 = insertvalue { i8*, i32 } undef, i8* %.0, 0
  %42 = insertvalue { i8*, i32 } %41, i32 %.01, 1
  resume { i8*, i32 } %42
}

; Function Attrs: nounwind
declare i32 @_setjmp(%struct.__jmp_buf_tag*) #1

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #5

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #6

attributes #0 = { noreturn uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }
attributes #6 = { nounwind }
attributes #7 = { noreturn }
attributes #8 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
