; ModuleID = 'test_nested_struct_varargs.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.C = type { [9 x i8], %struct.A, %struct.B }
%struct.A = type { i32 }
%struct.B = type { double }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str1 = private unnamed_addr constant [4 x i8] c"%f\0A\00", align 1
@.str3 = private unnamed_addr constant [9 x i8] c"nicetest\00", align 8

; Function Attrs: nounwind uwtable
define void @_Z3fooiz(i32 %unused, ...) #0 {
  %vl = alloca [1 x %struct.__va_list_tag], align 16
  %c = alloca %struct.C, align 8
  %1 = bitcast [1 x %struct.__va_list_tag]* %vl to i8*
  call void @llvm.va_start(i8* %1)
  %2 = call i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]* %vl, i64 24) #1
  %3 = getelementptr inbounds %struct.C* %c, i64 0, i32 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %2, i64 24, i32 8, i1 false), !tbaa.struct !1
  call void @llvm.va_end(i8* %1)
  %4 = getelementptr inbounds %struct.C* %c, i64 0, i32 1, i32 0
  %5 = load i32* %4, align 4, !tbaa !9
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str, i64 0, i64 0), i32 %5) #1
  %7 = getelementptr inbounds %struct.C* %c, i64 0, i32 2, i32 0
  %8 = load double* %7, align 8, !tbaa !13
  %9 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), double %8) #1
  %puts = call i32 @puts(i8* %3)
  ret void
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

declare i8* @__intrinsic_va_arg([1 x %struct.__va_list_tag]*, i64) #2

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = alloca %struct.C, align 8
  %2 = getelementptr inbounds %struct.C* %1, i64 0, i32 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), i64 12, i32 8, i1 false)
  %3 = getelementptr inbounds %struct.C* %1, i64 0, i32 1, i32 0
  store i32 42, i32* %3, align 4
  %4 = getelementptr inbounds %struct.C* %1, i64 0, i32 2, i32 0
  store double 4.231400e+01, double* %4, align 8
  call void (i32, ...)* @_Z3fooiz(i32 undef, %struct.C* byval align 8 %1)
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{i64 0, i64 9, metadata !2, i64 12, i64 4, metadata !5, i64 16, i64 8, metadata !7}
!2 = metadata !{metadata !3, metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"int", metadata !3, i64 0}
!7 = metadata !{metadata !8, metadata !8, i64 0}
!8 = metadata !{metadata !"double", metadata !3, i64 0}
!9 = metadata !{metadata !10, metadata !6, i64 12}
!10 = metadata !{metadata !"_ZTS1C", metadata !3, i64 0, metadata !11, i64 12, metadata !12, i64 16}
!11 = metadata !{metadata !"_ZTS1A", metadata !6, i64 0}
!12 = metadata !{metadata !"_ZTS1B", metadata !8, i64 0}
!13 = metadata !{metadata !10, metadata !8, i64 16}
