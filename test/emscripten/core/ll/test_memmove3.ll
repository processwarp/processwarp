; ModuleID = 'test_memmove3.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@_ZZ4mainE3str = private unnamed_addr constant [33 x i8] c"memmove can be vvery useful....!\00", align 16

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %str = alloca [33 x i8], align 16
  %1 = getelementptr inbounds [33 x i8]* %str, i64 0, i64 0
  call void @llvm.lifetime.start(i64 33, i8* %1) #1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([33 x i8]* @_ZZ4mainE3str, i64 0, i64 0), i64 33, i32 16, i1 false)
  %2 = getelementptr inbounds [33 x i8]* %str, i64 0, i64 15
  %3 = getelementptr inbounds [33 x i8]* %str, i64 0, i64 16
  call void @llvm.memmove.p0i8.p0i8.i64(i8* %2, i8* %3, i64 17, i32 1, i1 false)
  %4 = call i32 @puts(i8* %1)
  call void @llvm.lifetime.end(i64 33, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare void @llvm.memmove.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
