; ModuleID = 'test_longjmp4.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.jmp_state = type { [1 x %struct.__jmp_buf]* }
%struct.__jmp_buf = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.str1 = private unnamed_addr constant [48 x i8] c"Exception execution path of first function! %d\0A\00", align 1
@str = private unnamed_addr constant [33 x i8] c"Calling longjmp the second time!\00"
@str3 = private unnamed_addr constant [41 x i8] c"Normal execution path of first function!\00"

; Function Attrs: nounwind uwtable
define void @first_func(%struct.jmp_state* nocapture %s) #0 {
  %c_jmp = alloca [1 x %struct.__jmp_buf], align 16
  %once = alloca i32, align 4
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  %2 = bitcast [1 x %struct.__jmp_buf]* %c_jmp to i8*
  call void @llvm.lifetime.start(i64 80, i8* %2) #1
  store volatile i32 0, i32* %once, align 4
  %3 = getelementptr inbounds [1 x %struct.__jmp_buf]* %c_jmp, i64 0, i64 0
  %4 = call i32 @setjmp(%struct.__jmp_buf* %3) #6
  %5 = icmp eq i32 %4, 0
  br i1 %5, label %6, label %7

; <label>:6                                       ; preds = %0
  %puts1 = call i32 @puts(i8* getelementptr inbounds ([41 x i8]* @str3, i64 0, i64 0))
  store [1 x %struct.__jmp_buf]* %c_jmp, [1 x %struct.__jmp_buf]** %1, align 8, !tbaa !1
  call void @second_func(%struct.jmp_state* %s)
  unreachable

; <label>:7                                       ; preds = %0
  %8 = load volatile i32* %once, align 4
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([48 x i8]* @.str1, i64 0, i64 0), i32 %8) #1
  %10 = load volatile i32* %once, align 4
  %11 = icmp eq i32 %10, 0
  br i1 %11, label %12, label %15

; <label>:12                                      ; preds = %7
  %puts = call i32 @puts(i8* getelementptr inbounds ([33 x i8]* @str, i64 0, i64 0))
  store volatile i32 1, i32* %once, align 4
  %13 = load [1 x %struct.__jmp_buf]** %1, align 8, !tbaa !1
  %14 = getelementptr inbounds [1 x %struct.__jmp_buf]* %13, i64 0, i64 0
  call void @longjmp(%struct.__jmp_buf* %14, i32 1) #7
  unreachable

; <label>:15                                      ; preds = %7
  call void @llvm.lifetime.end(i64 80, i8* %2) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: returns_twice
declare i32 @setjmp(%struct.__jmp_buf*) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: noreturn nounwind uwtable
define void @second_func(%struct.jmp_state* nocapture readonly %s) #4 {
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  %2 = load [1 x %struct.__jmp_buf]** %1, align 8, !tbaa !1
  %3 = getelementptr inbounds [1 x %struct.__jmp_buf]* %2, i64 0, i64 0
  tail call void @longjmp(%struct.__jmp_buf* %3, i32 1) #7
  unreachable
}

; Function Attrs: noreturn
declare void @longjmp(%struct.__jmp_buf*, i32) #5

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %s = alloca %struct.jmp_state, align 8
  %1 = getelementptr inbounds %struct.jmp_state* %s, i64 0, i32 0
  store [1 x %struct.__jmp_buf]* null, [1 x %struct.__jmp_buf]** %1, align 8, !tbaa !1
  call void @first_func(%struct.jmp_state* %s)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nounwind returns_twice }
attributes #7 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"", metadata !3, i64 0}
!3 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
