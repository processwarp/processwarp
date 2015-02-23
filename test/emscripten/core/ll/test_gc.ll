; ModuleID = 'test_gc.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [30 x i8] c"finalizing %d (global == %d)\0A\00", align 1
@global = common global i8* null, align 8
@.str1 = private unnamed_addr constant [31 x i8] c"finalizing2 %d (global == %d)\0A\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"alloc %p\0A\00", align 1
@.str3 = private unnamed_addr constant [81 x i8] c"(char *)local - (char *)global >= 1024 || (char *)global - (char *)local >= 1024\00", align 1
@.str4 = private unnamed_addr constant [10 x i8] c"test_gc.c\00", align 1
@__PRETTY_FUNCTION__.main = private unnamed_addr constant [11 x i8] c"int main()\00", align 1
@.str7 = private unnamed_addr constant [16 x i8] c"heap size = %d\0A\00", align 1
@str = private unnamed_addr constant [11 x i8] c"basic test\00"
@str11 = private unnamed_addr constant [22 x i8] c"object scan test test\00"
@str13 = private unnamed_addr constant [2 x i8] c"*\00"
@str14 = private unnamed_addr constant [2 x i8] c".\00"

; Function Attrs: nounwind uwtable
define void @finalizer(i8* readnone %ptr, i8* %arg) #0 {
  %1 = ptrtoint i8* %arg to i64
  %2 = trunc i64 %1 to i32
  %3 = load i8** @global, align 8, !tbaa !1
  %4 = icmp eq i8* %3, %ptr
  %5 = zext i1 %4 to i32
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([30 x i8]* @.str, i64 0, i64 0), i32 %2, i32 %5) #4
  ret void
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #1

; Function Attrs: nounwind uwtable
define void @finalizer2(i8* readnone %ptr, i8* %arg) #0 {
  %1 = ptrtoint i8* %arg to i64
  %2 = trunc i64 %1 to i32
  %3 = load i8** @global, align 8, !tbaa !1
  %4 = icmp eq i8* %3, %ptr
  %5 = zext i1 %4 to i32
  %6 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([31 x i8]* @.str1, i64 0, i64 0), i32 %2, i32 %5) #4
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
  tail call void @GC_init() #4
  %1 = tail call noalias i8* @GC_malloc(i64 1024) #4
  store i8* %1, i8** @global, align 8, !tbaa !1
  tail call void @GC_register_finalizer_no_order(i8* %1, void (i8*, i8*)* @finalizer, i8* null, void (i8*, i8*)** null, i8** null) #4
  %2 = load i8** @global, align 8, !tbaa !1
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i8* %2) #4
  %4 = tail call noalias i8* @GC_malloc(i64 1024) #4
  tail call void @GC_register_finalizer_no_order(i8* %4, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 1 to i8*), void (i8*, i8*)** null, i8** null) #4
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i8* %4) #4
  %6 = load i8** @global, align 8, !tbaa !1
  %7 = ptrtoint i8* %4 to i64
  %8 = ptrtoint i8* %6 to i64
  %9 = sub i64 %7, %8
  %10 = icmp sgt i64 %9, 1023
  %11 = sub i64 %8, %7
  %12 = icmp sgt i64 %11, 1023
  %or.cond = or i1 %10, %12
  br i1 %or.cond, label %14, label %13

