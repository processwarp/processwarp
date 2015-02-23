; ModuleID = 'test_funcptr.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@globally1 = global i32 (...)* bitcast (i32 ()* @calc1 to i32 (...)*), align 8
@globally2 = global i32 (...)* bitcast (i32 ()* @calc2 to i32 (...)*), align 8
@.str = private unnamed_addr constant [21 x i8] c"*%d,%d,%d,%d,%d,%d*\0A\00", align 1
@.str1 = private unnamed_addr constant [7 x i8] c"*%d,%d\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c",%d,%d*\0A\00", align 1
@.str4 = private unnamed_addr constant [11 x i8] c"*goodbye!*\00", align 1

; Function Attrs: nounwind readnone uwtable
define i32 @calc1() #0 {
  ret i32 26
}

; Function Attrs: nounwind readnone uwtable
define i32 @calc2() #0 {
  ret i32 90
}

; Function Attrs: nounwind readnone uwtable
define i32 @nothing(i8* nocapture readnone %str) #0 {
  ret i32 0
}

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  %1 = load i32 (...)** @globally1, align 8, !tbaa !1
  %2 = tail call i32 (...)* %1() #3
  %3 = load i32 (...)** @globally2, align 8, !tbaa !1
  %4 = tail call i32 (...)* %3() #3
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str, i64 0, i64 0), i32 26, i32 26, i32 90, i32 90, i32 %2, i32 %4) #3
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([7 x i8]* @.str1, i64 0, i64 0), i32 1, i32 0) #3
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i64 0, i64 0), i32 0, i32 1) #3
  %8 = tail call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @.str4, i64 0, i64 0)) #3
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
