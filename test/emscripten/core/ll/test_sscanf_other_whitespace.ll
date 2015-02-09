; ModuleID = 'test_sscanf_other_whitespace.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"\092\093\09\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"\09\095\09\097\09\09\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"\0A11\0A13\0A\00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"\0A\0A17\0A\0A19\0A\0A\00", align 1
@.str4 = private unnamed_addr constant [8 x i8] c"\0B23\0B29\0B\00", align 1
@.str5 = private unnamed_addr constant [11 x i8] c"\0B\0B31\0B\0B37\0B\0B\00", align 1
@.str6 = private unnamed_addr constant [8 x i8] c"\0C41\0C43\0C\00", align 1
@.str7 = private unnamed_addr constant [11 x i8] c"\0C\0C47\0C\0C53\0C\0C\00", align 1
@.str8 = private unnamed_addr constant [8 x i8] c"\0D59\0D61\0D\00", align 1
@.str9 = private unnamed_addr constant [11 x i8] c"\0D\0D67\0D\0D71\0D\0D\00", align 1
@_ZZ4mainE6buffer = private unnamed_addr constant [10 x i8*] [i8* getelementptr inbounds ([6 x i8]* @.str, i32 0, i32 0), i8* getelementptr inbounds ([9 x i8]* @.str1, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8]* @.str3, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str4, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8]* @.str5, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str6, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8]* @.str7, i32 0, i32 0), i8* getelementptr inbounds ([8 x i8]* @.str8, i32 0, i32 0), i8* getelementptr inbounds ([11 x i8]* @.str9, i32 0, i32 0)], align 16
@.str10 = private unnamed_addr constant [8 x i8] c" %d %d \00", align 1
@.str11 = private unnamed_addr constant [9 x i8] c"%d, %d, \00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  br label %1

; <label>:1                                       ; preds = %1, %0
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %1 ]
  store i32 0, i32* %x, align 4, !tbaa !1
  store i32 0, i32* %y, align 4, !tbaa !1
  %2 = getelementptr inbounds [10 x i8*]* @_ZZ4mainE6buffer, i64 0, i64 %indvars.iv
  %3 = load i8** %2, align 8, !tbaa !5
  %4 = call i32 (i8*, i8*, ...)* @sscanf(i8* %3, i8* getelementptr inbounds ([8 x i8]* @.str10, i64 0, i64 0), i32* %x, i32* %y) #2
  %5 = load i32* %x, align 4, !tbaa !1
  %6 = load i32* %y, align 4, !tbaa !1
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str11, i64 0, i64 0), i32 %5, i32 %6) #2
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1
  %exitcond = icmp eq i64 %indvars.iv.next, 10
  br i1 %exitcond, label %8, label %1

; <label>:8                                       ; preds = %1
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @sscanf(i8* nocapture readonly, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"any pointer", metadata !3, i64 0}
