; ModuleID = 'test_printf_more.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [12 x i8] c"%s %d %.2f\0A\00", align 1
@.str1 = private unnamed_addr constant [14 x i8] c"me and myself\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c"%d : %s\0A\00", align 1
@.str3 = private unnamed_addr constant [12 x i8] c"%d waka %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %buff = alloca i8*, align 8
  %1 = call i32 (i8*, i64, i8*, ...)* @snprintf(i8* null, i64 0, i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 25, double 1.345000e+00) #2
  %2 = zext i32 %1 to i64
  %3 = alloca i8, i64 %2, align 16
  %4 = sext i32 %1 to i64
  %5 = call i32 (i8*, i64, i8*, ...)* @snprintf(i8* %3, i64 %4, i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i8* getelementptr inbounds ([14 x i8]* @.str1, i64 0, i64 0), i32 25, double 1.345000e+00) #2
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i64 0, i64 0), i32 %1, i8* %3)
  store i8* null, i8** %buff, align 8, !tbaa !1
  %7 = call i32 (i8**, i8*, ...)* @asprintf(i8** %buff, i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i32 21, i32 95) #2
  %8 = load i8** %buff, align 8, !tbaa !1
  %9 = call i32 @puts(i8* %8)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @snprintf(i8* nocapture, i64, i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind
declare i32 @asprintf(i8**, i8*, ...) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
