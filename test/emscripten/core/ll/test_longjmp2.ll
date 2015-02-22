; ModuleID = 'test_longjmp2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.jmp_state = type { [1 x %struct.__jmp_buf]* }
%struct.__jmp_buf = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.str = private unnamed_addr constant [43 x i8] c"Entering stack_manipulate_func, level: %d\0A\00", align 1
@.str1 = private unnamed_addr constant [41 x i8] c"Setjmp normal execution path, level: %d\0A\00", align 1
@.str2 = private unnamed_addr constant [40 x i8] c"Setjmp error execution path, level: %d\0A\00", align 1
@.str3 = private unnamed_addr constant [29 x i8] c"Perform longjmp at level %d\0A\00", align 1
@.str4 = private unnamed_addr constant [42 x i8] c"Exiting stack_manipulate_func, level: %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @stack_manipulate_func(%struct.jmp_state* nocapture %s, i32 %level) #0 {
  %buf = alloca [1 x %struct.__jmp_buf], align 16
  %1 = bitcast [1 x %struct.__jmp_buf]* %buf to i8*
  call void @llvm.lifetime.start(i64 80, i8* %1) #1
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([43 x i8]* @.str, i64 0, i64 0), i32 %level) #1
  %3 = icmp eq i32 %level, 0
  br i1 %3, label %4, label %13

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  store [1 x %struct.__jmp_buf]* %buf, [1 x %struct.__jmp_buf]** %5, align 8, !tbaa !1
  %6 = getelementptr inbounds [1 x %struct.__jmp_buf]* %buf, i64 0, i64 0
  %7 = call i32 @setjmp(%struct.__jmp_buf* %6) #5
  %8 = icmp eq i32 %7, 0
  br i1 %8, label %9, label %11

; <label>:9                                       ; preds = %4
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str1, i64 0, i64 0), i32 0) #1
  call void @stack_manipulate_func(%struct.jmp_state* %s, i32 1)
  br label %18

; <label>:11                                      ; preds = %4
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([40 x i8]* @.str2, i64 0, i64 0), i32 0) #1
  br label %18

; <label>:13                                      ; preds = %0
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([29 x i8]* @.str3, i64 0, i64 0), i32 %level) #1
  %15 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  %16 = load [1 x %struct.__jmp_buf]** %15, align 8, !tbaa !1
  %17 = getelementptr inbounds [1 x %struct.__jmp_buf]* %16, i64 0, i64 0
  call void @longjmp(%struct.__jmp_buf* %17, i32 1) #6
  unreachable

; <label>:18                                      ; preds = %11, %9
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([42 x i8]* @.str4, i64 0, i64 0), i32 0) #1
  call void @llvm.lifetime.end(i64 80, i8* %1) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: returns_twice
declare i32 @setjmp(%struct.__jmp_buf*) #3

; Function Attrs: noreturn
declare void @longjmp(%struct.__jmp_buf*, i32) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %s = alloca %struct.jmp_state, align 8
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  store [1 x %struct.__jmp_buf]* null, [1 x %struct.__jmp_buf]** %1, align 8, !tbaa !1
  call void @stack_manipulate_func(%struct.jmp_state* %s, i32 0)
  ret i32 0
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind returns_twice }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"", metadata !3, i64 0}
!3 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
