; ModuleID = 'test_statvfs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.statvfs = type { i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, i64, [6 x i32] }

@.str = private unnamed_addr constant [12 x i8] c"result: %d\0A\00", align 1
@.str1 = private unnamed_addr constant [6 x i8] c"/test\00", align 1
@.str2 = private unnamed_addr constant [11 x i8] c"errno: %d\0A\00", align 1
@.str3 = private unnamed_addr constant [14 x i8] c"f_bsize: %lu\0A\00", align 1
@.str4 = private unnamed_addr constant [15 x i8] c"f_frsize: %lu\0A\00", align 1
@.str5 = private unnamed_addr constant [15 x i8] c"f_blocks: %lu\0A\00", align 1
@.str6 = private unnamed_addr constant [14 x i8] c"f_bfree: %lu\0A\00", align 1
@.str7 = private unnamed_addr constant [15 x i8] c"f_bavail: %lu\0A\00", align 1
@.str8 = private unnamed_addr constant [13 x i8] c"f_files: %d\0A\00", align 1
@.str9 = private unnamed_addr constant [14 x i8] c"f_ffree: %lu\0A\00", align 1
@.str10 = private unnamed_addr constant [15 x i8] c"f_favail: %lu\0A\00", align 1
@.str11 = private unnamed_addr constant [13 x i8] c"f_fsid: %lu\0A\00", align 1
@.str12 = private unnamed_addr constant [13 x i8] c"f_flag: %lu\0A\00", align 1
@.str13 = private unnamed_addr constant [16 x i8] c"f_namemax: %lu\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %s = alloca %struct.statvfs, align 8
  %1 = bitcast %struct.statvfs* %s to i8*
  call void @llvm.lifetime.start(i64 112, i8* %1) #1
  %2 = call i32 @statvfs(i8* getelementptr inbounds ([6 x i8]* @.str1, i64 0, i64 0), %struct.statvfs* %s) #1
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str, i64 0, i64 0), i32 %2)
  %4 = tail call i32* @__errno_location() #4
  %5 = load i32* %4, align 4, !tbaa !1
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([11 x i8]* @.str2, i64 0, i64 0), i32 %5)
  %7 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 0
  %8 = load i64* %7, align 8, !tbaa !5
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str3, i64 0, i64 0), i64 %8)
  %10 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 1
  %11 = load i64* %10, align 8, !tbaa !8
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str4, i64 0, i64 0), i64 %11)
  %13 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 2
  %14 = load i64* %13, align 8, !tbaa !9
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str5, i64 0, i64 0), i64 %14)
  %16 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 3
  %17 = load i64* %16, align 8, !tbaa !10
  %18 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str6, i64 0, i64 0), i64 %17)
  %19 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 4
  %20 = load i64* %19, align 8, !tbaa !11
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str7, i64 0, i64 0), i64 %20)
  %22 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 5
  %23 = load i64* %22, align 8, !tbaa !12
  %24 = icmp ugt i64 %23, 5
  %25 = zext i1 %24 to i32
  %26 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str8, i64 0, i64 0), i32 %25)
  %27 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 6
  %28 = load i64* %27, align 8, !tbaa !13
  %29 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str9, i64 0, i64 0), i64 %28)
  %30 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 7
  %31 = load i64* %30, align 8, !tbaa !14
  %32 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([15 x i8]* @.str10, i64 0, i64 0), i64 %31)
  %33 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 8
  %34 = load i64* %33, align 8, !tbaa !15
  %35 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str11, i64 0, i64 0), i64 %34)
  %36 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 9
  %37 = load i64* %36, align 8, !tbaa !16
  %38 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str12, i64 0, i64 0), i64 %37)
  %39 = getelementptr inbounds %struct.statvfs* %s, i64 0, i32 10
  %40 = load i64* %39, align 8, !tbaa !17
  %41 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str13, i64 0, i64 0), i64 %40)
  call void @llvm.lifetime.end(i64 112, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @statvfs(i8* nocapture readonly, %struct.statvfs* nocapture) #2

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !7, i64 0}
!6 = metadata !{metadata !"_ZTS7statvfs", metadata !7, i64 0, metadata !7, i64 8, metadata !7, i64 16, metadata !7, i64 24, metadata !7, i64 32, metadata !7, i64 40, metadata !7, i64 48, metadata !7, i64 56, metadata !7, i64 64, metadata !7, i64 72, metadata !7, i64 80, metadata !3, i64 88}
!7 = metadata !{metadata !"long", metadata !3, i64 0}
!8 = metadata !{metadata !6, metadata !7, i64 8}
!9 = metadata !{metadata !6, metadata !7, i64 16}
!10 = metadata !{metadata !6, metadata !7, i64 24}
!11 = metadata !{metadata !6, metadata !7, i64 32}
!12 = metadata !{metadata !6, metadata !7, i64 40}
!13 = metadata !{metadata !6, metadata !7, i64 48}
!14 = metadata !{metadata !6, metadata !7, i64 56}
!15 = metadata !{metadata !6, metadata !7, i64 64}
!16 = metadata !{metadata !6, metadata !7, i64 72}
!17 = metadata !{metadata !6, metadata !7, i64 80}
