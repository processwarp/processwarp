; ModuleID = 'hellopp1.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%class.Hello = type { i8 }

@.str = private unnamed_addr constant [14 x i8] c"hello world!\0A\00", align 1
@str = private unnamed_addr constant [13 x i8] c"hello world!\00"

; Function Attrs: nounwind ssp uwtable
define i32 @main(i32 %argc, i8** nocapture readnone %argv) #0 {
  %hello = alloca %class.Hello, align 1
  call void @_ZN5Hello5helloEv(%class.Hello* %hello)
  ret i32 0
}

; Function Attrs: nounwind ssp uwtable
define linkonce_odr void @_ZN5Hello5helloEv(%class.Hello* nocapture readnone %this) #0 align 2 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([13 x i8]* @str, i64 0, i64 0))
  ret void
}

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.54) (based on LLVM 3.5svn)"}
