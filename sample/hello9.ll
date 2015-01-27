; ModuleID = 'hello9.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

@.str = private unnamed_addr constant [8 x i8] c"hello1\0A\00", align 1
@hello1 = global i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), align 8
@.str1 = private unnamed_addr constant [8 x i8] c"hello2\0A\00", align 1
@hello2 = global i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), align 8
@hello4 = global [8 x i8] c"hello4\0A\00", align 1
@hello5 = constant [8 x i8] c"hello5\0A\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"hello7\0A\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"hello8\0A\00", align 1
@.str4 = private unnamed_addr constant [8 x i8] c"hello9\0A\00", align 1
@main.hello10 = private unnamed_addr constant [9 x i8] c"hello10\0A\00", align 1
@main.hello11 = internal constant [9 x i8] c"hello11\0A\00", align 1
@main.hello12 = internal constant [9 x i8] c"hello12\0A\00", align 1
@.str5 = private unnamed_addr constant [8 x i8] c"hello0\0A\00", align 1
@hello6 = internal constant [8 x i8] c"hello6\0A\00", align 1
@.str6 = private unnamed_addr constant [6 x i8] c"%p %s\00", align 1
@.str7 = private unnamed_addr constant [8 x i8] c"hello3\0A\00", align 1
@str = private unnamed_addr constant [7 x i8] c"hello0\00"
@str8 = private unnamed_addr constant [7 x i8] c"hello5\00"
@str9 = private unnamed_addr constant [7 x i8] c"hello6\00"
@str10 = private unnamed_addr constant [7 x i8] c"hello7\00"
@str11 = private unnamed_addr constant [7 x i8] c"hello8\00"
@str12 = private unnamed_addr constant [8 x i8] c"hello11\00"
@str13 = private unnamed_addr constant [8 x i8] c"hello12\00"
@str14 = private unnamed_addr constant [7 x i8] c"hello3\00"
@str15 = private unnamed_addr constant [7 x i8] c"hello9\00"

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %hello10 = alloca [9 x i8], align 1
  %1 = getelementptr inbounds [9 x i8]* %hello10, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([9 x i8]* @main.hello10, i64 0, i64 0), i64 9, i32 1, i1 false)
  %puts = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  %2 = load i8** @hello1, align 8, !tbaa !1
  %3 = call i32 (i8*, ...)* @printf(i8* %2) #1
  %4 = load i8** @hello2, align 8, !tbaa !1
  %5 = call i32 (i8*, ...)* @printf(i8* %4) #1
  %puts7 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str14, i64 0, i64 0))
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @hello4, i64 0, i64 0)) #1
  %puts1 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str8, i64 0, i64 0))
  %puts2 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str9, i64 0, i64 0))
  %puts3 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str10, i64 0, i64 0))
  %puts4 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str11, i64 0, i64 0))
  %puts8 = call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str15, i64 0, i64 0))
  %7 = call i32 (i8*, ...)* @printf(i8* %1) #1
  %puts5 = call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str12, i64 0, i64 0))
  %puts6 = call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str13, i64 0, i64 0))
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0)) #1
  %9 = load i8** @hello1, align 8, !tbaa !1
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* %9, i8* %9) #1
  %11 = load i8** @hello2, align 8, !tbaa !1
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* %11, i8* %11) #1
  %13 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0)) #1
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @hello4, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @hello4, i64 0, i64 0)) #1
  %15 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @hello5, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @hello5, i64 0, i64 0)) #1
  %16 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @hello6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @hello6, i64 0, i64 0)) #1
  %17 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0)) #1
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0)) #1
  %19 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([8 x i8]* @.str4, i64 0, i64 0)) #1
  %20 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* %1, i8* %1) #1
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @main.hello11, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @main.hello11, i64 0, i64 0)) #1
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([6 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @main.hello12, i64 0, i64 0), i8* getelementptr inbounds ([9 x i8]* @main.hello12, i64 0, i64 0)) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
