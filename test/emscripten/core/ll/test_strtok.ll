; ModuleID = 'test_strtok.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"\5C/:;=-\00", align 1
@.str1 = private unnamed_addr constant [49 x i8] c"This;is.a:test:of=the/string\5Ctokenizer-function.\00", align 1
@.str2 = private unnamed_addr constant [20 x i8] c"blah:blat:blab:blag\00", align 1
@.str3 = private unnamed_addr constant [10 x i8] c"at %s:%s\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  %test = alloca [80 x i8], align 16
  %blah = alloca [80 x i8], align 16
  %brkt = alloca i8*, align 8
  %brkb = alloca i8*, align 8
  %1 = getelementptr inbounds [80 x i8]* %test, i64 0, i64 0
  call void @llvm.lifetime.start(i64 80, i8* %1) #1
  %2 = getelementptr inbounds [80 x i8]* %blah, i64 0, i64 0
  call void @llvm.lifetime.start(i64 80, i8* %2) #1
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* getelementptr inbounds ([49 x i8]* @.str1, i64 0, i64 0), i64 49, i32 1, i1 false)
  %3 = call i8* @__strtok_r(i8* %1, i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8** %brkt) #1
  %4 = icmp eq i8* %3, null
  br i1 %4, label %._crit_edge5, label %.lr.ph4

.lr.ph4:                                          ; preds = %._crit_edge, %0
  %word.02 = phi i8* [ %10, %._crit_edge ], [ %3, %0 ]
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* getelementptr inbounds ([20 x i8]* @.str2, i64 0, i64 0), i64 20, i32 1, i1 false)
  %5 = call i8* @__strtok_r(i8* %2, i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8** %brkb) #1
  %6 = icmp eq i8* %5, null
  br i1 %6, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %.lr.ph, %.lr.ph4
  %phrase.01 = phi i8* [ %8, %.lr.ph ], [ %5, %.lr.ph4 ]
  %7 = call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str3, i64 0, i64 0), i8* %word.02, i8* %phrase.01) #1
  %8 = call i8* @__strtok_r(i8* null, i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8** %brkb) #1
  %9 = icmp eq i8* %8, null
  br i1 %9, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %.lr.ph4
  %10 = call i8* @__strtok_r(i8* null, i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), i8** %brkt) #1
  %11 = icmp eq i8* %10, null
  br i1 %11, label %._crit_edge5, label %.lr.ph4

._crit_edge5:                                     ; preds = %._crit_edge, %0
  call void @llvm.lifetime.end(i64 80, i8* %2) #1
  call void @llvm.lifetime.end(i64 80, i8* %1) #1
  ret i32 0
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare i8* @__strtok_r(i8*, i8* nocapture readonly, i8**) #2

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
