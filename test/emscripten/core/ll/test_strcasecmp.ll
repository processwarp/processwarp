; ModuleID = 'test_strcasecmp.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"hello\00", align 1
@.str3 = private unnamed_addr constant [7 x i8] c"hello1\00", align 1
@.str4 = private unnamed_addr constant [6 x i8] c"iello\00", align 1
@.str5 = private unnamed_addr constant [2 x i8] c"A\00", align 1
@.str6 = private unnamed_addr constant [2 x i8] c"Z\00", align 1
@.str7 = private unnamed_addr constant [2 x i8] c"a\00", align 1
@.str8 = private unnamed_addr constant [2 x i8] c"z\00", align 1
@.str9 = private unnamed_addr constant [6 x i8] c"Hello\00", align 1
@.str10 = private unnamed_addr constant [7 x i8] c"Hello1\00", align 1
@.str11 = private unnamed_addr constant [6 x i8] c"Iello\00", align 1
@str12 = private unnamed_addr constant [2 x i8] c"*\00"

; Function Attrs: nounwind readnone uwtable
define i32 @_Z4signi(i32 %x) #0 {
  %1 = icmp slt i32 %x, 0
  br i1 %1, label %4, label %2

; <label>:2                                       ; preds = %0
  %3 = icmp sgt i32 %x, 0
  %. = zext i1 %3 to i32
  br label %4

; <label>:4                                       ; preds = %2, %0
  %.0 = phi i32 [ -1, %0 ], [ %., %2 ]
  ret i32 %.0
}

; Function Attrs: nounwind uwtable
define i32 @main() #1 {
  %puts = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str12, i64 0, i64 0))
  %1 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %2 = icmp slt i32 %1, 0
  br i1 %2, label %_Z4signi.exit, label %3

; <label>:3                                       ; preds = %0
  %4 = icmp sgt i32 %1, 0
  %..i = zext i1 %4 to i32
  br label %_Z4signi.exit

_Z4signi.exit:                                    ; preds = %3, %0
  %.0.i = phi i32 [ -1, %0 ], [ %..i, %3 ]
  %5 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i) #4
  %6 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %7 = icmp slt i32 %6, 0
  br i1 %7, label %_Z4signi.exit178, label %8

; <label>:8                                       ; preds = %_Z4signi.exit
  %9 = icmp sgt i32 %6, 0
  %..i176 = zext i1 %9 to i32
  br label %_Z4signi.exit178

_Z4signi.exit178:                                 ; preds = %8, %_Z4signi.exit
  %.0.i177 = phi i32 [ -1, %_Z4signi.exit ], [ %..i176, %8 ]
  %10 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i177) #4
  %11 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %12 = icmp slt i32 %11, 0
  br i1 %12, label %_Z4signi.exit175, label %13

; <label>:13                                      ; preds = %_Z4signi.exit178
  %14 = icmp sgt i32 %11, 0
  %..i173 = zext i1 %14 to i32
  br label %_Z4signi.exit175

_Z4signi.exit175:                                 ; preds = %13, %_Z4signi.exit178
  %.0.i174 = phi i32 [ -1, %_Z4signi.exit178 ], [ %..i173, %13 ]
  %15 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i174) #4
  %16 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %17 = icmp slt i32 %16, 0
  br i1 %17, label %_Z4signi.exit172, label %18

; <label>:18                                      ; preds = %_Z4signi.exit175
  %19 = icmp sgt i32 %16, 0
  %..i170 = zext i1 %19 to i32
  br label %_Z4signi.exit172

_Z4signi.exit172:                                 ; preds = %18, %_Z4signi.exit175
  %.0.i171 = phi i32 [ -1, %_Z4signi.exit175 ], [ %..i170, %18 ]
  %20 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i171) #4
  %21 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %22 = icmp slt i32 %21, 0
  br i1 %22, label %_Z4signi.exit169, label %23

; <label>:23                                      ; preds = %_Z4signi.exit172
  %24 = icmp sgt i32 %21, 0
  %..i167 = zext i1 %24 to i32
  br label %_Z4signi.exit169

_Z4signi.exit169:                                 ; preds = %23, %_Z4signi.exit172
  %.0.i168 = phi i32 [ -1, %_Z4signi.exit172 ], [ %..i167, %23 ]
  %25 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i168) #4
  %26 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0)) #5
  %27 = icmp slt i32 %26, 0
  br i1 %27, label %_Z4signi.exit166, label %28

