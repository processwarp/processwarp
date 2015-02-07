; ModuleID = 'test_exceptions_white_list.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [10 x i8] c"infunc...\00", align 1
@_ZTIi = external constant i8*
@str = private unnamed_addr constant [7 x i8] c"done!*\00"

; Function Attrs: noreturn uwtable
define void @_Z7throwerv() #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0))
  %2 = tail call i8* @__cxa_allocate_exception(i64 4) #3
  %3 = bitcast i8* %2 to i32*
  store i32 99, i32* %3, align 4, !tbaa !1
  tail call void @__cxa_throw(i8* %2, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #4
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: uwtable
define void @_Z12somefunctionv() #2 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str, i64 0, i64 0))
  %2 = tail call i8* @__cxa_allocate_exception(i64 4) #3
  %3 = bitcast i8* %2 to i32*
  store i32 99, i32* %3, align 4, !tbaa !1
  invoke void @__cxa_throw(i8* %2, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #4
          to label %.noexc unwind label %4

.noexc:                                           ; preds = %0
  unreachable

; <label>:4                                       ; preds = %0
  %5 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %6 = extractvalue { i8*, i32 } %5, 0
  %7 = tail call i8* @__cxa_begin_catch(i8* %6) #3
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([7 x i8]* @str, i64 0, i64 0))
  tail call void @__cxa_end_catch()
  ret void
}

declare i32 @__gxx_personality_v0(...)

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: uwtable
define i32 @main() #2 {
  tail call void @_Z12somefunctionv()
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #3

attributes #0 = { noreturn uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }
attributes #4 = { noreturn }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
