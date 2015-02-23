; ModuleID = 'test_transtrcase.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@main.szTolwr = private unnamed_addr constant [11 x i8] c"EMSCRIPTEN\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %szToupr = alloca i64, align 8
  %szTolwr = alloca [11 x i8], align 1
  store i64 9056056326776168, i64* %szToupr, align 8
  %1 = getelementptr inbounds [11 x i8]* %szTolwr, i64 0, i64 0
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([11 x i8]* @main.szTolwr, i64 0, i64 0), i64 11, i32 1, i1 false)
  %2 = bitcast i64* %szToupr to i8*
  %3 = call i32 (i8*, ...)* bitcast (i32 (...)* @strupr to i32 (i8*, ...)*)(i8* %2) #1
  %4 = call i32 (i8*, ...)* bitcast (i32 (...)* @strlwr to i32 (i8*, ...)*)(i8* %1) #1
  %5 = call i32 (i8*, ...)* @printf(i8* %2) #1
  %6 = call i32 (i8*, ...)* @printf(i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

declare i32 @strupr(...) #2

declare i32 @strlwr(...) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
