; ModuleID = 'test_poll.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.pollfd = type { i32, i16, i16 }

@.str = private unnamed_addr constant [6 x i8] c"/file\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"/device\00", align 1
@.str2 = private unnamed_addr constant [9 x i8] c"ret: %d\0A\00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"errno: %d\0A\00", align 1
@.str4 = private unnamed_addr constant [22 x i8] c"multi[0].revents: %d\0A\00", align 1
@.str5 = private unnamed_addr constant [22 x i8] c"multi[1].revents: %d\0A\00", align 1
@.str6 = private unnamed_addr constant [22 x i8] c"multi[2].revents: %d\0A\00", align 1
@.str7 = private unnamed_addr constant [22 x i8] c"multi[3].revents: %d\0A\00", align 1
@.str8 = private unnamed_addr constant [22 x i8] c"multi[4].revents: %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %multi = alloca [5 x %struct.pollfd], align 16
  %1 = bitcast [5 x %struct.pollfd]* %multi to i8*
  call void @llvm.lifetime.start(i64 40, i8* %1) #1
  %2 = call i32 (i8*, i32, ...)* @open(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), i32 0, i32 511) #1
  %3 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 0, i32 0
  store i32 %2, i32* %3, align 16, !tbaa !1
  %4 = call i32 (i8*, i32, ...)* @open(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i32 0, i32 511) #1
  %5 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 1, i32 0
  store i32 %4, i32* %5, align 8, !tbaa !1
  %6 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 2, i32 0
  store i32 123, i32* %6, align 16, !tbaa !1
  %7 = call i32 (i8*, i32, ...)* @open(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), i32 0, i32 511) #1
  %8 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 3, i32 0
  store i32 %7, i32* %8, align 8, !tbaa !1
  %9 = call i32 (i8*, i32, ...)* @open(i8* getelementptr inbounds ([6 x i8]* @.str, i64 0, i64 0), i32 0, i32 511) #1
  %10 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 4, i32 0
  store i32 %9, i32* %10, align 16, !tbaa !1
  %11 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 0, i32 1
  store i16 45, i16* %11, align 4, !tbaa !7
  %12 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 1, i32 1
  store i16 45, i16* %12, align 4, !tbaa !7
  %13 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 2, i32 1
  store i16 45, i16* %13, align 4, !tbaa !7
  %14 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 3, i32 1
  store i16 0, i16* %14, align 4, !tbaa !7
  %15 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 4, i32 1
  store i16 44, i16* %15, align 4, !tbaa !7
  %16 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 0
  %17 = call i32 @poll(%struct.pollfd* %16, i64 5, i32 123) #1
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str2, i64 0, i64 0), i32 %17) #1
  %19 = call i32* @__errno_location() #5
  %20 = load i32* %19, align 4, !tbaa !8
  %21 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str3, i64 0, i64 0), i32 %20) #1
  %22 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 0, i32 2
  %23 = load i16* %22, align 2, !tbaa !9
  %24 = icmp eq i16 %23, 5
  %25 = zext i1 %24 to i32
  %26 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str4, i64 0, i64 0), i32 %25) #1
  %27 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 1, i32 2
  %28 = load i16* %27, align 2, !tbaa !9
  %29 = icmp eq i16 %28, 5
  %30 = zext i1 %29 to i32
  %31 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str5, i64 0, i64 0), i32 %30) #1
  %32 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 2, i32 2
  %33 = load i16* %32, align 2, !tbaa !9
  %34 = icmp eq i16 %33, 32
  %35 = zext i1 %34 to i32
  %36 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str6, i64 0, i64 0), i32 %35) #1
  %37 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 3, i32 2
  %38 = load i16* %37, align 2, !tbaa !9
  %39 = icmp eq i16 %38, 0
  %40 = zext i1 %39 to i32
  %41 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str7, i64 0, i64 0), i32 %40) #1
  %42 = getelementptr inbounds [5 x %struct.pollfd]* %multi, i64 0, i64 4, i32 2
  %43 = load i16* %42, align 2, !tbaa !9
  %44 = icmp eq i16 %43, 4
  %45 = zext i1 %44 to i32
  %46 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str8, i64 0, i64 0), i32 %45) #1
  call void @llvm.lifetime.end(i64 40, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

declare i32 @open(i8* nocapture readonly, i32, ...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

declare i32 @poll(%struct.pollfd*, i64, i32) #2

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"pollfd", metadata !3, i64 0, metadata !6, i64 4, metadata !6, i64 6}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"short", metadata !4, i64 0}
!7 = metadata !{metadata !2, metadata !6, i64 4}
!8 = metadata !{metadata !3, metadata !3, i64 0}
!9 = metadata !{metadata !2, metadata !6, i64 6}
