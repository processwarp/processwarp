; ModuleID = 'test_exceptions_typed.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%class.ExFoo = type { i32 }
%class.ExBar = type { i32 }
%class.ExQuux = type { i32 }
%class.ExChild = type { %class.ExQuux }

@ExFooInstance = global %class.ExFoo zeroinitializer, align 4
@__dso_handle = external unnamed_addr global i8
@ExBarInstance = global %class.ExBar zeroinitializer, align 4
@ExQuuxInstance = global %class.ExQuux zeroinitializer, align 4
@ExChildInstance = global %class.ExChild zeroinitializer, align 4
@_ZTVN10__cxxabiv117__class_type_infoE = external global i8*
@_ZTS6ExQuux = linkonce_odr constant [8 x i8] c"6ExQuux\00"
@_ZTI6ExQuux = linkonce_odr unnamed_addr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([8 x i8]* @_ZTS6ExQuux, i32 0, i32 0) }
@_ZTS5ExBar = linkonce_odr constant [7 x i8] c"5ExBar\00"
@_ZTI5ExBar = linkonce_odr unnamed_addr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([7 x i8]* @_ZTS5ExBar, i32 0, i32 0) }
@_ZTS5ExFoo = linkonce_odr constant [7 x i8] c"5ExFoo\00"
@_ZTI5ExFoo = linkonce_odr unnamed_addr constant { i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv117__class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([7 x i8]* @_ZTS5ExFoo, i32 0, i32 0) }
@_ZTVN10__cxxabiv119__pointer_type_infoE = external global i8*
@_ZTSP6ExQuux = linkonce_odr constant [9 x i8] c"P6ExQuux\00"
@_ZTIP6ExQuux = linkonce_odr unnamed_addr constant { i8*, i8*, i32, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv119__pointer_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([9 x i8]* @_ZTSP6ExQuux, i32 0, i32 0), i32 0, i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*) }
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global i8*
@_ZTS7ExChild = linkonce_odr constant [9 x i8] c"7ExChild\00"
@_ZTI7ExChild = linkonce_odr unnamed_addr constant { i8*, i8*, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([9 x i8]* @_ZTS7ExChild, i32 0, i32 0), i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*) }
@_ZTSP7ExChild = linkonce_odr constant [10 x i8] c"P7ExChild\00"
@_ZTIP7ExChild = linkonce_odr unnamed_addr constant { i8*, i8*, i32, i8* } { i8* bitcast (i8** getelementptr inbounds (i8** @_ZTVN10__cxxabiv119__pointer_type_infoE, i64 2) to i8*), i8* getelementptr inbounds ([10 x i8]* @_ZTSP7ExChild, i32 0, i32 0), i32 0, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI7ExChild to i8*) }
@_ZTIi = external constant i8*
@_ZTIPv = external constant i8*
@.str12 = private unnamed_addr constant [20 x i8] c"inner re-throw: %d\0A\00", align 1
@.str13 = private unnamed_addr constant [22 x i8] c"inner catch quux: %d\0A\00", align 1
@.str15 = private unnamed_addr constant [9 x i8] c"test %d\0A\00", align 1
@.str17 = private unnamed_addr constant [21 x i8] c"outer catch int: %d\0A\00", align 1
@.str18 = private unnamed_addr constant [26 x i8] c"outer catch quux-ptr: %d\0A\00", align 1
@.str19 = private unnamed_addr constant [26 x i8] c"outer catch quux-ref: %d\0A\00", align 1
@.str20 = private unnamed_addr constant [25 x i8] c"outer catch bar-ref: %d\0A\00", align 1
@.str21 = private unnamed_addr constant [21 x i8] c"outer catch foo: %d\0A\00", align 1
@.str25 = private unnamed_addr constant [25 x i8] c"*DESTROYING A QUUX (%d)\0A\00", align 1
@.str30 = private unnamed_addr constant [26 x i8] c"*DESTROYING A CHILD (%d)\0A\00", align 1
@.str32 = private unnamed_addr constant [24 x i8] c"*DESTROYING A BAR (%d)\0A\00", align 1
@.str34 = private unnamed_addr constant [24 x i8] c"*DESTROYING A FOO (%d)\0A\00", align 1
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]
@str = private unnamed_addr constant [16 x i8] c"*CREATING A FOO\00"
@str36 = private unnamed_addr constant [16 x i8] c"*CREATING A BAR\00"
@str37 = private unnamed_addr constant [17 x i8] c"*CREATING A QUUX\00"
@str38 = private unnamed_addr constant [15 x i8] c"*COPYING A FOO\00"
@str39 = private unnamed_addr constant [15 x i8] c"*COPYING A BAR\00"
@str40 = private unnamed_addr constant [16 x i8] c"*COPYING A QUUX\00"
@str41 = private unnamed_addr constant [8 x i8] c"start\0A\0A\00"
@str42 = private unnamed_addr constant [4 x i8] c"end\00"
@str43 = private unnamed_addr constant [2 x i8] c"\0A\00"
@str44 = private unnamed_addr constant [18 x i8] c"*CREATING A CHILD\00"
@str45 = private unnamed_addr constant [15 x i8] c"*COPYING CHILD\00"
@str46 = private unnamed_addr constant [15 x i8] c"  not throwing\00"
@str47 = private unnamed_addr constant [16 x i8] c"  throwing NULL\00"
@str48 = private unnamed_addr constant [14 x i8] c"  throwing 42\00"
@str49 = private unnamed_addr constant [31 x i8] c"  throwing ExChildInstance ptr\00"
@str50 = private unnamed_addr constant [27 x i8] c"  throwing ExChildInstance\00"
@str51 = private unnamed_addr constant [22 x i8] c"  throwing ExQuux ptr\00"
@str52 = private unnamed_addr constant [26 x i8] c"  throwing ExQuuxInstance\00"
@str53 = private unnamed_addr constant [25 x i8] c"  throwing ExBarInstance\00"
@str54 = private unnamed_addr constant [25 x i8] c"  throwing ExFooInstance\00"
@str55 = private unnamed_addr constant [16 x i8] c"outer catch-all\00"

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN5ExFooD2Ev(%class.ExFoo* nocapture readonly %this) unnamed_addr #0 align 2 {
  %1 = getelementptr inbounds %class.ExFoo* %this, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !1
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str34, i64 0, i64 0), i32 %2)
  ret void
}

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN5ExBarD2Ev(%class.ExBar* nocapture readonly %this) unnamed_addr #0 align 2 {
  %1 = getelementptr inbounds %class.ExBar* %this, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !6
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str32, i64 0, i64 0), i32 %2)
  ret void
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN6ExQuuxD2Ev(%class.ExQuux* nocapture readonly %this) unnamed_addr #0 align 2 {
  %1 = getelementptr inbounds %class.ExQuux* %this, i64 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !8
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str25, i64 0, i64 0), i32 %2)
  ret void
}

