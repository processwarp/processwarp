; ModuleID = 'test_class.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Random = type { i32 }

@rng1 = global %struct.Random { i32 42 }, align 4
@.str = private unnamed_addr constant [8 x i8] c"%f, %f\0A\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"*%d*\0A\00", align 1
@llvm.global_ctors = appending global [0 x { i32, void ()*, i8* }] zeroinitializer

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %1

; <label>:1                                       ; preds = %1, %0
  %count.02 = phi i32 [ 0, %0 ], [ %count.1, %1 ]
  %i.01 = phi i32 [ 0, %0 ], [ %19, %1 ]
  %2 = phi i32 [ 42, %0 ], [ %11, %1 ]
  %3 = load i32* getelementptr inbounds (%struct.Random* @rng1, i64 0, i32 0), align 4, !tbaa !1
  %4 = mul i32 %3, 3877
  %5 = add i32 %4, 29573
  %6 = urem i32 %5, 139968
  store i32 %6, i32* getelementptr inbounds (%struct.Random* @rng1, i64 0, i32 0), align 4, !tbaa !1
  %7 = uitofp i32 %6 to float
  %8 = fdiv float %7, 1.399680e+05
  %9 = mul i32 %2, 3877
  %10 = add i32 %9, 29573
  %11 = urem i32 %10, 139968
  %12 = uitofp i32 %11 to float
  %13 = fdiv float %12, 1.399680e+05
  %14 = fpext float %8 to double
  %15 = fpext float %13 to double
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), double %14, double %15) #2
  %17 = fcmp une float %8, %13
  %18 = zext i1 %17 to i32
  %count.1 = add nsw i32 %18, %count.02
  %19 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %19, 100
  br i1 %exitcond, label %20, label %1

; <label>:20                                      ; preds = %1
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i32 %count.1) #2
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS6Random", metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
