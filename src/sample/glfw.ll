; ModuleID = 'glfw.bc'
target datalayout = "e-m:o-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx10.10.0"

%struct.__sFILE = type { i8*, i32, i32, i16, i16, %struct.__sbuf, i32, i8*, i32 (i8*)*, i32 (i8*, i8*, i32)*, i64 (i8*, i64, i32)*, i32 (i8*, i8*, i32)*, %struct.__sbuf, %struct.__sFILEX*, i32, [3 x i8], [1 x i8], %struct.__sbuf, i32, i64 }
%struct.__sFILEX = type opaque
%struct.__sbuf = type { i8*, i32 }
%struct.GLFWwindow = type opaque
%struct.GLFWmonitor = type opaque

@.str = private unnamed_addr constant [15 x i8] c"Simple example\00", align 1
@__stderrp = external global %struct.__sFILE*

; Function Attrs: noreturn nounwind ssp uwtable
define i32 @main() #0 {
  %width = alloca i32, align 4
  %height = alloca i32, align 4
  %1 = call void (i32, i8*)* (void (i32, i8*)*)* @glfwSetErrorCallback(void (i32, i8*)* @error_callback) #4
  %2 = call i32 @glfwInit() #4
  %3 = icmp eq i32 %2, 0
  br i1 %3, label %4, label %5

; <label>:4                                       ; preds = %0
  call void @exit(i32 1) #5
  unreachable

; <label>:5                                       ; preds = %0
  %6 = call %struct.GLFWwindow* @glfwCreateWindow(i32 640, i32 480, i8* getelementptr inbounds ([15 x i8]* @.str, i64 0, i64 0), %struct.GLFWmonitor* null, %struct.GLFWwindow* null) #4
  %7 = icmp eq %struct.GLFWwindow* %6, null
  br i1 %7, label %8, label %9

; <label>:8                                       ; preds = %5
  call void @glfwTerminate() #4
  call void @exit(i32 1) #5
  unreachable

; <label>:9                                       ; preds = %5
  call void @glfwMakeContextCurrent(%struct.GLFWwindow* %6) #4
  %10 = call void (%struct.GLFWwindow*, i32, i32, i32, i32)* (%struct.GLFWwindow*, void (%struct.GLFWwindow*, i32, i32, i32, i32)*)* @glfwSetKeyCallback(%struct.GLFWwindow* %6, void (%struct.GLFWwindow*, i32, i32, i32, i32)* @key_callback) #4
  %11 = call i32 @glfwWindowShouldClose(%struct.GLFWwindow* %6) #4
  %12 = icmp eq i32 %11, 0
  br i1 %12, label %.lr.ph, label %._crit_edge

.lr.ph:                                           ; preds = %.lr.ph, %9
  call void @glfwGetFramebufferSize(%struct.GLFWwindow* %6, i32* %width, i32* %height) #4
  %13 = load i32* %width, align 4, !tbaa !1
  %14 = sitofp i32 %13 to float
  %15 = load i32* %height, align 4, !tbaa !1
  %16 = sitofp i32 %15 to float
  %17 = fdiv float %14, %16
  call void @glViewport(i32 0, i32 0, i32 %13, i32 %15) #4
  call void @glClear(i32 16384) #4
  call void @glMatrixMode(i32 5889) #4
  call void @glLoadIdentity() #4
  %18 = fsub float -0.000000e+00, %17
  %19 = fpext float %18 to double
  %20 = fpext float %17 to double
  call void @glOrtho(double %19, double %20, double -1.000000e+00, double 1.000000e+00, double 1.000000e+00, double -1.000000e+00) #4
  call void @glMatrixMode(i32 5888) #4
  call void @glLoadIdentity() #4
  %21 = call double @glfwGetTime() #4
  %22 = fptrunc double %21 to float
  %23 = fmul float %22, 5.000000e+01
  call void @glRotatef(float %23, float 0.000000e+00, float 0.000000e+00, float 1.000000e+00) #4
  call void @glBegin(i32 4) #4
  call void @glColor3f(float 1.000000e+00, float 0.000000e+00, float 0.000000e+00) #4
  call void @glVertex3f(float 0xBFE3333340000000, float 0xBFD99999A0000000, float 0.000000e+00) #4
  call void @glColor3f(float 0.000000e+00, float 1.000000e+00, float 0.000000e+00) #4
  call void @glVertex3f(float 0x3FE3333340000000, float 0xBFD99999A0000000, float 0.000000e+00) #4
  call void @glColor3f(float 0.000000e+00, float 0.000000e+00, float 1.000000e+00) #4
  call void @glVertex3f(float 0.000000e+00, float 0x3FE3333340000000, float 0.000000e+00) #4
  call void @glEnd() #4
  call void @glfwSwapBuffers(%struct.GLFWwindow* %6) #4
  call void @glfwPollEvents() #4
  %24 = call i32 @glfwWindowShouldClose(%struct.GLFWwindow* %6) #4
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %.lr.ph, label %._crit_edge

