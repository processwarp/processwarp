; ModuleID = 'test_uname.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.utsname = type { [65 x i8], [65 x i8], [65 x i8], [65 x i8], [65 x i8], [65 x i8] }

@.str = private unnamed_addr constant [9 x i8] c"ret: %d\0A\00", align 1
@.str1 = private unnamed_addr constant [13 x i8] c"sysname: %s\0A\00", align 1
@.str2 = private unnamed_addr constant [14 x i8] c"nodename: %s\0A\00", align 1
@.str3 = private unnamed_addr constant [13 x i8] c"release: %s\0A\00", align 1
@.str4 = private unnamed_addr constant [13 x i8] c"version: %s\0A\00", align 1
@.str5 = private unnamed_addr constant [13 x i8] c"machine: %s\0A\00", align 1
@.str6 = private unnamed_addr constant [13 x i8] c"invalid: %d\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %u = alloca %struct.utsname, align 1
  %1 = getelementptr inbounds %struct.utsname* %u, i64 0, i32 0, i64 0
  call void @llvm.lifetime.start(i64 390, i8* %1) #1
  %2 = call i32 @uname(%struct.utsname* %u) #1
  %3 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0), i32 %2) #1
  %4 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str1, i64 0, i64 0), i8* %1) #1
  %5 = getelementptr inbounds %struct.utsname* %u, i64 0, i32 1, i64 0
  %6 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([14 x i8]* @.str2, i64 0, i64 0), i8* %5) #1
  %7 = getelementptr inbounds %struct.utsname* %u, i64 0, i32 2, i64 0
  %8 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str3, i64 0, i64 0), i8* %7) #1
  %9 = getelementptr inbounds %struct.utsname* %u, i64 0, i32 3, i64 0
  %10 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str4, i64 0, i64 0), i8* %9) #1
  %11 = getelementptr inbounds %struct.utsname* %u, i64 0, i32 4, i64 0
  %12 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str5, i64 0, i64 0), i8* %11) #1
  %13 = call i32 @uname(%struct.utsname* null) #1
  %14 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([13 x i8]* @.str6, i64 0, i64 0), i32 %13) #1
  call void @llvm.lifetime.end(i64 390, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare i32 @uname(%struct.utsname* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
