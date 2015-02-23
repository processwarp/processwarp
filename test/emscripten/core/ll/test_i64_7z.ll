; ModuleID = 'test_i64_7z.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@a = common global i64 0, align 8
@b = common global i64 0, align 8
@.str = private unnamed_addr constant [7 x i8] c"%d,%d\0A\00", align 1
@.str1 = private unnamed_addr constant [15 x i8] c"one %lld, %lld\00", align 1
@.str2 = private unnamed_addr constant [16 x i8] c"zero %lld, %lld\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readonly %argv) #0 {
  %1 = sext i32 %argc to i64
  store i64 %1, i64* @a, align 8, !tbaa !1
  %2 = getelementptr inbounds i8** %argv, i64 1
  %3 = load i8** %2, align 8, !tbaa !5
  %4 = load i8* %3, align 1, !tbaa !7
  %5 = sext i8 %4 to i64
  store i64 %5, i64* @b, align 8, !tbaa !1
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i64 %1, i64 %5) #3
  %7 = load i64* @a, align 8, !tbaa !1
  %8 = load i64* @b, align 8, !tbaa !1
  %uadd = tail call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %7, i64 %8)
  %9 = extractvalue { i64, i1 } %uadd, 1
  br i1 %9, label %14, label %10

; <label>:10                                      ; preds = %0
  %11 = extractvalue { i64, i1 } %uadd, 0
  %12 = add i64 %11, 1
  %13 = icmp ugt i64 %7, %12
  br i1 %13, label %14, label %16

; <label>:14                                      ; preds = %10, %0
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str1, i64 0, i64 0), i64 %7, i64 %8) #3
  br label %18

; <label>:16                                      ; preds = %10
  %17 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str2, i64 0, i64 0), i64 %7, i64 %8) #3
  br label %18

; <label>:18                                      ; preds = %16, %14
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind readnone
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #2

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readnone }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"long", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!7 = metadata !{metadata !3, metadata !3, i64 0}
