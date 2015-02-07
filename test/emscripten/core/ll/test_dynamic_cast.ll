; ModuleID = 'test_dynamic_cast.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.Support = type { i32 (...)** }

@_ZTVN10__cxxabiv117__class_type_infoE = external global i8*
@_ZTS7Support = linkonce_odr constant [9 x i8] c"7Support\00"
@_ZTI7Support = linkonce_odr unnamed_addr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([9 x i8]* @_ZTS7Support, i32 0, i32 0) }
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTS7Derived = linkonce_odr constant [9 x i8] c"7Derived\00"
@_ZTI7Derived = linkonce_odr unnamed_addr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([9 x i8]* @_ZTS7Derived, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTI7Support to i8*) }
@_ZTV7Derived = linkonce_odr unnamed_addr constant [3 x i8*] [i8* null, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI7Derived to i8*), i8* bitcast (void (%struct.Support*)* @_ZN7Support1fEv to i8*)]
@str = private unnamed_addr constant [4 x i8] c"f()\00"

; Function Attrs: uwtable
define i32 @main() #0 {
  %1 = tail call noalias i8* @_Znwm(i64 8) #5
  %2 = bitcast i8* %1 to i32 (...)***
  store i32 (...)** bitcast (i8** getelementptr inbounds ([3 x i8*]* @_ZTV7Derived, i64 0, i64 2) to i32 (...)**), i32 (...)*** %2, align 8, !tbaa !1
  %3 = tail call i8* @__dynamic_cast(i8* %1, i8* bitcast ({ i8*, i8* }* @_ZTI7Support to i8*), i8* bitcast ({ i8*, i8*, i8* }* @_ZTI7Derived to i8*), i64 0) #4
  %4 = bitcast i8* %3 to %struct.Support*
  %5 = bitcast i8* %3 to void (%struct.Support*)***
  %6 = load void (%struct.Support*)*** %5, align 8, !tbaa !1
  %7 = load void (%struct.Support*)** %6, align 8
  tail call void %7(%struct.Support* %4)
  ret i32 0
}

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #1

; Function Attrs: nounwind readonly
declare i8* @__dynamic_cast(i8*, i8*, i8*, i64) #2

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN7Support1fEv(%struct.Support* nocapture readnone %this) unnamed_addr #3 align 2 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly }
attributes #3 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { builtin }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"vtable pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"Simple C/C++ TBAA"}
