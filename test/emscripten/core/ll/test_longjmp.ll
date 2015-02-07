; ModuleID = 'test_longjmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf_tag = type { [8 x i64], i32, %struct.__sigset_t }
%struct.__sigset_t = type { [16 x i64] }

@_ZL3buf = internal global [1 x %struct.__jmp_buf_tag] zeroinitializer, align 16
@.str3 = private unnamed_addr constant [15 x i8] c"result: %d %d\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"second\00"
@str4 = private unnamed_addr constant [6 x i8] c"first\00"

; Function Attrs: noreturn nounwind uwtable
define void @_Z6secondv() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 -1) #5
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: noreturn nounwind
declare void @longjmp(%struct.__jmp_buf_tag*, i32) #2

; Function Attrs: noreturn nounwind uwtable
define void @_Z5firstv() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str4, i64 0, i64 0))
  tail call void @longjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0), i32 1) #5
  unreachable
}

; Function Attrs: nounwind uwtable
define i32 @main() #3 {
  %x = alloca i32, align 4
  store volatile i32 0, i32* %x, align 4
  %1 = tail call i32 @_setjmp(%struct.__jmp_buf_tag* getelementptr inbounds ([1 x %struct.__jmp_buf_tag]* @_ZL3buf, i64 0, i64 0)) #4
  switch i32 %1, label %13 [
    i32 0, label %2
    i32 1, label %5
    i32 -1, label %10
  ]

; <label>:2                                       ; preds = %0
  %3 = load volatile i32* %x, align 4
  %4 = add nsw i32 %3, 1
  store volatile i32 %4, i32* %x, align 4
  tail call void @_Z5firstv()
  unreachable

; <label>:5                                       ; preds = %0
  %6 = load volatile i32* %x, align 4
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %6, i32 1)
  %8 = load volatile i32* %x, align 4
  %9 = add nsw i32 %8, 1
  store volatile i32 %9, i32* %x, align 4
  tail call void @_Z6secondv()
  unreachable

; <label>:10                                      ; preds = %0
  %11 = load volatile i32* %x, align 4
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str3, i64 0, i64 0), i32 %11, i32 -1)
  br label %13

; <label>:13                                      ; preds = %10, %0
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @_setjmp(%struct.__jmp_buf_tag*) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { noreturn nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
