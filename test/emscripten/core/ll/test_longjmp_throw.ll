; ModuleID = 'test_longjmp_throw.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@x = global i32 0, align 4
@_ZTIi = external constant i8*
@_ZL3buf = internal global [1 x %struct.__jmp_buf] zeroinitializer, align 16
@.str3 = private unnamed_addr constant [15 x i8] c"result: %d %d\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"second\00"
@str4 = private unnamed_addr constant [6 x i8] c"first\00"
@str5 = private unnamed_addr constant [8 x i8] c"skipped\00"

; Function Attrs: uwtable
define void @_Z6secondv() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %1 = load volatile i32* @x, align 4, !tbaa !1
  %2 = icmp eq i32 %1, 17
  br i1 %2, label %3, label %6

; <label>:3                                       ; preds = %0
  %4 = tail call i8* @__cxa_allocate_exception(i64 4) #5
  %5 = bitcast i8* %4 to i32*
  store i32 5, i32* %5, align 4, !tbaa !1
  tail call void @__cxa_throw(i8* %4, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #6
  unreachable

; <label>:6                                       ; preds = %0
  tail call void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @_ZL3buf, i64 0, i64 0), i32 -1)
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_throw(i8*, i8*, i8*)

declare void @longjmp(%struct.__jmp_buf*, i32) #2

; Function Attrs: uwtable
define void @_Z5firstv() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str4, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @_ZL3buf, i64 0, i64 0), i32 1)
  ret void
}

; Function Attrs: uwtable
define i32 @main() #0 {
  %1 = call i32 @setjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @_ZL3buf, i64 0, i64 0)) #7
  switch i32 %1, label %_Z6secondv.exit [
    i32 0, label %2
    i32 1, label %5
    i32 -1, label %36
  ]

; <label>:2                                       ; preds = %0
  %3 = load volatile i32* @x, align 4, !tbaa !1
  %4 = add nsw i32 %3, 1
  store volatile i32 %4, i32* @x, align 4, !tbaa !1
  %puts.i = call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str4, i64 0, i64 0))
  call void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @_ZL3buf, i64 0, i64 0), i32 1)
  %puts = call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str5, i64 0, i64 0))
  br label %_Z6secondv.exit

; <label>:5                                       ; preds = %0
  %6 = load volatile i32* @x, align 4, !tbaa !1
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %6, i32 1)
  %8 = load volatile i32* @x, align 4, !tbaa !1
  %9 = add nsw i32 %8, 1
  store volatile i32 %9, i32* @x, align 4, !tbaa !1
  %puts.i2 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %10 = load volatile i32* @x, align 4, !tbaa !1
  %11 = icmp eq i32 %10, 17
  br i1 %11, label %12, label %15

; <label>:12                                      ; preds = %5
  %13 = call i8* @__cxa_allocate_exception(i64 4) #5
  %14 = bitcast i8* %13 to i32*
  store i32 5, i32* %14, align 4, !tbaa !1
  invoke void @__cxa_throw(i8* %13, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #6
          to label %.noexc unwind label %16

.noexc:                                           ; preds = %12
  unreachable

; <label>:15                                      ; preds = %5
  invoke void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @_ZL3buf, i64 0, i64 0), i32 -1)
          to label %_Z6secondv.exit unwind label %16

; <label>:16                                      ; preds = %15, %12
  %17 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast (i8** @_ZTIi to i8*)
  %18 = extractvalue { i8*, i32 } %17, 0
  %19 = extractvalue { i8*, i32 } %17, 1
  %20 = call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTIi to i8*)) #5
  %21 = icmp eq i32 %19, %20
  br i1 %21, label %22, label %39

; <label>:22                                      ; preds = %16
  %23 = call i8* @__cxa_begin_catch(i8* %18) #5
  %24 = load volatile i32* @x, align 4, !tbaa !1
  %25 = add nsw i32 %24, -1
  store volatile i32 %25, i32* @x, align 4, !tbaa !1
  %puts.i4 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %26 = load volatile i32* @x, align 4, !tbaa !1
  %27 = icmp eq i32 %26, 17
  br i1 %27, label %28, label %31

; <label>:28                                      ; preds = %22
  %29 = call i8* @__cxa_allocate_exception(i64 4) #5
  %30 = bitcast i8* %29 to i32*
  store i32 5, i32* %30, align 4, !tbaa !1
  invoke void @__cxa_throw(i8* %29, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #6
          to label %.noexc5 unwind label %32

.noexc5:                                          ; preds = %28
  unreachable

; <label>:31                                      ; preds = %22
  invoke void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @_ZL3buf, i64 0, i64 0), i32 -1)
          to label %_Z6secondv.exit7 unwind label %32

_Z6secondv.exit7:                                 ; preds = %31
  call void @__cxa_end_catch() #5
  br label %_Z6secondv.exit

; <label>:32                                      ; preds = %31, %28
  %33 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %34 = extractvalue { i8*, i32 } %33, 0
  %35 = extractvalue { i8*, i32 } %33, 1
  call void @__cxa_end_catch() #5
  br label %39

; <label>:36                                      ; preds = %0
  %37 = load volatile i32* @x, align 4, !tbaa !1
  %38 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %37, i32 -1)
  br label %_Z6secondv.exit

_Z6secondv.exit:                                  ; preds = %36, %_Z6secondv.exit7, %15, %2, %0
  ret i32 0

; <label>:39                                      ; preds = %32, %16
  %.01 = phi i32 [ %35, %32 ], [ %19, %16 ]
  %.0 = phi i8* [ %34, %32 ], [ %18, %16 ]
  %40 = insertvalue { i8*, i32 } undef, i8* %.0, 0
  %41 = insertvalue { i8*, i32 } %40, i32 %.01, 1
  resume { i8*, i32 } %41
}

; Function Attrs: returns_twice
declare i32 @setjmp(%struct.__jmp_buf*) #3

declare i32 @__gxx_personality_v0(...)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #5

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { nounwind }
attributes #6 = { noreturn }
attributes #7 = { returns_twice }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
