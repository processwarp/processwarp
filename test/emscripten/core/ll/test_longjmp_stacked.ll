; ModuleID = 'test_longjmp_stacked.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__jmp_buf = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64 }

@top = common global i32 0, align 4
@.str = private unnamed_addr constant [14 x i8] c"setjmp of %d\0A\00", align 1
@bottom = common global i32 0, align 4
@.str3 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@str = private unnamed_addr constant [5 x i8] c"back\00"
@str4 = private unnamed_addr constant [6 x i8] c"going\00"

; Function Attrs: nounwind uwtable
define i32 @run(i32 %y) #0 {
  %x = alloca i32, align 4
  %buf = alloca [1 x %struct.__jmp_buf], align 16
  %1 = alloca [100 x i8], align 1
  %.sub = getelementptr inbounds [100 x i8]* %1, i64 0, i64 0
  call void @llvm.memset.p0i8.i64(i8* %.sub, i8 1, i64 100, i32 1, i1 false)
  %2 = trunc i32 %y to i8
  %3 = sext i32 %y to i64
  %4 = getelementptr inbounds [100 x i8]* %1, i64 0, i64 %3
  store i8 %2, i8* %4, align 1, !tbaa !1
  %5 = shl nsw i32 %y, 1
  %6 = trunc i32 %5 to i8
  %7 = sdiv i32 %y, 2
  %8 = sext i32 %7 to i64
  %9 = getelementptr inbounds [100 x i8]* %1, i64 0, i64 %8
  store i8 %6, i8* %9, align 1, !tbaa !1
  %10 = load i8* %4, align 1, !tbaa !1
  %11 = sext i8 %10 to i32
  store volatile i32 %11, i32* %x, align 4
  %12 = alloca [4 x i8], align 1
  %13 = ptrtoint [4 x i8]* %12 to i64
  %14 = trunc i64 %13 to i32
  store i32 %14, i32* @top, align 4, !tbaa !4
  %15 = load volatile i32* %x, align 4
  %16 = icmp slt i32 %15, 3
  br i1 %16, label %17, label %19

; <label>:17                                      ; preds = %0
  %18 = load volatile i32* %x, align 4
  br label %35

; <label>:19                                      ; preds = %0
  %20 = bitcast [1 x %struct.__jmp_buf]* %buf to i8*
  call void @llvm.lifetime.start(i64 80, i8* %20) #1
  %21 = load volatile i32* %x, align 4
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i32 %21) #1
  %23 = getelementptr inbounds [1 x %struct.__jmp_buf]* %buf, i64 0, i64 0
  %24 = call i32 @setjmp(%struct.__jmp_buf* %23) #5
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %32

; <label>:26                                      ; preds = %19
  %puts2 = call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str4, i64 0, i64 0))
  %27 = load volatile i32* %x, align 4
  %28 = sdiv i32 %27, 2
  %29 = call i32 @run(i32 %28)
  %30 = load volatile i32* %x, align 4
  %31 = add nsw i32 %30, %29
  store volatile i32 %31, i32* %x, align 4
  call void @longjmp(%struct.__jmp_buf* %23, i32 1) #6
  unreachable

; <label>:32                                      ; preds = %19
  %puts = call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @str, i64 0, i64 0))
  %33 = load volatile i32* %x, align 4
  %34 = sdiv i32 %33, 2
  call void @llvm.lifetime.end(i64 80, i8* %20) #1
  br label %35

; <label>:35                                      ; preds = %32, %17
  %.0 = phi i32 [ %18, %17 ], [ %34, %32 ]
  ret i32 %.0
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: returns_twice
declare i32 @setjmp(%struct.__jmp_buf*) #3

; Function Attrs: noreturn
declare void @longjmp(%struct.__jmp_buf*, i32) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = shl nsw i32 %argc, 1
  %2 = icmp sgt i32 %argc, 0
  br i1 %2, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %21, %0
  %i.02 = phi i32 [ %22, %21 ], [ 0, %0 ]
  %sum.01 = phi i32 [ %7, %21 ], [ 0, %0 ]
  %3 = alloca [4 x i8], align 1
  %4 = ptrtoint [4 x i8]* %3 to i64
  %5 = trunc i64 %4 to i32
  store i32 %5, i32* @bottom, align 4, !tbaa !4
  %6 = call i32 @run(i32 10)
  %7 = add nsw i32 %6, %sum.01
  %8 = load i32* @bottom, align 4, !tbaa !4
  %9 = load i32* @top, align 4, !tbaa !4
  %10 = icmp slt i32 %8, %9
  br i1 %10, label %11, label %16

; <label>:11                                      ; preds = %.lr.ph
  %12 = sext i32 %8 to i64
  %13 = inttoptr i64 %12 to i8*
  %14 = sub nsw i32 %9, %8
  %15 = sext i32 %14 to i64
  call void @llvm.memset.p0i8.i64(i8* %13, i8 1, i64 %15, i32 1, i1 false)
  br label %21

; <label>:16                                      ; preds = %.lr.ph
  %17 = sext i32 %9 to i64
  %18 = inttoptr i64 %17 to i8*
  %19 = sub nsw i32 %8, %9
  %20 = sext i32 %19 to i64
  call void @llvm.memset.p0i8.i64(i8* %18, i8 1, i64 %20, i32 1, i1 false)
  br label %21

; <label>:21                                      ; preds = %16, %11
  %22 = add nsw i32 %i.02, 1
  %23 = icmp slt i32 %22, %1
  br i1 %23, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %21, %0
  %sum.0.lcssa = phi i32 [ 0, %0 ], [ %7, %21 ]
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str3, i64 0, i64 0), i32 %sum.0.lcssa) #1
  ret i32 %sum.0.lcssa
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { returns_twice "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind returns_twice }
attributes #6 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
!4 = metadata !{metadata !5, metadata !5, i64 0}
!5 = metadata !{metadata !"int", metadata !2, i64 0}