; <label>:28                                      ; preds = %_Z4signi.exit169
  %29 = icmp sgt i32 %26, 0
  %..i164 = zext i1 %29 to i32
  br label %_Z4signi.exit166

_Z4signi.exit166:                                 ; preds = %28, %_Z4signi.exit169
  %.0.i165 = phi i32 [ -1, %_Z4signi.exit169 ], [ %..i164, %28 ]
  %30 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i165) #4
  %31 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %32 = icmp slt i32 %31, 0
  br i1 %32, label %_Z4signi.exit163, label %33

; <label>:33                                      ; preds = %_Z4signi.exit166
  %34 = icmp sgt i32 %31, 0
  %..i161 = zext i1 %34 to i32
  br label %_Z4signi.exit163

_Z4signi.exit163:                                 ; preds = %33, %_Z4signi.exit166
  %.0.i162 = phi i32 [ -1, %_Z4signi.exit166 ], [ %..i161, %33 ]
  %35 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i162) #4
  %36 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %37 = icmp slt i32 %36, 0
  br i1 %37, label %_Z4signi.exit160, label %38

; <label>:38                                      ; preds = %_Z4signi.exit163
  %39 = icmp sgt i32 %36, 0
  %..i158 = zext i1 %39 to i32
  br label %_Z4signi.exit160

_Z4signi.exit160:                                 ; preds = %38, %_Z4signi.exit163
  %.0.i159 = phi i32 [ -1, %_Z4signi.exit163 ], [ %..i158, %38 ]
  %40 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i159) #4
  %41 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %42 = icmp slt i32 %41, 0
  br i1 %42, label %_Z4signi.exit157, label %43

; <label>:43                                      ; preds = %_Z4signi.exit160
  %44 = icmp sgt i32 %41, 0
  %..i155 = zext i1 %44 to i32
  br label %_Z4signi.exit157

_Z4signi.exit157:                                 ; preds = %43, %_Z4signi.exit160
  %.0.i156 = phi i32 [ -1, %_Z4signi.exit160 ], [ %..i155, %43 ]
  %45 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i156) #4
  %46 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %47 = icmp slt i32 %46, 0
  br i1 %47, label %_Z4signi.exit154, label %48

; <label>:48                                      ; preds = %_Z4signi.exit157
  %49 = icmp sgt i32 %46, 0
  %..i152 = zext i1 %49 to i32
  br label %_Z4signi.exit154

_Z4signi.exit154:                                 ; preds = %48, %_Z4signi.exit157
  %.0.i153 = phi i32 [ -1, %_Z4signi.exit157 ], [ %..i152, %48 ]
  %50 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i153) #4
  %51 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %52 = icmp slt i32 %51, 0
  br i1 %52, label %_Z4signi.exit151, label %53

; <label>:53                                      ; preds = %_Z4signi.exit154
  %54 = icmp sgt i32 %51, 0
  %..i149 = zext i1 %54 to i32
  br label %_Z4signi.exit151

_Z4signi.exit151:                                 ; preds = %53, %_Z4signi.exit154
  %.0.i150 = phi i32 [ -1, %_Z4signi.exit154 ], [ %..i149, %53 ]
  %55 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i150) #4
  %56 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %57 = icmp slt i32 %56, 0
  br i1 %57, label %_Z4signi.exit148, label %58

; <label>:58                                      ; preds = %_Z4signi.exit151
  %59 = icmp sgt i32 %56, 0
  %..i146 = zext i1 %59 to i32
  br label %_Z4signi.exit148

_Z4signi.exit148:                                 ; preds = %58, %_Z4signi.exit151
  %.0.i147 = phi i32 [ -1, %_Z4signi.exit151 ], [ %..i146, %58 ]
  %60 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i147) #4
  %61 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %62 = icmp slt i32 %61, 0
  br i1 %62, label %_Z4signi.exit145, label %63

; <label>:63                                      ; preds = %_Z4signi.exit148
  %64 = icmp sgt i32 %61, 0
  %..i143 = zext i1 %64 to i32
  br label %_Z4signi.exit145

_Z4signi.exit145:                                 ; preds = %63, %_Z4signi.exit148
  %.0.i144 = phi i32 [ -1, %_Z4signi.exit148 ], [ %..i143, %63 ]
  %65 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i144) #4
  %66 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %67 = icmp slt i32 %66, 0
  br i1 %67, label %_Z4signi.exit142, label %68

; <label>:68                                      ; preds = %_Z4signi.exit145
  %69 = icmp sgt i32 %66, 0
  %..i140 = zext i1 %69 to i32
  br label %_Z4signi.exit142

