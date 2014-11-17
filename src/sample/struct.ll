; ModuleID = 'struct.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct.ST = type { i32, double, %struct.RT* }
%struct.RT = type { i8, [10 x [20 x i32]], i8 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nounwind readonly ssp uwtable
define i32* @foo(%struct.ST* nocapture readonly %s, i32 %n) #0 {
  %1 = sext i32 %n to i64
  %2 = getelementptr inbounds %struct.ST* %s, i64 1, i32 2
  %3 = load %struct.RT** %2, align 8, !tbaa !1
  %4 = getelementptr inbounds %struct.RT* %3, i64 0, i32 1, i64 %1, i64 13
  ret i32* %4
}

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #1 {
  %rt = alloca [3 x %struct.RT], align 16
  %1 = getelementptr inbounds [3 x %struct.RT]* %rt, i64 0, i64 0, i32 0
  call void @llvm.lifetime.start(i64 2424, i8* %1) #2
  %2 = add nsw i32 %argc, 255
  %3 = trunc i32 %2 to i8
  call void @llvm.memset.p0i8.i64(i8* %1, i8 %3, i64 2424, i32 16, i1 false)
  %4 = sext i32 %argc to i64
  %5 = getelementptr inbounds [3 x %struct.RT]* %rt, i64 0, i64 2, i32 1, i64 %4, i64 13
  %6 = load i32* %5, align 4, !tbaa !8
  %7 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %6) #2
  call void @llvm.lifetime.end(i64 2424, i8* %1) #2
  ret i32 %7
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

attributes #0 = { nounwind readonly ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.54) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !7, i64 16}
!2 = metadata !{metadata !"ST", metadata !3, i64 0, metadata !6, i64 8, metadata !7, i64 16}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !"double", metadata !4, i64 0}
!7 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!8 = metadata !{metadata !3, metadata !3, i64 0}
