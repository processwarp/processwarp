; ModuleID = 'test_icmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@p_one = global i32 1, align 4
@p_two = global i32 2, align 4
@zero = global i32 0, align 4
@m_one = global i32 -1, align 4
@m_two = global i32 -2, align 4
@.str = private unnamed_addr constant [37 x i8] c"%d %d %d %d %d %d %d %d %d %d %d %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = load i32* @p_one, align 4, !tbaa !1
  %2 = load i32* @p_two, align 4, !tbaa !1
  %3 = icmp sgt i32 %1, %2
  %4 = zext i1 %3 to i32
  %5 = icmp sgt i32 %2, %1
  %6 = zext i1 %5 to i32
  %7 = icmp ugt i32 %1, %2
  %8 = zext i1 %7 to i32
  %9 = icmp ugt i32 %2, %1
  %10 = zext i1 %9 to i32
  %11 = load i32* @m_one, align 4, !tbaa !1
  %12 = load i32* @m_two, align 4, !tbaa !1
  %13 = icmp sgt i32 %11, %12
  %14 = zext i1 %13 to i32
  %15 = icmp sgt i32 %12, %11
  %16 = zext i1 %15 to i32
  %17 = icmp ugt i32 %11, %12
  %18 = zext i1 %17 to i32
  %19 = icmp ugt i32 %12, %11
  %20 = zext i1 %19 to i32
  %21 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i64 0, i64 0), i32 %4, i32 %6, i32 0, i32 %8, i32 %10, i32 0, i32 %14, i32 %16, i32 0, i32 %18, i32 %20, i32 0) #2
  %22 = load i32* @p_one, align 4, !tbaa !1
  %23 = load i32* @p_two, align 4, !tbaa !1
  %24 = icmp sge i32 %22, %23
  %25 = zext i1 %24 to i32
  %26 = icmp sge i32 %23, %22
  %27 = zext i1 %26 to i32
  %28 = icmp uge i32 %22, %23
  %29 = zext i1 %28 to i32
  %30 = icmp uge i32 %23, %22
  %31 = zext i1 %30 to i32
  %32 = load i32* @m_one, align 4, !tbaa !1
  %33 = load i32* @m_two, align 4, !tbaa !1
  %34 = icmp sge i32 %32, %33
  %35 = zext i1 %34 to i32
  %36 = icmp sge i32 %33, %32
  %37 = zext i1 %36 to i32
  %38 = icmp uge i32 %32, %33
  %39 = zext i1 %38 to i32
  %40 = icmp uge i32 %33, %32
  %41 = zext i1 %40 to i32
  %42 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i64 0, i64 0), i32 %25, i32 %27, i32 1, i32 %29, i32 %31, i32 1, i32 %35, i32 %37, i32 1, i32 %39, i32 %41, i32 1) #2
  %43 = load i32* @p_one, align 4, !tbaa !1
  %44 = load i32* @p_two, align 4, !tbaa !1
  %45 = icmp slt i32 %43, %44
  %46 = zext i1 %45 to i32
  %47 = icmp slt i32 %44, %43
  %48 = zext i1 %47 to i32
  %49 = icmp ult i32 %43, %44
  %50 = zext i1 %49 to i32
  %51 = icmp ult i32 %44, %43
  %52 = zext i1 %51 to i32
  %53 = load i32* @m_one, align 4, !tbaa !1
  %54 = load i32* @m_two, align 4, !tbaa !1
  %55 = icmp slt i32 %53, %54
  %56 = zext i1 %55 to i32
  %57 = icmp slt i32 %54, %53
  %58 = zext i1 %57 to i32
  %59 = icmp ult i32 %53, %54
  %60 = zext i1 %59 to i32
  %61 = icmp ult i32 %54, %53
  %62 = zext i1 %61 to i32
  %63 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i64 0, i64 0), i32 %46, i32 %48, i32 0, i32 %50, i32 %52, i32 0, i32 %56, i32 %58, i32 0, i32 %60, i32 %62, i32 0) #2
  %64 = load i32* @p_one, align 4, !tbaa !1
  %65 = load i32* @p_two, align 4, !tbaa !1
  %66 = icmp sle i32 %64, %65
  %67 = zext i1 %66 to i32
  %68 = icmp sle i32 %65, %64
  %69 = zext i1 %68 to i32
  %70 = icmp ule i32 %64, %65
  %71 = zext i1 %70 to i32
  %72 = icmp ule i32 %65, %64
  %73 = zext i1 %72 to i32
  %74 = load i32* @m_one, align 4, !tbaa !1
  %75 = load i32* @m_two, align 4, !tbaa !1
  %76 = icmp sle i32 %74, %75
  %77 = zext i1 %76 to i32
  %78 = icmp sle i32 %75, %74
  %79 = zext i1 %78 to i32
  %80 = icmp ule i32 %74, %75
  %81 = zext i1 %80 to i32
  %82 = icmp ule i32 %75, %74
  %83 = zext i1 %82 to i32
  %84 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i64 0, i64 0), i32 %67, i32 %69, i32 1, i32 %71, i32 %73, i32 1, i32 %77, i32 %79, i32 1, i32 %81, i32 %83, i32 1) #2
  %85 = load i32* @p_one, align 4, !tbaa !1
  %86 = load i32* @p_two, align 4, !tbaa !1
  %87 = icmp eq i32 %85, %86
  %88 = zext i1 %87 to i32
  %89 = load i32* @m_one, align 4, !tbaa !1
  %90 = load i32* @m_two, align 4, !tbaa !1
  %91 = icmp eq i32 %89, %90
  %92 = zext i1 %91 to i32
  %93 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i64 0, i64 0), i32 %88, i32 %88, i32 1, i32 %88, i32 %88, i32 1, i32 %92, i32 %92, i32 1, i32 %92, i32 %92, i32 1) #2
  %94 = load i32* @p_one, align 4, !tbaa !1
  %95 = load i32* @p_two, align 4, !tbaa !1
  %96 = icmp ne i32 %94, %95
  %97 = zext i1 %96 to i32
  %98 = load i32* @m_one, align 4, !tbaa !1
  %99 = load i32* @m_two, align 4, !tbaa !1
  %100 = icmp ne i32 %98, %99
  %101 = zext i1 %100 to i32
  %102 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([37 x i8]* @.str, i64 0, i64 0), i32 %97, i32 %97, i32 0, i32 %97, i32 %97, i32 0, i32 %101, i32 %101, i32 0, i32 %101, i32 %101, i32 0) #2
  ret i32 0
}

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