_Z4signi.exit142:                                 ; preds = %68, %_Z4signi.exit145
  %.0.i141 = phi i32 [ -1, %_Z4signi.exit145 ], [ %..i140, %68 ]
  %70 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i141) #4
  %71 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %72 = icmp slt i32 %71, 0
  br i1 %72, label %_Z4signi.exit139, label %73

; <label>:73                                      ; preds = %_Z4signi.exit142
  %74 = icmp sgt i32 %71, 0
  %..i137 = zext i1 %74 to i32
  br label %_Z4signi.exit139

_Z4signi.exit139:                                 ; preds = %73, %_Z4signi.exit142
  %.0.i138 = phi i32 [ -1, %_Z4signi.exit142 ], [ %..i137, %73 ]
  %75 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i138) #4
  %76 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0)) #5
  %77 = icmp slt i32 %76, 0
  br i1 %77, label %_Z4signi.exit136, label %78

; <label>:78                                      ; preds = %_Z4signi.exit139
  %79 = icmp sgt i32 %76, 0
  %..i134 = zext i1 %79 to i32
  br label %_Z4signi.exit136

_Z4signi.exit136:                                 ; preds = %78, %_Z4signi.exit139
  %.0.i135 = phi i32 [ -1, %_Z4signi.exit139 ], [ %..i134, %78 ]
  %80 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i135) #4
  %81 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %82 = icmp slt i32 %81, 0
  br i1 %82, label %_Z4signi.exit133, label %83

; <label>:83                                      ; preds = %_Z4signi.exit136
  %84 = icmp sgt i32 %81, 0
  %..i131 = zext i1 %84 to i32
  br label %_Z4signi.exit133

_Z4signi.exit133:                                 ; preds = %83, %_Z4signi.exit136
  %.0.i132 = phi i32 [ -1, %_Z4signi.exit136 ], [ %..i131, %83 ]
  %85 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i132) #4
  %86 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0)) #5
  %87 = icmp slt i32 %86, 0
  br i1 %87, label %_Z4signi.exit130, label %88

; <label>:88                                      ; preds = %_Z4signi.exit133
  %89 = icmp sgt i32 %86, 0
  %..i128 = zext i1 %89 to i32
  br label %_Z4signi.exit130

_Z4signi.exit130:                                 ; preds = %88, %_Z4signi.exit133
  %.0.i129 = phi i32 [ -1, %_Z4signi.exit133 ], [ %..i128, %88 ]
  %90 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i129) #4
  %91 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %92 = icmp slt i32 %91, 0
  br i1 %92, label %_Z4signi.exit127, label %93

; <label>:93                                      ; preds = %_Z4signi.exit130
  %94 = icmp sgt i32 %91, 0
  %..i125 = zext i1 %94 to i32
  br label %_Z4signi.exit127

_Z4signi.exit127:                                 ; preds = %93, %_Z4signi.exit130
  %.0.i126 = phi i32 [ -1, %_Z4signi.exit130 ], [ %..i125, %93 ]
  %95 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i126) #4
  %96 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %97 = icmp slt i32 %96, 0
  br i1 %97, label %_Z4signi.exit124, label %98

; <label>:98                                      ; preds = %_Z4signi.exit127
  %99 = icmp sgt i32 %96, 0
  %..i122 = zext i1 %99 to i32
  br label %_Z4signi.exit124

_Z4signi.exit124:                                 ; preds = %98, %_Z4signi.exit127
  %.0.i123 = phi i32 [ -1, %_Z4signi.exit127 ], [ %..i122, %98 ]
  %100 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i123) #4
  %101 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %102 = icmp slt i32 %101, 0
  br i1 %102, label %_Z4signi.exit121, label %103

; <label>:103                                     ; preds = %_Z4signi.exit124
  %104 = icmp sgt i32 %101, 0
  %..i119 = zext i1 %104 to i32
  br label %_Z4signi.exit121

_Z4signi.exit121:                                 ; preds = %103, %_Z4signi.exit124
  %.0.i120 = phi i32 [ -1, %_Z4signi.exit124 ], [ %..i119, %103 ]
  %105 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i120) #4
  %106 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0)) #5
  %107 = icmp slt i32 %106, 0
  br i1 %107, label %_Z4signi.exit118, label %108

; <label>:108                                     ; preds = %_Z4signi.exit121
  %109 = icmp sgt i32 %106, 0
  %..i116 = zext i1 %109 to i32
  br label %_Z4signi.exit118

