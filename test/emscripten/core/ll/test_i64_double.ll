; ModuleID = 'test_i64_double.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [15 x i8] c"*%d,%d,%d,%d*\0A\00", align 1

; Function Attrs: nounwind readnone uwtable
define zeroext i1 @_Z19JSDOUBLE_IS_NEGZEROd(double %d) #0 {
  %1 = fcmp une double %d, 0.000000e+00
  br i1 %1, label %5, label %2

; <label>:2                                       ; preds = %0
  %3 = bitcast double %d to i64
  %4 = icmp slt i64 %3, 0
  br label %5

; <label>:5                                       ; preds = %2, %0
  %.0 = phi i1 [ %4, %2 ], [ false, %0 ]
  ret i1 %.0
}

; Function Attrs: nounwind readnone uwtable
define zeroext i1 @_Z18JSINT64_IS_NEGZEROx(i64 %l) #0 {
  %1 = icmp eq i64 %l, 0
  ret i1 %1
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #1 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0), i32 0, i32 0, i32 0, i32 0)
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0), i32 1, i32 1, i32 0, i32 0)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