._crit_edge:                                      ; preds = %.lr.ph, %9
  call void @glfwDestroyWindow(%struct.GLFWwindow* %6) #4
  call void @glfwTerminate() #4
  call void @exit(i32 0) #5
  unreachable
}

declare void (i32, i8*)* @glfwSetErrorCallback(void (i32, i8*)*) #1

; Function Attrs: nounwind ssp uwtable
define internal void @error_callback(i32 %error, i8* %description) #2 {
  %1 = load %struct.__sFILE** @__stderrp, align 8, !tbaa !5
  %2 = tail call i32 @"\01_fputs"(i8* %description, %struct.__sFILE* %1) #4
  ret void
}

declare i32 @glfwInit() #1

; Function Attrs: noreturn
declare void @exit(i32) #3

declare %struct.GLFWwindow* @glfwCreateWindow(i32, i32, i8*, %struct.GLFWmonitor*, %struct.GLFWwindow*) #1

declare void @glfwTerminate() #1

declare void @glfwMakeContextCurrent(%struct.GLFWwindow*) #1

declare void (%struct.GLFWwindow*, i32, i32, i32, i32)* @glfwSetKeyCallback(%struct.GLFWwindow*, void (%struct.GLFWwindow*, i32, i32, i32, i32)*) #1

; Function Attrs: nounwind ssp uwtable
define internal void @key_callback(%struct.GLFWwindow* %window, i32 %key, i32 %scancode, i32 %action, i32 %mods) #2 {
  %1 = icmp eq i32 %key, 256
  %2 = icmp eq i32 %action, 1
  %or.cond = and i1 %1, %2
  br i1 %or.cond, label %3, label %4

; <label>:3                                       ; preds = %0
  tail call void @glfwSetWindowShouldClose(%struct.GLFWwindow* %window, i32 1) #4
  br label %4

; <label>:4                                       ; preds = %3, %0
  ret void
}

declare i32 @glfwWindowShouldClose(%struct.GLFWwindow*) #1

declare void @glfwGetFramebufferSize(%struct.GLFWwindow*, i32*, i32*) #1

declare void @glViewport(i32, i32, i32, i32) #1

declare void @glClear(i32) #1

declare void @glMatrixMode(i32) #1

declare void @glLoadIdentity() #1

declare void @glOrtho(double, double, double, double, double, double) #1

declare void @glRotatef(float, float, float, float) #1

declare double @glfwGetTime() #1

declare void @glBegin(i32) #1

declare void @glColor3f(float, float, float) #1

declare void @glVertex3f(float, float, float) #1

declare void @glEnd() #1

declare void @glfwSwapBuffers(%struct.GLFWwindow*) #1

declare void @glfwPollEvents() #1

declare void @glfwDestroyWindow(%struct.GLFWwindow*) #1

declare void @glfwSetWindowShouldClose(%struct.GLFWwindow*, i32) #1

declare i32 @"\01_fputs"(i8*, %struct.__sFILE*) #1

attributes #0 = { noreturn nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Apple LLVM version 6.0 (clang-600.0.56) (based on LLVM 3.5svn)"}
!1 = metadata !{metadata !2, metadata !2, i64 0}
!2 = metadata !{metadata !"int", metadata !3, i64 0}
!3 = metadata !{metadata !"omnipotent char", metadata !4, i64 0}
!4 = metadata !{metadata !"Simple C/C++ TBAA"}
!5 = metadata !{metadata !6, metadata !6, i64 0}
!6 = metadata !{metadata !"any pointer", metadata !3, i64 0}
