; ModuleID = 'test_va_arg.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.struct2 = type { i32, i16, i32, double }

@.str = private unnamed_addr constant [8 x i8] c"1 : %d\0A\00", align 1
@.str1 = private unnamed_addr constant [8 x i8] c"2 : %c\0A\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"3 : %f\0A\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"4 : %d\0A\00", align 1
@.str4 = private unnamed_addr constant [8 x i8] c"5 : %d\0A\00", align 1
@.str5 = private unnamed_addr constant [8 x i8] c"6 : %d\0A\00", align 1
@.str6 = private unnamed_addr constant [8 x i8] c"7 : %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @vaarg(i8 signext %unused, ...) #0 {
  %vl = alloca [1 x %struct.__va_list_tag], align 16
  %1 = bitcast [1 x %struct.__va_list_tag]* %vl to i8*
  call void @llvm.va_start(i8* %1)
  %2 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 2) #1
  %3 = bitcast i8* %2 to i16*
  %4 = load i16* %3, align 2, !tbaa !1
  %5 = sext i16 %4 to i32
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 %5) #1
  %7 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 4) #1
  %8 = bitcast i8* %7 to i32*
  %9 = load i32* %8, align 4, !tbaa !5
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i32 %9) #1
  %11 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 8) #1
  %12 = bitcast i8* %11 to double*
  %13 = load double* %12, align 8, !tbaa !7
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), double %13) #1
  %15 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 1) #1
  %16 = load i8* %15, align 1, !tbaa !9
  %17 = sext i8 %16 to i32
  %18 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 %17) #1
  %19 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 2) #1
  %20 = load i8* %19, align 1, !tbaa !10
  %21 = sext i8 %20 to i32
  %22 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str4, i64 0, i64 0), i32 %21) #1
  %23 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 24) #1
  %24 = getelementptr inbounds i8* %23, i64 4
  %25 = bitcast i8* %24 to i16*
  %26 = load i16* %25, align 2, !tbaa !12
  %27 = sext i16 %26 to i32
  %28 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i32 %27) #1
  %29 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 8) #1
  %30 = bitcast i8* %29 to i16**
  %31 = load i16** %30, align 8, !tbaa !14
  %32 = load i16* %31, align 2, !tbaa !1
  %33 = sext i16 %32 to i32
  %34 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str6, i64 0, i64 0), i32 %33) #1
  call void @llvm.va_end(i8* %1)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

declare i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]*, i64) #3

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %st2 = alloca %struct.struct2, align 8
  %1 = getelementptr inbounds %struct.struct2* %st2, i64 0, i32 0
  store i32 10, i32* %1, align 8, !tbaa !16
  %2 = getelementptr inbounds %struct.struct2* %st2, i64 0, i32 1
  store i16 20, i16* %2, align 4, !tbaa !12
  call void (i8, ...)* @vaarg(i8 signext undef, i32 1, i32 98, double 0x4008CCCCC0000000, i32 4, i16 513, %struct.struct2* byval align 8 %st2, i16* %2)
  ret i32 0
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"short", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"int", metadata !3, i64 0}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"double", metadata !3, i64 0}
!9 = metadata !{metadata !3, metadata !3, i64 0}
!10 = metadata !{metadata !11, metadata !3, i64 0}
!11 = metadata !{metadata !"", metadata !3, i64 0, metadata !3, i64 1}
!12 = metadata !{metadata !13, metadata !2, i64 4}
!13 = metadata !{metadata !"", metadata !6, i64 0, metadata !2, i64 4, metadata !6, i64 8, metadata !8, i64 16}
!14 = metadata !{metadata !15, metadata !15, i64 0}
!15 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!16 = metadata !{metadata !13, metadata !6, i64 0}
