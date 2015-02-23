; ModuleID = 'test_corruption_3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [35 x i8] c"buffer[i] == (char)((i * i) % 256)\00", align 1
@.str2 = private unnamed_addr constant [20 x i8] c"test_corruption_3.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [23 x i8] c"int main(int, char **)\00", align 1
@str = private unnamed_addr constant [7 x i8] c"all ok\00"

; Function Attrs: nounwind uwtable
define void @bye() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = tail call i32 @atexit(void ()* @bye) #3
  %2 = tail call noalias i8* @malloc(i64 100) #3
  br label %3

; <label>:3                                       ; preds = %3, %0
  %indvars.iv4 = phi i64 [ 0, %0 ], [ %indvars.iv.next5, %3 ]
  %4 = trunc i64 %indvars.iv4 to i32
  %5 = mul nsw i32 %4, %4
  %6 = trunc i32 %5 to i8
  %7 = getelementptr inbounds i8* %2, i64 %indvars.iv4
  store i8 %6, i8* %7, align 1, !tbaa !1
  %indvars.iv.next5 = add nuw nsw i64 %indvars.iv4, 1
  %exitcond = icmp eq i64 %indvars.iv.next5, 100
  br i1 %exitcond, label %8, label %3

; <label>:8                                       ; preds = %3
  %9 = add nsw i32 %argc, 50
  %10 = sext i32 %9 to i64
  %11 = tail call i8* @realloc(i8* %2, i64 %10) #3
  %12 = icmp sgt i32 %9, 0
  br i1 %12, label %.lr.ph, label %._crit_edge

; <label>:13                                      ; preds = %.lr.ph
  %14 = trunc i64 %indvars.iv.next to i32
  %15 = icmp slt i32 %14, %9
  br i1 %15, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %13, %8
  %indvars.iv = phi i64 [ %indvars.iv.next, %13 ], [ 0, %8 ]
  %16 = getelementptr inbounds i8* %11, i64 %indvars.iv
  %17 = load i8* %16, align 1, !tbaa !1
  %18 = sext i8 %17 to i32
  %19 = trunc i64 %indvars.iv to i32
  %20 = shl i32 %19, 24
  %sext = mul i32 %20, %19
  %21 = ashr exact i32 %sext, 24
  %22 = icmp eq i32 %18, %21
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  br i1 %22, label %13, label %23

; <label>:23                                      ; preds = %.lr.ph
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([20 x i8]* @.str2, i64 0, i64 0), i32 16, i8* getelementptr inbounds ([23 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #4
  unreachable

._crit_edge:                                      ; preds = %13, %8
  ret i32 1
}

; Function Attrs: nounwind
declare i32 @atexit(void ()*) #1

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #1

; Function Attrs: nounwind
declare noalias i8* @realloc(i8* nocapture, i64) #1

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"omnipotent char", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