_Z4signi.exit118:                                 ; preds = %108, %_Z4signi.exit121
  %.0.i117 = phi i32 [ -1, %_Z4signi.exit121 ], [ %..i116, %108 ]
  %110 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i117) #4
  %111 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %112 = icmp slt i32 %111, 0
  br i1 %112, label %_Z4signi.exit115, label %113

; <label>:113                                     ; preds = %_Z4signi.exit118
  %114 = icmp sgt i32 %111, 0
  %..i113 = zext i1 %114 to i32
  br label %_Z4signi.exit115

_Z4signi.exit115:                                 ; preds = %113, %_Z4signi.exit118
  %.0.i114 = phi i32 [ -1, %_Z4signi.exit118 ], [ %..i113, %113 ]
  %115 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i114) #4
  %116 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %117 = icmp slt i32 %116, 0
  br i1 %117, label %_Z4signi.exit112, label %118

; <label>:118                                     ; preds = %_Z4signi.exit115
  %119 = icmp sgt i32 %116, 0
  %..i110 = zext i1 %119 to i32
  br label %_Z4signi.exit112

_Z4signi.exit112:                                 ; preds = %118, %_Z4signi.exit115
  %.0.i111 = phi i32 [ -1, %_Z4signi.exit115 ], [ %..i110, %118 ]
  %120 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i111) #4
  %121 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %122 = icmp slt i32 %121, 0
  br i1 %122, label %_Z4signi.exit109, label %123

; <label>:123                                     ; preds = %_Z4signi.exit112
  %124 = icmp sgt i32 %121, 0
  %..i107 = zext i1 %124 to i32
  br label %_Z4signi.exit109

_Z4signi.exit109:                                 ; preds = %123, %_Z4signi.exit112
  %.0.i108 = phi i32 [ -1, %_Z4signi.exit112 ], [ %..i107, %123 ]
  %125 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i108) #4
  %126 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %127 = icmp slt i32 %126, 0
  br i1 %127, label %_Z4signi.exit106, label %128

; <label>:128                                     ; preds = %_Z4signi.exit109
  %129 = icmp sgt i32 %126, 0
  %..i104 = zext i1 %129 to i32
  br label %_Z4signi.exit106

_Z4signi.exit106:                                 ; preds = %128, %_Z4signi.exit109
  %.0.i105 = phi i32 [ -1, %_Z4signi.exit109 ], [ %..i104, %128 ]
  %130 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i105) #4
  %131 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %132 = icmp slt i32 %131, 0
  br i1 %132, label %_Z4signi.exit103, label %133

; <label>:133                                     ; preds = %_Z4signi.exit106
  %134 = icmp sgt i32 %131, 0
  %..i101 = zext i1 %134 to i32
  br label %_Z4signi.exit103

_Z4signi.exit103:                                 ; preds = %133, %_Z4signi.exit106
  %.0.i102 = phi i32 [ -1, %_Z4signi.exit106 ], [ %..i101, %133 ]
  %135 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i102) #4
  %136 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %137 = icmp slt i32 %136, 0
  br i1 %137, label %_Z4signi.exit100, label %138

; <label>:138                                     ; preds = %_Z4signi.exit103
  %139 = icmp sgt i32 %136, 0
  %..i98 = zext i1 %139 to i32
  br label %_Z4signi.exit100

_Z4signi.exit100:                                 ; preds = %138, %_Z4signi.exit103
  %.0.i99 = phi i32 [ -1, %_Z4signi.exit103 ], [ %..i98, %138 ]
  %140 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i99) #4
  %141 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %142 = icmp slt i32 %141, 0
  br i1 %142, label %_Z4signi.exit97, label %143

; <label>:143                                     ; preds = %_Z4signi.exit100
  %144 = icmp sgt i32 %141, 0
  %..i95 = zext i1 %144 to i32
  br label %_Z4signi.exit97

_Z4signi.exit97:                                  ; preds = %143, %_Z4signi.exit100
  %.0.i96 = phi i32 [ -1, %_Z4signi.exit100 ], [ %..i95, %143 ]
  %145 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i96) #4
  %146 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0)) #5
  %147 = icmp slt i32 %146, 0
  br i1 %147, label %_Z4signi.exit94, label %148

; <label>:148                                     ; preds = %_Z4signi.exit97
  %149 = icmp sgt i32 %146, 0
  %..i92 = zext i1 %149 to i32
  br label %_Z4signi.exit94