; Function Attrs: nounwind uwtable
define linkonce_odr void @_ZN7ExChildD2Ev(%class.ExChild* nocapture readonly %this) unnamed_addr #0 align 2 {
  %1 = getelementptr inbounds %class.ExChild* %this, i64 0, i32 0, i32 0
  %2 = load i32* %1, align 4, !tbaa !8
  %3 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str30, i64 0, i64 0), i32 %2)
  %4 = load i32* %1, align 4, !tbaa !8
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str25, i64 0, i64 0), i32 %4) #1
  ret void
}

; Function Attrs: uwtable
define void @_Z5magici(i32 %which) #2 {
  switch i32 %which, label %33 [
    i32 0, label %1
    i32 1, label %5
    i32 2, label %9
    i32 3, label %13
    i32 4, label %16
    i32 5, label %43
    i32 6, label %46
    i32 7, label %49
    i32 8, label %52
  ]

; <label>:1                                       ; preds = %0
  %puts15 = tail call i32 @puts(i8* getelementptr inbounds ([25 x i8]* @str54, i64 0, i64 0))
  %2 = tail call i8* @__cxa_allocate_exception(i64 4) #1
  %3 = load i32* getelementptr inbounds (%class.ExFoo* @ExFooInstance, i64 0, i32 0), align 4, !tbaa !1
  %4 = bitcast i8* %2 to i32*
  store i32 %3, i32* %4, align 4, !tbaa !1
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @str38, i64 0, i64 0)) #1
  invoke void @__cxa_throw(i8* %2, i8* bitcast ({ i8*, i8* }* @_ZTI5ExFoo to i8*), i8* bitcast (void (%class.ExFoo*)* @_ZN5ExFooD2Ev to i8*)) #6
          to label %64 unwind label %20

