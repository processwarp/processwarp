; ModuleID = 'test_vsnprintf.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.__va_list_tag = type { i32, i32, i8*, i8* }

@.str = private unnamed_addr constant [14 x i8] c"0x%llx_0x%llx\00", align 1

; Function Attrs: nounwind uwtable
define void @printy(i8* nocapture readonly %f, ...) #0 {
  %buffer = alloca [256 x i8], align 16
  %args = alloca [1 x %struct.__va_list_tag], align 16
  %1 = getelementptr inbounds [256 x i8]* %buffer, i64 0, i64 0
  call void @llvm.lifetime.start(i64 256, i8* %1) #1
  %2 = getelementptr inbounds [1 x %struct.__va_list_tag]* %args, i64 0, i64 0
  %3 = bitcast [1 x %struct.__va_list_tag]* %args to i8*
  call void @llvm.va_start(i8* %3)
  %4 = call i32 @vsnprintf(i8* %1, i64 256, i8* %f, %struct.__va_list_tag* %2) #1
  %5 = call i32 @puts(i8* %1) #1
  call void @llvm.va_end(i8* %3)
  call void @llvm.lifetime.end(i64 256, i8* %1) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #1

; Function Attrs: nounwind
declare i32 @vsnprintf(i8* nocapture, i64, i8* nocapture readonly, %struct.__va_list_tag*) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = add nsw i32 %argc, -1
  %2 = sext i32 %1 to i64
  %3 = add nsw i32 %argc, 4194303
  %4 = sext i32 %3 to i64
  %5 = srem i64 %2, 3
  %6 = icmp eq i64 %5, 2
  %7 = zext i1 %6 to i64
  %. = shl nsw i64 %4, %7
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 %2, i64 %.)
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 %2, i64 %2)
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 %., i64 %2)
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 %., i64 %.)
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 8388608, i64 140737488355328)
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 2048, i64 5123724185436160)
  tail call void (i8*, ...)* @printy(i8* getelementptr inbounds ([14 x i8]* @.str, i64 0, i64 0), i64 624958924630, i64 1812759625249959101)
  ret i32 0
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