_Z4signi.exit94:                                  ; preds = %148, %_Z4signi.exit97
  %.0.i93 = phi i32 [ -1, %_Z4signi.exit97 ], [ %..i92, %148 ]
  %150 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i93) #4
  %151 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %152 = icmp slt i32 %151, 0
  br i1 %152, label %_Z4signi.exit91, label %153

; <label>:153                                     ; preds = %_Z4signi.exit94
  %154 = icmp sgt i32 %151, 0
  %..i89 = zext i1 %154 to i32
  br label %_Z4signi.exit91

_Z4signi.exit91:                                  ; preds = %153, %_Z4signi.exit94
  %.0.i90 = phi i32 [ -1, %_Z4signi.exit94 ], [ %..i89, %153 ]
  %155 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i90) #4
  %156 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %157 = icmp slt i32 %156, 0
  br i1 %157, label %_Z4signi.exit88, label %158

; <label>:158                                     ; preds = %_Z4signi.exit91
  %159 = icmp sgt i32 %156, 0
  %..i86 = zext i1 %159 to i32
  br label %_Z4signi.exit88

_Z4signi.exit88:                                  ; preds = %158, %_Z4signi.exit91
  %.0.i87 = phi i32 [ -1, %_Z4signi.exit91 ], [ %..i86, %158 ]
  %160 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i87) #4
  %161 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %162 = icmp slt i32 %161, 0
  br i1 %162, label %_Z4signi.exit85, label %163

; <label>:163                                     ; preds = %_Z4signi.exit88
  %164 = icmp sgt i32 %161, 0
  %..i83 = zext i1 %164 to i32
  br label %_Z4signi.exit85

_Z4signi.exit85:                                  ; preds = %163, %_Z4signi.exit88
  %.0.i84 = phi i32 [ -1, %_Z4signi.exit88 ], [ %..i83, %163 ]
  %165 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i84) #4
  %166 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %167 = icmp slt i32 %166, 0
  br i1 %167, label %_Z4signi.exit82, label %168

; <label>:168                                     ; preds = %_Z4signi.exit85
  %169 = icmp sgt i32 %166, 0
  %..i80 = zext i1 %169 to i32
  br label %_Z4signi.exit82

_Z4signi.exit82:                                  ; preds = %168, %_Z4signi.exit85
  %.0.i81 = phi i32 [ -1, %_Z4signi.exit85 ], [ %..i80, %168 ]
  %170 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i81) #4
  %171 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %172 = icmp slt i32 %171, 0
  br i1 %172, label %_Z4signi.exit79, label %173

; <label>:173                                     ; preds = %_Z4signi.exit82
  %174 = icmp sgt i32 %171, 0
  %..i77 = zext i1 %174 to i32
  br label %_Z4signi.exit79

_Z4signi.exit79:                                  ; preds = %173, %_Z4signi.exit82
  %.0.i78 = phi i32 [ -1, %_Z4signi.exit82 ], [ %..i77, %173 ]
  %175 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i78) #4
  %176 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %177 = icmp slt i32 %176, 0
  br i1 %177, label %_Z4signi.exit76, label %178

; <label>:178                                     ; preds = %_Z4signi.exit79
  %179 = icmp sgt i32 %176, 0
  %..i74 = zext i1 %179 to i32
  br label %_Z4signi.exit76

_Z4signi.exit76:                                  ; preds = %178, %_Z4signi.exit79
  %.0.i75 = phi i32 [ -1, %_Z4signi.exit79 ], [ %..i74, %178 ]
  %180 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i75) #4
  %181 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %182 = icmp slt i32 %181, 0
  br i1 %182, label %_Z4signi.exit73, label %183

; <label>:183                                     ; preds = %_Z4signi.exit76
  %184 = icmp sgt i32 %181, 0
  %..i71 = zext i1 %184 to i32
  br label %_Z4signi.exit73

_Z4signi.exit73:                                  ; preds = %183, %_Z4signi.exit76
  %.0.i72 = phi i32 [ -1, %_Z4signi.exit76 ], [ %..i71, %183 ]
  %185 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i72) #4
  %186 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %187 = icmp slt i32 %186, 0
  br i1 %187, label %_Z4signi.exit70, label %188

; <label>:188                                     ; preds = %_Z4signi.exit73
  %189 = icmp sgt i32 %186, 0
  %..i68 = zext i1 %189 to i32
  br label %_Z4signi.exit70

_Z4signi.exit70:                                  ; preds = %188, %_Z4signi.exit73
  %.0.i69 = phi i32 [ -1, %_Z4signi.exit73 ], [ %..i68, %188 ]
  %190 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i69) #4
  %191 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %192 = icmp slt i32 %191, 0
  br i1 %192, label %_Z4signi.exit67, label %193