; <label>:5                                       ; preds = %0
  %puts14 = tail call i32 @puts(i8* getelementptr inbounds ([25 x i8]* @str53, i64 0, i64 0))
  %6 = tail call i8* @__cxa_allocate_exception(i64 4) #1
  %7 = load i32* getelementptr inbounds (%class.ExBar* @ExBarInstance, i64 0, i32 0), align 4, !tbaa !6
  %8 = bitcast i8* %6 to i32*
  store i32 %7, i32* %8, align 4, !tbaa !6
  %puts.i3 = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @str39, i64 0, i64 0)) #1
  invoke void @__cxa_throw(i8* %6, i8* bitcast ({ i8*, i8* }* @_ZTI5ExBar to i8*), i8* bitcast (void (%class.ExBar*)* @_ZN5ExBarD2Ev to i8*)) #6
          to label %64 unwind label %20

; <label>:9                                       ; preds = %0
  %puts13 = tail call i32 @puts(i8* getelementptr inbounds ([26 x i8]* @str52, i64 0, i64 0))
  %10 = tail call i8* @__cxa_allocate_exception(i64 4) #1
  %11 = load i32* getelementptr inbounds (%class.ExQuux* @ExQuuxInstance, i64 0, i32 0), align 4, !tbaa !8
  %12 = bitcast i8* %10 to i32*
  store i32 %11, i32* %12, align 4, !tbaa !8
  %puts.i4 = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str40, i64 0, i64 0)) #1
  invoke void @__cxa_throw(i8* %10, i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*), i8* bitcast (void (%class.ExQuux*)* @_ZN6ExQuuxD2Ev to i8*)) #6
          to label %64 unwind label %20

; <label>:13                                      ; preds = %0
  %puts12 = tail call i32 @puts(i8* getelementptr inbounds ([22 x i8]* @str51, i64 0, i64 0))
  %14 = tail call i8* @__cxa_allocate_exception(i64 8) #1
  %15 = bitcast i8* %14 to %class.ExQuux**
  store %class.ExQuux* @ExQuuxInstance, %class.ExQuux** %15, align 8, !tbaa !10
  invoke void @__cxa_throw(i8* %14, i8* bitcast ({ i8*, i8*, i32, i8* }* @_ZTIP6ExQuux to i8*), i8* null) #6
          to label %64 unwind label %20

; <label>:16                                      ; preds = %0
  %puts11 = tail call i32 @puts(i8* getelementptr inbounds ([27 x i8]* @str50, i64 0, i64 0))
  %17 = tail call i8* @__cxa_allocate_exception(i64 4) #1
  %18 = bitcast i8* %17 to i32*
  %puts.i.i = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8]* @str37, i64 0, i64 0)) #1
  %19 = load i32* getelementptr inbounds (%class.ExChild* @ExChildInstance, i64 0, i32 0, i32 0), align 4, !tbaa !8
  store i32 %19, i32* %18, align 4, !tbaa !8
  %puts.i5 = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @str45, i64 0, i64 0)) #1
  invoke void @__cxa_throw(i8* %17, i8* bitcast ({ i8*, i8*, i8* }* @_ZTI7ExChild to i8*), i8* bitcast (void (%class.ExChild*)* @_ZN7ExChildD2Ev to i8*)) #6
          to label %64 unwind label %20

; <label>:20                                      ; preds = %49, %46, %43, %16, %13, %9, %5, %1
  %21 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*)
          catch i8* bitcast ({ i8*, i8* }* @_ZTI5ExBar to i8*)
  %22 = extractvalue { i8*, i32 } %21, 0
  %23 = extractvalue { i8*, i32 } %21, 1
  %24 = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*)) #1
  %25 = icmp eq i32 %23, %24
  br i1 %25, label %26, label %34

