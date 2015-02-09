; ModuleID = 'test_longjmp3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.jmp_state = type { [1 x %struct.__jmp_buf_tag]* }
%struct.__jmp_buf_tag = type { [8 x i64], i32, %struct.__sigset_t }
%struct.__sigset_t = type { [16 x i64] }

@.str1 = private unnamed_addr constant [41 x i8] c"setjmp normal execution path, level: %d\0A\00", align 1
@.str2 = private unnamed_addr constant [44 x i8] c"setjmp exception execution path, level: %d\0A\00", align 1
@.str4 = private unnamed_addr constant [36 x i8] c"Exiting setjmp function, level: %d\0A\00", align 1
@str = private unnamed_addr constant [46 x i8] c"prev_jmp is not empty, continue with longjmp!\00"
@str5 = private unnamed_addr constant [29 x i8] c"level is 2, perform longjmp!\00"

; Function Attrs: nounwind uwtable
define void @_Z11setjmp_funcP9jmp_statei(%struct.jmp_state* nocapture %s, i32 %level) #0 {
  %c_jmp = alloca [1 x %struct.__jmp_buf_tag], align 16
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  %2 = load [1 x %struct.__jmp_buf_tag]** %1, align 8, !tbaa !1
  %3 = bitcast [1 x %struct.__jmp_buf_tag]* %c_jmp to i8*
  call void @llvm.lifetime.start(i64 200, i8* %3) #1
  %4 = icmp eq i32 %level, 2
  br i1 %4, label %5, label %8

; <label>:5                                       ; preds = %0
  %puts1 = call i32 @puts(i8* getelementptr inbounds ([29 x i8]* @str5, i64 0, i64 0))
  %6 = load [1 x %struct.__jmp_buf_tag]** %1, align 8, !tbaa !1
  %7 = getelementptr inbounds [1 x %struct.__jmp_buf_tag]* %6, i64 0, i64 0
  call void @longjmp(%struct.__jmp_buf_tag* %7, i32 1) #5
  unreachable

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds [1 x %struct.__jmp_buf_tag]* %c_jmp, i64 0, i64 0
  %10 = call i32 @_setjmp(%struct.__jmp_buf_tag* %9) #6
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %15

; <label>:12                                      ; preds = %8
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([41 x i8]* @.str1, i64 0, i64 0), i32 %level) #1
  store [1 x %struct.__jmp_buf_tag]* %c_jmp, [1 x %struct.__jmp_buf_tag]** %1, align 8, !tbaa !1
  %14 = add nsw i32 %level, 1
  call void @_Z11setjmp_funcP9jmp_statei(%struct.jmp_state* %s, i32 %14)
  br label %20

; <label>:15                                      ; preds = %8
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([44 x i8]* @.str2, i64 0, i64 0), i32 %level) #1
  %17 = icmp eq [1 x %struct.__jmp_buf_tag]* %2, null
  br i1 %17, label %20, label %18

; <label>:18                                      ; preds = %15
  %puts = call i32 @puts(i8* getelementptr inbounds ([46 x i8]* @str, i64 0, i64 0))
  store [1 x %struct.__jmp_buf_tag]* %2, [1 x %struct.__jmp_buf_tag]** %1, align 8, !tbaa !1
  %19 = getelementptr inbounds [1 x %struct.__jmp_buf_tag]* %2, i64 0, i64 0
  call void @longjmp(%struct.__jmp_buf_tag* %19, i32 1) #5
  unreachable

; <label>:20                                      ; preds = %15, %12
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([36 x i8]* @.str4, i64 0, i64 0), i32 %level) #1
  call void @llvm.lifetime.end(i64 200, i8* %3) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: noreturn nounwind
declare void @longjmp(%struct.__jmp_buf_tag*, i32) #3

; Function Attrs: nounwind returns_twice
declare i32 @_setjmp(%struct.__jmp_buf_tag*) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %s = alloca %struct.jmp_state, align 8
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  store [1 x %struct.__jmp_buf_tag]* null, [1 x %struct.__jmp_buf_tag]** %1, align 8, !tbaa !1
  call void @_Z11setjmp_funcP9jmp_statei(%struct.jmp_state* %s, i32 0)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn nounwind }
attributes #6 = { nounwind returns_twice }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS9jmp_state", metadata !3, i64 0}
!3 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
