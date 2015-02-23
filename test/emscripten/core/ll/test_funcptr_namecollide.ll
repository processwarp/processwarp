; ModuleID = 'test_funcptr_namecollide.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [9 x i8] c"delusion\00", align 1
@.str1 = private unnamed_addr constant [5 x i8] c"====\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"confusion\00", align 1
@.str3 = private unnamed_addr constant [10 x i8] c"waka waka\00", align 1

; Function Attrs: nounwind uwtable
define void @do_print(i8* %str) #0 {
  %1 = icmp eq i8* %str, null
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  tail call void @do_call(void (i8*)* null, i8* getelementptr inbounds ([9 x i8]* @.str, i64 0, i64 0))
  br label %3

; <label>:3                                       ; preds = %2, %0
  %4 = ptrtoint i8* %str to i64
  %5 = trunc i64 %4 to i32
  %6 = icmp eq i32 %5, -1
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %3
  %8 = getelementptr inbounds i8* %str, i64 10
  tail call void @do_print(i8* %8)
  br label %9

; <label>:9                                       ; preds = %7, %3
  %10 = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0)) #2
  %11 = tail call i32 @puts(i8* %str) #2
  %12 = tail call i32 @puts(i8* getelementptr inbounds ([5 x i8]* @.str1, i64 0, i64 0)) #2
  ret void
}

; Function Attrs: nounwind uwtable
define void @do_call(void (i8*)* nocapture %puts, i8* %str) #0 {
  %1 = icmp eq i8* %str, null
  br i1 %1, label %2, label %3

; <label>:2                                       ; preds = %0
  tail call void @do_print(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0))
  br label %3

; <label>:3                                       ; preds = %2, %0
  %4 = ptrtoint i8* %str to i64
  %5 = trunc i64 %4 to i32
  %6 = icmp eq i32 %5, -1
  br i1 %6, label %7, label %9

; <label>:7                                       ; preds = %3
  %8 = getelementptr inbounds i8* %str, i64 -10
  tail call void @do_call(void (i8*)* null, i8* %8)
  br label %9

; <label>:9                                       ; preds = %7, %3
  tail call void %puts(i8* %str) #2
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

; Function Attrs: nounwind uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %1 = icmp sgt i32 %argc, 0
  br i1 %1, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %0
  %i.01 = phi i32 [ %6, %.lr.ph ], [ 0, %0 ]
  %2 = icmp ne i32 %i.01, 10
  %3 = select i1 %2, void (i8*)* @do_print, void (i8*)* null
  %4 = icmp ne i32 %i.01, 15
  %5 = select i1 %4, i8* getelementptr inbounds ([10 x i8]* @.str3, i64 0, i64 0), i8* null
  tail call void @do_call(void (i8*)* %3, i8* %5)
  %6 = add nsw i32 %i.01, 1
  %exitcond = icmp eq i32 %6, %argc
  br i1 %exitcond, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %.lr.ph, %0
  ret i32 0
}

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
