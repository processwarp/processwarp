; ModuleID = 'test_exceptions_white_list_2.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_ZTIi = external constant i8*
@funptr = global void ()* @_Z9throwherev, align 8
@str = private unnamed_addr constant [6 x i8] c"ERROR\00"
@str2 = private unnamed_addr constant [8 x i8] c"SUCCESS\00"

; Function Attrs: noreturn uwtable
define void @_Z9throwherev() #0 {
  %1 = tail call i8* @__cxa_allocate_exception(i64 4) #2
  %2 = bitcast i8* %1 to i32*
  store i32 1, i32* %2, align 4, !tbaa !1
  tail call void @__cxa_throw(i8* %1, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #3
  unreachable
}

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: uwtable
define void @_Z7nocatchv() #1 {
  %1 = load void ()** @funptr, align 8, !tbaa !5
  invoke void %1()
          to label %6 unwind label %2

; <label>:2                                       ; preds = %0
  %3 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %4 = extractvalue { i8*, i32 } %3, 0
  %5 = tail call i8* @__cxa_begin_catch(i8* %4) #2
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str, i64 0, i64 0))
  tail call void @__cxa_end_catch()
  br label %6

; <label>:6                                       ; preds = %2, %0
  ret void
}

declare i32 @__gxx_personality_v0(...)

declare i8* @__cxa_begin_catch(i8*)

declare void @__cxa_end_catch()

; Function Attrs: uwtable
define i32 @main() #1 {
  %1 = load void ()** @funptr, align 8, !tbaa !5
  invoke void %1()
          to label %_Z7nocatchv.exit unwind label %2

; <label>:2                                       ; preds = %0
  %3 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %4 = extractvalue { i8*, i32 } %3, 0
  %5 = tail call i8* @__cxa_begin_catch(i8* %4) #2
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([6 x i8]* @str, i64 0, i64 0))
  invoke void @__cxa_end_catch()
          to label %_Z7nocatchv.exit unwind label %6

; <label>:6                                       ; preds = %2
  %7 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %8 = extractvalue { i8*, i32 } %7, 0
  %9 = tail call i8* @__cxa_begin_catch(i8* %8) #2
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str2, i64 0, i64 0))
  tail call void @__cxa_end_catch()
  br label %_Z7nocatchv.exit

_Z7nocatchv.exit:                                 ; preds = %6, %2, %0
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture) #2

attributes #0 = { noreturn uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }
attributes #3 = { noreturn }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"any pointer", metadata !3, i64 0}