; <label>:13                                      ; preds = %0
  tail call void @__assert_fail(i8* getelementptr inbounds ([81 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([10 x i8]* @.str4, i64 0, i64 0), i32 31, i8* getelementptr inbounds ([11 x i8]* @__PRETTY_FUNCTION__.main, i64 0, i64 0)) #5
  unreachable

; <label>:14                                      ; preds = %0
  %15 = tail call noalias i8* @GC_malloc(i64 1024) #4
  %16 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i8* %15) #4
  %17 = tail call noalias i8* @GC_malloc(i64 1024) #4
  tail call void @GC_register_finalizer_no_order(i8* %17, void (i8*, i8*)* @finalizer2, i8* inttoptr (i64 2 to i8*), void (i8*, i8*)** null, i8** null) #4
  %18 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i8* %4) #4
  %19 = tail call noalias i8* @GC_malloc(i64 1024) #4
  tail call void @GC_register_finalizer_no_order(i8* %19, void (i8*, i8*)* @finalizer2, i8* inttoptr (i64 3 to i8*), void (i8*, i8*)** null, i8** null) #4
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), i8* %4) #4
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([11 x i8]* @str, i64 0, i64 0))
  %21 = tail call i32 (...)* @GC_FORCE_COLLECT() #4
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str13, i64 0, i64 0))
  %22 = load i8** @global, align 8, !tbaa !1
  tail call void @GC_free(i8* %22) #4
  %23 = tail call noalias i8* @GC_malloc(i64 12) #4
  store i8* %23, i8** @global, align 8, !tbaa !1
  tail call void @GC_register_finalizer_no_order(i8* %23, void (i8*, i8*)* @finalizer, i8* null, void (i8*, i8*)** null, i8** null) #4
  %24 = tail call noalias i8* @GC_malloc(i64 12) #4
  tail call void @GC_register_finalizer_no_order(i8* %24, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 1 to i8*), void (i8*, i8*)** null, i8** null) #4
  %25 = tail call noalias i8* @GC_malloc_atomic(i64 12) #4
  tail call void @GC_register_finalizer_no_order(i8* %25, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 2 to i8*), void (i8*, i8*)** null, i8** null) #4
  %26 = tail call noalias i8* @GC_malloc(i64 12) #4
  tail call void @GC_register_finalizer_no_order(i8* %26, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 3 to i8*), void (i8*, i8*)** null, i8** null) #4
  %27 = tail call noalias i8* @GC_malloc(i64 12) #4
  tail call void @GC_register_finalizer_no_order(i8* %27, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 4 to i8*), void (i8*, i8*)** null, i8** null) #4
  %28 = tail call noalias i8* @GC_malloc_uncollectable(i64 12) #4
  tail call void @GC_register_finalizer_no_order(i8* %28, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 5 to i8*), void (i8*, i8*)** null, i8** null) #4
  %29 = tail call i64 @GC_get_heap_size() #4
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str7, i64 0, i64 0), i64 %29) #4
  %31 = tail call i8* @GC_realloc(i8* %27, i64 24) #4
  %32 = tail call i64 @GC_get_heap_size() #4
  %33 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([16 x i8]* @.str7, i64 0, i64 0), i64 %32) #4
  %34 = tail call noalias i8* @GC_malloc(i64 12) #4
  tail call void @GC_register_finalizer_no_order(i8* %34, void (i8*, i8*)* @finalizer, i8* inttoptr (i64 6 to i8*), void (i8*, i8*)** null, i8** null) #4
  %35 = tail call i8* @GC_realloc(i8* %34, i64 0) #4
  %36 = load i8** @global, align 8, !tbaa !1
  %37 = bitcast i8* %36 to i8**
  store i8* %24, i8** %37, align 8, !tbaa !1
  %38 = getelementptr inbounds i8* %36, i64 8
  %39 = bitcast i8* %38 to i8**
  store i8* %25, i8** %39, align 8, !tbaa !1
  %40 = bitcast i8* %24 to i8**
  store i8* %26, i8** %40, align 8, !tbaa !1
  %41 = bitcast i8* %25 to i8**
  store i8* %31, i8** %41, align 8, !tbaa !1
  %puts2 = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8]* @str11, i64 0, i64 0))
  %42 = tail call i32 (...)* @GC_FORCE_COLLECT() #4
  %puts3 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str13, i64 0, i64 0))
  %43 = load i8** @global, align 8, !tbaa !1
  tail call void @GC_free(i8* %43) #4
  %puts4 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str13, i64 0, i64 0))
  %44 = tail call i32 (...)* @GC_FORCE_COLLECT() #4
  %puts5 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str14, i64 0, i64 0))
  store i8* null, i8** @global, align 8, !tbaa !1
  ret i32 0
}

declare void @GC_init() #2

declare noalias i8* @GC_malloc(i64) #2

declare void @GC_register_finalizer_no_order(i8*, void (i8*, i8*)*, i8*, void (i8*, i8*)**, i8**) #2

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #3

declare i32 @GC_FORCE_COLLECT(...) #2

declare void @GC_free(i8*) #2

declare noalias i8* @GC_malloc_atomic(i64) #2

declare noalias i8* @GC_malloc_uncollectable(i64) #2

declare i64 @GC_get_heap_size() #2

declare i8* @GC_realloc(i8*, i64) #2

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"any pointer", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