; <label>:193                                     ; preds = %_Z4signi.exit70
  %194 = icmp sgt i32 %191, 0
  %..i65 = zext i1 %194 to i32
  br label %_Z4signi.exit67

_Z4signi.exit67:                                  ; preds = %193, %_Z4signi.exit70
  %.0.i66 = phi i32 [ -1, %_Z4signi.exit70 ], [ %..i65, %193 ]
  %195 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i66) #4
  %196 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str10, i64 0, i64 0)) #5
  %197 = icmp slt i32 %196, 0
  br i1 %197, label %_Z4signi.exit64, label %198

; <label>:198                                     ; preds = %_Z4signi.exit67
  %199 = icmp sgt i32 %196, 0
  %..i62 = zext i1 %199 to i32
  br label %_Z4signi.exit64

_Z4signi.exit64:                                  ; preds = %198, %_Z4signi.exit67
  %.0.i63 = phi i32 [ -1, %_Z4signi.exit67 ], [ %..i62, %198 ]
  %200 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i63) #4
  %201 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %202 = icmp slt i32 %201, 0
  br i1 %202, label %_Z4signi.exit61, label %203

; <label>:203                                     ; preds = %_Z4signi.exit64
  %204 = icmp sgt i32 %201, 0
  %..i59 = zext i1 %204 to i32
  br label %_Z4signi.exit61

_Z4signi.exit61:                                  ; preds = %203, %_Z4signi.exit64
  %.0.i60 = phi i32 [ -1, %_Z4signi.exit64 ], [ %..i59, %203 ]
  %205 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i60) #4
  %206 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str11, i64 0, i64 0)) #5
  %207 = icmp slt i32 %206, 0
  br i1 %207, label %_Z4signi.exit58, label %208

; <label>:208                                     ; preds = %_Z4signi.exit61
  %209 = icmp sgt i32 %206, 0
  %..i56 = zext i1 %209 to i32
  br label %_Z4signi.exit58

_Z4signi.exit58:                                  ; preds = %208, %_Z4signi.exit61
  %.0.i57 = phi i32 [ -1, %_Z4signi.exit61 ], [ %..i56, %208 ]
  %210 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i57) #4
  %211 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %212 = icmp slt i32 %211, 0
  br i1 %212, label %_Z4signi.exit55, label %213

; <label>:213                                     ; preds = %_Z4signi.exit58
  %214 = icmp sgt i32 %211, 0
  %..i53 = zext i1 %214 to i32
  br label %_Z4signi.exit55

_Z4signi.exit55:                                  ; preds = %213, %_Z4signi.exit58
  %.0.i54 = phi i32 [ -1, %_Z4signi.exit58 ], [ %..i53, %213 ]
  %215 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i54) #4
  %216 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %217 = icmp slt i32 %216, 0
  br i1 %217, label %_Z4signi.exit52, label %218

; <label>:218                                     ; preds = %_Z4signi.exit55
  %219 = icmp sgt i32 %216, 0
  %..i50 = zext i1 %219 to i32
  br label %_Z4signi.exit52

_Z4signi.exit52:                                  ; preds = %218, %_Z4signi.exit55
  %.0.i51 = phi i32 [ -1, %_Z4signi.exit55 ], [ %..i50, %218 ]
  %220 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i51) #4
  %221 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %222 = icmp slt i32 %221, 0
  br i1 %222, label %_Z4signi.exit49, label %223

; <label>:223                                     ; preds = %_Z4signi.exit52
  %224 = icmp sgt i32 %221, 0
  %..i47 = zext i1 %224 to i32
  br label %_Z4signi.exit49

_Z4signi.exit49:                                  ; preds = %223, %_Z4signi.exit52
  %.0.i48 = phi i32 [ -1, %_Z4signi.exit52 ], [ %..i47, %223 ]
  %225 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i48) #4
  %226 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0)) #5
  %227 = icmp slt i32 %226, 0
  br i1 %227, label %_Z4signi.exit46, label %228

; <label>:228                                     ; preds = %_Z4signi.exit49
  %229 = icmp sgt i32 %226, 0
  %..i44 = zext i1 %229 to i32
  br label %_Z4signi.exit46

_Z4signi.exit46:                                  ; preds = %228, %_Z4signi.exit49
  %.0.i45 = phi i32 [ -1, %_Z4signi.exit49 ], [ %..i44, %228 ]
  %230 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i45) #4
  %231 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0)) #5
  %232 = icmp slt i32 %231, 0
  br i1 %232, label %_Z4signi.exit43, label %233

