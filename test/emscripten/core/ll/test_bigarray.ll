; ModuleID = 'test_bigarray.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Struct = type { i8, i32 }

@buffy = global [102400 x %struct.Struct] zeroinitializer, align 16
@.str = private unnamed_addr constant [35 x i8] c"buffy[i].x == 0 && buffy[i].y == 0\00", align 1
@.str1 = private unnamed_addr constant [22 x i8] c"tmp/test_bigarray.cpp\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"*%d*\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  br label %4

; <label>:1                                       ; preds = %8
  %2 = trunc i64 %indvars.iv.next5 to i32
  %3 = icmp slt i32 %2, 102400
  br i1 %3, label %4, label %.preheader

; <label>:4                                       ; preds = %1, %0
  %indvars.iv4 = phi i64 [ 0, %0 ], [ %indvars.iv.next5, %1 ]
  %5 = getelementptr inbounds [102400 x %struct.Struct]* @buffy, i64 0, i64 %indvars.iv4, i32 0
  %6 = load i8* %5, align 8, !tbaa !1
  %7 = icmp eq i8 %6, 0
  br i1 %7, label %8, label %12

; <label>:8                                       ; preds = %4
  %9 = getelementptr inbounds [102400 x %struct.Struct]* @buffy, i64 0, i64 %indvars.iv4, i32 1
  %10 = load i32* %9, align 4, !tbaa !6
  %11 = icmp eq i32 %10, 0
  %indvars.iv.next5 = add nuw nsw i64 %indvars.iv4, 1
  br i1 %11, label %1, label %12

; <label>:12                                      ; preds = %8, %4
  tail call void @__assert_fail(i8* getelementptr inbounds ([35 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([22 x i8]* @.str1, i64 0, i64 0), i32 14, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #3
  unreachable

.preheader:                                       ; preds = %.preheader, %1
  %indvars.iv = phi i64 [ %indvars.iv.next, %.preheader ], [ 0, %1 ]
  %13 = trunc i64 %indvars.iv to i32
  %14 = mul nsw i32 %13, %13
  %15 = trunc i32 %14 to i8
  %16 = getelementptr inbounds [102400 x %struct.Struct]* @buffy, i64 0, i64 %indvars.iv, i32 0
  store i8 %15, i8* %16, align 8, !tbaa !1
  %17 = mul nsw i32 %14, %13
  %18 = getelementptr inbounds [102400 x %struct.Struct]* @buffy, i64 0, i64 %indvars.iv, i32 1
  store i32 %17, i32* %18, align 4, !tbaa !6
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 102400
  br i1 %exitcond, label %19, label %.preheader

; <label>:19                                      ; preds = %.preheader
  %20 = load i8* getelementptr inbounds ([102400 x %struct.Struct]* @buffy, i64 0, i64 34133, i32 0), align 8, !tbaa !1
  %21 = sext i8 %20 to i32
  %22 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i32 %21)
  ret i32 0
}

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS6Struct", metadata !3, i64 0, metadata !5, i64 4}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !"int", metadata !3, i64 0}
!6 = metadata !{metadata !2, metadata !5, i64 4}
