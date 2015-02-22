; ModuleID = 'test_longjmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@buf = internal global [1 x %struct.__jmp_buf] zeroinitializer, align 16
@.str3 = private unnamed_addr constant [15 x i8] c"result: %d %d\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"second\00"
@str4 = private unnamed_addr constant [6 x i8] c"first\00"

; Function Attrs: noreturn nounwind uwtable
define void @second() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @buf, i64 0, i64 0), i32 -1) #6
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: noreturn
declare void @longjmp(%struct.__jmp_buf*, i32) #2

; Function Attrs: noreturn nounwind uwtable
define void @first() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str4, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @buf, i64 0, i64 0), i32 1) #6
  unreachable
}

; Function Attrs: nounwind uwtable
define i32 @main() #3 {
  %x = alloca i32, align 4
  store volatile i32 0, i32* %x, align 4
  %1 = call i32 @setjmp(%struct.__jmp_buf* getelementptr inbounds ([1 x %struct.__jmp_buf]* @buf, i64 0, i64 0)) #7
  switch i32 %1, label %13 [
    i32 0, label %2
    i32 1, label %5
    i32 -1, label %10
  ]

; <label>:2                                       ; preds = %0
  %3 = load volatile i32* %x, align 4
  %4 = add nsw i32 %3, 1
  store volatile i32 %4, i32* %x, align 4
  call void @first()
  unreachable

; <label>:5                                       ; preds = %0
  %6 = load volatile i32* %x, align 4
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %6, i32 1) #5
  %8 = load volatile i32* %x, align 4
  %9 = add nsw i32 %8, 1
  store volatile i32 %9, i32* %x, align 4
  call void @second()
  unreachable

; <label>:10                                      ; preds = %0
  %11 = load volatile i32* %x, align 4
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %11, i32 -1) #5
  br label %13

; <label>:13                                      ; preds = %10, %0
  ret i32 0
}

; Function Attrs: returns_twice
declare i32 @setjmp(%struct.__jmp_buf*) #4

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #5

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { noreturn nounwind }
attributes #7 = { nounwind returns_twice }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