; <label>:26                                      ; preds = %20
  %27 = tail call i8* @__cxa_get_exception_ptr(i8* %22) #1
  %28 = bitcast i8* %27 to i32*
  %29 = load i32* %28, align 4, !tbaa !8
  %puts.i6 = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str40, i64 0, i64 0)) #1
  %30 = tail call i8* @__cxa_begin_catch(i8* %22) #1
  %31 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([22 x i8]* @.str13, i64 0, i64 0), i32 %29)
  %32 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str25, i64 0, i64 0), i32 %29) #1
  tail call void @__cxa_end_catch()
  br label %33

; <label>:33                                      ; preds = %52, %26, %0
  ret void

; <label>:34                                      ; preds = %20
  %35 = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8* }* @_ZTI5ExBar to i8*)) #1
  %36 = icmp eq i32 %23, %35
  br i1 %36, label %37, label %58

; <label>:37                                      ; preds = %34
  %38 = tail call i8* @__cxa_get_exception_ptr(i8* %22) #1
  %39 = bitcast i8* %38 to i32*
  %40 = load i32* %39, align 4, !tbaa !6
  %puts.i7 = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @str39, i64 0, i64 0)) #1
  %41 = tail call i8* @__cxa_begin_catch(i8* %22) #1
  %42 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([20 x i8]* @.str12, i64 0, i64 0), i32 %40)
  invoke void @__cxa_rethrow() #6
          to label %64 unwind label %53

; <label>:43                                      ; preds = %0
  %puts10 = tail call i32 @puts(i8* getelementptr inbounds ([31 x i8]* @str49, i64 0, i64 0))
  %44 = tail call i8* @__cxa_allocate_exception(i64 8) #1
  %45 = bitcast i8* %44 to %class.ExChild**
  store %class.ExChild* @ExChildInstance, %class.ExChild** %45, align 8, !tbaa !10
  invoke void @__cxa_throw(i8* %44, i8* bitcast ({ i8*, i8*, i32, i8* }* @_ZTIP7ExChild to i8*), i8* null) #6
          to label %64 unwind label %20

; <label>:46                                      ; preds = %0
  %puts9 = tail call i32 @puts(i8* getelementptr inbounds ([14 x i8]* @str48, i64 0, i64 0))
  %47 = tail call i8* @__cxa_allocate_exception(i64 4) #1
  %48 = bitcast i8* %47 to i32*
  store i32 42, i32* %48, align 4, !tbaa !12
  invoke void @__cxa_throw(i8* %47, i8* bitcast (i8** @_ZTIi to i8*), i8* null) #6
          to label %64 unwind label %20

; <label>:49                                      ; preds = %0
  %puts8 = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str47, i64 0, i64 0))
  %50 = tail call i8* @__cxa_allocate_exception(i64 8) #1
  %51 = bitcast i8* %50 to i8**
  store i8* null, i8** %51, align 8, !tbaa !10
  invoke void @__cxa_throw(i8* %50, i8* bitcast (i8** @_ZTIPv to i8*), i8* null) #6
          to label %64 unwind label %20

; <label>:52                                      ; preds = %0
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @str46, i64 0, i64 0))
  br label %33

; <label>:53                                      ; preds = %37
  %54 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %55 = extractvalue { i8*, i32 } %54, 0
  %56 = extractvalue { i8*, i32 } %54, 1
  %57 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str32, i64 0, i64 0), i32 %40) #1
  invoke void @__cxa_end_catch()
          to label %58 unwind label %61

; <label>:58                                      ; preds = %53, %34
  %.12 = phi i8* [ %55, %53 ], [ %22, %34 ]
  %.1 = phi i32 [ %56, %53 ], [ %23, %34 ]
  %59 = insertvalue { i8*, i32 } undef, i8* %.12, 0
  %60 = insertvalue { i8*, i32 } %59, i32 %.1, 1
  resume { i8*, i32 } %60

; <label>:61                                      ; preds = %53
  %62 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %63 = extractvalue { i8*, i32 } %62, 0
  tail call void @__clang_call_terminate(i8* %63) #7
  unreachable

; <label>:64                                      ; preds = %49, %46, %43, %37, %16, %13, %9, %5, %1
  unreachable
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #3

declare i32 @__gxx_personality_v0(...)

declare i8* @__cxa_allocate_exception(i64)

