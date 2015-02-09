; ModuleID = 'test_longjmp_funcptr.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf_tag = type { [8 x i64], i32, %struct.__sigset_t }
%struct.__sigset_t = type { [16 x i64] }

@fp = global void ()* null, align 8
@_ZL3buf = internal global [1 x %struct.__jmp_buf_tag] zeroinitializer, align 16
@.str2 = private unnamed_addr constant [10 x i8] c"main: %d\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"second\00"
@str3 = private unnamed_addr constant [6 x i8] c"first\00"

; Function Attrs: noreturn nounwind uwtable
define void @_Z6secondv() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 1) #6
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: noreturn nounwind
declare void @longjmp(%struct.__jmp_buf_tag*, i32) #2

; Function Attrs: nounwind uwtable
define void @_Z5firstv() #3 {
  %1 = load void ()** @fp, align 8, !tbaa !1
  tail call void %1() #5
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str3, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #3 {
  %x = alloca i32, align 4
  %1 = icmp eq i32 %argc, 200
  %2 = select i1 %1, void ()* null, void ()* @_Z6secondv
  store void ()* %2, void ()** @fp, align 8, !tbaa !1
  store volatile i32 0, i32* %x, align 4
  %3 = call i32 @_setjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0)) #7
  %4 = icmp eq i32 %3, 0
  %5 = load volatile i32* %x, align 4
  br i1 %4, label %6, label %9

; <label>:6                                       ; preds = %0
  %7 = add nsw i32 %5, 1
  store volatile i32 %7, i32* %x, align 4
  %8 = load void ()** @fp, align 8, !tbaa !1
  call void %8() #5
  %puts.i = call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str3, i64 0, i64 0)) #5
  br label %11

; <label>:9                                       ; preds = %0
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i32 %5) #5
  br label %11

; <label>:11                                      ; preds = %9, %6
  ret i32 0
}

; Function Attrs: nounwind returns_twice
declare i32 @_setjmp(%struct.__jmp_buf_tag*) #4

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #5

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind returns_twice }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
