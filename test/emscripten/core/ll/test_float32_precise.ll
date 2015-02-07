; ModuleID = 'test_float32_precise.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [15 x i8] c"\0A%.20f, %.20f\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = icmp sgt i32 %argc, 10
  %2 = srem i32 %argc, 19
  %3 = icmp eq i32 %2, 15
  %or.cond2 = or i1 %1, %3
  br i1 %or.cond2, label %.critedge, label %._crit_edge

.critedge:                                        ; preds = %.critedge, %0
  %y.05 = phi float [ %6, %.critedge ], [ 0x4014D17860000000, %0 ]
  %x.04 = phi float [ %4, %.critedge ], [ 0x3FF3C0CA40000000, %0 ]
  %.03 = phi i32 [ %7, %.critedge ], [ %argc, %0 ]
  %4 = fdiv float %x.04, %y.05
  %5 = fmul float %y.05, 2.000000e+00
  %6 = fadd float %5, -1.000000e+00
  %7 = add nsw i32 %.03, -1
  %8 = icmp sgt i32 %7, 10
  %9 = srem i32 %7, 19
  %10 = icmp eq i32 %9, 15
  %or.cond = or i1 %8, %10
  br i1 %or.cond, label %.critedge, label %._crit_edge

._crit_edge:                                      ; preds = %.critedge, %0
  %y.0.lcssa = phi float [ 0x4014D17860000000, %0 ], [ %6, %.critedge ]
  %x.0.lcssa = phi float [ 0x3FF3C0CA40000000, %0 ], [ %4, %.critedge ]
  %11 = fsub float %x.0.lcssa, %y.0.lcssa
  %12 = fmul float %y.0.lcssa, 3.000000e+00
  %13 = fmul float %11, 5.000000e-01
  %14 = fsub float %12, %13
  %15 = fmul float %11, %14
  %16 = fpext float %14 to double
  %17 = fadd double %16, 0x3DE0EC0280B9C936
  %18 = fptrunc double %17 to float
  %19 = fpext float %18 to double
  %20 = fdiv double %19, 7.654000e+00
  %21 = fpext float %15 to double
  %22 = fsub double %21, %20
  %23 = fptrunc double %22 to float
  %24 = fpext float %23 to double
  %25 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0), double %24, double %19)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
