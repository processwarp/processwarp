; ModuleID = 'closebitcasts.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [5 x i8] c"!%d\0A\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"%d,%d!\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = srem i32 %argc, 17
  %2 = sitofp i32 %1 to float
  %3 = add nsw i32 %argc, 1
  %4 = add nsw i32 %argc, 2
  %5 = add nsw i32 %argc, 3
  %6 = add nsw i32 %argc, 4
  %7 = mul nsw i32 %argc, 5
  %8 = mul i32 %7, %4
  %9 = mul i32 %8, %3
  %10 = mul i32 %9, %5
  %11 = mul i32 %10, %6
  %12 = sitofp i32 %11 to float
  %13 = fmul float %12, 0x41D0000000000000
  %14 = fmul float %13, -1.300000e+01
  %15 = icmp eq i32 %argc, 17
  br i1 %15, label %16, label %19

; <label>:16                                      ; preds = %0
  %17 = fadd float %2, 1.000000e+00
  %18 = fadd float %14, -1.000000e+00
  br label %19

; <label>:19                                      ; preds = %16, %0
  %y.sroa.0.0.in = phi float [ %18, %16 ], [ %14, %0 ]
  %x.sroa.0.0.in = phi float [ %17, %16 ], [ %2, %0 ]
  %x.sroa.0.0 = bitcast float %x.sroa.0.0.in to i32
  %y.sroa.0.0 = bitcast float %y.sroa.0.0.in to i32
  %20 = sub nsw i32 %x.sroa.0.0, %y.sroa.0.0
  br label %21

; <label>:21                                      ; preds = %21, %19
  %z.0 = phi i32 [ %20, %19 ], [ %24, %21 ]
  %22 = srem i32 %z.0, 15
  %23 = icmp eq i32 %22, 0
  %24 = add nsw i32 %z.0, 1
  br i1 %23, label %25, label %21

; <label>:25                                      ; preds = %21
  %26 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([5 x i8]* @.str, i64 0, i64 0), i32 %z.0)
  %27 = fpext float %x.sroa.0.0.in to double
  %28 = fpext float %y.sroa.0.0.in to double
  %29 = fmul double %28, %28
  %30 = fmul double %29, %29
  %31 = bitcast double %27 to i64
  %32 = trunc i64 %31 to i32
  %33 = bitcast double %30 to i64
  %34 = trunc i64 %33 to i32
  %35 = sub nsw i32 %32, %34
  %36 = lshr i64 %31, 32
  %37 = trunc i64 %36 to i32
  %38 = lshr i64 %33, 32
  %39 = trunc i64 %38 to i32
  %40 = sub nsw i32 %37, %39
  %41 = srem i32 %35, 15
  %42 = icmp eq i32 %41, 0
  br i1 %42, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %25
  %h.02 = phi i32 [ %44, %.lr.ph ], [ %40, %25 ]
  %l.01 = phi i32 [ %43, %.lr.ph ], [ %35, %25 ]
  %43 = add nsw i32 %l.01, 1
  %44 = add nsw i32 %h.02, 3
  %45 = srem i32 %43, 15
  %46 = icmp eq i32 %45, 0
  br i1 %46, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %25
  %h.0.lcssa = phi i32 [ %40, %25 ], [ %44, %.lr.ph ]
  %l.0.lcssa = phi i32 [ %35, %25 ], [ %43, %.lr.ph ]
  %47 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i32 %l.0.lcssa, i32 %h.0.lcssa)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
