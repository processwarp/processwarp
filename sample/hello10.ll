; ModuleID = 'hello10.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

@.str1 = private unnamed_addr constant [17 x i8] c"hello world %s.\0A\00", align 1
@.str2 = private unnamed_addr constant [12 x i8] c"hello.(%d)\0A\00", align 1
@.str3 = private unnamed_addr constant [6 x i8] c"joker\00", align 1
@str = private unnamed_addr constant [13 x i8] c"hello world.\00"

; Function Attrs: nounwind ssp uwtable
define void @hello() #0 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind ssp uwtable
define i32 @hello_name(i8* %name) #0 {
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str1, i64 0, i64 0), i8* %name) #2
  ret i32 %1
}

; Function Attrs: nounwind ssp uwtable
define i32 @hello_num(i32 %times) #0 {
  %1 = icmp sgt i32 %times, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %i.01 = phi i32 [ %3, %.lr.ph ], [ 0, %0 ]
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str2, i64 0, i64 0), i32 %i.01) #2
  %3 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %3, %times
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  %i.0.lcssa = phi i32 [ 0, %0 ], [ %times, %.lr.ph ]
  ret i32 %i.0.lcssa
}

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @str, i64 0, i64 0)) #2
  %1 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([17 x i8]* @.str1, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str3, i64 0, i64 0)) #2
  %2 = sdiv i32 %1, 3
  %3 = icmp sgt i32 %1, 2
  br i1 %3, label %.lr.ph.i, label %hello_num.exit

.lr.ph.i:                                         ; preds = %.lr.ph.i, %0
  %i.01.i = phi i32 [ %5, %.lr.ph.i ], [ 0, %0 ]
  %4 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([12 x i8]* @.str2, i64 0, i64 0), i32 %i.01.i) #2
  %5 = add nsw i32 %i.01.i, 1
  %exitcond.i = icmp eq i32 %5, %2
  br i1 %exitcond.i, label %hello_num.exit, label %.lr.ph.i

hello_num.exit:                                   ; preds = %.lr.ph.i, %0
  %i.0.lcssa.i = phi i32 [ 0, %0 ], [ %2, %.lr.ph.i ]
  ret i32 %i.0.lcssa.i
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #2

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
