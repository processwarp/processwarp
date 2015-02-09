; ModuleID = 'test_dynamic_cast_b.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%class.CBase = type { i32 (...)** }

@.str = private unnamed_addr constant [8 x i8] c"a1: %d\0A\00", align 1
@_ZTVN10__cxxabiv117__class_type_infoE = external global i8*
@_ZTS5CBase = linkonce_odr constant [7 x i8] c"5CBase\00"
@_ZTI5CBase = linkonce_odr unnamed_addr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([7 x i8]* @_ZTS5CBase, i32 0, i32 0) }
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTS11CDerivedest = linkonce_odr constant [14 x i8] c"11CDerivedest\00"
@_ZTS8CDerived = linkonce_odr constant [10 x i8] c"8CDerived\00"
@_ZTI8CDerived = linkonce_odr unnamed_addr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([10 x i8]* @_ZTS8CDerived, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*) }
@_ZTI11CDerivedest = linkonce_odr unnamed_addr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([14 x i8]* @_ZTS11CDerivedest, i32 0, i32 0), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI8CDerived to i8*) }
@.str1 = private unnamed_addr constant [8 x i8] c"a2: %d\0A\00", align 1
@.str2 = private unnamed_addr constant [8 x i8] c"a3: %d\0A\00", align 1
@.str3 = private unnamed_addr constant [8 x i8] c"b1: %d\0A\00", align 1
@.str4 = private unnamed_addr constant [8 x i8] c"b2: %d\0A\00", align 1
@.str5 = private unnamed_addr constant [8 x i8] c"b3: %d\0A\00", align 1
@.str6 = private unnamed_addr constant [8 x i8] c"c1: %d\0A\00", align 1
@.str7 = private unnamed_addr constant [8 x i8] c"c2: %d\0A\00", align 1
@.str8 = private unnamed_addr constant [8 x i8] c"c3: %d\0A\00", align 1
@_ZTV11CDerivedest = linkonce_odr unnamed_addr constant [3 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI11CDerivedest to i8*), i8* bitcast (void (%class.CBase*)* @_ZN5CBase5dummyEv to i8*)]
@_ZTV8CDerived = linkonce_odr unnamed_addr constant [3 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI8CDerived to i8*), i8* bitcast (void (%class.CBase*)* @_ZN5CBase5dummyEv to i8*)]
@_ZTV5CBase = linkonce_odr unnamed_addr constant [3 x i8*] [i8* null, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast (void (%class.CBase*)* @_ZN5CBase5dummyEv to i8*)]

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %1 = tail call noalias i8* @_Znwm(i64 8) #5
  %2 = bitcast i8* %1 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([3 x i8*]* @_ZTV5CBase, i64 0, i64 2) to i32 (...)**), i32 (...)*** %2, align 8, !tbaa !1
  %3 = tail call noalias i8* @_Znwm(i64 16) #5
  %4 = bitcast i8* %3 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([3 x i8*]* @_ZTV8CDerived, i64 0, i64 2) to i32 (...)**), i32 (...)*** %4, align 8, !tbaa !1
  %5 = tail call noalias i8* @_Znwm(i64 16) #5
  %6 = bitcast i8* %5 to i8***
  store i8** getelementptr inbounds ([3 x i8*]* @_ZTV11CDerivedest, i64 0, i64 2), i8*** %6, align 8, !tbaa !1
  %7 = tail call i8* @__dynamic_cast(i8* %1, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI11CDerivedest to i8*), i64 0) #6
  %phitmp = icmp ne i8* %7, null
  %8 = zext i1 %phitmp to i32
  %9 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str, i64 0, i64 0), i32 %8) #6
  %10 = tail call i8* @__dynamic_cast(i8* %1, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI8CDerived to i8*), i64 0) #6
  %phitmp1 = icmp ne i8* %10, null
  %11 = zext i1 %phitmp1 to i32
  %12 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str1, i64 0, i64 0), i32 %11) #6
  %13 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str2, i64 0, i64 0), i32 1) #6
  %14 = tail call i8* @__dynamic_cast(i8* %3, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI11CDerivedest to i8*), i64 0) #6
  %phitmp2 = icmp ne i8* %14, null
  %15 = zext i1 %phitmp2 to i32
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str3, i64 0, i64 0), i32 %15) #6
  %17 = tail call i8* @__dynamic_cast(i8* %3, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI8CDerived to i8*), i64 0) #6
  %phitmp3 = icmp ne i8* %17, null
  %18 = zext i1 %phitmp3 to i32
  %19 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str4, i64 0, i64 0), i32 %18) #6
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str5, i64 0, i64 0), i32 1) #6
  %21 = tail call i8* @__dynamic_cast(i8* %5, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI11CDerivedest to i8*), i64 0) #6
  %phitmp4 = icmp ne i8* %21, null
  %22 = zext i1 %phitmp4 to i32
  %23 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str6, i64 0, i64 0), i32 %22) #6
  %24 = tail call i8* @__dynamic_cast(i8* %5, i8* bitcast ({ i8*, i8* }* @_ZTI5CBase to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI8CDerived to i8*), i64 0) #6
  %phitmp5 = icmp ne i8* %24, null
  %25 = zext i1 %phitmp5 to i32
  %26 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str7, i64 0, i64 0), i32 %25) #6
  %27 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([8 x i8]* @.str8, i64 0, i64 0), i32 1) #6
  ret i32 0
}

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind readonly
declare i8* @__dynamic_cast(i8*, i8*, i8*, i64) #3

; Function Attrs: nounwind readnone uwtable
define linkonce_odr void @_ZN5CBase5dummyEv(%class.CBase* nocapture %this) unnamed_addr #4 align 2 {
  ret void
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly }
attributes #4 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { builtin nounwind }
attributes #6 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"vtable pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