declare void @__cxa_throw(i8*, i8*, i8*)

; Function Attrs: nounwind readnone
declare i32 @llvm.eh.typeid.for(i8*) #4

declare i8* @__cxa_get_exception_ptr(i8*)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #5 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #7
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare void @__cxa_rethrow()

declare void @__cxa_end_catch()

; Function Attrs: uwtable
define i32 @main() #2 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([8 x i8]* @str41, i64 0, i64 0))
  br label %1

; <label>:1                                       ; preds = %16, %0
  %i.05 = phi i32 [ 0, %0 ], [ %17, %16 ]
  %2 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([9 x i8]* @.str15, i64 0, i64 0), i32 %i.05)
  invoke void @_Z5magici(i32 %i.05)
          to label %16 unwind label %3

; <label>:3                                       ; preds = %1
  %4 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* bitcast ({ i8*, i8* }* @_ZTI5ExFoo to i8*)
          catch i8* bitcast ({ i8*, i8* }* @_ZTI5ExBar to i8*)
          catch i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*)
          catch i8* bitcast ({ i8*, i8*, i32, i8* }* @_ZTIP6ExQuux to i8*)
          catch i8* bitcast (i8** @_ZTIi to i8*)
          catch i8* null
  %5 = extractvalue { i8*, i32 } %4, 0
  %6 = extractvalue { i8*, i32 } %4, 1
  %7 = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8* }* @_ZTI5ExFoo to i8*)) #1
  %8 = icmp eq i32 %6, %7
  br i1 %8, label %9, label %18

; <label>:9                                       ; preds = %3
  %10 = tail call i8* @__cxa_get_exception_ptr(i8* %5) #1
  %11 = bitcast i8* %10 to i32*
  %12 = load i32* %11, align 4, !tbaa !1
  %puts.i = tail call i32 @puts(i8* getelementptr inbounds ([15 x i8]* @str38, i64 0, i64 0)) #1
  %13 = tail call i8* @__cxa_begin_catch(i8* %5) #1
  %14 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str21, i64 0, i64 0), i32 %12)
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([24 x i8]* @.str34, i64 0, i64 0), i32 %12) #1
  tail call void @__cxa_end_catch()
  br label %16

; <label>:16                                      ; preds = %50, %46, %37, %29, %21, %9, %1
  %puts3 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str43, i64 0, i64 0))
  %17 = add nsw i32 %i.05, 1
  %exitcond = icmp eq i32 %17, 9
  br i1 %exitcond, label %51, label %1

; <label>:18                                      ; preds = %3
  %19 = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8* }* @_ZTI5ExBar to i8*)) #1
  %20 = icmp eq i32 %6, %19
  br i1 %20, label %21, label %26

; <label>:21                                      ; preds = %18
  %22 = tail call i8* @__cxa_begin_catch(i8* %5) #1
  %23 = bitcast i8* %22 to i32*
  %24 = load i32* %23, align 4, !tbaa !6
  %25 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([25 x i8]* @.str20, i64 0, i64 0), i32 %24)
  tail call void @__cxa_end_catch()
  br label %16

; <label>:26                                      ; preds = %18
  %27 = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8* }* @_ZTI6ExQuux to i8*)) #1
  %28 = icmp eq i32 %6, %27
  br i1 %28, label %29, label %34

; <label>:29                                      ; preds = %26
  %30 = tail call i8* @__cxa_begin_catch(i8* %5) #1
  %31 = bitcast i8* %30 to i32*
  %32 = load i32* %31, align 4, !tbaa !8
  %33 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str19, i64 0, i64 0), i32 %32)
  tail call void @__cxa_end_catch()
  br label %16

; <label>:34                                      ; preds = %26
  %35 = tail call i32 @llvm.eh.typeid.for(i8* bitcast ({ i8*, i8*, i32, i8* }* @_ZTIP6ExQuux to i8*)) #1
  %36 = icmp eq i32 %6, %35
  br i1 %36, label %37, label %42

; <label>:37                                      ; preds = %34
  %38 = tail call i8* @__cxa_begin_catch(i8* %5) #1
  %39 = bitcast i8* %38 to i32*
  %40 = load i32* %39, align 4, !tbaa !8
  %41 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([26 x i8]* @.str18, i64 0, i64 0), i32 %40)
  tail call void @__cxa_end_catch() #1
  br label %16

