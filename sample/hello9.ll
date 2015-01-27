; ModuleID = 'hello9.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

@hello1 = global i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), align 8
@hello2 = global i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), align 8
@hello4 = global [10 x i8] c"hello %d\0A\00", align 1
@hello5 = constant [10 x i8] c"hello %d\0A\00", align 1
@main.hello11 = internal constant [10 x i8] c"hello %d\0A\00", align 1
@main.hello12 = internal constant [10 x i8] c"hello %d\0A\00", align 1
@hello6 = internal constant [10 x i8] c"hello %d\0A\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"%p %s\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"hello0\0A\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %hello10 = alloca [10 x i8], align 1
  %1 = getelementptr inbounds [10 x i8]* %hello10, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i64 10, i32 1, i1 false)
  %2 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i32 0) #1
  %3 = load i8** @hello1, align 8, !tbaa !1
  %4 = call i32 (i8*, ...)* @printf(i8* %3, i32 1) #1
  %5 = load i8** @hello2, align 8, !tbaa !1
  %6 = call i32 (i8*, ...)* @printf(i8* %5, i32 2) #1
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i32 3) #1
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello4, i64 0, i64 0), i32 4) #1
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i32 5) #1
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello6, i64 0, i64 0), i32 6) #1
  %11 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i32 7) #1
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i32 8) #1
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i32 9) #1
  %14 = call i32 (i8*, ...)* @printf(i8* %1, i32 10) #1
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @main.hello11, i64 0, i64 0), i32 11) #1
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @main.hello12, i64 0, i64 0), i32 12) #1
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #1
  %18 = load i8** @hello1, align 8, !tbaa !1
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %18, i8* %18) #1
  %20 = load i8** @hello2, align 8, !tbaa !1
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %20, i8* %20) #1
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0)) #1
  %23 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello4, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello4, i64 0, i64 0)) #1
  %24 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0)) #1
  %25 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello6, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello6, i64 0, i64 0)) #1
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0)) #1
  %27 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0)) #1
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @hello5, i64 0, i64 0)) #1
  %29 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* %1, i8* %1) #1
  %30 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @main.hello11, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @main.hello11, i64 0, i64 0)) #1
  %31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @main.hello12, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @main.hello12, i64 0, i64 0)) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
