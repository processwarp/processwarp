; ModuleID = 'test_i64_umul.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [18 x i8] c"testu64a is %llu\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %testu32a = alloca i32, align 4
  %testu64a = alloca i64, align 8
  store volatile i32 -1919243264, i32* %testu32a, align 4
  store volatile i64 -3700493244756848616, i64* %testu64a, align 8
  %1 = load volatile i32* %testu32a, align 4
  %2 = zext i32 %1 to i64
  %3 = mul i64 %2, 4294967295
  %4 = load volatile i64* %testu64a, align 8
  %5 = icmp ult i64 %3, %4
  br i1 %5, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %6 = load volatile i64* %testu64a, align 8
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([18 x i8]* @.str, i64 0, i64 0), i64 %6) #2
  %8 = load volatile i64* %testu64a, align 8
  %9 = lshr i64 %8, 1
  store volatile i64 %9, i64* %testu64a, align 8
  %10 = load volatile i32* %testu32a, align 4
  %11 = zext i32 %10 to i64
  %12 = mul i64 %11, 4294967295
  %13 = load volatile i64* %testu64a, align 8
  %14 = icmp ult i64 %12, %13
  br i1 %14, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %0
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