; <label>:233                                     ; preds = %_Z4signi.exit46
  %234 = icmp sgt i32 %231, 0
  %..i41 = zext i1 %234 to i32
  br label %_Z4signi.exit43

_Z4signi.exit43:                                  ; preds = %233, %_Z4signi.exit46
  %.0.i42 = phi i32 [ -1, %_Z4signi.exit46 ], [ %..i41, %233 ]
  %235 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i42) #4
  %236 = tail call i32 @strcasecmp(i8* getelementptr inbounds ([6 x i8]* @.str9, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0)) #5
  %237 = icmp slt i32 %236, 0
  br i1 %237, label %_Z4signi.exit40, label %238

; <label>:238                                     ; preds = %_Z4signi.exit43
  %239 = icmp sgt i32 %236, 0
  %..i38 = zext i1 %239 to i32
  br label %_Z4signi.exit40

_Z4signi.exit40:                                  ; preds = %238, %_Z4signi.exit43
  %.0.i39 = phi i32 [ -1, %_Z4signi.exit43 ], [ %..i38, %238 ]
  %240 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i39) #4
  %241 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %242 = icmp slt i32 %241, 0
  br i1 %242, label %_Z4signi.exit37, label %243

; <label>:243                                     ; preds = %_Z4signi.exit40
  %244 = icmp sgt i32 %241, 0
  %..i35 = zext i1 %244 to i32
  br label %_Z4signi.exit37

_Z4signi.exit37:                                  ; preds = %243, %_Z4signi.exit40
  %.0.i36 = phi i32 [ -1, %_Z4signi.exit40 ], [ %..i35, %243 ]
  %245 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i36) #4
  %246 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %247 = icmp slt i32 %246, 0
  br i1 %247, label %_Z4signi.exit34, label %248

; <label>:248                                     ; preds = %_Z4signi.exit37
  %249 = icmp sgt i32 %246, 0
  %..i32 = zext i1 %249 to i32
  br label %_Z4signi.exit34

_Z4signi.exit34:                                  ; preds = %248, %_Z4signi.exit37
  %.0.i33 = phi i32 [ -1, %_Z4signi.exit37 ], [ %..i32, %248 ]
  %250 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i33) #4
  %251 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 3) #5
  %252 = icmp slt i32 %251, 0
  br i1 %252, label %_Z4signi.exit31, label %253

; <label>:253                                     ; preds = %_Z4signi.exit34
  %254 = icmp sgt i32 %251, 0
  %..i29 = zext i1 %254 to i32
  br label %_Z4signi.exit31

_Z4signi.exit31:                                  ; preds = %253, %_Z4signi.exit34
  %.0.i30 = phi i32 [ -1, %_Z4signi.exit34 ], [ %..i29, %253 ]
  %255 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i30) #4
  %256 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([7 x i8]* @.str3, i64 0, i64 0), i64 3) #5
  %257 = icmp slt i32 %256, 0
  br i1 %257, label %_Z4signi.exit28, label %258

; <label>:258                                     ; preds = %_Z4signi.exit31
  %259 = icmp sgt i32 %256, 0
  %..i26 = zext i1 %259 to i32
  br label %_Z4signi.exit28

_Z4signi.exit28:                                  ; preds = %258, %_Z4signi.exit31
  %.0.i27 = phi i32 [ -1, %_Z4signi.exit31 ], [ %..i26, %258 ]
  %260 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i27) #4
  %261 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %262 = icmp slt i32 %261, 0
  br i1 %262, label %_Z4signi.exit25, label %263

; <label>:263                                     ; preds = %_Z4signi.exit28
  %264 = icmp sgt i32 %261, 0
  %..i23 = zext i1 %264 to i32
  br label %_Z4signi.exit25

_Z4signi.exit25:                                  ; preds = %263, %_Z4signi.exit28
  %.0.i24 = phi i32 [ -1, %_Z4signi.exit28 ], [ %..i23, %263 ]
  %265 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i24) #4
  %266 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str4, i64 0, i64 0), i64 3) #5
  %267 = icmp slt i32 %266, 0
  br i1 %267, label %_Z4signi.exit22, label %268

; <label>:268                                     ; preds = %_Z4signi.exit25
  %269 = icmp sgt i32 %266, 0
  %..i20 = zext i1 %269 to i32
  br label %_Z4signi.exit22