; <label>:42                                      ; preds = %34
  %43 = tail call i32 @llvm.eh.typeid.for(i8* bitcast (i8** @_ZTIi to i8*)) #1
  %44 = icmp eq i32 %6, %43
  %45 = tail call i8* @__cxa_begin_catch(i8* %5) #1
  br i1 %44, label %46, label %50

; <label>:46                                      ; preds = %42
  %47 = bitcast i8* %45 to i32*
  %48 = load i32* %47, align 4, !tbaa !12
  %49 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([21 x i8]* @.str17, i64 0, i64 0), i32 %48)
  tail call void @__cxa_end_catch() #1
  br label %16

; <label>:50                                      ; preds = %42
  %puts4 = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str55, i64 0, i64 0))
  tail call void @__cxa_end_catch()
  br label %16

; <label>:51                                      ; preds = %16
  %puts2 = tail call i32 @puts(i8* getelementptr inbounds ([4 x i8]* @str42, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
define internal void @_GLOBAL__I_a() #1 section ".text.startup" {
  store i32 11, i32* getelementptr inbounds (%class.ExFoo* @ExFooInstance, i64 0, i32 0), align 4, !tbaa !1
  %puts.i.i = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str, i64 0, i64 0)) #1
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%class.ExFoo*)* @_ZN5ExFooD2Ev to void (i8*)*), i8* bitcast (%class.ExFoo* @ExFooInstance to i8*), i8* @__dso_handle) #1
  store i32 22, i32* getelementptr inbounds (%class.ExBar* @ExBarInstance, i64 0, i32 0), align 4, !tbaa !6
  %puts.i.i1 = tail call i32 @puts(i8* getelementptr inbounds ([16 x i8]* @str36, i64 0, i64 0)) #1
  %2 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%class.ExBar*)* @_ZN5ExBarD2Ev to void (i8*)*), i8* bitcast (%class.ExBar* @ExBarInstance to i8*), i8* @__dso_handle) #1
  store i32 33, i32* getelementptr inbounds (%class.ExQuux* @ExQuuxInstance, i64 0, i32 0), align 4, !tbaa !8
  %puts.i.i2 = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8]* @str37, i64 0, i64 0)) #1
  %3 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%class.ExQuux*)* @_ZN6ExQuuxD2Ev to void (i8*)*), i8* bitcast (%class.ExQuux* @ExQuuxInstance to i8*), i8* @__dso_handle) #1
  store i32 44, i32* getelementptr inbounds (%class.ExChild* @ExChildInstance, i64 0, i32 0, i32 0), align 4, !tbaa !8
  %puts.i.i.i = tail call i32 @puts(i8* getelementptr inbounds ([17 x i8]* @str37, i64 0, i64 0)) #1
  %puts.i.i3 = tail call i32 @puts(i8* getelementptr inbounds ([18 x i8]* @str44, i64 0, i64 0)) #1
  %4 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%class.ExChild*)* @_ZN7ExChildD2Ev to void (i8*)*), i8* bitcast (%class.ExChild* @ExChildInstance to i8*), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone }
attributes #5 = { noinline noreturn nounwind }
attributes #6 = { noreturn }
attributes #7 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !3, i64 0}
!2 = metadata !{metadata !"_ZTS5ExFoo", metadata !3, i64 0}
!3 = metadata !{metadata !"int", metadata !4, i64 0}
!4 = metadata !{metadata !"omnipotent char", metadata !5, i64 0}
!5 = metadata !{metadata !"Simple C/C++ TBAA"}
!6 = metadata !{metadata !7, metadata !3, i64 0}
!7 = metadata !{metadata !"_ZTS5ExBar", metadata !3, i64 0}
!8 = metadata !{metadata !9, metadata !3, i64 0}
!9 = metadata !{metadata !"_ZTS6ExQuux", metadata !3, i64 0}
!10 = metadata !{metadata !11, metadata !11, i64 0}
!11 = metadata !{metadata !"any pointer", metadata !4, i64 0}
!12 = metadata !{metadata !3, metadata !3, i64 0}
