; ModuleID = 'test_longjmp_repeat.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@.str = private unnamed_addr constant [11 x i8] c"setjmp:%d\0A\00", align 1
@buf = internal global [1 x %struct.__jmp_buf] zeroinitializer, align 16
@.str1 = private unnamed_addr constant [6 x i8] c"x:%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %x = alloca i32, align 4
  store volatile i32 0, i32* %x, align 4
  %1 = call i32 @setjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @buf, i64 0, i64 0)) #4
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str, i64 0, i64 0), i32 %1) #5
  %3 = load volatile i32* %x, align 4
  %4 = add nsw i32 %3, 1
  store volatile i32 %4, i32* %x, align 4
  %5 = load volatile i32* %x, align 4
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 %5) #5
  %7 = load volatile i32* %x, align 4
  %8 = icmp slt i32 %7, 4
  br i1 %8, label %9, label %12

; <label>:9                                       ; preds = %0
  %10 = load volatile i32* %x, align 4
  %11 = shl nsw i32 %10, 1
  call void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @buf, i64 0, i64 0), i32 %11) #6
  unreachable

; <label>:12                                      ; preds = %0
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: returns_twice
declare i32 @setjmp(%struct.__jmp_buf*) #2

; Function Attrs: noreturn
declare void @longjmp(%struct.__jmp_buf*, i32) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind returns_twice }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