_Z4signi.exit22:                                  ; preds = %268, %_Z4signi.exit25
  %.0.i21 = phi i32 [ -1, %_Z4signi.exit25 ], [ %..i20, %268 ]
  %270 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i21) #4
  %271 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %272 = icmp slt i32 %271, 0
  br i1 %272, label %_Z4signi.exit19, label %273

; <label>:273                                     ; preds = %_Z4signi.exit22
  %274 = icmp sgt i32 %271, 0
  %..i17 = zext i1 %274 to i32
  br label %_Z4signi.exit19

_Z4signi.exit19:                                  ; preds = %273, %_Z4signi.exit22
  %.0.i18 = phi i32 [ -1, %_Z4signi.exit22 ], [ %..i17, %273 ]
  %275 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i18) #4
  %276 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %277 = icmp slt i32 %276, 0
  br i1 %277, label %_Z4signi.exit16, label %278

; <label>:278                                     ; preds = %_Z4signi.exit19
  %279 = icmp sgt i32 %276, 0
  %..i14 = zext i1 %279 to i32
  br label %_Z4signi.exit16

_Z4signi.exit16:                                  ; preds = %278, %_Z4signi.exit19
  %.0.i15 = phi i32 [ -1, %_Z4signi.exit19 ], [ %..i14, %278 ]
  %280 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i15) #4
  %281 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %282 = icmp slt i32 %281, 0
  br i1 %282, label %_Z4signi.exit13, label %283

; <label>:283                                     ; preds = %_Z4signi.exit16
  %284 = icmp sgt i32 %281, 0
  %..i11 = zext i1 %284 to i32
  br label %_Z4signi.exit13

_Z4signi.exit13:                                  ; preds = %283, %_Z4signi.exit16
  %.0.i12 = phi i32 [ -1, %_Z4signi.exit16 ], [ %..i11, %283 ]
  %285 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i12) #4
  %286 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i64 3) #5
  %287 = icmp slt i32 %286, 0
  br i1 %287, label %_Z4signi.exit10, label %288

; <label>:288                                     ; preds = %_Z4signi.exit13
  %289 = icmp sgt i32 %286, 0
  %..i8 = zext i1 %289 to i32
  br label %_Z4signi.exit10

_Z4signi.exit10:                                  ; preds = %288, %_Z4signi.exit13
  %.0.i9 = phi i32 [ -1, %_Z4signi.exit13 ], [ %..i8, %288 ]
  %290 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i9) #4
  %291 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str7, i64 0, i64 0), i64 3) #5
  %292 = icmp slt i32 %291, 0
  br i1 %292, label %_Z4signi.exit7, label %293

; <label>:293                                     ; preds = %_Z4signi.exit10
  %294 = icmp sgt i32 %291, 0
  %..i5 = zext i1 %294 to i32
  br label %_Z4signi.exit7

_Z4signi.exit7:                                   ; preds = %293, %_Z4signi.exit10
  %.0.i6 = phi i32 [ -1, %_Z4signi.exit10 ], [ %..i5, %293 ]
  %295 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i6) #4
  %296 = tail call i32 @strncasecmp(i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), i8* getelementptr inbounds ([2 x i8]* @.str8, i64 0, i64 0), i64 3) #5
  %297 = icmp slt i32 %296, 0
  br i1 %297, label %_Z4signi.exit4, label %298

; <label>:298                                     ; preds = %_Z4signi.exit7
  %299 = icmp sgt i32 %296, 0
  %..i2 = zext i1 %299 to i32
  br label %_Z4signi.exit4

_Z4signi.exit4:                                   ; preds = %298, %_Z4signi.exit7
  %.0.i3 = phi i32 [ -1, %_Z4signi.exit7 ], [ %..i2, %298 ]
  %300 = tail call i32 (i8*, ...)* @printf(i8* getelementptr inbounds ([4 x i8]* @.str1, i64 0, i64 0), i32 %.0.i3) #4
  %puts1 = tail call i32 @puts(i8* getelementptr inbounds ([2 x i8]* @str12, i64 0, i64 0))
  ret i32 0
}

; Function Attrs: nounwind
declare i32 @printf(i8* nocapture readonly, ...) #2

; Function Attrs: nounwind readonly
declare i32 @strcasecmp(i8* nocapture, i8* nocapture) #3

; Function Attrs: nounwind readonly
declare i32 @strncasecmp(i8* nocapture, i8* nocapture, i64) #3

; Function Attrs: nounwind
declare i32 @puts(i8* nocapture readonly) #4

attributes #0 = { nounwind readnone uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind }
attributes #5 = { nounwind readonly }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
