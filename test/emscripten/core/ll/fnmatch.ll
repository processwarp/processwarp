; ModuleID = 'fnmatch.bc'
target datalayout = "e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%"class.std::ios_base::Init" = type { i8 }
%"class.std::basic_ostream" = type { i32 (...)**, %"class.std::basic_ios" }
%"class.std::basic_ios" = type { %"class.std::ios_base", %"class.std::basic_ostream"*, i8, i8, %"class.std::basic_streambuf"*, %"class.std::ctype"*, %"class.std::num_put"*, %"class.std::num_get"* }
%"class.std::ios_base" = type { i32 (...)**, i64, i64, i32, i32, i32, %"struct.std::ios_base::_Callback_list"*, %"struct.std::ios_base::_Words", [8 x %"struct.std::ios_base::_Words"], i32, %"struct.std::ios_base::_Words"*, %"class.std::locale" }
%"struct.std::ios_base::_Callback_list" = type { %"struct.std::ios_base::_Callback_list"*, void (i32, %"class.std::ios_base"*, i32)*, i32, i32 }
%"struct.std::ios_base::_Words" = type { i8*, i64 }
%"class.std::locale" = type { %"class.std::locale::_Impl"* }
%"class.std::locale::_Impl" = type { i32, %"class.std::locale::facet"**, i64, %"class.std::locale::facet"**, i8** }
%"class.std::locale::facet" = type { i32 (...)**, i32 }
%"class.std::basic_streambuf" = type { i32 (...)**, i8*, i8*, i8*, i8*, i8*, i8*, %"class.std::locale" }
%"class.std::ctype" = type { %"class.std::locale::facet", %struct.__locale_struct*, i8, i32*, i32*, i16*, i8, [256 x i8], [256 x i8], i8 }
%struct.__locale_struct = type { [13 x %struct.__locale_data*], i16*, i32*, i32*, [13 x i8*] }
%struct.__locale_data = type opaque
%"class.std::num_put" = type { %"class.std::locale::facet" }
%"class.std::num_get" = type { %"class.std::locale::facet" }
%"class.std::allocator.0" = type { i8 }
%"class.std::vector" = type { %"struct.std::_Vector_base" }
%"struct.std::_Vector_base" = type { %"struct.std::_Vector_base<TestCase, std::allocator<TestCase> >::_Vector_impl" }
%"struct.std::_Vector_base<TestCase, std::allocator<TestCase> >::_Vector_impl" = type { %class.TestCase*, %class.TestCase*, %class.TestCase* }
%class.TestCase = type { %"class.std::basic_string", %"class.std::basic_string", i32, i32 }
%"class.std::basic_string" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Alloc_hider" = type { i8* }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep" = type { %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" }
%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep_base" = type { i64, i64, i32 }

@_ZStL8__ioinit = internal global %"class.std::ios_base::Init" zeroinitializer, align 1
@__dso_handle = external global i8
@.str = private unnamed_addr constant [2 x i8] c"*\00", align 1
@.str1 = private unnamed_addr constant [9 x i8] c"anything\00", align 1
@.str2 = private unnamed_addr constant [6 x i8] c"*.txt\00", align 1
@.str3 = private unnamed_addr constant [11 x i8] c"readme.txt\00", align 1
@.str4 = private unnamed_addr constant [12 x i8] c"readme.info\00", align 1
@.str5 = private unnamed_addr constant [6 x i8] c"*.t?t\00", align 1
@.str6 = private unnamed_addr constant [11 x i8] c"readme.tot\00", align 1
@.str7 = private unnamed_addr constant [12 x i8] c"readme.txxt\00", align 1
@.str8 = private unnamed_addr constant [7 x i8] c"[a-g]1\00", align 1
@.str9 = private unnamed_addr constant [3 x i8] c"c1\00", align 1
@.str10 = private unnamed_addr constant [3 x i8] c"i1\00", align 1
@.str11 = private unnamed_addr constant [8 x i8] c"[!a-g]1\00", align 1
@.str12 = private unnamed_addr constant [4 x i8] c"a\5C*\00", align 1
@.str13 = private unnamed_addr constant [3 x i8] c"a*\00", align 1
@.str14 = private unnamed_addr constant [8 x i8] c"*readme\00", align 1
@.str15 = private unnamed_addr constant [12 x i8] c"/etc/readme\00", align 1
@.str16 = private unnamed_addr constant [10 x i8] c"/*/readme\00", align 1
@.str17 = private unnamed_addr constant [13 x i8] c"/etc/.readme\00", align 1
@.str18 = private unnamed_addr constant [8 x i8] c".readme\00", align 1
@.str19 = private unnamed_addr constant [9 x i8] c"*.readme\00", align 1
@.str20 = private unnamed_addr constant [11 x i8] c"/*/.readme\00", align 1
@.str21 = private unnamed_addr constant [7 x i8] c"ReAdME\00", align 1
@.str22 = private unnamed_addr constant [7 x i8] c"readme\00", align 1
@_ZSt4cout = external global %"class.std::basic_ostream"
@.str23 = private unnamed_addr constant [7 x i8] c"Pass: \00", align 1
@.str24 = private unnamed_addr constant [7 x i8] c"Fail: \00", align 1
@.str25 = private unnamed_addr constant [9 x i8] c"fnmatch(\00", align 1
@.str26 = private unnamed_addr constant [3 x i8] c", \00", align 1
@.str27 = private unnamed_addr constant [12 x i8] c") returned \00", align 1
@.str28 = private unnamed_addr constant [12 x i8] c", expected \00", align 1
@.str29 = private unnamed_addr constant [18 x i8] c"All tests passed.\00", align 1
@.str30 = private unnamed_addr constant [19 x i8] c"Some tests failed.\00", align 1
@_ZNSs4_Rep20_S_empty_rep_storageE = external global [0 x i64]
@llvm.global_ctors = appending global [1 x { i32, void ()*, i8* }] [{ i32, void ()*, i8* } { i32 65535, void ()* @_GLOBAL__I_a, i8* null }]

declare void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"*) #0

declare void @_ZNSt8ios_base4InitD1Ev(%"class.std::ios_base::Init"*) #0

; Function Attrs: nounwind
declare i32 @__cxa_atexit(void (i8*)*, i8*, i8*) #1

; Function Attrs: uwtable
define i32 @main() #2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator.0", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator.0", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator.0", align 1
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::allocator.0", align 1
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::allocator.0", align 1
  %11 = alloca i32, align 4
  %12 = alloca %"class.std::allocator.0", align 1
  %13 = alloca i32, align 4
  %14 = alloca %"class.std::allocator.0", align 1
  %15 = alloca i32, align 4
  %16 = alloca %"class.std::allocator.0", align 1
  %17 = alloca i32, align 4
  %18 = alloca %"class.std::allocator.0", align 1
  %19 = alloca i32, align 4
  %20 = alloca %"class.std::allocator.0", align 1
  %21 = alloca i32, align 4
  %22 = alloca %"class.std::allocator.0", align 1
  %23 = alloca i32, align 4
  %24 = alloca %"class.std::allocator.0", align 1
  %25 = alloca i32, align 4
  %26 = alloca %"class.std::allocator.0", align 1
  %27 = alloca i32, align 4
  %28 = alloca %"class.std::allocator.0", align 1
  %29 = alloca i32, align 4
  %30 = alloca %"class.std::allocator.0", align 1
  %31 = alloca i32, align 4
  %32 = alloca %"class.std::allocator.0", align 1
  %33 = alloca i32, align 4
  %34 = alloca %"class.std::allocator.0", align 1
  %35 = alloca i32, align 4
  %36 = alloca %"class.std::allocator.0", align 1
  %37 = alloca i32, align 4
  %38 = alloca %"class.std::allocator.0", align 1
  %39 = alloca i32, align 4
  %40 = alloca %"class.std::allocator.0", align 1
  %41 = alloca i32, align 4
  %42 = alloca %"class.std::allocator.0", align 1
  %43 = alloca i32, align 4
  %44 = alloca %"class.std::allocator.0", align 1
  %45 = alloca i32, align 4
  %46 = alloca %"class.std::allocator.0", align 1
  %47 = alloca i32, align 4
  %48 = alloca %"class.std::allocator.0", align 1
  %49 = alloca i32, align 4
  %50 = alloca %"class.std::allocator.0", align 1
  %51 = alloca i32, align 4
  %52 = alloca %"class.std::allocator.0", align 1
  %53 = alloca i32, align 4
  %54 = alloca %"class.std::allocator.0", align 1
  %55 = alloca i32, align 4
  %56 = alloca %"class.std::allocator.0", align 1
  %57 = alloca i32, align 4
  %58 = alloca %"class.std::allocator.0", align 1
  %59 = alloca i32, align 4
  %60 = alloca %"class.std::allocator.0", align 1
  %61 = alloca i32, align 4
  %62 = alloca %"class.std::allocator.0", align 1
  %63 = alloca i32, align 4
  %64 = alloca %"class.std::allocator.0", align 1
  %65 = alloca i32, align 4
  %66 = alloca %"class.std::allocator.0", align 1
  %67 = alloca i32, align 4
  %68 = alloca %"class.std::allocator.0", align 1
  %69 = alloca i32, align 4
  %70 = alloca %"class.std::allocator.0", align 1
  %71 = alloca i32, align 4
  %72 = alloca %"class.std::allocator.0", align 1
  %73 = alloca i32, align 4
  %74 = alloca %"class.std::allocator.0", align 1
  %75 = alloca i32, align 4
  %76 = alloca %"class.std::allocator.0", align 1
  %77 = alloca i32, align 4
  %78 = alloca %"class.std::allocator.0", align 1
  %79 = alloca i32, align 4
  %80 = alloca %"class.std::allocator.0", align 1
  %81 = alloca i32, align 4
  %82 = alloca %"class.std::allocator.0", align 1
  %83 = alloca i32, align 4
  %84 = alloca %"class.std::allocator.0", align 1
  %85 = alloca i32, align 4
  %86 = alloca %"class.std::allocator.0", align 1
  %87 = alloca i32, align 4
  %88 = alloca %"class.std::allocator.0", align 1
  %89 = alloca i32, align 4
  %90 = alloca %"class.std::allocator.0", align 1
  %91 = alloca i32, align 4
  %92 = alloca %"class.std::allocator.0", align 1
  %93 = alloca i32, align 4
  %94 = alloca %"class.std::allocator.0", align 1
  %95 = alloca i32, align 4
  %96 = alloca %"class.std::allocator.0", align 1
  %97 = alloca i32, align 4
  %98 = alloca %"class.std::allocator.0", align 1
  %99 = alloca i32, align 4
  %100 = alloca %"class.std::allocator.0", align 1
  %101 = alloca i32, align 4
  %102 = alloca %"class.std::allocator.0", align 1
  %103 = alloca i32, align 4
  %104 = alloca %"class.std::allocator.0", align 1
  %105 = alloca i32, align 4
  %106 = alloca %"class.std::allocator.0", align 1
  %107 = alloca i32, align 4
  %108 = alloca %"class.std::allocator.0", align 1
  %109 = alloca i32, align 4
  %110 = alloca %"class.std::allocator.0", align 1
  %111 = alloca i32, align 4
  %112 = alloca %"class.std::allocator.0", align 1
  %113 = alloca i32, align 4
  %114 = alloca %"class.std::allocator.0", align 1
  %115 = alloca i32, align 4
  %116 = alloca %"class.std::allocator.0", align 1
  %117 = alloca i32, align 4
  %118 = alloca %"class.std::allocator.0", align 1
  %119 = alloca i32, align 4
  %120 = alloca %"class.std::allocator.0", align 1
  %121 = alloca i32, align 4
  %122 = alloca %"class.std::allocator.0", align 1
  %123 = alloca i32, align 4
  %124 = alloca %"class.std::allocator.0", align 1
  %125 = alloca i32, align 4
  %126 = alloca %"class.std::allocator.0", align 1
  %127 = alloca i32, align 4
  %128 = alloca %"class.std::allocator.0", align 1
  %129 = alloca i32, align 4
  %130 = alloca %"class.std::allocator.0", align 1
  %131 = alloca i32, align 4
  %132 = alloca %"class.std::allocator.0", align 1
  %133 = alloca i32, align 4
  %134 = alloca %"class.std::allocator.0", align 1
  %135 = alloca i32, align 4
  %136 = alloca %"class.std::allocator.0", align 1
  %137 = alloca i32, align 4
  %138 = alloca %"class.std::allocator.0", align 1
  %139 = alloca i32, align 4
  %140 = alloca %"class.std::allocator.0", align 1
  %141 = alloca i32, align 4
  %142 = alloca %"class.std::allocator.0", align 1
  %143 = alloca i32, align 4
  %144 = alloca %"class.std::allocator.0", align 1
  %145 = alloca i32, align 4
  %146 = alloca %"class.std::allocator.0", align 1
  %147 = alloca i32, align 4
  %148 = alloca %"class.std::allocator.0", align 1
  %149 = alloca i32, align 4
  %150 = alloca %"class.std::allocator.0", align 1
  %151 = alloca i32, align 4
  %152 = alloca %"class.std::allocator.0", align 1
  %153 = alloca i32, align 4
  %154 = alloca %"class.std::allocator.0", align 1
  %155 = alloca i32, align 4
  %156 = alloca %"class.std::allocator.0", align 1
  %157 = alloca i32, align 4
  %158 = alloca %"class.std::allocator.0", align 1
  %159 = alloca i32, align 4
  %160 = alloca %"class.std::allocator.0", align 1
  %161 = alloca i32, align 4
  %162 = alloca %"class.std::allocator.0", align 1
  %163 = alloca i32, align 4
  %164 = alloca %"class.std::allocator.0", align 1
  %165 = alloca i32, align 4
  %166 = alloca %"class.std::allocator.0", align 1
  %167 = alloca i32, align 4
  %168 = alloca %"class.std::allocator.0", align 1
  %169 = alloca i32, align 4
  %170 = alloca %"class.std::allocator.0", align 1
  %171 = alloca i32, align 4
  %172 = alloca %"class.std::allocator.0", align 1
  %173 = alloca i32, align 4
  %174 = alloca %"class.std::allocator.0", align 1
  %175 = alloca i32, align 4
  %176 = alloca %"class.std::allocator.0", align 1
  %177 = alloca i32, align 4
  %178 = alloca %"class.std::allocator.0", align 1
  %179 = alloca i32, align 4
  %180 = alloca %"class.std::allocator.0", align 1
  %181 = alloca i32, align 4
  %182 = alloca %"class.std::allocator.0", align 1
  %183 = alloca i32, align 4
  %184 = alloca %"class.std::allocator.0", align 1
  %185 = alloca i32, align 4
  %186 = alloca %"class.std::allocator.0", align 1
  %187 = alloca i32, align 4
  %188 = alloca %"class.std::allocator.0", align 1
  %189 = alloca i32, align 4
  %190 = alloca %"class.std::allocator.0", align 1
  %191 = alloca i32, align 4
  %192 = alloca %"class.std::allocator.0", align 1
  %193 = alloca i32, align 4
  %194 = alloca %"class.std::allocator.0", align 1
  %195 = alloca i32, align 4
  %196 = alloca %"class.std::allocator.0", align 1
  %197 = alloca i32, align 4
  %198 = alloca %"class.std::allocator.0", align 1
  %199 = alloca i32, align 4
  %200 = alloca %"class.std::allocator.0", align 1
  %201 = alloca i32, align 4
  %202 = alloca %"class.std::allocator.0", align 1
  %203 = alloca i32, align 4
  %204 = alloca %"class.std::allocator.0", align 1
  %205 = alloca i32, align 4
  %206 = alloca %"class.std::allocator.0", align 1
  %207 = alloca i32, align 4
  %208 = alloca %"class.std::allocator.0", align 1
  %209 = alloca i32, align 4
  %210 = alloca %"class.std::allocator.0", align 1
  %211 = alloca i32, align 4
  %212 = alloca %"class.std::allocator.0", align 1
  %213 = alloca i32, align 4
  %214 = alloca %"class.std::allocator.0", align 1
  %215 = alloca i32, align 4
  %216 = alloca %"class.std::allocator.0", align 1
  %217 = alloca i32, align 4
  %218 = alloca %"class.std::allocator.0", align 1
  %219 = alloca i32, align 4
  %220 = alloca %"class.std::allocator.0", align 1
  %221 = alloca i32, align 4
  %222 = alloca %"class.std::allocator.0", align 1
  %223 = alloca i32, align 4
  %224 = alloca %"class.std::allocator.0", align 1
  %225 = alloca i32, align 4
  %226 = alloca %"class.std::allocator.0", align 1
  %227 = alloca i32, align 4
  %228 = alloca %"class.std::allocator.0", align 1
  %229 = alloca i32, align 4
  %230 = alloca %"class.std::allocator.0", align 1
  %231 = alloca i32, align 4
  %232 = alloca %"class.std::allocator.0", align 1
  %233 = alloca i32, align 4
  %234 = alloca %"class.std::allocator.0", align 1
  %235 = alloca i32, align 4
  %236 = alloca %"class.std::allocator.0", align 1
  %237 = alloca i32, align 4
  %238 = alloca %"class.std::allocator.0", align 1
  %239 = alloca i32, align 4
  %240 = alloca %"class.std::allocator.0", align 1
  %241 = alloca i32, align 4
  %242 = alloca %"class.std::allocator.0", align 1
  %243 = alloca i32, align 4
  %244 = alloca %"class.std::allocator.0", align 1
  %245 = alloca i32, align 4
  %246 = alloca %"class.std::allocator.0", align 1
  %247 = alloca i32, align 4
  %248 = alloca %"class.std::allocator.0", align 1
  %249 = alloca i32, align 4
  %250 = alloca %"class.std::allocator.0", align 1
  %251 = alloca i32, align 4
  %252 = alloca %"class.std::allocator.0", align 1
  %253 = alloca i32, align 4
  %254 = alloca %"class.std::allocator.0", align 1
  %255 = alloca i32, align 4
  %256 = alloca %"class.std::allocator.0", align 1
  %257 = alloca i32, align 4
  %258 = alloca %"class.std::allocator.0", align 1
  %259 = alloca i32, align 4
  %260 = alloca %"class.std::allocator.0", align 1
  %261 = alloca i32, align 4
  %262 = alloca %"class.std::allocator.0", align 1
  %263 = alloca i32, align 4
  %264 = alloca %"class.std::allocator.0", align 1
  %265 = alloca i32, align 4
  %266 = alloca %"class.std::allocator.0", align 1
  %267 = alloca i32, align 4
  %268 = alloca %"class.std::allocator.0", align 1
  %269 = alloca i32, align 4
  %270 = alloca %"class.std::allocator.0", align 1
  %271 = alloca i32, align 4
  %272 = alloca %"class.std::allocator.0", align 1
  %273 = alloca i32, align 4
  %274 = alloca %"class.std::allocator.0", align 1
  %275 = alloca i32, align 4
  %276 = alloca %"class.std::allocator.0", align 1
  %277 = alloca i32, align 4
  %278 = alloca %"class.std::allocator.0", align 1
  %279 = alloca i32, align 4
  %280 = alloca %"class.std::allocator.0", align 1
  %281 = alloca i32, align 4
  %282 = alloca %"class.std::allocator.0", align 1
  %283 = alloca i32, align 4
  %284 = alloca %"class.std::allocator.0", align 1
  %285 = alloca i32, align 4
  %286 = alloca %"class.std::allocator.0", align 1
  %287 = alloca i32, align 4
  %288 = alloca %"class.std::allocator.0", align 1
  %289 = alloca i32, align 4
  %290 = alloca %"class.std::allocator.0", align 1
  %291 = alloca i32, align 4
  %292 = alloca %"class.std::allocator.0", align 1
  %293 = alloca i32, align 4
  %294 = alloca %"class.std::allocator.0", align 1
  %295 = alloca i32, align 4
  %296 = alloca %"class.std::allocator.0", align 1
  %297 = alloca i32, align 4
  %298 = alloca %"class.std::allocator.0", align 1
  %299 = alloca i32, align 4
  %300 = alloca %"class.std::allocator.0", align 1
  %301 = alloca i32, align 4
  %302 = alloca %"class.std::allocator.0", align 1
  %303 = alloca i32, align 4
  %304 = alloca %"class.std::allocator.0", align 1
  %305 = alloca i32, align 4
  %306 = alloca %"class.std::allocator.0", align 1
  %307 = alloca i32, align 4
  %308 = alloca %"class.std::allocator.0", align 1
  %309 = alloca i32, align 4
  %310 = alloca %"class.std::allocator.0", align 1
  %311 = alloca i32, align 4
  %312 = alloca %"class.std::allocator.0", align 1
  %313 = alloca i32, align 4
  %314 = alloca %"class.std::allocator.0", align 1
  %315 = alloca i32, align 4
  %316 = alloca %"class.std::allocator.0", align 1
  %317 = alloca i32, align 4
  %318 = alloca %"class.std::allocator.0", align 1
  %319 = alloca i32, align 4
  %320 = alloca %"class.std::allocator.0", align 1
  %321 = alloca i32, align 4
  %322 = alloca %"class.std::allocator.0", align 1
  %323 = alloca i32, align 4
  %324 = alloca %"class.std::allocator.0", align 1
  %325 = alloca i32, align 4
  %326 = alloca %"class.std::allocator.0", align 1
  %327 = alloca i32, align 4
  %328 = alloca %"class.std::allocator.0", align 1
  %329 = alloca i32, align 4
  %330 = alloca %"class.std::allocator.0", align 1
  %331 = alloca i32, align 4
  %332 = alloca %"class.std::allocator.0", align 1
  %333 = alloca i32, align 4
  %334 = alloca %"class.std::allocator.0", align 1
  %335 = alloca i32, align 4
  %336 = alloca %"class.std::allocator.0", align 1
  %337 = alloca i32, align 4
  %338 = alloca %"class.std::allocator.0", align 1
  %339 = alloca i32, align 4
  %340 = alloca %"class.std::allocator.0", align 1
  %341 = alloca i32, align 4
  %342 = alloca %"class.std::allocator.0", align 1
  %343 = alloca i32, align 4
  %344 = alloca %"class.std::allocator.0", align 1
  %345 = alloca i32, align 4
  %346 = alloca %"class.std::allocator.0", align 1
  %347 = alloca i32, align 4
  %348 = alloca %"class.std::allocator.0", align 1
  %349 = alloca i32, align 4
  %350 = alloca %"class.std::allocator.0", align 1
  %351 = alloca i32, align 4
  %352 = alloca %"class.std::allocator.0", align 1
  %353 = alloca i32, align 4
  %354 = alloca %"class.std::allocator.0", align 1
  %355 = alloca i32, align 4
  %356 = alloca %"class.std::allocator.0", align 1
  %357 = alloca i32, align 4
  %358 = alloca %"class.std::allocator.0", align 1
  %359 = alloca i32, align 4
  %360 = alloca %"class.std::allocator.0", align 1
  %361 = alloca i32, align 4
  %362 = alloca %"class.std::allocator.0", align 1
  %363 = alloca i32, align 4
  %364 = alloca %"class.std::allocator.0", align 1
  %365 = alloca i32, align 4
  %366 = alloca %"class.std::allocator.0", align 1
  %367 = alloca i32, align 4
  %368 = alloca %"class.std::allocator.0", align 1
  %369 = alloca i32, align 4
  %370 = alloca %"class.std::allocator.0", align 1
  %371 = alloca i32, align 4
  %372 = alloca %"class.std::allocator.0", align 1
  %373 = alloca i32, align 4
  %374 = alloca %"class.std::allocator.0", align 1
  %375 = alloca i32, align 4
  %376 = alloca %"class.std::allocator.0", align 1
  %377 = alloca i32, align 4
  %378 = alloca %"class.std::allocator.0", align 1
  %379 = alloca i32, align 4
  %380 = alloca %"class.std::allocator.0", align 1
  %381 = alloca i32, align 4
  %382 = alloca %"class.std::allocator.0", align 1
  %383 = alloca i32, align 4
  %384 = alloca %"class.std::allocator.0", align 1
  %385 = alloca i32, align 4
  %386 = alloca %"class.std::allocator.0", align 1
  %387 = alloca i32, align 4
  %388 = alloca %"class.std::allocator.0", align 1
  %389 = alloca i32, align 4
  %390 = alloca %"class.std::allocator.0", align 1
  %391 = alloca i32, align 4
  %392 = alloca %"class.std::allocator.0", align 1
  %393 = alloca i32, align 4
  %394 = alloca %"class.std::allocator.0", align 1
  %395 = alloca i32, align 4
  %396 = alloca %"class.std::allocator.0", align 1
  %testCases = alloca %"class.std::vector", align 8
  %397 = alloca %class.TestCase, align 8
  %398 = alloca %"class.std::basic_string", align 8
  %399 = alloca %"class.std::allocator.0", align 1
  %400 = alloca %"class.std::basic_string", align 8
  %401 = alloca %"class.std::allocator.0", align 1
  %402 = alloca %class.TestCase, align 8
  %403 = alloca %"class.std::basic_string", align 8
  %404 = alloca %"class.std::allocator.0", align 1
  %405 = alloca %"class.std::basic_string", align 8
  %406 = alloca %"class.std::allocator.0", align 1
  %407 = alloca %class.TestCase, align 8
  %408 = alloca %"class.std::basic_string", align 8
  %409 = alloca %"class.std::allocator.0", align 1
  %410 = alloca %"class.std::basic_string", align 8
  %411 = alloca %"class.std::allocator.0", align 1
  %412 = alloca %class.TestCase, align 8
  %413 = alloca %"class.std::basic_string", align 8
  %414 = alloca %"class.std::allocator.0", align 1
  %415 = alloca %"class.std::basic_string", align 8
  %416 = alloca %"class.std::allocator.0", align 1
  %417 = alloca %class.TestCase, align 8
  %418 = alloca %"class.std::basic_string", align 8
  %419 = alloca %"class.std::allocator.0", align 1
  %420 = alloca %"class.std::basic_string", align 8
  %421 = alloca %"class.std::allocator.0", align 1
  %422 = alloca %class.TestCase, align 8
  %423 = alloca %"class.std::basic_string", align 8
  %424 = alloca %"class.std::allocator.0", align 1
  %425 = alloca %"class.std::basic_string", align 8
  %426 = alloca %"class.std::allocator.0", align 1
  %427 = alloca %class.TestCase, align 8
  %428 = alloca %"class.std::basic_string", align 8
  %429 = alloca %"class.std::allocator.0", align 1
  %430 = alloca %"class.std::basic_string", align 8
  %431 = alloca %"class.std::allocator.0", align 1
  %432 = alloca %class.TestCase, align 8
  %433 = alloca %"class.std::basic_string", align 8
  %434 = alloca %"class.std::allocator.0", align 1
  %435 = alloca %"class.std::basic_string", align 8
  %436 = alloca %"class.std::allocator.0", align 1
  %437 = alloca %class.TestCase, align 8
  %438 = alloca %"class.std::basic_string", align 8
  %439 = alloca %"class.std::allocator.0", align 1
  %440 = alloca %"class.std::basic_string", align 8
  %441 = alloca %"class.std::allocator.0", align 1
  %442 = alloca %class.TestCase, align 8
  %443 = alloca %"class.std::basic_string", align 8
  %444 = alloca %"class.std::allocator.0", align 1
  %445 = alloca %"class.std::basic_string", align 8
  %446 = alloca %"class.std::allocator.0", align 1
  %447 = alloca %class.TestCase, align 8
  %448 = alloca %"class.std::basic_string", align 8
  %449 = alloca %"class.std::allocator.0", align 1
  %450 = alloca %"class.std::basic_string", align 8
  %451 = alloca %"class.std::allocator.0", align 1
  %452 = alloca %class.TestCase, align 8
  %453 = alloca %"class.std::basic_string", align 8
  %454 = alloca %"class.std::allocator.0", align 1
  %455 = alloca %"class.std::basic_string", align 8
  %456 = alloca %"class.std::allocator.0", align 1
  %457 = alloca %class.TestCase, align 8
  %458 = alloca %"class.std::basic_string", align 8
  %459 = alloca %"class.std::allocator.0", align 1
  %460 = alloca %"class.std::basic_string", align 8
  %461 = alloca %"class.std::allocator.0", align 1
  %462 = alloca %class.TestCase, align 8
  %463 = alloca %"class.std::basic_string", align 8
  %464 = alloca %"class.std::allocator.0", align 1
  %465 = alloca %"class.std::basic_string", align 8
  %466 = alloca %"class.std::allocator.0", align 1
  %467 = alloca %class.TestCase, align 8
  %468 = alloca %"class.std::basic_string", align 8
  %469 = alloca %"class.std::allocator.0", align 1
  %470 = alloca %"class.std::basic_string", align 8
  %471 = alloca %"class.std::allocator.0", align 1
  %472 = alloca %class.TestCase, align 8
  %473 = alloca %"class.std::basic_string", align 8
  %474 = alloca %"class.std::allocator.0", align 1
  %475 = alloca %"class.std::basic_string", align 8
  %476 = alloca %"class.std::allocator.0", align 1
  %477 = alloca %class.TestCase, align 8
  %478 = alloca %"class.std::basic_string", align 8
  %479 = alloca %"class.std::allocator.0", align 1
  %480 = alloca %"class.std::basic_string", align 8
  %481 = alloca %"class.std::allocator.0", align 1
  %482 = alloca %class.TestCase, align 8
  %483 = alloca %"class.std::basic_string", align 8
  %484 = alloca %"class.std::allocator.0", align 1
  %485 = alloca %"class.std::basic_string", align 8
  %486 = alloca %"class.std::allocator.0", align 1
  %487 = alloca %class.TestCase, align 8
  %488 = alloca %"class.std::basic_string", align 8
  %489 = alloca %"class.std::allocator.0", align 1
  %490 = alloca %"class.std::basic_string", align 8
  %491 = alloca %"class.std::allocator.0", align 1
  %492 = alloca %class.TestCase, align 8
  %493 = alloca %"class.std::basic_string", align 8
  %494 = alloca %"class.std::allocator.0", align 1
  %495 = alloca %"class.std::basic_string", align 8
  %496 = alloca %"class.std::allocator.0", align 1
  %497 = alloca %class.TestCase, align 8
  %498 = alloca %"class.std::basic_string", align 8
  %499 = alloca %"class.std::allocator.0", align 1
  %500 = alloca %"class.std::basic_string", align 8
  %501 = alloca %"class.std::allocator.0", align 1
  %502 = alloca %class.TestCase, align 8
  %503 = alloca %"class.std::basic_string", align 8
  %504 = alloca %"class.std::allocator.0", align 1
  %505 = alloca %"class.std::basic_string", align 8
  %506 = alloca %"class.std::allocator.0", align 1
  %507 = bitcast %"class.std::vector"* %testCases to i8*
  call void @llvm.memset.p0i8.i64(i8* %507, i8 0, i64 24, i32 8, i1 false) #1
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %398, i8* getelementptr inbounds ([2 x i8]* @.str, i64 0, i64 0), %"class.std::allocator.0"* %399)
          to label %508 unwind label %2815

; <label>:508                                     ; preds = %0
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %400, i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), %"class.std::allocator.0"* %401)
          to label %509 unwind label %2819

; <label>:509                                     ; preds = %508
  %510 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %510, %"class.std::basic_string"* %398)
          to label %.noexc unwind label %2823

.noexc:                                           ; preds = %509
  %511 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %511, %"class.std::basic_string"* %400)
          to label %532 unwind label %512

; <label>:512                                     ; preds = %.noexc
  %513 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %514 = getelementptr inbounds %"class.std::allocator.0"* %396, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %514)
  %515 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 0, i32 0, i32 0
  %516 = load i8** %515, align 8, !tbaa !1
  %517 = getelementptr inbounds i8* %516, i64 -24
  %518 = bitcast i8* %517 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %519 = icmp eq i8* %517, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %519, label %.body76, label %520, !prof !7

; <label>:520                                     ; preds = %512
  %521 = getelementptr inbounds i8* %516, i64 -8
  %522 = bitcast i8* %521 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %523, label %527

; <label>:523                                     ; preds = %520
  %524 = bitcast i32* %395 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %524)
  %525 = atomicrmw volatile add i32* %522, i32 -1 acq_rel
  store i32 %525, i32* %395, align 4
  %526 = load volatile i32* %395, align 4
  call void @llvm.lifetime.end(i64 4, i8* %524)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:527                                     ; preds = %520
  %528 = load i32* %522, align 4, !tbaa !8
  %529 = add nsw i32 %528, -1
  store i32 %529, i32* %522, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %527, %523
  %.0.i.i.i.i.i = phi i32 [ %526, %523 ], [ %528, %527 ]
  %530 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %530, label %531, label %.body76

; <label>:531                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %518, %"class.std::allocator.0"* %396) #1
  br label %.body76

; <label>:532                                     ; preds = %.noexc
  %533 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 2
  store i32 0, i32* %533, align 8, !tbaa !10
  %534 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 3
  store i32 0, i32* %534, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %397)
          to label %535 unwind label %2827

; <label>:535                                     ; preds = %532
  %536 = getelementptr inbounds %"class.std::allocator.0"* %394, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %536)
  %537 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 1, i32 0, i32 0
  %538 = load i8** %537, align 8, !tbaa !1
  %539 = getelementptr inbounds i8* %538, i64 -24
  %540 = bitcast i8* %539 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %541 = icmp eq i8* %539, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %541, label %554, label %542, !prof !7

; <label>:542                                     ; preds = %535
  %543 = getelementptr inbounds i8* %538, i64 -8
  %544 = bitcast i8* %543 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %545, label %549

; <label>:545                                     ; preds = %542
  %546 = bitcast i32* %393 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %546)
  %547 = atomicrmw volatile add i32* %544, i32 -1 acq_rel
  store i32 %547, i32* %393, align 4
  %548 = load volatile i32* %393, align 4
  call void @llvm.lifetime.end(i64 4, i8* %546)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i79

; <label>:549                                     ; preds = %542
  %550 = load i32* %544, align 4, !tbaa !8
  %551 = add nsw i32 %550, -1
  store i32 %551, i32* %544, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i79

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i79: ; preds = %549, %545
  %.0.i.i.i.i.i78 = phi i32 [ %548, %545 ], [ %550, %549 ]
  %552 = icmp slt i32 %.0.i.i.i.i.i78, 1
  br i1 %552, label %553, label %554

; <label>:553                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i79
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %540, %"class.std::allocator.0"* %394) #1
  br label %554

; <label>:554                                     ; preds = %553, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i79, %535
  call void @llvm.lifetime.end(i64 1, i8* %536)
  %555 = getelementptr inbounds %"class.std::allocator.0"* %392, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %555)
  %556 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 0, i32 0, i32 0
  %557 = load i8** %556, align 8, !tbaa !1
  %558 = getelementptr inbounds i8* %557, i64 -24
  %559 = bitcast i8* %558 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %560 = icmp eq i8* %558, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %560, label %573, label %561, !prof !7

; <label>:561                                     ; preds = %554
  %562 = getelementptr inbounds i8* %557, i64 -8
  %563 = bitcast i8* %562 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %564, label %568

; <label>:564                                     ; preds = %561
  %565 = bitcast i32* %391 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %565)
  %566 = atomicrmw volatile add i32* %563, i32 -1 acq_rel
  store i32 %566, i32* %391, align 4
  %567 = load volatile i32* %391, align 4
  call void @llvm.lifetime.end(i64 4, i8* %565)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i

; <label>:568                                     ; preds = %561
  %569 = load i32* %563, align 4, !tbaa !8
  %570 = add nsw i32 %569, -1
  store i32 %570, i32* %563, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i: ; preds = %568, %564
  %.0.i.i.i.i1.i = phi i32 [ %567, %564 ], [ %569, %568 ]
  %571 = icmp slt i32 %.0.i.i.i.i1.i, 1
  br i1 %571, label %572, label %573

; <label>:572                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %559, %"class.std::allocator.0"* %392) #1
  br label %573

; <label>:573                                     ; preds = %572, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i, %554
  call void @llvm.lifetime.end(i64 1, i8* %555)
  %574 = getelementptr inbounds %"class.std::allocator.0"* %390, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %574)
  %575 = getelementptr inbounds %"class.std::basic_string"* %400, i64 0, i32 0, i32 0
  %576 = load i8** %575, align 8, !tbaa !1
  %577 = getelementptr inbounds i8* %576, i64 -24
  %578 = bitcast i8* %577 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %579 = icmp eq i8* %577, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %579, label %592, label %580, !prof !7

; <label>:580                                     ; preds = %573
  %581 = getelementptr inbounds i8* %576, i64 -8
  %582 = bitcast i8* %581 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %583, label %587

; <label>:583                                     ; preds = %580
  %584 = bitcast i32* %389 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %584)
  %585 = atomicrmw volatile add i32* %582, i32 -1 acq_rel
  store i32 %585, i32* %389, align 4
  %586 = load volatile i32* %389, align 4
  call void @llvm.lifetime.end(i64 4, i8* %584)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

; <label>:587                                     ; preds = %580
  %588 = load i32* %582, align 4, !tbaa !8
  %589 = add nsw i32 %588, -1
  store i32 %589, i32* %582, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i: ; preds = %587, %583
  %.0.i.i.i.i = phi i32 [ %586, %583 ], [ %588, %587 ]
  %590 = icmp slt i32 %.0.i.i.i.i, 1
  br i1 %590, label %591, label %592

; <label>:591                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %578, %"class.std::allocator.0"* %390) #1
  br label %592

; <label>:592                                     ; preds = %591, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i, %573
  call void @llvm.lifetime.end(i64 1, i8* %574)
  %593 = getelementptr inbounds %"class.std::allocator.0"* %388, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %593)
  %594 = getelementptr inbounds %"class.std::basic_string"* %398, i64 0, i32 0, i32 0
  %595 = load i8** %594, align 8, !tbaa !1
  %596 = getelementptr inbounds i8* %595, i64 -24
  %597 = bitcast i8* %596 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %598 = icmp eq i8* %596, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %598, label %611, label %599, !prof !7

; <label>:599                                     ; preds = %592
  %600 = getelementptr inbounds i8* %595, i64 -8
  %601 = bitcast i8* %600 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %602, label %606

; <label>:602                                     ; preds = %599
  %603 = bitcast i32* %387 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %603)
  %604 = atomicrmw volatile add i32* %601, i32 -1 acq_rel
  store i32 %604, i32* %387, align 4
  %605 = load volatile i32* %387, align 4
  call void @llvm.lifetime.end(i64 4, i8* %603)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i81

; <label>:606                                     ; preds = %599
  %607 = load i32* %601, align 4, !tbaa !8
  %608 = add nsw i32 %607, -1
  store i32 %608, i32* %601, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i81

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i81: ; preds = %606, %602
  %.0.i.i.i.i80 = phi i32 [ %605, %602 ], [ %607, %606 ]
  %609 = icmp slt i32 %.0.i.i.i.i80, 1
  br i1 %609, label %610, label %611

; <label>:610                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i81
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %597, %"class.std::allocator.0"* %388) #1
  br label %611

; <label>:611                                     ; preds = %610, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i81, %592
  call void @llvm.lifetime.end(i64 1, i8* %593)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %403, i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator.0"* %404)
          to label %612 unwind label %2904

; <label>:612                                     ; preds = %611
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %405, i8* getelementptr inbounds ([11 x i8]* @.str3, i64 0, i64 0), %"class.std::allocator.0"* %406)
          to label %613 unwind label %2908

; <label>:613                                     ; preds = %612
  %614 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %614, %"class.std::basic_string"* %403)
          to label %.noexc85 unwind label %2912

.noexc85:                                         ; preds = %613
  %615 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %615, %"class.std::basic_string"* %405)
          to label %636 unwind label %616

; <label>:616                                     ; preds = %.noexc85
  %617 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %618 = getelementptr inbounds %"class.std::allocator.0"* %386, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %618)
  %619 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 0, i32 0, i32 0
  %620 = load i8** %619, align 8, !tbaa !1
  %621 = getelementptr inbounds i8* %620, i64 -24
  %622 = bitcast i8* %621 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %623 = icmp eq i8* %621, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %623, label %.body86, label %624, !prof !7

; <label>:624                                     ; preds = %616
  %625 = getelementptr inbounds i8* %620, i64 -8
  %626 = bitcast i8* %625 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %627, label %631

; <label>:627                                     ; preds = %624
  %628 = bitcast i32* %385 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %628)
  %629 = atomicrmw volatile add i32* %626, i32 -1 acq_rel
  store i32 %629, i32* %385, align 4
  %630 = load volatile i32* %385, align 4
  call void @llvm.lifetime.end(i64 4, i8* %628)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i84

; <label>:631                                     ; preds = %624
  %632 = load i32* %626, align 4, !tbaa !8
  %633 = add nsw i32 %632, -1
  store i32 %633, i32* %626, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i84

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i84: ; preds = %631, %627
  %.0.i.i.i.i.i83 = phi i32 [ %630, %627 ], [ %632, %631 ]
  %634 = icmp slt i32 %.0.i.i.i.i.i83, 1
  br i1 %634, label %635, label %.body86

; <label>:635                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i84
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %622, %"class.std::allocator.0"* %386) #1
  br label %.body86

; <label>:636                                     ; preds = %.noexc85
  %637 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 2
  store i32 0, i32* %637, align 8, !tbaa !10
  %638 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 3
  store i32 0, i32* %638, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %402)
          to label %639 unwind label %2916

; <label>:639                                     ; preds = %636
  %640 = getelementptr inbounds %"class.std::allocator.0"* %384, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %640)
  %641 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 1, i32 0, i32 0
  %642 = load i8** %641, align 8, !tbaa !1
  %643 = getelementptr inbounds i8* %642, i64 -24
  %644 = bitcast i8* %643 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %645 = icmp eq i8* %643, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %645, label %658, label %646, !prof !7

; <label>:646                                     ; preds = %639
  %647 = getelementptr inbounds i8* %642, i64 -8
  %648 = bitcast i8* %647 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %649, label %653

; <label>:649                                     ; preds = %646
  %650 = bitcast i32* %383 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %650)
  %651 = atomicrmw volatile add i32* %648, i32 -1 acq_rel
  store i32 %651, i32* %383, align 4
  %652 = load volatile i32* %383, align 4
  call void @llvm.lifetime.end(i64 4, i8* %650)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i90

; <label>:653                                     ; preds = %646
  %654 = load i32* %648, align 4, !tbaa !8
  %655 = add nsw i32 %654, -1
  store i32 %655, i32* %648, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i90

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i90: ; preds = %653, %649
  %.0.i.i.i.i.i89 = phi i32 [ %652, %649 ], [ %654, %653 ]
  %656 = icmp slt i32 %.0.i.i.i.i.i89, 1
  br i1 %656, label %657, label %658

; <label>:657                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i90
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %644, %"class.std::allocator.0"* %384) #1
  br label %658

; <label>:658                                     ; preds = %657, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i90, %639
  call void @llvm.lifetime.end(i64 1, i8* %640)
  %659 = getelementptr inbounds %"class.std::allocator.0"* %382, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %659)
  %660 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 0, i32 0, i32 0
  %661 = load i8** %660, align 8, !tbaa !1
  %662 = getelementptr inbounds i8* %661, i64 -24
  %663 = bitcast i8* %662 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %664 = icmp eq i8* %662, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %664, label %677, label %665, !prof !7

; <label>:665                                     ; preds = %658
  %666 = getelementptr inbounds i8* %661, i64 -8
  %667 = bitcast i8* %666 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %668, label %672

; <label>:668                                     ; preds = %665
  %669 = bitcast i32* %381 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %669)
  %670 = atomicrmw volatile add i32* %667, i32 -1 acq_rel
  store i32 %670, i32* %381, align 4
  %671 = load volatile i32* %381, align 4
  call void @llvm.lifetime.end(i64 4, i8* %669)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i92

; <label>:672                                     ; preds = %665
  %673 = load i32* %667, align 4, !tbaa !8
  %674 = add nsw i32 %673, -1
  store i32 %674, i32* %667, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i92

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i92: ; preds = %672, %668
  %.0.i.i.i.i1.i91 = phi i32 [ %671, %668 ], [ %673, %672 ]
  %675 = icmp slt i32 %.0.i.i.i.i1.i91, 1
  br i1 %675, label %676, label %677

; <label>:676                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i92
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %663, %"class.std::allocator.0"* %382) #1
  br label %677

; <label>:677                                     ; preds = %676, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i92, %658
  call void @llvm.lifetime.end(i64 1, i8* %659)
  %678 = getelementptr inbounds %"class.std::allocator.0"* %380, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %678)
  %679 = getelementptr inbounds %"class.std::basic_string"* %405, i64 0, i32 0, i32 0
  %680 = load i8** %679, align 8, !tbaa !1
  %681 = getelementptr inbounds i8* %680, i64 -24
  %682 = bitcast i8* %681 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %683 = icmp eq i8* %681, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %683, label %696, label %684, !prof !7

; <label>:684                                     ; preds = %677
  %685 = getelementptr inbounds i8* %680, i64 -8
  %686 = bitcast i8* %685 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %687, label %691

; <label>:687                                     ; preds = %684
  %688 = bitcast i32* %379 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %688)
  %689 = atomicrmw volatile add i32* %686, i32 -1 acq_rel
  store i32 %689, i32* %379, align 4
  %690 = load volatile i32* %379, align 4
  call void @llvm.lifetime.end(i64 4, i8* %688)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i95

; <label>:691                                     ; preds = %684
  %692 = load i32* %686, align 4, !tbaa !8
  %693 = add nsw i32 %692, -1
  store i32 %693, i32* %686, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i95

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i95: ; preds = %691, %687
  %.0.i.i.i.i94 = phi i32 [ %690, %687 ], [ %692, %691 ]
  %694 = icmp slt i32 %.0.i.i.i.i94, 1
  br i1 %694, label %695, label %696

; <label>:695                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i95
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %682, %"class.std::allocator.0"* %380) #1
  br label %696

; <label>:696                                     ; preds = %695, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i95, %677
  call void @llvm.lifetime.end(i64 1, i8* %678)
  %697 = getelementptr inbounds %"class.std::allocator.0"* %378, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %697)
  %698 = getelementptr inbounds %"class.std::basic_string"* %403, i64 0, i32 0, i32 0
  %699 = load i8** %698, align 8, !tbaa !1
  %700 = getelementptr inbounds i8* %699, i64 -24
  %701 = bitcast i8* %700 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %702 = icmp eq i8* %700, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %702, label %715, label %703, !prof !7

; <label>:703                                     ; preds = %696
  %704 = getelementptr inbounds i8* %699, i64 -8
  %705 = bitcast i8* %704 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %706, label %710

; <label>:706                                     ; preds = %703
  %707 = bitcast i32* %377 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %707)
  %708 = atomicrmw volatile add i32* %705, i32 -1 acq_rel
  store i32 %708, i32* %377, align 4
  %709 = load volatile i32* %377, align 4
  call void @llvm.lifetime.end(i64 4, i8* %707)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i98

; <label>:710                                     ; preds = %703
  %711 = load i32* %705, align 4, !tbaa !8
  %712 = add nsw i32 %711, -1
  store i32 %712, i32* %705, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i98

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i98: ; preds = %710, %706
  %.0.i.i.i.i97 = phi i32 [ %709, %706 ], [ %711, %710 ]
  %713 = icmp slt i32 %.0.i.i.i.i97, 1
  br i1 %713, label %714, label %715

; <label>:714                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i98
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %701, %"class.std::allocator.0"* %378) #1
  br label %715

; <label>:715                                     ; preds = %714, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i98, %696
  call void @llvm.lifetime.end(i64 1, i8* %697)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %408, i8* getelementptr inbounds ([6 x i8]* @.str2, i64 0, i64 0), %"class.std::allocator.0"* %409)
          to label %716 unwind label %2993

; <label>:716                                     ; preds = %715
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %410, i8* getelementptr inbounds ([12 x i8]* @.str4, i64 0, i64 0), %"class.std::allocator.0"* %411)
          to label %717 unwind label %2997

; <label>:717                                     ; preds = %716
  %718 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %718, %"class.std::basic_string"* %408)
          to label %.noexc105 unwind label %3001

.noexc105:                                        ; preds = %717
  %719 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %719, %"class.std::basic_string"* %410)
          to label %740 unwind label %720

; <label>:720                                     ; preds = %.noexc105
  %721 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %722 = getelementptr inbounds %"class.std::allocator.0"* %376, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %722)
  %723 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 0, i32 0, i32 0
  %724 = load i8** %723, align 8, !tbaa !1
  %725 = getelementptr inbounds i8* %724, i64 -24
  %726 = bitcast i8* %725 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %727 = icmp eq i8* %725, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %727, label %.body106, label %728, !prof !7

; <label>:728                                     ; preds = %720
  %729 = getelementptr inbounds i8* %724, i64 -8
  %730 = bitcast i8* %729 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %731, label %735

; <label>:731                                     ; preds = %728
  %732 = bitcast i32* %375 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %732)
  %733 = atomicrmw volatile add i32* %730, i32 -1 acq_rel
  store i32 %733, i32* %375, align 4
  %734 = load volatile i32* %375, align 4
  call void @llvm.lifetime.end(i64 4, i8* %732)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i104

; <label>:735                                     ; preds = %728
  %736 = load i32* %730, align 4, !tbaa !8
  %737 = add nsw i32 %736, -1
  store i32 %737, i32* %730, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i104

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i104: ; preds = %735, %731
  %.0.i.i.i.i.i103 = phi i32 [ %734, %731 ], [ %736, %735 ]
  %738 = icmp slt i32 %.0.i.i.i.i.i103, 1
  br i1 %738, label %739, label %.body106

; <label>:739                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i104
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %726, %"class.std::allocator.0"* %376) #1
  br label %.body106

; <label>:740                                     ; preds = %.noexc105
  %741 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 2
  store i32 0, i32* %741, align 8, !tbaa !10
  %742 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 3
  store i32 1, i32* %742, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %407)
          to label %743 unwind label %3005

; <label>:743                                     ; preds = %740
  %744 = getelementptr inbounds %"class.std::allocator.0"* %374, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %744)
  %745 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 1, i32 0, i32 0
  %746 = load i8** %745, align 8, !tbaa !1
  %747 = getelementptr inbounds i8* %746, i64 -24
  %748 = bitcast i8* %747 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %749 = icmp eq i8* %747, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %749, label %762, label %750, !prof !7

; <label>:750                                     ; preds = %743
  %751 = getelementptr inbounds i8* %746, i64 -8
  %752 = bitcast i8* %751 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %753, label %757

; <label>:753                                     ; preds = %750
  %754 = bitcast i32* %373 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %754)
  %755 = atomicrmw volatile add i32* %752, i32 -1 acq_rel
  store i32 %755, i32* %373, align 4
  %756 = load volatile i32* %373, align 4
  call void @llvm.lifetime.end(i64 4, i8* %754)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i110

; <label>:757                                     ; preds = %750
  %758 = load i32* %752, align 4, !tbaa !8
  %759 = add nsw i32 %758, -1
  store i32 %759, i32* %752, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i110

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i110: ; preds = %757, %753
  %.0.i.i.i.i.i109 = phi i32 [ %756, %753 ], [ %758, %757 ]
  %760 = icmp slt i32 %.0.i.i.i.i.i109, 1
  br i1 %760, label %761, label %762

; <label>:761                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i110
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %748, %"class.std::allocator.0"* %374) #1
  br label %762

; <label>:762                                     ; preds = %761, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i110, %743
  call void @llvm.lifetime.end(i64 1, i8* %744)
  %763 = getelementptr inbounds %"class.std::allocator.0"* %372, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %763)
  %764 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 0, i32 0, i32 0
  %765 = load i8** %764, align 8, !tbaa !1
  %766 = getelementptr inbounds i8* %765, i64 -24
  %767 = bitcast i8* %766 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %768 = icmp eq i8* %766, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %768, label %781, label %769, !prof !7

; <label>:769                                     ; preds = %762
  %770 = getelementptr inbounds i8* %765, i64 -8
  %771 = bitcast i8* %770 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %772, label %776

; <label>:772                                     ; preds = %769
  %773 = bitcast i32* %371 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %773)
  %774 = atomicrmw volatile add i32* %771, i32 -1 acq_rel
  store i32 %774, i32* %371, align 4
  %775 = load volatile i32* %371, align 4
  call void @llvm.lifetime.end(i64 4, i8* %773)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i112

; <label>:776                                     ; preds = %769
  %777 = load i32* %771, align 4, !tbaa !8
  %778 = add nsw i32 %777, -1
  store i32 %778, i32* %771, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i112

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i112: ; preds = %776, %772
  %.0.i.i.i.i1.i111 = phi i32 [ %775, %772 ], [ %777, %776 ]
  %779 = icmp slt i32 %.0.i.i.i.i1.i111, 1
  br i1 %779, label %780, label %781

; <label>:780                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i112
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %767, %"class.std::allocator.0"* %372) #1
  br label %781

; <label>:781                                     ; preds = %780, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i112, %762
  call void @llvm.lifetime.end(i64 1, i8* %763)
  %782 = getelementptr inbounds %"class.std::allocator.0"* %370, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %782)
  %783 = getelementptr inbounds %"class.std::basic_string"* %410, i64 0, i32 0, i32 0
  %784 = load i8** %783, align 8, !tbaa !1
  %785 = getelementptr inbounds i8* %784, i64 -24
  %786 = bitcast i8* %785 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %787 = icmp eq i8* %785, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %787, label %800, label %788, !prof !7

; <label>:788                                     ; preds = %781
  %789 = getelementptr inbounds i8* %784, i64 -8
  %790 = bitcast i8* %789 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %791, label %795

; <label>:791                                     ; preds = %788
  %792 = bitcast i32* %369 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %792)
  %793 = atomicrmw volatile add i32* %790, i32 -1 acq_rel
  store i32 %793, i32* %369, align 4
  %794 = load volatile i32* %369, align 4
  call void @llvm.lifetime.end(i64 4, i8* %792)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i115

; <label>:795                                     ; preds = %788
  %796 = load i32* %790, align 4, !tbaa !8
  %797 = add nsw i32 %796, -1
  store i32 %797, i32* %790, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i115

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i115: ; preds = %795, %791
  %.0.i.i.i.i114 = phi i32 [ %794, %791 ], [ %796, %795 ]
  %798 = icmp slt i32 %.0.i.i.i.i114, 1
  br i1 %798, label %799, label %800

; <label>:799                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i115
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %786, %"class.std::allocator.0"* %370) #1
  br label %800

; <label>:800                                     ; preds = %799, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i115, %781
  call void @llvm.lifetime.end(i64 1, i8* %782)
  %801 = getelementptr inbounds %"class.std::allocator.0"* %368, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %801)
  %802 = getelementptr inbounds %"class.std::basic_string"* %408, i64 0, i32 0, i32 0
  %803 = load i8** %802, align 8, !tbaa !1
  %804 = getelementptr inbounds i8* %803, i64 -24
  %805 = bitcast i8* %804 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %806 = icmp eq i8* %804, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %806, label %819, label %807, !prof !7

; <label>:807                                     ; preds = %800
  %808 = getelementptr inbounds i8* %803, i64 -8
  %809 = bitcast i8* %808 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %810, label %814

; <label>:810                                     ; preds = %807
  %811 = bitcast i32* %367 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %811)
  %812 = atomicrmw volatile add i32* %809, i32 -1 acq_rel
  store i32 %812, i32* %367, align 4
  %813 = load volatile i32* %367, align 4
  call void @llvm.lifetime.end(i64 4, i8* %811)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i118

; <label>:814                                     ; preds = %807
  %815 = load i32* %809, align 4, !tbaa !8
  %816 = add nsw i32 %815, -1
  store i32 %816, i32* %809, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i118

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i118: ; preds = %814, %810
  %.0.i.i.i.i117 = phi i32 [ %813, %810 ], [ %815, %814 ]
  %817 = icmp slt i32 %.0.i.i.i.i117, 1
  br i1 %817, label %818, label %819

; <label>:818                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i118
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %805, %"class.std::allocator.0"* %368) #1
  br label %819

; <label>:819                                     ; preds = %818, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i118, %800
  call void @llvm.lifetime.end(i64 1, i8* %801)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %413, i8* getelementptr inbounds ([6 x i8]* @.str5, i64 0, i64 0), %"class.std::allocator.0"* %414)
          to label %820 unwind label %3082

; <label>:820                                     ; preds = %819
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %415, i8* getelementptr inbounds ([11 x i8]* @.str3, i64 0, i64 0), %"class.std::allocator.0"* %416)
          to label %821 unwind label %3086

; <label>:821                                     ; preds = %820
  %822 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %822, %"class.std::basic_string"* %413)
          to label %.noexc122 unwind label %3090

.noexc122:                                        ; preds = %821
  %823 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %823, %"class.std::basic_string"* %415)
          to label %844 unwind label %824

; <label>:824                                     ; preds = %.noexc122
  %825 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %826 = getelementptr inbounds %"class.std::allocator.0"* %366, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %826)
  %827 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 0, i32 0, i32 0
  %828 = load i8** %827, align 8, !tbaa !1
  %829 = getelementptr inbounds i8* %828, i64 -24
  %830 = bitcast i8* %829 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %831 = icmp eq i8* %829, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %831, label %.body123, label %832, !prof !7

; <label>:832                                     ; preds = %824
  %833 = getelementptr inbounds i8* %828, i64 -8
  %834 = bitcast i8* %833 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %835, label %839

; <label>:835                                     ; preds = %832
  %836 = bitcast i32* %365 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %836)
  %837 = atomicrmw volatile add i32* %834, i32 -1 acq_rel
  store i32 %837, i32* %365, align 4
  %838 = load volatile i32* %365, align 4
  call void @llvm.lifetime.end(i64 4, i8* %836)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i121

; <label>:839                                     ; preds = %832
  %840 = load i32* %834, align 4, !tbaa !8
  %841 = add nsw i32 %840, -1
  store i32 %841, i32* %834, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i121

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i121: ; preds = %839, %835
  %.0.i.i.i.i.i120 = phi i32 [ %838, %835 ], [ %840, %839 ]
  %842 = icmp slt i32 %.0.i.i.i.i.i120, 1
  br i1 %842, label %843, label %.body123

; <label>:843                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i121
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %830, %"class.std::allocator.0"* %366) #1
  br label %.body123

; <label>:844                                     ; preds = %.noexc122
  %845 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 2
  store i32 0, i32* %845, align 8, !tbaa !10
  %846 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 3
  store i32 0, i32* %846, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %412)
          to label %847 unwind label %3094

; <label>:847                                     ; preds = %844
  %848 = getelementptr inbounds %"class.std::allocator.0"* %364, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %848)
  %849 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 1, i32 0, i32 0
  %850 = load i8** %849, align 8, !tbaa !1
  %851 = getelementptr inbounds i8* %850, i64 -24
  %852 = bitcast i8* %851 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %853 = icmp eq i8* %851, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %853, label %866, label %854, !prof !7

; <label>:854                                     ; preds = %847
  %855 = getelementptr inbounds i8* %850, i64 -8
  %856 = bitcast i8* %855 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %857, label %861

; <label>:857                                     ; preds = %854
  %858 = bitcast i32* %363 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %858)
  %859 = atomicrmw volatile add i32* %856, i32 -1 acq_rel
  store i32 %859, i32* %363, align 4
  %860 = load volatile i32* %363, align 4
  call void @llvm.lifetime.end(i64 4, i8* %858)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i127

; <label>:861                                     ; preds = %854
  %862 = load i32* %856, align 4, !tbaa !8
  %863 = add nsw i32 %862, -1
  store i32 %863, i32* %856, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i127

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i127: ; preds = %861, %857
  %.0.i.i.i.i.i126 = phi i32 [ %860, %857 ], [ %862, %861 ]
  %864 = icmp slt i32 %.0.i.i.i.i.i126, 1
  br i1 %864, label %865, label %866

; <label>:865                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i127
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %852, %"class.std::allocator.0"* %364) #1
  br label %866

; <label>:866                                     ; preds = %865, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i127, %847
  call void @llvm.lifetime.end(i64 1, i8* %848)
  %867 = getelementptr inbounds %"class.std::allocator.0"* %362, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %867)
  %868 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 0, i32 0, i32 0
  %869 = load i8** %868, align 8, !tbaa !1
  %870 = getelementptr inbounds i8* %869, i64 -24
  %871 = bitcast i8* %870 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %872 = icmp eq i8* %870, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %872, label %885, label %873, !prof !7

; <label>:873                                     ; preds = %866
  %874 = getelementptr inbounds i8* %869, i64 -8
  %875 = bitcast i8* %874 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %876, label %880

; <label>:876                                     ; preds = %873
  %877 = bitcast i32* %361 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %877)
  %878 = atomicrmw volatile add i32* %875, i32 -1 acq_rel
  store i32 %878, i32* %361, align 4
  %879 = load volatile i32* %361, align 4
  call void @llvm.lifetime.end(i64 4, i8* %877)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i129

; <label>:880                                     ; preds = %873
  %881 = load i32* %875, align 4, !tbaa !8
  %882 = add nsw i32 %881, -1
  store i32 %882, i32* %875, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i129

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i129: ; preds = %880, %876
  %.0.i.i.i.i1.i128 = phi i32 [ %879, %876 ], [ %881, %880 ]
  %883 = icmp slt i32 %.0.i.i.i.i1.i128, 1
  br i1 %883, label %884, label %885

; <label>:884                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i129
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %871, %"class.std::allocator.0"* %362) #1
  br label %885

; <label>:885                                     ; preds = %884, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i129, %866
  call void @llvm.lifetime.end(i64 1, i8* %867)
  %886 = getelementptr inbounds %"class.std::allocator.0"* %360, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %886)
  %887 = getelementptr inbounds %"class.std::basic_string"* %415, i64 0, i32 0, i32 0
  %888 = load i8** %887, align 8, !tbaa !1
  %889 = getelementptr inbounds i8* %888, i64 -24
  %890 = bitcast i8* %889 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %891 = icmp eq i8* %889, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %891, label %904, label %892, !prof !7

; <label>:892                                     ; preds = %885
  %893 = getelementptr inbounds i8* %888, i64 -8
  %894 = bitcast i8* %893 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %895, label %899

; <label>:895                                     ; preds = %892
  %896 = bitcast i32* %359 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %896)
  %897 = atomicrmw volatile add i32* %894, i32 -1 acq_rel
  store i32 %897, i32* %359, align 4
  %898 = load volatile i32* %359, align 4
  call void @llvm.lifetime.end(i64 4, i8* %896)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i132

; <label>:899                                     ; preds = %892
  %900 = load i32* %894, align 4, !tbaa !8
  %901 = add nsw i32 %900, -1
  store i32 %901, i32* %894, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i132

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i132: ; preds = %899, %895
  %.0.i.i.i.i131 = phi i32 [ %898, %895 ], [ %900, %899 ]
  %902 = icmp slt i32 %.0.i.i.i.i131, 1
  br i1 %902, label %903, label %904

; <label>:903                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i132
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %890, %"class.std::allocator.0"* %360) #1
  br label %904

; <label>:904                                     ; preds = %903, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i132, %885
  call void @llvm.lifetime.end(i64 1, i8* %886)
  %905 = getelementptr inbounds %"class.std::allocator.0"* %358, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %905)
  %906 = getelementptr inbounds %"class.std::basic_string"* %413, i64 0, i32 0, i32 0
  %907 = load i8** %906, align 8, !tbaa !1
  %908 = getelementptr inbounds i8* %907, i64 -24
  %909 = bitcast i8* %908 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %910 = icmp eq i8* %908, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %910, label %923, label %911, !prof !7

; <label>:911                                     ; preds = %904
  %912 = getelementptr inbounds i8* %907, i64 -8
  %913 = bitcast i8* %912 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %914, label %918

; <label>:914                                     ; preds = %911
  %915 = bitcast i32* %357 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %915)
  %916 = atomicrmw volatile add i32* %913, i32 -1 acq_rel
  store i32 %916, i32* %357, align 4
  %917 = load volatile i32* %357, align 4
  call void @llvm.lifetime.end(i64 4, i8* %915)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i135

; <label>:918                                     ; preds = %911
  %919 = load i32* %913, align 4, !tbaa !8
  %920 = add nsw i32 %919, -1
  store i32 %920, i32* %913, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i135

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i135: ; preds = %918, %914
  %.0.i.i.i.i134 = phi i32 [ %917, %914 ], [ %919, %918 ]
  %921 = icmp slt i32 %.0.i.i.i.i134, 1
  br i1 %921, label %922, label %923

; <label>:922                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i135
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %909, %"class.std::allocator.0"* %358) #1
  br label %923

; <label>:923                                     ; preds = %922, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i135, %904
  call void @llvm.lifetime.end(i64 1, i8* %905)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %418, i8* getelementptr inbounds ([6 x i8]* @.str5, i64 0, i64 0), %"class.std::allocator.0"* %419)
          to label %924 unwind label %3171

; <label>:924                                     ; preds = %923
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %420, i8* getelementptr inbounds ([11 x i8]* @.str6, i64 0, i64 0), %"class.std::allocator.0"* %421)
          to label %925 unwind label %3175

; <label>:925                                     ; preds = %924
  %926 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %926, %"class.std::basic_string"* %418)
          to label %.noexc139 unwind label %3179

.noexc139:                                        ; preds = %925
  %927 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %927, %"class.std::basic_string"* %420)
          to label %948 unwind label %928

; <label>:928                                     ; preds = %.noexc139
  %929 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %930 = getelementptr inbounds %"class.std::allocator.0"* %356, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %930)
  %931 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 0, i32 0, i32 0
  %932 = load i8** %931, align 8, !tbaa !1
  %933 = getelementptr inbounds i8* %932, i64 -24
  %934 = bitcast i8* %933 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %935 = icmp eq i8* %933, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %935, label %.body140, label %936, !prof !7

; <label>:936                                     ; preds = %928
  %937 = getelementptr inbounds i8* %932, i64 -8
  %938 = bitcast i8* %937 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %939, label %943

; <label>:939                                     ; preds = %936
  %940 = bitcast i32* %355 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %940)
  %941 = atomicrmw volatile add i32* %938, i32 -1 acq_rel
  store i32 %941, i32* %355, align 4
  %942 = load volatile i32* %355, align 4
  call void @llvm.lifetime.end(i64 4, i8* %940)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i138

; <label>:943                                     ; preds = %936
  %944 = load i32* %938, align 4, !tbaa !8
  %945 = add nsw i32 %944, -1
  store i32 %945, i32* %938, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i138

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i138: ; preds = %943, %939
  %.0.i.i.i.i.i137 = phi i32 [ %942, %939 ], [ %944, %943 ]
  %946 = icmp slt i32 %.0.i.i.i.i.i137, 1
  br i1 %946, label %947, label %.body140

; <label>:947                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i138
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %934, %"class.std::allocator.0"* %356) #1
  br label %.body140

; <label>:948                                     ; preds = %.noexc139
  %949 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 2
  store i32 0, i32* %949, align 8, !tbaa !10
  %950 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 3
  store i32 0, i32* %950, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %417)
          to label %951 unwind label %3183

; <label>:951                                     ; preds = %948
  %952 = getelementptr inbounds %"class.std::allocator.0"* %354, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %952)
  %953 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 1, i32 0, i32 0
  %954 = load i8** %953, align 8, !tbaa !1
  %955 = getelementptr inbounds i8* %954, i64 -24
  %956 = bitcast i8* %955 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %957 = icmp eq i8* %955, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %957, label %970, label %958, !prof !7

; <label>:958                                     ; preds = %951
  %959 = getelementptr inbounds i8* %954, i64 -8
  %960 = bitcast i8* %959 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %961, label %965

; <label>:961                                     ; preds = %958
  %962 = bitcast i32* %353 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %962)
  %963 = atomicrmw volatile add i32* %960, i32 -1 acq_rel
  store i32 %963, i32* %353, align 4
  %964 = load volatile i32* %353, align 4
  call void @llvm.lifetime.end(i64 4, i8* %962)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i144

; <label>:965                                     ; preds = %958
  %966 = load i32* %960, align 4, !tbaa !8
  %967 = add nsw i32 %966, -1
  store i32 %967, i32* %960, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i144

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i144: ; preds = %965, %961
  %.0.i.i.i.i.i143 = phi i32 [ %964, %961 ], [ %966, %965 ]
  %968 = icmp slt i32 %.0.i.i.i.i.i143, 1
  br i1 %968, label %969, label %970

; <label>:969                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i144
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %956, %"class.std::allocator.0"* %354) #1
  br label %970

; <label>:970                                     ; preds = %969, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i144, %951
  call void @llvm.lifetime.end(i64 1, i8* %952)
  %971 = getelementptr inbounds %"class.std::allocator.0"* %352, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %971)
  %972 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 0, i32 0, i32 0
  %973 = load i8** %972, align 8, !tbaa !1
  %974 = getelementptr inbounds i8* %973, i64 -24
  %975 = bitcast i8* %974 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %976 = icmp eq i8* %974, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %976, label %989, label %977, !prof !7

; <label>:977                                     ; preds = %970
  %978 = getelementptr inbounds i8* %973, i64 -8
  %979 = bitcast i8* %978 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %980, label %984

; <label>:980                                     ; preds = %977
  %981 = bitcast i32* %351 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %981)
  %982 = atomicrmw volatile add i32* %979, i32 -1 acq_rel
  store i32 %982, i32* %351, align 4
  %983 = load volatile i32* %351, align 4
  call void @llvm.lifetime.end(i64 4, i8* %981)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i146

; <label>:984                                     ; preds = %977
  %985 = load i32* %979, align 4, !tbaa !8
  %986 = add nsw i32 %985, -1
  store i32 %986, i32* %979, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i146

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i146: ; preds = %984, %980
  %.0.i.i.i.i1.i145 = phi i32 [ %983, %980 ], [ %985, %984 ]
  %987 = icmp slt i32 %.0.i.i.i.i1.i145, 1
  br i1 %987, label %988, label %989

; <label>:988                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i146
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %975, %"class.std::allocator.0"* %352) #1
  br label %989

; <label>:989                                     ; preds = %988, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i146, %970
  call void @llvm.lifetime.end(i64 1, i8* %971)
  %990 = getelementptr inbounds %"class.std::allocator.0"* %350, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %990)
  %991 = getelementptr inbounds %"class.std::basic_string"* %420, i64 0, i32 0, i32 0
  %992 = load i8** %991, align 8, !tbaa !1
  %993 = getelementptr inbounds i8* %992, i64 -24
  %994 = bitcast i8* %993 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %995 = icmp eq i8* %993, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %995, label %1008, label %996, !prof !7

; <label>:996                                     ; preds = %989
  %997 = getelementptr inbounds i8* %992, i64 -8
  %998 = bitcast i8* %997 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %999, label %1003

; <label>:999                                     ; preds = %996
  %1000 = bitcast i32* %349 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1000)
  %1001 = atomicrmw volatile add i32* %998, i32 -1 acq_rel
  store i32 %1001, i32* %349, align 4
  %1002 = load volatile i32* %349, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1000)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i149

; <label>:1003                                    ; preds = %996
  %1004 = load i32* %998, align 4, !tbaa !8
  %1005 = add nsw i32 %1004, -1
  store i32 %1005, i32* %998, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i149

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i149: ; preds = %1003, %999
  %.0.i.i.i.i148 = phi i32 [ %1002, %999 ], [ %1004, %1003 ]
  %1006 = icmp slt i32 %.0.i.i.i.i148, 1
  br i1 %1006, label %1007, label %1008

; <label>:1007                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i149
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %994, %"class.std::allocator.0"* %350) #1
  br label %1008

; <label>:1008                                    ; preds = %1007, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i149, %989
  call void @llvm.lifetime.end(i64 1, i8* %990)
  %1009 = getelementptr inbounds %"class.std::allocator.0"* %348, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1009)
  %1010 = getelementptr inbounds %"class.std::basic_string"* %418, i64 0, i32 0, i32 0
  %1011 = load i8** %1010, align 8, !tbaa !1
  %1012 = getelementptr inbounds i8* %1011, i64 -24
  %1013 = bitcast i8* %1012 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1014 = icmp eq i8* %1012, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1014, label %1027, label %1015, !prof !7

; <label>:1015                                    ; preds = %1008
  %1016 = getelementptr inbounds i8* %1011, i64 -8
  %1017 = bitcast i8* %1016 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1018, label %1022

; <label>:1018                                    ; preds = %1015
  %1019 = bitcast i32* %347 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1019)
  %1020 = atomicrmw volatile add i32* %1017, i32 -1 acq_rel
  store i32 %1020, i32* %347, align 4
  %1021 = load volatile i32* %347, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1019)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i152

; <label>:1022                                    ; preds = %1015
  %1023 = load i32* %1017, align 4, !tbaa !8
  %1024 = add nsw i32 %1023, -1
  store i32 %1024, i32* %1017, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i152

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i152: ; preds = %1022, %1018
  %.0.i.i.i.i151 = phi i32 [ %1021, %1018 ], [ %1023, %1022 ]
  %1025 = icmp slt i32 %.0.i.i.i.i151, 1
  br i1 %1025, label %1026, label %1027

; <label>:1026                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i152
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1013, %"class.std::allocator.0"* %348) #1
  br label %1027

; <label>:1027                                    ; preds = %1026, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i152, %1008
  call void @llvm.lifetime.end(i64 1, i8* %1009)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %423, i8* getelementptr inbounds ([6 x i8]* @.str5, i64 0, i64 0), %"class.std::allocator.0"* %424)
          to label %1028 unwind label %3260

; <label>:1028                                    ; preds = %1027
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %425, i8* getelementptr inbounds ([12 x i8]* @.str7, i64 0, i64 0), %"class.std::allocator.0"* %426)
          to label %1029 unwind label %3264

; <label>:1029                                    ; preds = %1028
  %1030 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1030, %"class.std::basic_string"* %423)
          to label %.noexc161 unwind label %3268

.noexc161:                                        ; preds = %1029
  %1031 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1031, %"class.std::basic_string"* %425)
          to label %1052 unwind label %1032

; <label>:1032                                    ; preds = %.noexc161
  %1033 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1034 = getelementptr inbounds %"class.std::allocator.0"* %346, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1034)
  %1035 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 0, i32 0, i32 0
  %1036 = load i8** %1035, align 8, !tbaa !1
  %1037 = getelementptr inbounds i8* %1036, i64 -24
  %1038 = bitcast i8* %1037 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1039 = icmp eq i8* %1037, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1039, label %.body162, label %1040, !prof !7

; <label>:1040                                    ; preds = %1032
  %1041 = getelementptr inbounds i8* %1036, i64 -8
  %1042 = bitcast i8* %1041 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1043, label %1047

; <label>:1043                                    ; preds = %1040
  %1044 = bitcast i32* %345 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1044)
  %1045 = atomicrmw volatile add i32* %1042, i32 -1 acq_rel
  store i32 %1045, i32* %345, align 4
  %1046 = load volatile i32* %345, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1044)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i160

; <label>:1047                                    ; preds = %1040
  %1048 = load i32* %1042, align 4, !tbaa !8
  %1049 = add nsw i32 %1048, -1
  store i32 %1049, i32* %1042, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i160

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i160: ; preds = %1047, %1043
  %.0.i.i.i.i.i159 = phi i32 [ %1046, %1043 ], [ %1048, %1047 ]
  %1050 = icmp slt i32 %.0.i.i.i.i.i159, 1
  br i1 %1050, label %1051, label %.body162

; <label>:1051                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i160
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1038, %"class.std::allocator.0"* %346) #1
  br label %.body162

; <label>:1052                                    ; preds = %.noexc161
  %1053 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 2
  store i32 0, i32* %1053, align 8, !tbaa !10
  %1054 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 3
  store i32 1, i32* %1054, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %422)
          to label %1055 unwind label %3272

; <label>:1055                                    ; preds = %1052
  %1056 = getelementptr inbounds %"class.std::allocator.0"* %344, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1056)
  %1057 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 1, i32 0, i32 0
  %1058 = load i8** %1057, align 8, !tbaa !1
  %1059 = getelementptr inbounds i8* %1058, i64 -24
  %1060 = bitcast i8* %1059 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1061 = icmp eq i8* %1059, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1061, label %1074, label %1062, !prof !7

; <label>:1062                                    ; preds = %1055
  %1063 = getelementptr inbounds i8* %1058, i64 -8
  %1064 = bitcast i8* %1063 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1065, label %1069

; <label>:1065                                    ; preds = %1062
  %1066 = bitcast i32* %343 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1066)
  %1067 = atomicrmw volatile add i32* %1064, i32 -1 acq_rel
  store i32 %1067, i32* %343, align 4
  %1068 = load volatile i32* %343, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1066)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i166

; <label>:1069                                    ; preds = %1062
  %1070 = load i32* %1064, align 4, !tbaa !8
  %1071 = add nsw i32 %1070, -1
  store i32 %1071, i32* %1064, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i166

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i166: ; preds = %1069, %1065
  %.0.i.i.i.i.i165 = phi i32 [ %1068, %1065 ], [ %1070, %1069 ]
  %1072 = icmp slt i32 %.0.i.i.i.i.i165, 1
  br i1 %1072, label %1073, label %1074

; <label>:1073                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i166
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1060, %"class.std::allocator.0"* %344) #1
  br label %1074

; <label>:1074                                    ; preds = %1073, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i166, %1055
  call void @llvm.lifetime.end(i64 1, i8* %1056)
  %1075 = getelementptr inbounds %"class.std::allocator.0"* %342, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1075)
  %1076 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 0, i32 0, i32 0
  %1077 = load i8** %1076, align 8, !tbaa !1
  %1078 = getelementptr inbounds i8* %1077, i64 -24
  %1079 = bitcast i8* %1078 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1080 = icmp eq i8* %1078, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1080, label %1093, label %1081, !prof !7

; <label>:1081                                    ; preds = %1074
  %1082 = getelementptr inbounds i8* %1077, i64 -8
  %1083 = bitcast i8* %1082 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1084, label %1088

; <label>:1084                                    ; preds = %1081
  %1085 = bitcast i32* %341 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1085)
  %1086 = atomicrmw volatile add i32* %1083, i32 -1 acq_rel
  store i32 %1086, i32* %341, align 4
  %1087 = load volatile i32* %341, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1085)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i168

; <label>:1088                                    ; preds = %1081
  %1089 = load i32* %1083, align 4, !tbaa !8
  %1090 = add nsw i32 %1089, -1
  store i32 %1090, i32* %1083, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i168

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i168: ; preds = %1088, %1084
  %.0.i.i.i.i1.i167 = phi i32 [ %1087, %1084 ], [ %1089, %1088 ]
  %1091 = icmp slt i32 %.0.i.i.i.i1.i167, 1
  br i1 %1091, label %1092, label %1093

; <label>:1092                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i168
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1079, %"class.std::allocator.0"* %342) #1
  br label %1093

; <label>:1093                                    ; preds = %1092, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i168, %1074
  call void @llvm.lifetime.end(i64 1, i8* %1075)
  %1094 = getelementptr inbounds %"class.std::allocator.0"* %340, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1094)
  %1095 = getelementptr inbounds %"class.std::basic_string"* %425, i64 0, i32 0, i32 0
  %1096 = load i8** %1095, align 8, !tbaa !1
  %1097 = getelementptr inbounds i8* %1096, i64 -24
  %1098 = bitcast i8* %1097 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1099 = icmp eq i8* %1097, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1099, label %1112, label %1100, !prof !7

; <label>:1100                                    ; preds = %1093
  %1101 = getelementptr inbounds i8* %1096, i64 -8
  %1102 = bitcast i8* %1101 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1103, label %1107

; <label>:1103                                    ; preds = %1100
  %1104 = bitcast i32* %339 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1104)
  %1105 = atomicrmw volatile add i32* %1102, i32 -1 acq_rel
  store i32 %1105, i32* %339, align 4
  %1106 = load volatile i32* %339, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1104)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i171

; <label>:1107                                    ; preds = %1100
  %1108 = load i32* %1102, align 4, !tbaa !8
  %1109 = add nsw i32 %1108, -1
  store i32 %1109, i32* %1102, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i171

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i171: ; preds = %1107, %1103
  %.0.i.i.i.i170 = phi i32 [ %1106, %1103 ], [ %1108, %1107 ]
  %1110 = icmp slt i32 %.0.i.i.i.i170, 1
  br i1 %1110, label %1111, label %1112

; <label>:1111                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i171
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1098, %"class.std::allocator.0"* %340) #1
  br label %1112

; <label>:1112                                    ; preds = %1111, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i171, %1093
  call void @llvm.lifetime.end(i64 1, i8* %1094)
  %1113 = getelementptr inbounds %"class.std::allocator.0"* %338, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1113)
  %1114 = getelementptr inbounds %"class.std::basic_string"* %423, i64 0, i32 0, i32 0
  %1115 = load i8** %1114, align 8, !tbaa !1
  %1116 = getelementptr inbounds i8* %1115, i64 -24
  %1117 = bitcast i8* %1116 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1118 = icmp eq i8* %1116, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1118, label %1131, label %1119, !prof !7

; <label>:1119                                    ; preds = %1112
  %1120 = getelementptr inbounds i8* %1115, i64 -8
  %1121 = bitcast i8* %1120 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1122, label %1126

; <label>:1122                                    ; preds = %1119
  %1123 = bitcast i32* %337 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1123)
  %1124 = atomicrmw volatile add i32* %1121, i32 -1 acq_rel
  store i32 %1124, i32* %337, align 4
  %1125 = load volatile i32* %337, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1123)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i174

; <label>:1126                                    ; preds = %1119
  %1127 = load i32* %1121, align 4, !tbaa !8
  %1128 = add nsw i32 %1127, -1
  store i32 %1128, i32* %1121, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i174

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i174: ; preds = %1126, %1122
  %.0.i.i.i.i173 = phi i32 [ %1125, %1122 ], [ %1127, %1126 ]
  %1129 = icmp slt i32 %.0.i.i.i.i173, 1
  br i1 %1129, label %1130, label %1131

; <label>:1130                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i174
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1117, %"class.std::allocator.0"* %338) #1
  br label %1131

; <label>:1131                                    ; preds = %1130, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i174, %1112
  call void @llvm.lifetime.end(i64 1, i8* %1113)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %428, i8* getelementptr inbounds ([7 x i8]* @.str8, i64 0, i64 0), %"class.std::allocator.0"* %429)
          to label %1132 unwind label %3349

; <label>:1132                                    ; preds = %1131
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %430, i8* getelementptr inbounds ([3 x i8]* @.str9, i64 0, i64 0), %"class.std::allocator.0"* %431)
          to label %1133 unwind label %3353

; <label>:1133                                    ; preds = %1132
  %1134 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1134, %"class.std::basic_string"* %428)
          to label %.noexc178 unwind label %3357

.noexc178:                                        ; preds = %1133
  %1135 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1135, %"class.std::basic_string"* %430)
          to label %1156 unwind label %1136

; <label>:1136                                    ; preds = %.noexc178
  %1137 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1138 = getelementptr inbounds %"class.std::allocator.0"* %336, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1138)
  %1139 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 0, i32 0, i32 0
  %1140 = load i8** %1139, align 8, !tbaa !1
  %1141 = getelementptr inbounds i8* %1140, i64 -24
  %1142 = bitcast i8* %1141 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1143 = icmp eq i8* %1141, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1143, label %.body179, label %1144, !prof !7

; <label>:1144                                    ; preds = %1136
  %1145 = getelementptr inbounds i8* %1140, i64 -8
  %1146 = bitcast i8* %1145 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1147, label %1151

; <label>:1147                                    ; preds = %1144
  %1148 = bitcast i32* %335 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1148)
  %1149 = atomicrmw volatile add i32* %1146, i32 -1 acq_rel
  store i32 %1149, i32* %335, align 4
  %1150 = load volatile i32* %335, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1148)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i177

; <label>:1151                                    ; preds = %1144
  %1152 = load i32* %1146, align 4, !tbaa !8
  %1153 = add nsw i32 %1152, -1
  store i32 %1153, i32* %1146, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i177

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i177: ; preds = %1151, %1147
  %.0.i.i.i.i.i176 = phi i32 [ %1150, %1147 ], [ %1152, %1151 ]
  %1154 = icmp slt i32 %.0.i.i.i.i.i176, 1
  br i1 %1154, label %1155, label %.body179

; <label>:1155                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i177
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1142, %"class.std::allocator.0"* %336) #1
  br label %.body179

; <label>:1156                                    ; preds = %.noexc178
  %1157 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 2
  store i32 0, i32* %1157, align 8, !tbaa !10
  %1158 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 3
  store i32 0, i32* %1158, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %427)
          to label %1159 unwind label %3361

; <label>:1159                                    ; preds = %1156
  %1160 = getelementptr inbounds %"class.std::allocator.0"* %334, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1160)
  %1161 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 1, i32 0, i32 0
  %1162 = load i8** %1161, align 8, !tbaa !1
  %1163 = getelementptr inbounds i8* %1162, i64 -24
  %1164 = bitcast i8* %1163 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1165 = icmp eq i8* %1163, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1165, label %1178, label %1166, !prof !7

; <label>:1166                                    ; preds = %1159
  %1167 = getelementptr inbounds i8* %1162, i64 -8
  %1168 = bitcast i8* %1167 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1169, label %1173

; <label>:1169                                    ; preds = %1166
  %1170 = bitcast i32* %333 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1170)
  %1171 = atomicrmw volatile add i32* %1168, i32 -1 acq_rel
  store i32 %1171, i32* %333, align 4
  %1172 = load volatile i32* %333, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1170)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i183

; <label>:1173                                    ; preds = %1166
  %1174 = load i32* %1168, align 4, !tbaa !8
  %1175 = add nsw i32 %1174, -1
  store i32 %1175, i32* %1168, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i183

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i183: ; preds = %1173, %1169
  %.0.i.i.i.i.i182 = phi i32 [ %1172, %1169 ], [ %1174, %1173 ]
  %1176 = icmp slt i32 %.0.i.i.i.i.i182, 1
  br i1 %1176, label %1177, label %1178

; <label>:1177                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i183
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1164, %"class.std::allocator.0"* %334) #1
  br label %1178

; <label>:1178                                    ; preds = %1177, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i183, %1159
  call void @llvm.lifetime.end(i64 1, i8* %1160)
  %1179 = getelementptr inbounds %"class.std::allocator.0"* %332, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1179)
  %1180 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 0, i32 0, i32 0
  %1181 = load i8** %1180, align 8, !tbaa !1
  %1182 = getelementptr inbounds i8* %1181, i64 -24
  %1183 = bitcast i8* %1182 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1184 = icmp eq i8* %1182, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1184, label %1197, label %1185, !prof !7

; <label>:1185                                    ; preds = %1178
  %1186 = getelementptr inbounds i8* %1181, i64 -8
  %1187 = bitcast i8* %1186 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1188, label %1192

; <label>:1188                                    ; preds = %1185
  %1189 = bitcast i32* %331 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1189)
  %1190 = atomicrmw volatile add i32* %1187, i32 -1 acq_rel
  store i32 %1190, i32* %331, align 4
  %1191 = load volatile i32* %331, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1189)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i185

; <label>:1192                                    ; preds = %1185
  %1193 = load i32* %1187, align 4, !tbaa !8
  %1194 = add nsw i32 %1193, -1
  store i32 %1194, i32* %1187, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i185

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i185: ; preds = %1192, %1188
  %.0.i.i.i.i1.i184 = phi i32 [ %1191, %1188 ], [ %1193, %1192 ]
  %1195 = icmp slt i32 %.0.i.i.i.i1.i184, 1
  br i1 %1195, label %1196, label %1197

; <label>:1196                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i185
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1183, %"class.std::allocator.0"* %332) #1
  br label %1197

; <label>:1197                                    ; preds = %1196, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i185, %1178
  call void @llvm.lifetime.end(i64 1, i8* %1179)
  %1198 = getelementptr inbounds %"class.std::allocator.0"* %330, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1198)
  %1199 = getelementptr inbounds %"class.std::basic_string"* %430, i64 0, i32 0, i32 0
  %1200 = load i8** %1199, align 8, !tbaa !1
  %1201 = getelementptr inbounds i8* %1200, i64 -24
  %1202 = bitcast i8* %1201 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1203 = icmp eq i8* %1201, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1203, label %1216, label %1204, !prof !7

; <label>:1204                                    ; preds = %1197
  %1205 = getelementptr inbounds i8* %1200, i64 -8
  %1206 = bitcast i8* %1205 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1207, label %1211

; <label>:1207                                    ; preds = %1204
  %1208 = bitcast i32* %329 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1208)
  %1209 = atomicrmw volatile add i32* %1206, i32 -1 acq_rel
  store i32 %1209, i32* %329, align 4
  %1210 = load volatile i32* %329, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1208)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i188

; <label>:1211                                    ; preds = %1204
  %1212 = load i32* %1206, align 4, !tbaa !8
  %1213 = add nsw i32 %1212, -1
  store i32 %1213, i32* %1206, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i188

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i188: ; preds = %1211, %1207
  %.0.i.i.i.i187 = phi i32 [ %1210, %1207 ], [ %1212, %1211 ]
  %1214 = icmp slt i32 %.0.i.i.i.i187, 1
  br i1 %1214, label %1215, label %1216

; <label>:1215                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i188
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1202, %"class.std::allocator.0"* %330) #1
  br label %1216

; <label>:1216                                    ; preds = %1215, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i188, %1197
  call void @llvm.lifetime.end(i64 1, i8* %1198)
  %1217 = getelementptr inbounds %"class.std::allocator.0"* %328, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1217)
  %1218 = getelementptr inbounds %"class.std::basic_string"* %428, i64 0, i32 0, i32 0
  %1219 = load i8** %1218, align 8, !tbaa !1
  %1220 = getelementptr inbounds i8* %1219, i64 -24
  %1221 = bitcast i8* %1220 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1222 = icmp eq i8* %1220, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1222, label %1235, label %1223, !prof !7

; <label>:1223                                    ; preds = %1216
  %1224 = getelementptr inbounds i8* %1219, i64 -8
  %1225 = bitcast i8* %1224 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1226, label %1230

; <label>:1226                                    ; preds = %1223
  %1227 = bitcast i32* %327 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1227)
  %1228 = atomicrmw volatile add i32* %1225, i32 -1 acq_rel
  store i32 %1228, i32* %327, align 4
  %1229 = load volatile i32* %327, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1227)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i191

; <label>:1230                                    ; preds = %1223
  %1231 = load i32* %1225, align 4, !tbaa !8
  %1232 = add nsw i32 %1231, -1
  store i32 %1232, i32* %1225, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i191

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i191: ; preds = %1230, %1226
  %.0.i.i.i.i190 = phi i32 [ %1229, %1226 ], [ %1231, %1230 ]
  %1233 = icmp slt i32 %.0.i.i.i.i190, 1
  br i1 %1233, label %1234, label %1235

; <label>:1234                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i191
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1221, %"class.std::allocator.0"* %328) #1
  br label %1235

; <label>:1235                                    ; preds = %1234, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i191, %1216
  call void @llvm.lifetime.end(i64 1, i8* %1217)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %433, i8* getelementptr inbounds ([7 x i8]* @.str8, i64 0, i64 0), %"class.std::allocator.0"* %434)
          to label %1236 unwind label %3438

; <label>:1236                                    ; preds = %1235
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %435, i8* getelementptr inbounds ([3 x i8]* @.str10, i64 0, i64 0), %"class.std::allocator.0"* %436)
          to label %1237 unwind label %3442

; <label>:1237                                    ; preds = %1236
  %1238 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1238, %"class.std::basic_string"* %433)
          to label %.noexc199 unwind label %3446

.noexc199:                                        ; preds = %1237
  %1239 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1239, %"class.std::basic_string"* %435)
          to label %1260 unwind label %1240

; <label>:1240                                    ; preds = %.noexc199
  %1241 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1242 = getelementptr inbounds %"class.std::allocator.0"* %326, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1242)
  %1243 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 0, i32 0, i32 0
  %1244 = load i8** %1243, align 8, !tbaa !1
  %1245 = getelementptr inbounds i8* %1244, i64 -24
  %1246 = bitcast i8* %1245 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1247 = icmp eq i8* %1245, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1247, label %.body200, label %1248, !prof !7

; <label>:1248                                    ; preds = %1240
  %1249 = getelementptr inbounds i8* %1244, i64 -8
  %1250 = bitcast i8* %1249 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1251, label %1255

; <label>:1251                                    ; preds = %1248
  %1252 = bitcast i32* %325 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1252)
  %1253 = atomicrmw volatile add i32* %1250, i32 -1 acq_rel
  store i32 %1253, i32* %325, align 4
  %1254 = load volatile i32* %325, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1252)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i198

; <label>:1255                                    ; preds = %1248
  %1256 = load i32* %1250, align 4, !tbaa !8
  %1257 = add nsw i32 %1256, -1
  store i32 %1257, i32* %1250, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i198

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i198: ; preds = %1255, %1251
  %.0.i.i.i.i.i197 = phi i32 [ %1254, %1251 ], [ %1256, %1255 ]
  %1258 = icmp slt i32 %.0.i.i.i.i.i197, 1
  br i1 %1258, label %1259, label %.body200

; <label>:1259                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i198
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1246, %"class.std::allocator.0"* %326) #1
  br label %.body200

; <label>:1260                                    ; preds = %.noexc199
  %1261 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 2
  store i32 0, i32* %1261, align 8, !tbaa !10
  %1262 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 3
  store i32 1, i32* %1262, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %432)
          to label %1263 unwind label %3450

; <label>:1263                                    ; preds = %1260
  %1264 = getelementptr inbounds %"class.std::allocator.0"* %324, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1264)
  %1265 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 1, i32 0, i32 0
  %1266 = load i8** %1265, align 8, !tbaa !1
  %1267 = getelementptr inbounds i8* %1266, i64 -24
  %1268 = bitcast i8* %1267 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1269 = icmp eq i8* %1267, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1269, label %1282, label %1270, !prof !7

; <label>:1270                                    ; preds = %1263
  %1271 = getelementptr inbounds i8* %1266, i64 -8
  %1272 = bitcast i8* %1271 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1273, label %1277

; <label>:1273                                    ; preds = %1270
  %1274 = bitcast i32* %323 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1274)
  %1275 = atomicrmw volatile add i32* %1272, i32 -1 acq_rel
  store i32 %1275, i32* %323, align 4
  %1276 = load volatile i32* %323, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1274)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i204

; <label>:1277                                    ; preds = %1270
  %1278 = load i32* %1272, align 4, !tbaa !8
  %1279 = add nsw i32 %1278, -1
  store i32 %1279, i32* %1272, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i204

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i204: ; preds = %1277, %1273
  %.0.i.i.i.i.i203 = phi i32 [ %1276, %1273 ], [ %1278, %1277 ]
  %1280 = icmp slt i32 %.0.i.i.i.i.i203, 1
  br i1 %1280, label %1281, label %1282

; <label>:1281                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i204
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1268, %"class.std::allocator.0"* %324) #1
  br label %1282

; <label>:1282                                    ; preds = %1281, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i204, %1263
  call void @llvm.lifetime.end(i64 1, i8* %1264)
  %1283 = getelementptr inbounds %"class.std::allocator.0"* %322, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1283)
  %1284 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 0, i32 0, i32 0
  %1285 = load i8** %1284, align 8, !tbaa !1
  %1286 = getelementptr inbounds i8* %1285, i64 -24
  %1287 = bitcast i8* %1286 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1288 = icmp eq i8* %1286, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1288, label %1301, label %1289, !prof !7

; <label>:1289                                    ; preds = %1282
  %1290 = getelementptr inbounds i8* %1285, i64 -8
  %1291 = bitcast i8* %1290 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1292, label %1296

; <label>:1292                                    ; preds = %1289
  %1293 = bitcast i32* %321 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1293)
  %1294 = atomicrmw volatile add i32* %1291, i32 -1 acq_rel
  store i32 %1294, i32* %321, align 4
  %1295 = load volatile i32* %321, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1293)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i206

; <label>:1296                                    ; preds = %1289
  %1297 = load i32* %1291, align 4, !tbaa !8
  %1298 = add nsw i32 %1297, -1
  store i32 %1298, i32* %1291, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i206

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i206: ; preds = %1296, %1292
  %.0.i.i.i.i1.i205 = phi i32 [ %1295, %1292 ], [ %1297, %1296 ]
  %1299 = icmp slt i32 %.0.i.i.i.i1.i205, 1
  br i1 %1299, label %1300, label %1301

; <label>:1300                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i206
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1287, %"class.std::allocator.0"* %322) #1
  br label %1301

; <label>:1301                                    ; preds = %1300, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i206, %1282
  call void @llvm.lifetime.end(i64 1, i8* %1283)
  %1302 = getelementptr inbounds %"class.std::allocator.0"* %320, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1302)
  %1303 = getelementptr inbounds %"class.std::basic_string"* %435, i64 0, i32 0, i32 0
  %1304 = load i8** %1303, align 8, !tbaa !1
  %1305 = getelementptr inbounds i8* %1304, i64 -24
  %1306 = bitcast i8* %1305 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1307 = icmp eq i8* %1305, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1307, label %1320, label %1308, !prof !7

; <label>:1308                                    ; preds = %1301
  %1309 = getelementptr inbounds i8* %1304, i64 -8
  %1310 = bitcast i8* %1309 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1311, label %1315

; <label>:1311                                    ; preds = %1308
  %1312 = bitcast i32* %319 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1312)
  %1313 = atomicrmw volatile add i32* %1310, i32 -1 acq_rel
  store i32 %1313, i32* %319, align 4
  %1314 = load volatile i32* %319, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1312)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i209

; <label>:1315                                    ; preds = %1308
  %1316 = load i32* %1310, align 4, !tbaa !8
  %1317 = add nsw i32 %1316, -1
  store i32 %1317, i32* %1310, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i209

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i209: ; preds = %1315, %1311
  %.0.i.i.i.i208 = phi i32 [ %1314, %1311 ], [ %1316, %1315 ]
  %1318 = icmp slt i32 %.0.i.i.i.i208, 1
  br i1 %1318, label %1319, label %1320

; <label>:1319                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i209
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1306, %"class.std::allocator.0"* %320) #1
  br label %1320

; <label>:1320                                    ; preds = %1319, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i209, %1301
  call void @llvm.lifetime.end(i64 1, i8* %1302)
  %1321 = getelementptr inbounds %"class.std::allocator.0"* %318, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1321)
  %1322 = getelementptr inbounds %"class.std::basic_string"* %433, i64 0, i32 0, i32 0
  %1323 = load i8** %1322, align 8, !tbaa !1
  %1324 = getelementptr inbounds i8* %1323, i64 -24
  %1325 = bitcast i8* %1324 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1326 = icmp eq i8* %1324, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1326, label %1339, label %1327, !prof !7

; <label>:1327                                    ; preds = %1320
  %1328 = getelementptr inbounds i8* %1323, i64 -8
  %1329 = bitcast i8* %1328 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1330, label %1334

; <label>:1330                                    ; preds = %1327
  %1331 = bitcast i32* %317 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1331)
  %1332 = atomicrmw volatile add i32* %1329, i32 -1 acq_rel
  store i32 %1332, i32* %317, align 4
  %1333 = load volatile i32* %317, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1331)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i212

; <label>:1334                                    ; preds = %1327
  %1335 = load i32* %1329, align 4, !tbaa !8
  %1336 = add nsw i32 %1335, -1
  store i32 %1336, i32* %1329, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i212

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i212: ; preds = %1334, %1330
  %.0.i.i.i.i211 = phi i32 [ %1333, %1330 ], [ %1335, %1334 ]
  %1337 = icmp slt i32 %.0.i.i.i.i211, 1
  br i1 %1337, label %1338, label %1339

; <label>:1338                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i212
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1325, %"class.std::allocator.0"* %318) #1
  br label %1339

; <label>:1339                                    ; preds = %1338, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i212, %1320
  call void @llvm.lifetime.end(i64 1, i8* %1321)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %438, i8* getelementptr inbounds ([8 x i8]* @.str11, i64 0, i64 0), %"class.std::allocator.0"* %439)
          to label %1340 unwind label %3527

; <label>:1340                                    ; preds = %1339
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %440, i8* getelementptr inbounds ([3 x i8]* @.str10, i64 0, i64 0), %"class.std::allocator.0"* %441)
          to label %1341 unwind label %3531

; <label>:1341                                    ; preds = %1340
  %1342 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1342, %"class.std::basic_string"* %438)
          to label %.noexc216 unwind label %3535

.noexc216:                                        ; preds = %1341
  %1343 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1343, %"class.std::basic_string"* %440)
          to label %1364 unwind label %1344

; <label>:1344                                    ; preds = %.noexc216
  %1345 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1346 = getelementptr inbounds %"class.std::allocator.0"* %316, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1346)
  %1347 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 0, i32 0, i32 0
  %1348 = load i8** %1347, align 8, !tbaa !1
  %1349 = getelementptr inbounds i8* %1348, i64 -24
  %1350 = bitcast i8* %1349 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1351 = icmp eq i8* %1349, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1351, label %.body217, label %1352, !prof !7

; <label>:1352                                    ; preds = %1344
  %1353 = getelementptr inbounds i8* %1348, i64 -8
  %1354 = bitcast i8* %1353 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1355, label %1359

; <label>:1355                                    ; preds = %1352
  %1356 = bitcast i32* %315 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1356)
  %1357 = atomicrmw volatile add i32* %1354, i32 -1 acq_rel
  store i32 %1357, i32* %315, align 4
  %1358 = load volatile i32* %315, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1356)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i215

; <label>:1359                                    ; preds = %1352
  %1360 = load i32* %1354, align 4, !tbaa !8
  %1361 = add nsw i32 %1360, -1
  store i32 %1361, i32* %1354, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i215

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i215: ; preds = %1359, %1355
  %.0.i.i.i.i.i214 = phi i32 [ %1358, %1355 ], [ %1360, %1359 ]
  %1362 = icmp slt i32 %.0.i.i.i.i.i214, 1
  br i1 %1362, label %1363, label %.body217

; <label>:1363                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i215
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1350, %"class.std::allocator.0"* %316) #1
  br label %.body217

; <label>:1364                                    ; preds = %.noexc216
  %1365 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 2
  store i32 0, i32* %1365, align 8, !tbaa !10
  %1366 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 3
  store i32 0, i32* %1366, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %437)
          to label %1367 unwind label %3539

; <label>:1367                                    ; preds = %1364
  %1368 = getelementptr inbounds %"class.std::allocator.0"* %314, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1368)
  %1369 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 1, i32 0, i32 0
  %1370 = load i8** %1369, align 8, !tbaa !1
  %1371 = getelementptr inbounds i8* %1370, i64 -24
  %1372 = bitcast i8* %1371 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1373 = icmp eq i8* %1371, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1373, label %1386, label %1374, !prof !7

; <label>:1374                                    ; preds = %1367
  %1375 = getelementptr inbounds i8* %1370, i64 -8
  %1376 = bitcast i8* %1375 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1377, label %1381

; <label>:1377                                    ; preds = %1374
  %1378 = bitcast i32* %313 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1378)
  %1379 = atomicrmw volatile add i32* %1376, i32 -1 acq_rel
  store i32 %1379, i32* %313, align 4
  %1380 = load volatile i32* %313, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1378)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i221

; <label>:1381                                    ; preds = %1374
  %1382 = load i32* %1376, align 4, !tbaa !8
  %1383 = add nsw i32 %1382, -1
  store i32 %1383, i32* %1376, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i221

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i221: ; preds = %1381, %1377
  %.0.i.i.i.i.i220 = phi i32 [ %1380, %1377 ], [ %1382, %1381 ]
  %1384 = icmp slt i32 %.0.i.i.i.i.i220, 1
  br i1 %1384, label %1385, label %1386

; <label>:1385                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i221
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1372, %"class.std::allocator.0"* %314) #1
  br label %1386

; <label>:1386                                    ; preds = %1385, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i221, %1367
  call void @llvm.lifetime.end(i64 1, i8* %1368)
  %1387 = getelementptr inbounds %"class.std::allocator.0"* %312, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1387)
  %1388 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 0, i32 0, i32 0
  %1389 = load i8** %1388, align 8, !tbaa !1
  %1390 = getelementptr inbounds i8* %1389, i64 -24
  %1391 = bitcast i8* %1390 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1392 = icmp eq i8* %1390, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1392, label %1405, label %1393, !prof !7

; <label>:1393                                    ; preds = %1386
  %1394 = getelementptr inbounds i8* %1389, i64 -8
  %1395 = bitcast i8* %1394 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1396, label %1400

; <label>:1396                                    ; preds = %1393
  %1397 = bitcast i32* %311 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1397)
  %1398 = atomicrmw volatile add i32* %1395, i32 -1 acq_rel
  store i32 %1398, i32* %311, align 4
  %1399 = load volatile i32* %311, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1397)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i223

; <label>:1400                                    ; preds = %1393
  %1401 = load i32* %1395, align 4, !tbaa !8
  %1402 = add nsw i32 %1401, -1
  store i32 %1402, i32* %1395, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i223

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i223: ; preds = %1400, %1396
  %.0.i.i.i.i1.i222 = phi i32 [ %1399, %1396 ], [ %1401, %1400 ]
  %1403 = icmp slt i32 %.0.i.i.i.i1.i222, 1
  br i1 %1403, label %1404, label %1405

; <label>:1404                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i223
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1391, %"class.std::allocator.0"* %312) #1
  br label %1405

; <label>:1405                                    ; preds = %1404, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i223, %1386
  call void @llvm.lifetime.end(i64 1, i8* %1387)
  %1406 = getelementptr inbounds %"class.std::allocator.0"* %310, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1406)
  %1407 = getelementptr inbounds %"class.std::basic_string"* %440, i64 0, i32 0, i32 0
  %1408 = load i8** %1407, align 8, !tbaa !1
  %1409 = getelementptr inbounds i8* %1408, i64 -24
  %1410 = bitcast i8* %1409 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1411 = icmp eq i8* %1409, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1411, label %1424, label %1412, !prof !7

; <label>:1412                                    ; preds = %1405
  %1413 = getelementptr inbounds i8* %1408, i64 -8
  %1414 = bitcast i8* %1413 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1415, label %1419

; <label>:1415                                    ; preds = %1412
  %1416 = bitcast i32* %309 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1416)
  %1417 = atomicrmw volatile add i32* %1414, i32 -1 acq_rel
  store i32 %1417, i32* %309, align 4
  %1418 = load volatile i32* %309, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1416)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i226

; <label>:1419                                    ; preds = %1412
  %1420 = load i32* %1414, align 4, !tbaa !8
  %1421 = add nsw i32 %1420, -1
  store i32 %1421, i32* %1414, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i226

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i226: ; preds = %1419, %1415
  %.0.i.i.i.i225 = phi i32 [ %1418, %1415 ], [ %1420, %1419 ]
  %1422 = icmp slt i32 %.0.i.i.i.i225, 1
  br i1 %1422, label %1423, label %1424

; <label>:1423                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i226
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1410, %"class.std::allocator.0"* %310) #1
  br label %1424

; <label>:1424                                    ; preds = %1423, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i226, %1405
  call void @llvm.lifetime.end(i64 1, i8* %1406)
  %1425 = getelementptr inbounds %"class.std::allocator.0"* %308, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1425)
  %1426 = getelementptr inbounds %"class.std::basic_string"* %438, i64 0, i32 0, i32 0
  %1427 = load i8** %1426, align 8, !tbaa !1
  %1428 = getelementptr inbounds i8* %1427, i64 -24
  %1429 = bitcast i8* %1428 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1430 = icmp eq i8* %1428, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1430, label %1443, label %1431, !prof !7

; <label>:1431                                    ; preds = %1424
  %1432 = getelementptr inbounds i8* %1427, i64 -8
  %1433 = bitcast i8* %1432 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1434, label %1438

; <label>:1434                                    ; preds = %1431
  %1435 = bitcast i32* %307 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1435)
  %1436 = atomicrmw volatile add i32* %1433, i32 -1 acq_rel
  store i32 %1436, i32* %307, align 4
  %1437 = load volatile i32* %307, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1435)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i229

; <label>:1438                                    ; preds = %1431
  %1439 = load i32* %1433, align 4, !tbaa !8
  %1440 = add nsw i32 %1439, -1
  store i32 %1440, i32* %1433, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i229

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i229: ; preds = %1438, %1434
  %.0.i.i.i.i228 = phi i32 [ %1437, %1434 ], [ %1439, %1438 ]
  %1441 = icmp slt i32 %.0.i.i.i.i228, 1
  br i1 %1441, label %1442, label %1443

; <label>:1442                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i229
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1429, %"class.std::allocator.0"* %308) #1
  br label %1443

; <label>:1443                                    ; preds = %1442, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i229, %1424
  call void @llvm.lifetime.end(i64 1, i8* %1425)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %443, i8* getelementptr inbounds ([4 x i8]* @.str12, i64 0, i64 0), %"class.std::allocator.0"* %444)
          to label %1444 unwind label %3616

; <label>:1444                                    ; preds = %1443
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %445, i8* getelementptr inbounds ([9 x i8]* @.str1, i64 0, i64 0), %"class.std::allocator.0"* %446)
          to label %1445 unwind label %3620

; <label>:1445                                    ; preds = %1444
  %1446 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1446, %"class.std::basic_string"* %443)
          to label %.noexc234 unwind label %3624

.noexc234:                                        ; preds = %1445
  %1447 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1447, %"class.std::basic_string"* %445)
          to label %1468 unwind label %1448

; <label>:1448                                    ; preds = %.noexc234
  %1449 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1450 = getelementptr inbounds %"class.std::allocator.0"* %306, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1450)
  %1451 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 0, i32 0, i32 0
  %1452 = load i8** %1451, align 8, !tbaa !1
  %1453 = getelementptr inbounds i8* %1452, i64 -24
  %1454 = bitcast i8* %1453 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1455 = icmp eq i8* %1453, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1455, label %.body235, label %1456, !prof !7

; <label>:1456                                    ; preds = %1448
  %1457 = getelementptr inbounds i8* %1452, i64 -8
  %1458 = bitcast i8* %1457 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1459, label %1463

; <label>:1459                                    ; preds = %1456
  %1460 = bitcast i32* %305 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1460)
  %1461 = atomicrmw volatile add i32* %1458, i32 -1 acq_rel
  store i32 %1461, i32* %305, align 4
  %1462 = load volatile i32* %305, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1460)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i233

; <label>:1463                                    ; preds = %1456
  %1464 = load i32* %1458, align 4, !tbaa !8
  %1465 = add nsw i32 %1464, -1
  store i32 %1465, i32* %1458, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i233

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i233: ; preds = %1463, %1459
  %.0.i.i.i.i.i232 = phi i32 [ %1462, %1459 ], [ %1464, %1463 ]
  %1466 = icmp slt i32 %.0.i.i.i.i.i232, 1
  br i1 %1466, label %1467, label %.body235

; <label>:1467                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i233
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1454, %"class.std::allocator.0"* %306) #1
  br label %.body235

; <label>:1468                                    ; preds = %.noexc234
  %1469 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 2
  store i32 0, i32* %1469, align 8, !tbaa !10
  %1470 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 3
  store i32 1, i32* %1470, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %442)
          to label %1471 unwind label %3628

; <label>:1471                                    ; preds = %1468
  %1472 = getelementptr inbounds %"class.std::allocator.0"* %304, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1472)
  %1473 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 1, i32 0, i32 0
  %1474 = load i8** %1473, align 8, !tbaa !1
  %1475 = getelementptr inbounds i8* %1474, i64 -24
  %1476 = bitcast i8* %1475 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1477 = icmp eq i8* %1475, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1477, label %1490, label %1478, !prof !7

; <label>:1478                                    ; preds = %1471
  %1479 = getelementptr inbounds i8* %1474, i64 -8
  %1480 = bitcast i8* %1479 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1481, label %1485

; <label>:1481                                    ; preds = %1478
  %1482 = bitcast i32* %303 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1482)
  %1483 = atomicrmw volatile add i32* %1480, i32 -1 acq_rel
  store i32 %1483, i32* %303, align 4
  %1484 = load volatile i32* %303, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1482)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i239

; <label>:1485                                    ; preds = %1478
  %1486 = load i32* %1480, align 4, !tbaa !8
  %1487 = add nsw i32 %1486, -1
  store i32 %1487, i32* %1480, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i239

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i239: ; preds = %1485, %1481
  %.0.i.i.i.i.i238 = phi i32 [ %1484, %1481 ], [ %1486, %1485 ]
  %1488 = icmp slt i32 %.0.i.i.i.i.i238, 1
  br i1 %1488, label %1489, label %1490

; <label>:1489                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i239
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1476, %"class.std::allocator.0"* %304) #1
  br label %1490

; <label>:1490                                    ; preds = %1489, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i239, %1471
  call void @llvm.lifetime.end(i64 1, i8* %1472)
  %1491 = getelementptr inbounds %"class.std::allocator.0"* %302, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1491)
  %1492 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 0, i32 0, i32 0
  %1493 = load i8** %1492, align 8, !tbaa !1
  %1494 = getelementptr inbounds i8* %1493, i64 -24
  %1495 = bitcast i8* %1494 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1496 = icmp eq i8* %1494, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1496, label %1509, label %1497, !prof !7

; <label>:1497                                    ; preds = %1490
  %1498 = getelementptr inbounds i8* %1493, i64 -8
  %1499 = bitcast i8* %1498 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1500, label %1504

; <label>:1500                                    ; preds = %1497
  %1501 = bitcast i32* %301 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1501)
  %1502 = atomicrmw volatile add i32* %1499, i32 -1 acq_rel
  store i32 %1502, i32* %301, align 4
  %1503 = load volatile i32* %301, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1501)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i241

; <label>:1504                                    ; preds = %1497
  %1505 = load i32* %1499, align 4, !tbaa !8
  %1506 = add nsw i32 %1505, -1
  store i32 %1506, i32* %1499, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i241

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i241: ; preds = %1504, %1500
  %.0.i.i.i.i1.i240 = phi i32 [ %1503, %1500 ], [ %1505, %1504 ]
  %1507 = icmp slt i32 %.0.i.i.i.i1.i240, 1
  br i1 %1507, label %1508, label %1509

; <label>:1508                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i241
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1495, %"class.std::allocator.0"* %302) #1
  br label %1509

; <label>:1509                                    ; preds = %1508, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i241, %1490
  call void @llvm.lifetime.end(i64 1, i8* %1491)
  %1510 = getelementptr inbounds %"class.std::allocator.0"* %300, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1510)
  %1511 = getelementptr inbounds %"class.std::basic_string"* %445, i64 0, i32 0, i32 0
  %1512 = load i8** %1511, align 8, !tbaa !1
  %1513 = getelementptr inbounds i8* %1512, i64 -24
  %1514 = bitcast i8* %1513 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1515 = icmp eq i8* %1513, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1515, label %1528, label %1516, !prof !7

; <label>:1516                                    ; preds = %1509
  %1517 = getelementptr inbounds i8* %1512, i64 -8
  %1518 = bitcast i8* %1517 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1519, label %1523

; <label>:1519                                    ; preds = %1516
  %1520 = bitcast i32* %299 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1520)
  %1521 = atomicrmw volatile add i32* %1518, i32 -1 acq_rel
  store i32 %1521, i32* %299, align 4
  %1522 = load volatile i32* %299, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1520)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i244

; <label>:1523                                    ; preds = %1516
  %1524 = load i32* %1518, align 4, !tbaa !8
  %1525 = add nsw i32 %1524, -1
  store i32 %1525, i32* %1518, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i244

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i244: ; preds = %1523, %1519
  %.0.i.i.i.i243 = phi i32 [ %1522, %1519 ], [ %1524, %1523 ]
  %1526 = icmp slt i32 %.0.i.i.i.i243, 1
  br i1 %1526, label %1527, label %1528

; <label>:1527                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i244
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1514, %"class.std::allocator.0"* %300) #1
  br label %1528

; <label>:1528                                    ; preds = %1527, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i244, %1509
  call void @llvm.lifetime.end(i64 1, i8* %1510)
  %1529 = getelementptr inbounds %"class.std::allocator.0"* %298, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1529)
  %1530 = getelementptr inbounds %"class.std::basic_string"* %443, i64 0, i32 0, i32 0
  %1531 = load i8** %1530, align 8, !tbaa !1
  %1532 = getelementptr inbounds i8* %1531, i64 -24
  %1533 = bitcast i8* %1532 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1534 = icmp eq i8* %1532, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1534, label %1547, label %1535, !prof !7

; <label>:1535                                    ; preds = %1528
  %1536 = getelementptr inbounds i8* %1531, i64 -8
  %1537 = bitcast i8* %1536 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1538, label %1542

; <label>:1538                                    ; preds = %1535
  %1539 = bitcast i32* %297 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1539)
  %1540 = atomicrmw volatile add i32* %1537, i32 -1 acq_rel
  store i32 %1540, i32* %297, align 4
  %1541 = load volatile i32* %297, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1539)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i247

; <label>:1542                                    ; preds = %1535
  %1543 = load i32* %1537, align 4, !tbaa !8
  %1544 = add nsw i32 %1543, -1
  store i32 %1544, i32* %1537, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i247

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i247: ; preds = %1542, %1538
  %.0.i.i.i.i246 = phi i32 [ %1541, %1538 ], [ %1543, %1542 ]
  %1545 = icmp slt i32 %.0.i.i.i.i246, 1
  br i1 %1545, label %1546, label %1547

; <label>:1546                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i247
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1533, %"class.std::allocator.0"* %298) #1
  br label %1547

; <label>:1547                                    ; preds = %1546, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i247, %1528
  call void @llvm.lifetime.end(i64 1, i8* %1529)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %448, i8* getelementptr inbounds ([4 x i8]* @.str12, i64 0, i64 0), %"class.std::allocator.0"* %449)
          to label %1548 unwind label %3705

; <label>:1548                                    ; preds = %1547
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %450, i8* getelementptr inbounds ([3 x i8]* @.str13, i64 0, i64 0), %"class.std::allocator.0"* %451)
          to label %1549 unwind label %3709

; <label>:1549                                    ; preds = %1548
  %1550 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1550, %"class.std::basic_string"* %448)
          to label %.noexc252 unwind label %3713

.noexc252:                                        ; preds = %1549
  %1551 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1551, %"class.std::basic_string"* %450)
          to label %1572 unwind label %1552

; <label>:1552                                    ; preds = %.noexc252
  %1553 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1554 = getelementptr inbounds %"class.std::allocator.0"* %296, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1554)
  %1555 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 0, i32 0, i32 0
  %1556 = load i8** %1555, align 8, !tbaa !1
  %1557 = getelementptr inbounds i8* %1556, i64 -24
  %1558 = bitcast i8* %1557 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1559 = icmp eq i8* %1557, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1559, label %.body253, label %1560, !prof !7

; <label>:1560                                    ; preds = %1552
  %1561 = getelementptr inbounds i8* %1556, i64 -8
  %1562 = bitcast i8* %1561 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1563, label %1567

; <label>:1563                                    ; preds = %1560
  %1564 = bitcast i32* %295 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1564)
  %1565 = atomicrmw volatile add i32* %1562, i32 -1 acq_rel
  store i32 %1565, i32* %295, align 4
  %1566 = load volatile i32* %295, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1564)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i251

; <label>:1567                                    ; preds = %1560
  %1568 = load i32* %1562, align 4, !tbaa !8
  %1569 = add nsw i32 %1568, -1
  store i32 %1569, i32* %1562, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i251

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i251: ; preds = %1567, %1563
  %.0.i.i.i.i.i250 = phi i32 [ %1566, %1563 ], [ %1568, %1567 ]
  %1570 = icmp slt i32 %.0.i.i.i.i.i250, 1
  br i1 %1570, label %1571, label %.body253

; <label>:1571                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i251
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1558, %"class.std::allocator.0"* %296) #1
  br label %.body253

; <label>:1572                                    ; preds = %.noexc252
  %1573 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 2
  store i32 0, i32* %1573, align 8, !tbaa !10
  %1574 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 3
  store i32 0, i32* %1574, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %447)
          to label %1575 unwind label %3717

; <label>:1575                                    ; preds = %1572
  %1576 = getelementptr inbounds %"class.std::allocator.0"* %294, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1576)
  %1577 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 1, i32 0, i32 0
  %1578 = load i8** %1577, align 8, !tbaa !1
  %1579 = getelementptr inbounds i8* %1578, i64 -24
  %1580 = bitcast i8* %1579 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1581 = icmp eq i8* %1579, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1581, label %1594, label %1582, !prof !7

; <label>:1582                                    ; preds = %1575
  %1583 = getelementptr inbounds i8* %1578, i64 -8
  %1584 = bitcast i8* %1583 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1585, label %1589

; <label>:1585                                    ; preds = %1582
  %1586 = bitcast i32* %293 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1586)
  %1587 = atomicrmw volatile add i32* %1584, i32 -1 acq_rel
  store i32 %1587, i32* %293, align 4
  %1588 = load volatile i32* %293, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1586)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i257

; <label>:1589                                    ; preds = %1582
  %1590 = load i32* %1584, align 4, !tbaa !8
  %1591 = add nsw i32 %1590, -1
  store i32 %1591, i32* %1584, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i257

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i257: ; preds = %1589, %1585
  %.0.i.i.i.i.i256 = phi i32 [ %1588, %1585 ], [ %1590, %1589 ]
  %1592 = icmp slt i32 %.0.i.i.i.i.i256, 1
  br i1 %1592, label %1593, label %1594

; <label>:1593                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i257
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1580, %"class.std::allocator.0"* %294) #1
  br label %1594

; <label>:1594                                    ; preds = %1593, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i257, %1575
  call void @llvm.lifetime.end(i64 1, i8* %1576)
  %1595 = getelementptr inbounds %"class.std::allocator.0"* %292, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1595)
  %1596 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 0, i32 0, i32 0
  %1597 = load i8** %1596, align 8, !tbaa !1
  %1598 = getelementptr inbounds i8* %1597, i64 -24
  %1599 = bitcast i8* %1598 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1600 = icmp eq i8* %1598, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1600, label %1613, label %1601, !prof !7

; <label>:1601                                    ; preds = %1594
  %1602 = getelementptr inbounds i8* %1597, i64 -8
  %1603 = bitcast i8* %1602 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1604, label %1608

; <label>:1604                                    ; preds = %1601
  %1605 = bitcast i32* %291 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1605)
  %1606 = atomicrmw volatile add i32* %1603, i32 -1 acq_rel
  store i32 %1606, i32* %291, align 4
  %1607 = load volatile i32* %291, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1605)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i259

; <label>:1608                                    ; preds = %1601
  %1609 = load i32* %1603, align 4, !tbaa !8
  %1610 = add nsw i32 %1609, -1
  store i32 %1610, i32* %1603, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i259

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i259: ; preds = %1608, %1604
  %.0.i.i.i.i1.i258 = phi i32 [ %1607, %1604 ], [ %1609, %1608 ]
  %1611 = icmp slt i32 %.0.i.i.i.i1.i258, 1
  br i1 %1611, label %1612, label %1613

; <label>:1612                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i259
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1599, %"class.std::allocator.0"* %292) #1
  br label %1613

; <label>:1613                                    ; preds = %1612, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i259, %1594
  call void @llvm.lifetime.end(i64 1, i8* %1595)
  %1614 = getelementptr inbounds %"class.std::allocator.0"* %290, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1614)
  %1615 = getelementptr inbounds %"class.std::basic_string"* %450, i64 0, i32 0, i32 0
  %1616 = load i8** %1615, align 8, !tbaa !1
  %1617 = getelementptr inbounds i8* %1616, i64 -24
  %1618 = bitcast i8* %1617 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1619 = icmp eq i8* %1617, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1619, label %1632, label %1620, !prof !7

; <label>:1620                                    ; preds = %1613
  %1621 = getelementptr inbounds i8* %1616, i64 -8
  %1622 = bitcast i8* %1621 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1623, label %1627

; <label>:1623                                    ; preds = %1620
  %1624 = bitcast i32* %289 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1624)
  %1625 = atomicrmw volatile add i32* %1622, i32 -1 acq_rel
  store i32 %1625, i32* %289, align 4
  %1626 = load volatile i32* %289, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1624)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i262

; <label>:1627                                    ; preds = %1620
  %1628 = load i32* %1622, align 4, !tbaa !8
  %1629 = add nsw i32 %1628, -1
  store i32 %1629, i32* %1622, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i262

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i262: ; preds = %1627, %1623
  %.0.i.i.i.i261 = phi i32 [ %1626, %1623 ], [ %1628, %1627 ]
  %1630 = icmp slt i32 %.0.i.i.i.i261, 1
  br i1 %1630, label %1631, label %1632

; <label>:1631                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i262
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1618, %"class.std::allocator.0"* %290) #1
  br label %1632

; <label>:1632                                    ; preds = %1631, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i262, %1613
  call void @llvm.lifetime.end(i64 1, i8* %1614)
  %1633 = getelementptr inbounds %"class.std::allocator.0"* %288, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1633)
  %1634 = getelementptr inbounds %"class.std::basic_string"* %448, i64 0, i32 0, i32 0
  %1635 = load i8** %1634, align 8, !tbaa !1
  %1636 = getelementptr inbounds i8* %1635, i64 -24
  %1637 = bitcast i8* %1636 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1638 = icmp eq i8* %1636, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1638, label %1651, label %1639, !prof !7

; <label>:1639                                    ; preds = %1632
  %1640 = getelementptr inbounds i8* %1635, i64 -8
  %1641 = bitcast i8* %1640 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1642, label %1646

; <label>:1642                                    ; preds = %1639
  %1643 = bitcast i32* %287 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1643)
  %1644 = atomicrmw volatile add i32* %1641, i32 -1 acq_rel
  store i32 %1644, i32* %287, align 4
  %1645 = load volatile i32* %287, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1643)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i265

; <label>:1646                                    ; preds = %1639
  %1647 = load i32* %1641, align 4, !tbaa !8
  %1648 = add nsw i32 %1647, -1
  store i32 %1648, i32* %1641, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i265

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i265: ; preds = %1646, %1642
  %.0.i.i.i.i264 = phi i32 [ %1645, %1642 ], [ %1647, %1646 ]
  %1649 = icmp slt i32 %.0.i.i.i.i264, 1
  br i1 %1649, label %1650, label %1651

; <label>:1650                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i265
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1637, %"class.std::allocator.0"* %288) #1
  br label %1651

; <label>:1651                                    ; preds = %1650, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i265, %1632
  call void @llvm.lifetime.end(i64 1, i8* %1633)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %453, i8* getelementptr inbounds ([4 x i8]* @.str12, i64 0, i64 0), %"class.std::allocator.0"* %454)
          to label %1652 unwind label %3794

; <label>:1652                                    ; preds = %1651
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %455, i8* getelementptr inbounds ([3 x i8]* @.str13, i64 0, i64 0), %"class.std::allocator.0"* %456)
          to label %1653 unwind label %3798

; <label>:1653                                    ; preds = %1652
  %1654 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1654, %"class.std::basic_string"* %453)
          to label %.noexc269 unwind label %3802

.noexc269:                                        ; preds = %1653
  %1655 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1655, %"class.std::basic_string"* %455)
          to label %1676 unwind label %1656

; <label>:1656                                    ; preds = %.noexc269
  %1657 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1658 = getelementptr inbounds %"class.std::allocator.0"* %286, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1658)
  %1659 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 0, i32 0, i32 0
  %1660 = load i8** %1659, align 8, !tbaa !1
  %1661 = getelementptr inbounds i8* %1660, i64 -24
  %1662 = bitcast i8* %1661 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1663 = icmp eq i8* %1661, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1663, label %.body270, label %1664, !prof !7

; <label>:1664                                    ; preds = %1656
  %1665 = getelementptr inbounds i8* %1660, i64 -8
  %1666 = bitcast i8* %1665 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1667, label %1671

; <label>:1667                                    ; preds = %1664
  %1668 = bitcast i32* %285 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1668)
  %1669 = atomicrmw volatile add i32* %1666, i32 -1 acq_rel
  store i32 %1669, i32* %285, align 4
  %1670 = load volatile i32* %285, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1668)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i268

; <label>:1671                                    ; preds = %1664
  %1672 = load i32* %1666, align 4, !tbaa !8
  %1673 = add nsw i32 %1672, -1
  store i32 %1673, i32* %1666, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i268

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i268: ; preds = %1671, %1667
  %.0.i.i.i.i.i267 = phi i32 [ %1670, %1667 ], [ %1672, %1671 ]
  %1674 = icmp slt i32 %.0.i.i.i.i.i267, 1
  br i1 %1674, label %1675, label %.body270

; <label>:1675                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i268
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1662, %"class.std::allocator.0"* %286) #1
  br label %.body270

; <label>:1676                                    ; preds = %.noexc269
  %1677 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 2
  store i32 2, i32* %1677, align 8, !tbaa !10
  %1678 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 3
  store i32 1, i32* %1678, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %452)
          to label %1679 unwind label %3806

; <label>:1679                                    ; preds = %1676
  %1680 = getelementptr inbounds %"class.std::allocator.0"* %284, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1680)
  %1681 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 1, i32 0, i32 0
  %1682 = load i8** %1681, align 8, !tbaa !1
  %1683 = getelementptr inbounds i8* %1682, i64 -24
  %1684 = bitcast i8* %1683 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1685 = icmp eq i8* %1683, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1685, label %1698, label %1686, !prof !7

; <label>:1686                                    ; preds = %1679
  %1687 = getelementptr inbounds i8* %1682, i64 -8
  %1688 = bitcast i8* %1687 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1689, label %1693

; <label>:1689                                    ; preds = %1686
  %1690 = bitcast i32* %283 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1690)
  %1691 = atomicrmw volatile add i32* %1688, i32 -1 acq_rel
  store i32 %1691, i32* %283, align 4
  %1692 = load volatile i32* %283, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1690)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i274

; <label>:1693                                    ; preds = %1686
  %1694 = load i32* %1688, align 4, !tbaa !8
  %1695 = add nsw i32 %1694, -1
  store i32 %1695, i32* %1688, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i274

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i274: ; preds = %1693, %1689
  %.0.i.i.i.i.i273 = phi i32 [ %1692, %1689 ], [ %1694, %1693 ]
  %1696 = icmp slt i32 %.0.i.i.i.i.i273, 1
  br i1 %1696, label %1697, label %1698

; <label>:1697                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i274
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1684, %"class.std::allocator.0"* %284) #1
  br label %1698

; <label>:1698                                    ; preds = %1697, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i274, %1679
  call void @llvm.lifetime.end(i64 1, i8* %1680)
  %1699 = getelementptr inbounds %"class.std::allocator.0"* %282, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1699)
  %1700 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 0, i32 0, i32 0
  %1701 = load i8** %1700, align 8, !tbaa !1
  %1702 = getelementptr inbounds i8* %1701, i64 -24
  %1703 = bitcast i8* %1702 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1704 = icmp eq i8* %1702, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1704, label %1717, label %1705, !prof !7

; <label>:1705                                    ; preds = %1698
  %1706 = getelementptr inbounds i8* %1701, i64 -8
  %1707 = bitcast i8* %1706 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1708, label %1712

; <label>:1708                                    ; preds = %1705
  %1709 = bitcast i32* %281 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1709)
  %1710 = atomicrmw volatile add i32* %1707, i32 -1 acq_rel
  store i32 %1710, i32* %281, align 4
  %1711 = load volatile i32* %281, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1709)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i276

; <label>:1712                                    ; preds = %1705
  %1713 = load i32* %1707, align 4, !tbaa !8
  %1714 = add nsw i32 %1713, -1
  store i32 %1714, i32* %1707, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i276

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i276: ; preds = %1712, %1708
  %.0.i.i.i.i1.i275 = phi i32 [ %1711, %1708 ], [ %1713, %1712 ]
  %1715 = icmp slt i32 %.0.i.i.i.i1.i275, 1
  br i1 %1715, label %1716, label %1717

; <label>:1716                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i276
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1703, %"class.std::allocator.0"* %282) #1
  br label %1717

; <label>:1717                                    ; preds = %1716, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i276, %1698
  call void @llvm.lifetime.end(i64 1, i8* %1699)
  %1718 = getelementptr inbounds %"class.std::allocator.0"* %280, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1718)
  %1719 = getelementptr inbounds %"class.std::basic_string"* %455, i64 0, i32 0, i32 0
  %1720 = load i8** %1719, align 8, !tbaa !1
  %1721 = getelementptr inbounds i8* %1720, i64 -24
  %1722 = bitcast i8* %1721 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1723 = icmp eq i8* %1721, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1723, label %1736, label %1724, !prof !7

; <label>:1724                                    ; preds = %1717
  %1725 = getelementptr inbounds i8* %1720, i64 -8
  %1726 = bitcast i8* %1725 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1727, label %1731

; <label>:1727                                    ; preds = %1724
  %1728 = bitcast i32* %279 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1728)
  %1729 = atomicrmw volatile add i32* %1726, i32 -1 acq_rel
  store i32 %1729, i32* %279, align 4
  %1730 = load volatile i32* %279, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1728)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i279

; <label>:1731                                    ; preds = %1724
  %1732 = load i32* %1726, align 4, !tbaa !8
  %1733 = add nsw i32 %1732, -1
  store i32 %1733, i32* %1726, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i279

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i279: ; preds = %1731, %1727
  %.0.i.i.i.i278 = phi i32 [ %1730, %1727 ], [ %1732, %1731 ]
  %1734 = icmp slt i32 %.0.i.i.i.i278, 1
  br i1 %1734, label %1735, label %1736

; <label>:1735                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i279
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1722, %"class.std::allocator.0"* %280) #1
  br label %1736

; <label>:1736                                    ; preds = %1735, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i279, %1717
  call void @llvm.lifetime.end(i64 1, i8* %1718)
  %1737 = getelementptr inbounds %"class.std::allocator.0"* %278, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1737)
  %1738 = getelementptr inbounds %"class.std::basic_string"* %453, i64 0, i32 0, i32 0
  %1739 = load i8** %1738, align 8, !tbaa !1
  %1740 = getelementptr inbounds i8* %1739, i64 -24
  %1741 = bitcast i8* %1740 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1742 = icmp eq i8* %1740, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1742, label %1755, label %1743, !prof !7

; <label>:1743                                    ; preds = %1736
  %1744 = getelementptr inbounds i8* %1739, i64 -8
  %1745 = bitcast i8* %1744 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1746, label %1750

; <label>:1746                                    ; preds = %1743
  %1747 = bitcast i32* %277 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1747)
  %1748 = atomicrmw volatile add i32* %1745, i32 -1 acq_rel
  store i32 %1748, i32* %277, align 4
  %1749 = load volatile i32* %277, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1747)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i282

; <label>:1750                                    ; preds = %1743
  %1751 = load i32* %1745, align 4, !tbaa !8
  %1752 = add nsw i32 %1751, -1
  store i32 %1752, i32* %1745, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i282

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i282: ; preds = %1750, %1746
  %.0.i.i.i.i281 = phi i32 [ %1749, %1746 ], [ %1751, %1750 ]
  %1753 = icmp slt i32 %.0.i.i.i.i281, 1
  br i1 %1753, label %1754, label %1755

; <label>:1754                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i282
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1741, %"class.std::allocator.0"* %278) #1
  br label %1755

; <label>:1755                                    ; preds = %1754, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i282, %1736
  call void @llvm.lifetime.end(i64 1, i8* %1737)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %458, i8* getelementptr inbounds ([4 x i8]* @.str12, i64 0, i64 0), %"class.std::allocator.0"* %459)
          to label %1756 unwind label %3883

; <label>:1756                                    ; preds = %1755
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %460, i8* getelementptr inbounds ([4 x i8]* @.str12, i64 0, i64 0), %"class.std::allocator.0"* %461)
          to label %1757 unwind label %3887

; <label>:1757                                    ; preds = %1756
  %1758 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1758, %"class.std::basic_string"* %458)
          to label %.noexc294 unwind label %3891

.noexc294:                                        ; preds = %1757
  %1759 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1759, %"class.std::basic_string"* %460)
          to label %1780 unwind label %1760

; <label>:1760                                    ; preds = %.noexc294
  %1761 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1762 = getelementptr inbounds %"class.std::allocator.0"* %276, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1762)
  %1763 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 0, i32 0, i32 0
  %1764 = load i8** %1763, align 8, !tbaa !1
  %1765 = getelementptr inbounds i8* %1764, i64 -24
  %1766 = bitcast i8* %1765 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1767 = icmp eq i8* %1765, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1767, label %.body295, label %1768, !prof !7

; <label>:1768                                    ; preds = %1760
  %1769 = getelementptr inbounds i8* %1764, i64 -8
  %1770 = bitcast i8* %1769 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1771, label %1775

; <label>:1771                                    ; preds = %1768
  %1772 = bitcast i32* %275 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1772)
  %1773 = atomicrmw volatile add i32* %1770, i32 -1 acq_rel
  store i32 %1773, i32* %275, align 4
  %1774 = load volatile i32* %275, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1772)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i293

; <label>:1775                                    ; preds = %1768
  %1776 = load i32* %1770, align 4, !tbaa !8
  %1777 = add nsw i32 %1776, -1
  store i32 %1777, i32* %1770, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i293

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i293: ; preds = %1775, %1771
  %.0.i.i.i.i.i292 = phi i32 [ %1774, %1771 ], [ %1776, %1775 ]
  %1778 = icmp slt i32 %.0.i.i.i.i.i292, 1
  br i1 %1778, label %1779, label %.body295

; <label>:1779                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i293
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1766, %"class.std::allocator.0"* %276) #1
  br label %.body295

; <label>:1780                                    ; preds = %.noexc294
  %1781 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 2
  store i32 2, i32* %1781, align 8, !tbaa !10
  %1782 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 3
  store i32 0, i32* %1782, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %457)
          to label %1783 unwind label %3895

; <label>:1783                                    ; preds = %1780
  %1784 = getelementptr inbounds %"class.std::allocator.0"* %274, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1784)
  %1785 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 1, i32 0, i32 0
  %1786 = load i8** %1785, align 8, !tbaa !1
  %1787 = getelementptr inbounds i8* %1786, i64 -24
  %1788 = bitcast i8* %1787 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1789 = icmp eq i8* %1787, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1789, label %1802, label %1790, !prof !7

; <label>:1790                                    ; preds = %1783
  %1791 = getelementptr inbounds i8* %1786, i64 -8
  %1792 = bitcast i8* %1791 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1793, label %1797

; <label>:1793                                    ; preds = %1790
  %1794 = bitcast i32* %273 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1794)
  %1795 = atomicrmw volatile add i32* %1792, i32 -1 acq_rel
  store i32 %1795, i32* %273, align 4
  %1796 = load volatile i32* %273, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1794)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i299

; <label>:1797                                    ; preds = %1790
  %1798 = load i32* %1792, align 4, !tbaa !8
  %1799 = add nsw i32 %1798, -1
  store i32 %1799, i32* %1792, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i299

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i299: ; preds = %1797, %1793
  %.0.i.i.i.i.i298 = phi i32 [ %1796, %1793 ], [ %1798, %1797 ]
  %1800 = icmp slt i32 %.0.i.i.i.i.i298, 1
  br i1 %1800, label %1801, label %1802

; <label>:1801                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i299
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1788, %"class.std::allocator.0"* %274) #1
  br label %1802

; <label>:1802                                    ; preds = %1801, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i299, %1783
  call void @llvm.lifetime.end(i64 1, i8* %1784)
  %1803 = getelementptr inbounds %"class.std::allocator.0"* %272, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1803)
  %1804 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 0, i32 0, i32 0
  %1805 = load i8** %1804, align 8, !tbaa !1
  %1806 = getelementptr inbounds i8* %1805, i64 -24
  %1807 = bitcast i8* %1806 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1808 = icmp eq i8* %1806, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1808, label %1821, label %1809, !prof !7

; <label>:1809                                    ; preds = %1802
  %1810 = getelementptr inbounds i8* %1805, i64 -8
  %1811 = bitcast i8* %1810 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1812, label %1816

; <label>:1812                                    ; preds = %1809
  %1813 = bitcast i32* %271 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1813)
  %1814 = atomicrmw volatile add i32* %1811, i32 -1 acq_rel
  store i32 %1814, i32* %271, align 4
  %1815 = load volatile i32* %271, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1813)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i301

; <label>:1816                                    ; preds = %1809
  %1817 = load i32* %1811, align 4, !tbaa !8
  %1818 = add nsw i32 %1817, -1
  store i32 %1818, i32* %1811, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i301

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i301: ; preds = %1816, %1812
  %.0.i.i.i.i1.i300 = phi i32 [ %1815, %1812 ], [ %1817, %1816 ]
  %1819 = icmp slt i32 %.0.i.i.i.i1.i300, 1
  br i1 %1819, label %1820, label %1821

; <label>:1820                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i301
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1807, %"class.std::allocator.0"* %272) #1
  br label %1821

; <label>:1821                                    ; preds = %1820, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i301, %1802
  call void @llvm.lifetime.end(i64 1, i8* %1803)
  %1822 = getelementptr inbounds %"class.std::allocator.0"* %270, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1822)
  %1823 = getelementptr inbounds %"class.std::basic_string"* %460, i64 0, i32 0, i32 0
  %1824 = load i8** %1823, align 8, !tbaa !1
  %1825 = getelementptr inbounds i8* %1824, i64 -24
  %1826 = bitcast i8* %1825 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1827 = icmp eq i8* %1825, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1827, label %1840, label %1828, !prof !7

; <label>:1828                                    ; preds = %1821
  %1829 = getelementptr inbounds i8* %1824, i64 -8
  %1830 = bitcast i8* %1829 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1831, label %1835

; <label>:1831                                    ; preds = %1828
  %1832 = bitcast i32* %269 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1832)
  %1833 = atomicrmw volatile add i32* %1830, i32 -1 acq_rel
  store i32 %1833, i32* %269, align 4
  %1834 = load volatile i32* %269, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1832)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i304

; <label>:1835                                    ; preds = %1828
  %1836 = load i32* %1830, align 4, !tbaa !8
  %1837 = add nsw i32 %1836, -1
  store i32 %1837, i32* %1830, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i304

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i304: ; preds = %1835, %1831
  %.0.i.i.i.i303 = phi i32 [ %1834, %1831 ], [ %1836, %1835 ]
  %1838 = icmp slt i32 %.0.i.i.i.i303, 1
  br i1 %1838, label %1839, label %1840

; <label>:1839                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i304
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1826, %"class.std::allocator.0"* %270) #1
  br label %1840

; <label>:1840                                    ; preds = %1839, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i304, %1821
  call void @llvm.lifetime.end(i64 1, i8* %1822)
  %1841 = getelementptr inbounds %"class.std::allocator.0"* %268, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1841)
  %1842 = getelementptr inbounds %"class.std::basic_string"* %458, i64 0, i32 0, i32 0
  %1843 = load i8** %1842, align 8, !tbaa !1
  %1844 = getelementptr inbounds i8* %1843, i64 -24
  %1845 = bitcast i8* %1844 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1846 = icmp eq i8* %1844, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1846, label %1859, label %1847, !prof !7

; <label>:1847                                    ; preds = %1840
  %1848 = getelementptr inbounds i8* %1843, i64 -8
  %1849 = bitcast i8* %1848 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1850, label %1854

; <label>:1850                                    ; preds = %1847
  %1851 = bitcast i32* %267 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1851)
  %1852 = atomicrmw volatile add i32* %1849, i32 -1 acq_rel
  store i32 %1852, i32* %267, align 4
  %1853 = load volatile i32* %267, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1851)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i307

; <label>:1854                                    ; preds = %1847
  %1855 = load i32* %1849, align 4, !tbaa !8
  %1856 = add nsw i32 %1855, -1
  store i32 %1856, i32* %1849, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i307

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i307: ; preds = %1854, %1850
  %.0.i.i.i.i306 = phi i32 [ %1853, %1850 ], [ %1855, %1854 ]
  %1857 = icmp slt i32 %.0.i.i.i.i306, 1
  br i1 %1857, label %1858, label %1859

; <label>:1858                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i307
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1845, %"class.std::allocator.0"* %268) #1
  br label %1859

; <label>:1859                                    ; preds = %1858, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i307, %1840
  call void @llvm.lifetime.end(i64 1, i8* %1841)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %463, i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), %"class.std::allocator.0"* %464)
          to label %1860 unwind label %3972

; <label>:1860                                    ; preds = %1859
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %465, i8* getelementptr inbounds ([12 x i8]* @.str15, i64 0, i64 0), %"class.std::allocator.0"* %466)
          to label %1861 unwind label %3976

; <label>:1861                                    ; preds = %1860
  %1862 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1862, %"class.std::basic_string"* %463)
          to label %.noexc311 unwind label %3980

.noexc311:                                        ; preds = %1861
  %1863 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1863, %"class.std::basic_string"* %465)
          to label %1884 unwind label %1864

; <label>:1864                                    ; preds = %.noexc311
  %1865 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1866 = getelementptr inbounds %"class.std::allocator.0"* %266, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1866)
  %1867 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 0, i32 0, i32 0
  %1868 = load i8** %1867, align 8, !tbaa !1
  %1869 = getelementptr inbounds i8* %1868, i64 -24
  %1870 = bitcast i8* %1869 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1871 = icmp eq i8* %1869, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1871, label %.body312, label %1872, !prof !7

; <label>:1872                                    ; preds = %1864
  %1873 = getelementptr inbounds i8* %1868, i64 -8
  %1874 = bitcast i8* %1873 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1875, label %1879

; <label>:1875                                    ; preds = %1872
  %1876 = bitcast i32* %265 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1876)
  %1877 = atomicrmw volatile add i32* %1874, i32 -1 acq_rel
  store i32 %1877, i32* %265, align 4
  %1878 = load volatile i32* %265, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1876)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i310

; <label>:1879                                    ; preds = %1872
  %1880 = load i32* %1874, align 4, !tbaa !8
  %1881 = add nsw i32 %1880, -1
  store i32 %1881, i32* %1874, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i310

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i310: ; preds = %1879, %1875
  %.0.i.i.i.i.i309 = phi i32 [ %1878, %1875 ], [ %1880, %1879 ]
  %1882 = icmp slt i32 %.0.i.i.i.i.i309, 1
  br i1 %1882, label %1883, label %.body312

; <label>:1883                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i310
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1870, %"class.std::allocator.0"* %266) #1
  br label %.body312

; <label>:1884                                    ; preds = %.noexc311
  %1885 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 2
  store i32 0, i32* %1885, align 8, !tbaa !10
  %1886 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 3
  store i32 0, i32* %1886, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %462)
          to label %1887 unwind label %3984

; <label>:1887                                    ; preds = %1884
  %1888 = getelementptr inbounds %"class.std::allocator.0"* %264, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1888)
  %1889 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 1, i32 0, i32 0
  %1890 = load i8** %1889, align 8, !tbaa !1
  %1891 = getelementptr inbounds i8* %1890, i64 -24
  %1892 = bitcast i8* %1891 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1893 = icmp eq i8* %1891, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1893, label %1906, label %1894, !prof !7

; <label>:1894                                    ; preds = %1887
  %1895 = getelementptr inbounds i8* %1890, i64 -8
  %1896 = bitcast i8* %1895 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1897, label %1901

; <label>:1897                                    ; preds = %1894
  %1898 = bitcast i32* %263 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1898)
  %1899 = atomicrmw volatile add i32* %1896, i32 -1 acq_rel
  store i32 %1899, i32* %263, align 4
  %1900 = load volatile i32* %263, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1898)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i316

; <label>:1901                                    ; preds = %1894
  %1902 = load i32* %1896, align 4, !tbaa !8
  %1903 = add nsw i32 %1902, -1
  store i32 %1903, i32* %1896, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i316

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i316: ; preds = %1901, %1897
  %.0.i.i.i.i.i315 = phi i32 [ %1900, %1897 ], [ %1902, %1901 ]
  %1904 = icmp slt i32 %.0.i.i.i.i.i315, 1
  br i1 %1904, label %1905, label %1906

; <label>:1905                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i316
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1892, %"class.std::allocator.0"* %264) #1
  br label %1906

; <label>:1906                                    ; preds = %1905, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i316, %1887
  call void @llvm.lifetime.end(i64 1, i8* %1888)
  %1907 = getelementptr inbounds %"class.std::allocator.0"* %262, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1907)
  %1908 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 0, i32 0, i32 0
  %1909 = load i8** %1908, align 8, !tbaa !1
  %1910 = getelementptr inbounds i8* %1909, i64 -24
  %1911 = bitcast i8* %1910 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1912 = icmp eq i8* %1910, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1912, label %1925, label %1913, !prof !7

; <label>:1913                                    ; preds = %1906
  %1914 = getelementptr inbounds i8* %1909, i64 -8
  %1915 = bitcast i8* %1914 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1916, label %1920

; <label>:1916                                    ; preds = %1913
  %1917 = bitcast i32* %261 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1917)
  %1918 = atomicrmw volatile add i32* %1915, i32 -1 acq_rel
  store i32 %1918, i32* %261, align 4
  %1919 = load volatile i32* %261, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1917)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i318

; <label>:1920                                    ; preds = %1913
  %1921 = load i32* %1915, align 4, !tbaa !8
  %1922 = add nsw i32 %1921, -1
  store i32 %1922, i32* %1915, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i318

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i318: ; preds = %1920, %1916
  %.0.i.i.i.i1.i317 = phi i32 [ %1919, %1916 ], [ %1921, %1920 ]
  %1923 = icmp slt i32 %.0.i.i.i.i1.i317, 1
  br i1 %1923, label %1924, label %1925

; <label>:1924                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i318
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1911, %"class.std::allocator.0"* %262) #1
  br label %1925

; <label>:1925                                    ; preds = %1924, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i318, %1906
  call void @llvm.lifetime.end(i64 1, i8* %1907)
  %1926 = getelementptr inbounds %"class.std::allocator.0"* %260, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1926)
  %1927 = getelementptr inbounds %"class.std::basic_string"* %465, i64 0, i32 0, i32 0
  %1928 = load i8** %1927, align 8, !tbaa !1
  %1929 = getelementptr inbounds i8* %1928, i64 -24
  %1930 = bitcast i8* %1929 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1931 = icmp eq i8* %1929, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1931, label %1944, label %1932, !prof !7

; <label>:1932                                    ; preds = %1925
  %1933 = getelementptr inbounds i8* %1928, i64 -8
  %1934 = bitcast i8* %1933 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1935, label %1939

; <label>:1935                                    ; preds = %1932
  %1936 = bitcast i32* %259 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1936)
  %1937 = atomicrmw volatile add i32* %1934, i32 -1 acq_rel
  store i32 %1937, i32* %259, align 4
  %1938 = load volatile i32* %259, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1936)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i321

; <label>:1939                                    ; preds = %1932
  %1940 = load i32* %1934, align 4, !tbaa !8
  %1941 = add nsw i32 %1940, -1
  store i32 %1941, i32* %1934, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i321

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i321: ; preds = %1939, %1935
  %.0.i.i.i.i320 = phi i32 [ %1938, %1935 ], [ %1940, %1939 ]
  %1942 = icmp slt i32 %.0.i.i.i.i320, 1
  br i1 %1942, label %1943, label %1944

; <label>:1943                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i321
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1930, %"class.std::allocator.0"* %260) #1
  br label %1944

; <label>:1944                                    ; preds = %1943, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i321, %1925
  call void @llvm.lifetime.end(i64 1, i8* %1926)
  %1945 = getelementptr inbounds %"class.std::allocator.0"* %258, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1945)
  %1946 = getelementptr inbounds %"class.std::basic_string"* %463, i64 0, i32 0, i32 0
  %1947 = load i8** %1946, align 8, !tbaa !1
  %1948 = getelementptr inbounds i8* %1947, i64 -24
  %1949 = bitcast i8* %1948 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1950 = icmp eq i8* %1948, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1950, label %1963, label %1951, !prof !7

; <label>:1951                                    ; preds = %1944
  %1952 = getelementptr inbounds i8* %1947, i64 -8
  %1953 = bitcast i8* %1952 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1954, label %1958

; <label>:1954                                    ; preds = %1951
  %1955 = bitcast i32* %257 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1955)
  %1956 = atomicrmw volatile add i32* %1953, i32 -1 acq_rel
  store i32 %1956, i32* %257, align 4
  %1957 = load volatile i32* %257, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1955)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i324

; <label>:1958                                    ; preds = %1951
  %1959 = load i32* %1953, align 4, !tbaa !8
  %1960 = add nsw i32 %1959, -1
  store i32 %1960, i32* %1953, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i324

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i324: ; preds = %1958, %1954
  %.0.i.i.i.i323 = phi i32 [ %1957, %1954 ], [ %1959, %1958 ]
  %1961 = icmp slt i32 %.0.i.i.i.i323, 1
  br i1 %1961, label %1962, label %1963

; <label>:1962                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i324
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1949, %"class.std::allocator.0"* %258) #1
  br label %1963

; <label>:1963                                    ; preds = %1962, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i324, %1944
  call void @llvm.lifetime.end(i64 1, i8* %1945)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %468, i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), %"class.std::allocator.0"* %469)
          to label %1964 unwind label %4061

; <label>:1964                                    ; preds = %1963
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %470, i8* getelementptr inbounds ([12 x i8]* @.str15, i64 0, i64 0), %"class.std::allocator.0"* %471)
          to label %1965 unwind label %4065

; <label>:1965                                    ; preds = %1964
  %1966 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1966, %"class.std::basic_string"* %468)
          to label %.noexc335 unwind label %4069

.noexc335:                                        ; preds = %1965
  %1967 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %1967, %"class.std::basic_string"* %470)
          to label %1988 unwind label %1968

; <label>:1968                                    ; preds = %.noexc335
  %1969 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %1970 = getelementptr inbounds %"class.std::allocator.0"* %256, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1970)
  %1971 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 0, i32 0, i32 0
  %1972 = load i8** %1971, align 8, !tbaa !1
  %1973 = getelementptr inbounds i8* %1972, i64 -24
  %1974 = bitcast i8* %1973 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1975 = icmp eq i8* %1973, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1975, label %.body336, label %1976, !prof !7

; <label>:1976                                    ; preds = %1968
  %1977 = getelementptr inbounds i8* %1972, i64 -8
  %1978 = bitcast i8* %1977 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %1979, label %1983

; <label>:1979                                    ; preds = %1976
  %1980 = bitcast i32* %255 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %1980)
  %1981 = atomicrmw volatile add i32* %1978, i32 -1 acq_rel
  store i32 %1981, i32* %255, align 4
  %1982 = load volatile i32* %255, align 4
  call void @llvm.lifetime.end(i64 4, i8* %1980)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i334

; <label>:1983                                    ; preds = %1976
  %1984 = load i32* %1978, align 4, !tbaa !8
  %1985 = add nsw i32 %1984, -1
  store i32 %1985, i32* %1978, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i334

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i334: ; preds = %1983, %1979
  %.0.i.i.i.i.i333 = phi i32 [ %1982, %1979 ], [ %1984, %1983 ]
  %1986 = icmp slt i32 %.0.i.i.i.i.i333, 1
  br i1 %1986, label %1987, label %.body336

; <label>:1987                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i334
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1974, %"class.std::allocator.0"* %256) #1
  br label %.body336

; <label>:1988                                    ; preds = %.noexc335
  %1989 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 2
  store i32 1, i32* %1989, align 8, !tbaa !10
  %1990 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 3
  store i32 1, i32* %1990, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %467)
          to label %1991 unwind label %4073

; <label>:1991                                    ; preds = %1988
  %1992 = getelementptr inbounds %"class.std::allocator.0"* %254, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %1992)
  %1993 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 1, i32 0, i32 0
  %1994 = load i8** %1993, align 8, !tbaa !1
  %1995 = getelementptr inbounds i8* %1994, i64 -24
  %1996 = bitcast i8* %1995 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %1997 = icmp eq i8* %1995, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %1997, label %2010, label %1998, !prof !7

; <label>:1998                                    ; preds = %1991
  %1999 = getelementptr inbounds i8* %1994, i64 -8
  %2000 = bitcast i8* %1999 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2001, label %2005

; <label>:2001                                    ; preds = %1998
  %2002 = bitcast i32* %253 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2002)
  %2003 = atomicrmw volatile add i32* %2000, i32 -1 acq_rel
  store i32 %2003, i32* %253, align 4
  %2004 = load volatile i32* %253, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2002)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i340

; <label>:2005                                    ; preds = %1998
  %2006 = load i32* %2000, align 4, !tbaa !8
  %2007 = add nsw i32 %2006, -1
  store i32 %2007, i32* %2000, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i340

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i340: ; preds = %2005, %2001
  %.0.i.i.i.i.i339 = phi i32 [ %2004, %2001 ], [ %2006, %2005 ]
  %2008 = icmp slt i32 %.0.i.i.i.i.i339, 1
  br i1 %2008, label %2009, label %2010

; <label>:2009                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i340
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %1996, %"class.std::allocator.0"* %254) #1
  br label %2010

; <label>:2010                                    ; preds = %2009, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i340, %1991
  call void @llvm.lifetime.end(i64 1, i8* %1992)
  %2011 = getelementptr inbounds %"class.std::allocator.0"* %252, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2011)
  %2012 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 0, i32 0, i32 0
  %2013 = load i8** %2012, align 8, !tbaa !1
  %2014 = getelementptr inbounds i8* %2013, i64 -24
  %2015 = bitcast i8* %2014 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2016 = icmp eq i8* %2014, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2016, label %2029, label %2017, !prof !7

; <label>:2017                                    ; preds = %2010
  %2018 = getelementptr inbounds i8* %2013, i64 -8
  %2019 = bitcast i8* %2018 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2020, label %2024

; <label>:2020                                    ; preds = %2017
  %2021 = bitcast i32* %251 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2021)
  %2022 = atomicrmw volatile add i32* %2019, i32 -1 acq_rel
  store i32 %2022, i32* %251, align 4
  %2023 = load volatile i32* %251, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2021)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i342

; <label>:2024                                    ; preds = %2017
  %2025 = load i32* %2019, align 4, !tbaa !8
  %2026 = add nsw i32 %2025, -1
  store i32 %2026, i32* %2019, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i342

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i342: ; preds = %2024, %2020
  %.0.i.i.i.i1.i341 = phi i32 [ %2023, %2020 ], [ %2025, %2024 ]
  %2027 = icmp slt i32 %.0.i.i.i.i1.i341, 1
  br i1 %2027, label %2028, label %2029

; <label>:2028                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i342
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2015, %"class.std::allocator.0"* %252) #1
  br label %2029

; <label>:2029                                    ; preds = %2028, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i342, %2010
  call void @llvm.lifetime.end(i64 1, i8* %2011)
  %2030 = getelementptr inbounds %"class.std::allocator.0"* %250, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2030)
  %2031 = getelementptr inbounds %"class.std::basic_string"* %470, i64 0, i32 0, i32 0
  %2032 = load i8** %2031, align 8, !tbaa !1
  %2033 = getelementptr inbounds i8* %2032, i64 -24
  %2034 = bitcast i8* %2033 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2035 = icmp eq i8* %2033, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2035, label %2048, label %2036, !prof !7

; <label>:2036                                    ; preds = %2029
  %2037 = getelementptr inbounds i8* %2032, i64 -8
  %2038 = bitcast i8* %2037 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2039, label %2043

; <label>:2039                                    ; preds = %2036
  %2040 = bitcast i32* %249 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2040)
  %2041 = atomicrmw volatile add i32* %2038, i32 -1 acq_rel
  store i32 %2041, i32* %249, align 4
  %2042 = load volatile i32* %249, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2040)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i345

; <label>:2043                                    ; preds = %2036
  %2044 = load i32* %2038, align 4, !tbaa !8
  %2045 = add nsw i32 %2044, -1
  store i32 %2045, i32* %2038, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i345

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i345: ; preds = %2043, %2039
  %.0.i.i.i.i344 = phi i32 [ %2042, %2039 ], [ %2044, %2043 ]
  %2046 = icmp slt i32 %.0.i.i.i.i344, 1
  br i1 %2046, label %2047, label %2048

; <label>:2047                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i345
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2034, %"class.std::allocator.0"* %250) #1
  br label %2048

; <label>:2048                                    ; preds = %2047, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i345, %2029
  call void @llvm.lifetime.end(i64 1, i8* %2030)
  %2049 = getelementptr inbounds %"class.std::allocator.0"* %248, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2049)
  %2050 = getelementptr inbounds %"class.std::basic_string"* %468, i64 0, i32 0, i32 0
  %2051 = load i8** %2050, align 8, !tbaa !1
  %2052 = getelementptr inbounds i8* %2051, i64 -24
  %2053 = bitcast i8* %2052 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2054 = icmp eq i8* %2052, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2054, label %2067, label %2055, !prof !7

; <label>:2055                                    ; preds = %2048
  %2056 = getelementptr inbounds i8* %2051, i64 -8
  %2057 = bitcast i8* %2056 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2058, label %2062

; <label>:2058                                    ; preds = %2055
  %2059 = bitcast i32* %247 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2059)
  %2060 = atomicrmw volatile add i32* %2057, i32 -1 acq_rel
  store i32 %2060, i32* %247, align 4
  %2061 = load volatile i32* %247, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2059)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i348

; <label>:2062                                    ; preds = %2055
  %2063 = load i32* %2057, align 4, !tbaa !8
  %2064 = add nsw i32 %2063, -1
  store i32 %2064, i32* %2057, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i348

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i348: ; preds = %2062, %2058
  %.0.i.i.i.i347 = phi i32 [ %2061, %2058 ], [ %2063, %2062 ]
  %2065 = icmp slt i32 %.0.i.i.i.i347, 1
  br i1 %2065, label %2066, label %2067

; <label>:2066                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i348
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2053, %"class.std::allocator.0"* %248) #1
  br label %2067

; <label>:2067                                    ; preds = %2066, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i348, %2048
  call void @llvm.lifetime.end(i64 1, i8* %2049)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %473, i8* getelementptr inbounds ([10 x i8]* @.str16, i64 0, i64 0), %"class.std::allocator.0"* %474)
          to label %2068 unwind label %4150

; <label>:2068                                    ; preds = %2067
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %475, i8* getelementptr inbounds ([12 x i8]* @.str15, i64 0, i64 0), %"class.std::allocator.0"* %476)
          to label %2069 unwind label %4154

; <label>:2069                                    ; preds = %2068
  %2070 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2070, %"class.std::basic_string"* %473)
          to label %.noexc352 unwind label %4158

.noexc352:                                        ; preds = %2069
  %2071 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2071, %"class.std::basic_string"* %475)
          to label %2092 unwind label %2072

; <label>:2072                                    ; preds = %.noexc352
  %2073 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2074 = getelementptr inbounds %"class.std::allocator.0"* %246, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2074)
  %2075 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 0, i32 0, i32 0
  %2076 = load i8** %2075, align 8, !tbaa !1
  %2077 = getelementptr inbounds i8* %2076, i64 -24
  %2078 = bitcast i8* %2077 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2079 = icmp eq i8* %2077, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2079, label %.body353, label %2080, !prof !7

; <label>:2080                                    ; preds = %2072
  %2081 = getelementptr inbounds i8* %2076, i64 -8
  %2082 = bitcast i8* %2081 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2083, label %2087

; <label>:2083                                    ; preds = %2080
  %2084 = bitcast i32* %245 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2084)
  %2085 = atomicrmw volatile add i32* %2082, i32 -1 acq_rel
  store i32 %2085, i32* %245, align 4
  %2086 = load volatile i32* %245, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2084)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i351

; <label>:2087                                    ; preds = %2080
  %2088 = load i32* %2082, align 4, !tbaa !8
  %2089 = add nsw i32 %2088, -1
  store i32 %2089, i32* %2082, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i351

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i351: ; preds = %2087, %2083
  %.0.i.i.i.i.i350 = phi i32 [ %2086, %2083 ], [ %2088, %2087 ]
  %2090 = icmp slt i32 %.0.i.i.i.i.i350, 1
  br i1 %2090, label %2091, label %.body353

; <label>:2091                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i351
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2078, %"class.std::allocator.0"* %246) #1
  br label %.body353

; <label>:2092                                    ; preds = %.noexc352
  %2093 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 2
  store i32 1, i32* %2093, align 8, !tbaa !10
  %2094 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 3
  store i32 0, i32* %2094, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %472)
          to label %2095 unwind label %4162

; <label>:2095                                    ; preds = %2092
  %2096 = getelementptr inbounds %"class.std::allocator.0"* %244, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2096)
  %2097 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 1, i32 0, i32 0
  %2098 = load i8** %2097, align 8, !tbaa !1
  %2099 = getelementptr inbounds i8* %2098, i64 -24
  %2100 = bitcast i8* %2099 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2101 = icmp eq i8* %2099, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2101, label %2114, label %2102, !prof !7

; <label>:2102                                    ; preds = %2095
  %2103 = getelementptr inbounds i8* %2098, i64 -8
  %2104 = bitcast i8* %2103 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2105, label %2109

; <label>:2105                                    ; preds = %2102
  %2106 = bitcast i32* %243 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2106)
  %2107 = atomicrmw volatile add i32* %2104, i32 -1 acq_rel
  store i32 %2107, i32* %243, align 4
  %2108 = load volatile i32* %243, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2106)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i357

; <label>:2109                                    ; preds = %2102
  %2110 = load i32* %2104, align 4, !tbaa !8
  %2111 = add nsw i32 %2110, -1
  store i32 %2111, i32* %2104, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i357

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i357: ; preds = %2109, %2105
  %.0.i.i.i.i.i356 = phi i32 [ %2108, %2105 ], [ %2110, %2109 ]
  %2112 = icmp slt i32 %.0.i.i.i.i.i356, 1
  br i1 %2112, label %2113, label %2114

; <label>:2113                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i357
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2100, %"class.std::allocator.0"* %244) #1
  br label %2114

; <label>:2114                                    ; preds = %2113, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i357, %2095
  call void @llvm.lifetime.end(i64 1, i8* %2096)
  %2115 = getelementptr inbounds %"class.std::allocator.0"* %242, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2115)
  %2116 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 0, i32 0, i32 0
  %2117 = load i8** %2116, align 8, !tbaa !1
  %2118 = getelementptr inbounds i8* %2117, i64 -24
  %2119 = bitcast i8* %2118 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2120 = icmp eq i8* %2118, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2120, label %2133, label %2121, !prof !7

; <label>:2121                                    ; preds = %2114
  %2122 = getelementptr inbounds i8* %2117, i64 -8
  %2123 = bitcast i8* %2122 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2124, label %2128

; <label>:2124                                    ; preds = %2121
  %2125 = bitcast i32* %241 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2125)
  %2126 = atomicrmw volatile add i32* %2123, i32 -1 acq_rel
  store i32 %2126, i32* %241, align 4
  %2127 = load volatile i32* %241, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2125)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i359

; <label>:2128                                    ; preds = %2121
  %2129 = load i32* %2123, align 4, !tbaa !8
  %2130 = add nsw i32 %2129, -1
  store i32 %2130, i32* %2123, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i359

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i359: ; preds = %2128, %2124
  %.0.i.i.i.i1.i358 = phi i32 [ %2127, %2124 ], [ %2129, %2128 ]
  %2131 = icmp slt i32 %.0.i.i.i.i1.i358, 1
  br i1 %2131, label %2132, label %2133

; <label>:2132                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i359
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2119, %"class.std::allocator.0"* %242) #1
  br label %2133

; <label>:2133                                    ; preds = %2132, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i359, %2114
  call void @llvm.lifetime.end(i64 1, i8* %2115)
  %2134 = getelementptr inbounds %"class.std::allocator.0"* %240, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2134)
  %2135 = getelementptr inbounds %"class.std::basic_string"* %475, i64 0, i32 0, i32 0
  %2136 = load i8** %2135, align 8, !tbaa !1
  %2137 = getelementptr inbounds i8* %2136, i64 -24
  %2138 = bitcast i8* %2137 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2139 = icmp eq i8* %2137, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2139, label %2152, label %2140, !prof !7

; <label>:2140                                    ; preds = %2133
  %2141 = getelementptr inbounds i8* %2136, i64 -8
  %2142 = bitcast i8* %2141 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2143, label %2147

; <label>:2143                                    ; preds = %2140
  %2144 = bitcast i32* %239 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2144)
  %2145 = atomicrmw volatile add i32* %2142, i32 -1 acq_rel
  store i32 %2145, i32* %239, align 4
  %2146 = load volatile i32* %239, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2144)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i362

; <label>:2147                                    ; preds = %2140
  %2148 = load i32* %2142, align 4, !tbaa !8
  %2149 = add nsw i32 %2148, -1
  store i32 %2149, i32* %2142, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i362

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i362: ; preds = %2147, %2143
  %.0.i.i.i.i361 = phi i32 [ %2146, %2143 ], [ %2148, %2147 ]
  %2150 = icmp slt i32 %.0.i.i.i.i361, 1
  br i1 %2150, label %2151, label %2152

; <label>:2151                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i362
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2138, %"class.std::allocator.0"* %240) #1
  br label %2152

; <label>:2152                                    ; preds = %2151, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i362, %2133
  call void @llvm.lifetime.end(i64 1, i8* %2134)
  %2153 = getelementptr inbounds %"class.std::allocator.0"* %238, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2153)
  %2154 = getelementptr inbounds %"class.std::basic_string"* %473, i64 0, i32 0, i32 0
  %2155 = load i8** %2154, align 8, !tbaa !1
  %2156 = getelementptr inbounds i8* %2155, i64 -24
  %2157 = bitcast i8* %2156 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2158 = icmp eq i8* %2156, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2158, label %2171, label %2159, !prof !7

; <label>:2159                                    ; preds = %2152
  %2160 = getelementptr inbounds i8* %2155, i64 -8
  %2161 = bitcast i8* %2160 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2162, label %2166

; <label>:2162                                    ; preds = %2159
  %2163 = bitcast i32* %237 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2163)
  %2164 = atomicrmw volatile add i32* %2161, i32 -1 acq_rel
  store i32 %2164, i32* %237, align 4
  %2165 = load volatile i32* %237, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2163)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i365

; <label>:2166                                    ; preds = %2159
  %2167 = load i32* %2161, align 4, !tbaa !8
  %2168 = add nsw i32 %2167, -1
  store i32 %2168, i32* %2161, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i365

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i365: ; preds = %2166, %2162
  %.0.i.i.i.i364 = phi i32 [ %2165, %2162 ], [ %2167, %2166 ]
  %2169 = icmp slt i32 %.0.i.i.i.i364, 1
  br i1 %2169, label %2170, label %2171

; <label>:2170                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i365
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2157, %"class.std::allocator.0"* %238) #1
  br label %2171

; <label>:2171                                    ; preds = %2170, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i365, %2152
  call void @llvm.lifetime.end(i64 1, i8* %2153)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %478, i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), %"class.std::allocator.0"* %479)
          to label %2172 unwind label %4239

; <label>:2172                                    ; preds = %2171
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %480, i8* getelementptr inbounds ([13 x i8]* @.str17, i64 0, i64 0), %"class.std::allocator.0"* %481)
          to label %2173 unwind label %4243

; <label>:2173                                    ; preds = %2172
  %2174 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2174, %"class.std::basic_string"* %478)
          to label %.noexc371 unwind label %4247

.noexc371:                                        ; preds = %2173
  %2175 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2175, %"class.std::basic_string"* %480)
          to label %2196 unwind label %2176

; <label>:2176                                    ; preds = %.noexc371
  %2177 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2178 = getelementptr inbounds %"class.std::allocator.0"* %236, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2178)
  %2179 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 0, i32 0, i32 0
  %2180 = load i8** %2179, align 8, !tbaa !1
  %2181 = getelementptr inbounds i8* %2180, i64 -24
  %2182 = bitcast i8* %2181 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2183 = icmp eq i8* %2181, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2183, label %.body372, label %2184, !prof !7

; <label>:2184                                    ; preds = %2176
  %2185 = getelementptr inbounds i8* %2180, i64 -8
  %2186 = bitcast i8* %2185 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2187, label %2191

; <label>:2187                                    ; preds = %2184
  %2188 = bitcast i32* %235 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2188)
  %2189 = atomicrmw volatile add i32* %2186, i32 -1 acq_rel
  store i32 %2189, i32* %235, align 4
  %2190 = load volatile i32* %235, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2188)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i370

; <label>:2191                                    ; preds = %2184
  %2192 = load i32* %2186, align 4, !tbaa !8
  %2193 = add nsw i32 %2192, -1
  store i32 %2193, i32* %2186, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i370

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i370: ; preds = %2191, %2187
  %.0.i.i.i.i.i369 = phi i32 [ %2190, %2187 ], [ %2192, %2191 ]
  %2194 = icmp slt i32 %.0.i.i.i.i.i369, 1
  br i1 %2194, label %2195, label %.body372

; <label>:2195                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i370
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2182, %"class.std::allocator.0"* %236) #1
  br label %.body372

; <label>:2196                                    ; preds = %.noexc371
  %2197 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 2
  store i32 0, i32* %2197, align 8, !tbaa !10
  %2198 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 3
  store i32 0, i32* %2198, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %477)
          to label %2199 unwind label %4251

; <label>:2199                                    ; preds = %2196
  %2200 = getelementptr inbounds %"class.std::allocator.0"* %234, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2200)
  %2201 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 1, i32 0, i32 0
  %2202 = load i8** %2201, align 8, !tbaa !1
  %2203 = getelementptr inbounds i8* %2202, i64 -24
  %2204 = bitcast i8* %2203 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2205 = icmp eq i8* %2203, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2205, label %2218, label %2206, !prof !7

; <label>:2206                                    ; preds = %2199
  %2207 = getelementptr inbounds i8* %2202, i64 -8
  %2208 = bitcast i8* %2207 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2209, label %2213

; <label>:2209                                    ; preds = %2206
  %2210 = bitcast i32* %233 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2210)
  %2211 = atomicrmw volatile add i32* %2208, i32 -1 acq_rel
  store i32 %2211, i32* %233, align 4
  %2212 = load volatile i32* %233, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2210)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i376

; <label>:2213                                    ; preds = %2206
  %2214 = load i32* %2208, align 4, !tbaa !8
  %2215 = add nsw i32 %2214, -1
  store i32 %2215, i32* %2208, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i376

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i376: ; preds = %2213, %2209
  %.0.i.i.i.i.i375 = phi i32 [ %2212, %2209 ], [ %2214, %2213 ]
  %2216 = icmp slt i32 %.0.i.i.i.i.i375, 1
  br i1 %2216, label %2217, label %2218

; <label>:2217                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i376
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2204, %"class.std::allocator.0"* %234) #1
  br label %2218

; <label>:2218                                    ; preds = %2217, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i376, %2199
  call void @llvm.lifetime.end(i64 1, i8* %2200)
  %2219 = getelementptr inbounds %"class.std::allocator.0"* %232, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2219)
  %2220 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 0, i32 0, i32 0
  %2221 = load i8** %2220, align 8, !tbaa !1
  %2222 = getelementptr inbounds i8* %2221, i64 -24
  %2223 = bitcast i8* %2222 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2224 = icmp eq i8* %2222, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2224, label %2237, label %2225, !prof !7

; <label>:2225                                    ; preds = %2218
  %2226 = getelementptr inbounds i8* %2221, i64 -8
  %2227 = bitcast i8* %2226 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2228, label %2232

; <label>:2228                                    ; preds = %2225
  %2229 = bitcast i32* %231 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2229)
  %2230 = atomicrmw volatile add i32* %2227, i32 -1 acq_rel
  store i32 %2230, i32* %231, align 4
  %2231 = load volatile i32* %231, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2229)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i378

; <label>:2232                                    ; preds = %2225
  %2233 = load i32* %2227, align 4, !tbaa !8
  %2234 = add nsw i32 %2233, -1
  store i32 %2234, i32* %2227, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i378

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i378: ; preds = %2232, %2228
  %.0.i.i.i.i1.i377 = phi i32 [ %2231, %2228 ], [ %2233, %2232 ]
  %2235 = icmp slt i32 %.0.i.i.i.i1.i377, 1
  br i1 %2235, label %2236, label %2237

; <label>:2236                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i378
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2223, %"class.std::allocator.0"* %232) #1
  br label %2237

; <label>:2237                                    ; preds = %2236, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i378, %2218
  call void @llvm.lifetime.end(i64 1, i8* %2219)
  %2238 = getelementptr inbounds %"class.std::allocator.0"* %230, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2238)
  %2239 = getelementptr inbounds %"class.std::basic_string"* %480, i64 0, i32 0, i32 0
  %2240 = load i8** %2239, align 8, !tbaa !1
  %2241 = getelementptr inbounds i8* %2240, i64 -24
  %2242 = bitcast i8* %2241 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2243 = icmp eq i8* %2241, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2243, label %2256, label %2244, !prof !7

; <label>:2244                                    ; preds = %2237
  %2245 = getelementptr inbounds i8* %2240, i64 -8
  %2246 = bitcast i8* %2245 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2247, label %2251

; <label>:2247                                    ; preds = %2244
  %2248 = bitcast i32* %229 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2248)
  %2249 = atomicrmw volatile add i32* %2246, i32 -1 acq_rel
  store i32 %2249, i32* %229, align 4
  %2250 = load volatile i32* %229, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2248)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i381

; <label>:2251                                    ; preds = %2244
  %2252 = load i32* %2246, align 4, !tbaa !8
  %2253 = add nsw i32 %2252, -1
  store i32 %2253, i32* %2246, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i381

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i381: ; preds = %2251, %2247
  %.0.i.i.i.i380 = phi i32 [ %2250, %2247 ], [ %2252, %2251 ]
  %2254 = icmp slt i32 %.0.i.i.i.i380, 1
  br i1 %2254, label %2255, label %2256

; <label>:2255                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i381
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2242, %"class.std::allocator.0"* %230) #1
  br label %2256

; <label>:2256                                    ; preds = %2255, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i381, %2237
  call void @llvm.lifetime.end(i64 1, i8* %2238)
  %2257 = getelementptr inbounds %"class.std::allocator.0"* %228, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2257)
  %2258 = getelementptr inbounds %"class.std::basic_string"* %478, i64 0, i32 0, i32 0
  %2259 = load i8** %2258, align 8, !tbaa !1
  %2260 = getelementptr inbounds i8* %2259, i64 -24
  %2261 = bitcast i8* %2260 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2262 = icmp eq i8* %2260, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2262, label %2275, label %2263, !prof !7

; <label>:2263                                    ; preds = %2256
  %2264 = getelementptr inbounds i8* %2259, i64 -8
  %2265 = bitcast i8* %2264 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2266, label %2270

; <label>:2266                                    ; preds = %2263
  %2267 = bitcast i32* %227 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2267)
  %2268 = atomicrmw volatile add i32* %2265, i32 -1 acq_rel
  store i32 %2268, i32* %227, align 4
  %2269 = load volatile i32* %227, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2267)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i384

; <label>:2270                                    ; preds = %2263
  %2271 = load i32* %2265, align 4, !tbaa !8
  %2272 = add nsw i32 %2271, -1
  store i32 %2272, i32* %2265, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i384

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i384: ; preds = %2270, %2266
  %.0.i.i.i.i383 = phi i32 [ %2269, %2266 ], [ %2271, %2270 ]
  %2273 = icmp slt i32 %.0.i.i.i.i383, 1
  br i1 %2273, label %2274, label %2275

; <label>:2274                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i384
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2261, %"class.std::allocator.0"* %228) #1
  br label %2275

; <label>:2275                                    ; preds = %2274, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i384, %2256
  call void @llvm.lifetime.end(i64 1, i8* %2257)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %483, i8* getelementptr inbounds ([8 x i8]* @.str14, i64 0, i64 0), %"class.std::allocator.0"* %484)
          to label %2276 unwind label %4328

; <label>:2276                                    ; preds = %2275
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %485, i8* getelementptr inbounds ([8 x i8]* @.str18, i64 0, i64 0), %"class.std::allocator.0"* %486)
          to label %2277 unwind label %4332

; <label>:2277                                    ; preds = %2276
  %2278 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2278, %"class.std::basic_string"* %483)
          to label %.noexc390 unwind label %4336

.noexc390:                                        ; preds = %2277
  %2279 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2279, %"class.std::basic_string"* %485)
          to label %2300 unwind label %2280

; <label>:2280                                    ; preds = %.noexc390
  %2281 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2282 = getelementptr inbounds %"class.std::allocator.0"* %226, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2282)
  %2283 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 0, i32 0, i32 0
  %2284 = load i8** %2283, align 8, !tbaa !1
  %2285 = getelementptr inbounds i8* %2284, i64 -24
  %2286 = bitcast i8* %2285 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2287 = icmp eq i8* %2285, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2287, label %.body391, label %2288, !prof !7

; <label>:2288                                    ; preds = %2280
  %2289 = getelementptr inbounds i8* %2284, i64 -8
  %2290 = bitcast i8* %2289 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2291, label %2295

; <label>:2291                                    ; preds = %2288
  %2292 = bitcast i32* %225 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2292)
  %2293 = atomicrmw volatile add i32* %2290, i32 -1 acq_rel
  store i32 %2293, i32* %225, align 4
  %2294 = load volatile i32* %225, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2292)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i389

; <label>:2295                                    ; preds = %2288
  %2296 = load i32* %2290, align 4, !tbaa !8
  %2297 = add nsw i32 %2296, -1
  store i32 %2297, i32* %2290, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i389

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i389: ; preds = %2295, %2291
  %.0.i.i.i.i.i388 = phi i32 [ %2294, %2291 ], [ %2296, %2295 ]
  %2298 = icmp slt i32 %.0.i.i.i.i.i388, 1
  br i1 %2298, label %2299, label %.body391

; <label>:2299                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i389
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2286, %"class.std::allocator.0"* %226) #1
  br label %.body391

; <label>:2300                                    ; preds = %.noexc390
  %2301 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 2
  store i32 4, i32* %2301, align 8, !tbaa !10
  %2302 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 3
  store i32 1, i32* %2302, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %482)
          to label %2303 unwind label %4340

; <label>:2303                                    ; preds = %2300
  %2304 = getelementptr inbounds %"class.std::allocator.0"* %224, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2304)
  %2305 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 1, i32 0, i32 0
  %2306 = load i8** %2305, align 8, !tbaa !1
  %2307 = getelementptr inbounds i8* %2306, i64 -24
  %2308 = bitcast i8* %2307 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2309 = icmp eq i8* %2307, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2309, label %2322, label %2310, !prof !7

; <label>:2310                                    ; preds = %2303
  %2311 = getelementptr inbounds i8* %2306, i64 -8
  %2312 = bitcast i8* %2311 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2313, label %2317

; <label>:2313                                    ; preds = %2310
  %2314 = bitcast i32* %223 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2314)
  %2315 = atomicrmw volatile add i32* %2312, i32 -1 acq_rel
  store i32 %2315, i32* %223, align 4
  %2316 = load volatile i32* %223, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2314)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i395

; <label>:2317                                    ; preds = %2310
  %2318 = load i32* %2312, align 4, !tbaa !8
  %2319 = add nsw i32 %2318, -1
  store i32 %2319, i32* %2312, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i395

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i395: ; preds = %2317, %2313
  %.0.i.i.i.i.i394 = phi i32 [ %2316, %2313 ], [ %2318, %2317 ]
  %2320 = icmp slt i32 %.0.i.i.i.i.i394, 1
  br i1 %2320, label %2321, label %2322

; <label>:2321                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i395
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2308, %"class.std::allocator.0"* %224) #1
  br label %2322

; <label>:2322                                    ; preds = %2321, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i395, %2303
  call void @llvm.lifetime.end(i64 1, i8* %2304)
  %2323 = getelementptr inbounds %"class.std::allocator.0"* %222, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2323)
  %2324 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 0, i32 0, i32 0
  %2325 = load i8** %2324, align 8, !tbaa !1
  %2326 = getelementptr inbounds i8* %2325, i64 -24
  %2327 = bitcast i8* %2326 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2328 = icmp eq i8* %2326, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2328, label %2341, label %2329, !prof !7

; <label>:2329                                    ; preds = %2322
  %2330 = getelementptr inbounds i8* %2325, i64 -8
  %2331 = bitcast i8* %2330 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2332, label %2336

; <label>:2332                                    ; preds = %2329
  %2333 = bitcast i32* %221 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2333)
  %2334 = atomicrmw volatile add i32* %2331, i32 -1 acq_rel
  store i32 %2334, i32* %221, align 4
  %2335 = load volatile i32* %221, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2333)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i397

; <label>:2336                                    ; preds = %2329
  %2337 = load i32* %2331, align 4, !tbaa !8
  %2338 = add nsw i32 %2337, -1
  store i32 %2338, i32* %2331, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i397

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i397: ; preds = %2336, %2332
  %.0.i.i.i.i1.i396 = phi i32 [ %2335, %2332 ], [ %2337, %2336 ]
  %2339 = icmp slt i32 %.0.i.i.i.i1.i396, 1
  br i1 %2339, label %2340, label %2341

; <label>:2340                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i397
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2327, %"class.std::allocator.0"* %222) #1
  br label %2341

; <label>:2341                                    ; preds = %2340, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i397, %2322
  call void @llvm.lifetime.end(i64 1, i8* %2323)
  %2342 = getelementptr inbounds %"class.std::allocator.0"* %220, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2342)
  %2343 = getelementptr inbounds %"class.std::basic_string"* %485, i64 0, i32 0, i32 0
  %2344 = load i8** %2343, align 8, !tbaa !1
  %2345 = getelementptr inbounds i8* %2344, i64 -24
  %2346 = bitcast i8* %2345 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2347 = icmp eq i8* %2345, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2347, label %2360, label %2348, !prof !7

; <label>:2348                                    ; preds = %2341
  %2349 = getelementptr inbounds i8* %2344, i64 -8
  %2350 = bitcast i8* %2349 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2351, label %2355

; <label>:2351                                    ; preds = %2348
  %2352 = bitcast i32* %219 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2352)
  %2353 = atomicrmw volatile add i32* %2350, i32 -1 acq_rel
  store i32 %2353, i32* %219, align 4
  %2354 = load volatile i32* %219, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2352)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i400

; <label>:2355                                    ; preds = %2348
  %2356 = load i32* %2350, align 4, !tbaa !8
  %2357 = add nsw i32 %2356, -1
  store i32 %2357, i32* %2350, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i400

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i400: ; preds = %2355, %2351
  %.0.i.i.i.i399 = phi i32 [ %2354, %2351 ], [ %2356, %2355 ]
  %2358 = icmp slt i32 %.0.i.i.i.i399, 1
  br i1 %2358, label %2359, label %2360

; <label>:2359                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i400
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2346, %"class.std::allocator.0"* %220) #1
  br label %2360

; <label>:2360                                    ; preds = %2359, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i400, %2341
  call void @llvm.lifetime.end(i64 1, i8* %2342)
  %2361 = getelementptr inbounds %"class.std::allocator.0"* %218, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2361)
  %2362 = getelementptr inbounds %"class.std::basic_string"* %483, i64 0, i32 0, i32 0
  %2363 = load i8** %2362, align 8, !tbaa !1
  %2364 = getelementptr inbounds i8* %2363, i64 -24
  %2365 = bitcast i8* %2364 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2366 = icmp eq i8* %2364, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2366, label %2379, label %2367, !prof !7

; <label>:2367                                    ; preds = %2360
  %2368 = getelementptr inbounds i8* %2363, i64 -8
  %2369 = bitcast i8* %2368 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2370, label %2374

; <label>:2370                                    ; preds = %2367
  %2371 = bitcast i32* %217 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2371)
  %2372 = atomicrmw volatile add i32* %2369, i32 -1 acq_rel
  store i32 %2372, i32* %217, align 4
  %2373 = load volatile i32* %217, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2371)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i403

; <label>:2374                                    ; preds = %2367
  %2375 = load i32* %2369, align 4, !tbaa !8
  %2376 = add nsw i32 %2375, -1
  store i32 %2376, i32* %2369, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i403

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i403: ; preds = %2374, %2370
  %.0.i.i.i.i402 = phi i32 [ %2373, %2370 ], [ %2375, %2374 ]
  %2377 = icmp slt i32 %.0.i.i.i.i402, 1
  br i1 %2377, label %2378, label %2379

; <label>:2378                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i403
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2365, %"class.std::allocator.0"* %218) #1
  br label %2379

; <label>:2379                                    ; preds = %2378, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i403, %2360
  call void @llvm.lifetime.end(i64 1, i8* %2361)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %488, i8* getelementptr inbounds ([9 x i8]* @.str19, i64 0, i64 0), %"class.std::allocator.0"* %489)
          to label %2380 unwind label %4417

; <label>:2380                                    ; preds = %2379
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %490, i8* getelementptr inbounds ([13 x i8]* @.str17, i64 0, i64 0), %"class.std::allocator.0"* %491)
          to label %2381 unwind label %4421

; <label>:2381                                    ; preds = %2380
  %2382 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2382, %"class.std::basic_string"* %488)
          to label %.noexc407 unwind label %4425

.noexc407:                                        ; preds = %2381
  %2383 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2383, %"class.std::basic_string"* %490)
          to label %2404 unwind label %2384

; <label>:2384                                    ; preds = %.noexc407
  %2385 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2386 = getelementptr inbounds %"class.std::allocator.0"* %216, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2386)
  %2387 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 0, i32 0, i32 0
  %2388 = load i8** %2387, align 8, !tbaa !1
  %2389 = getelementptr inbounds i8* %2388, i64 -24
  %2390 = bitcast i8* %2389 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2391 = icmp eq i8* %2389, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2391, label %.body408, label %2392, !prof !7

; <label>:2392                                    ; preds = %2384
  %2393 = getelementptr inbounds i8* %2388, i64 -8
  %2394 = bitcast i8* %2393 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2395, label %2399

; <label>:2395                                    ; preds = %2392
  %2396 = bitcast i32* %215 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2396)
  %2397 = atomicrmw volatile add i32* %2394, i32 -1 acq_rel
  store i32 %2397, i32* %215, align 4
  %2398 = load volatile i32* %215, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2396)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i406

; <label>:2399                                    ; preds = %2392
  %2400 = load i32* %2394, align 4, !tbaa !8
  %2401 = add nsw i32 %2400, -1
  store i32 %2401, i32* %2394, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i406

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i406: ; preds = %2399, %2395
  %.0.i.i.i.i.i405 = phi i32 [ %2398, %2395 ], [ %2400, %2399 ]
  %2402 = icmp slt i32 %.0.i.i.i.i.i405, 1
  br i1 %2402, label %2403, label %.body408

; <label>:2403                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i406
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2390, %"class.std::allocator.0"* %216) #1
  br label %.body408

; <label>:2404                                    ; preds = %.noexc407
  %2405 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 2
  store i32 4, i32* %2405, align 8, !tbaa !10
  %2406 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 3
  store i32 0, i32* %2406, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %487)
          to label %2407 unwind label %4429

; <label>:2407                                    ; preds = %2404
  %2408 = getelementptr inbounds %"class.std::allocator.0"* %214, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2408)
  %2409 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 1, i32 0, i32 0
  %2410 = load i8** %2409, align 8, !tbaa !1
  %2411 = getelementptr inbounds i8* %2410, i64 -24
  %2412 = bitcast i8* %2411 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2413 = icmp eq i8* %2411, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2413, label %2426, label %2414, !prof !7

; <label>:2414                                    ; preds = %2407
  %2415 = getelementptr inbounds i8* %2410, i64 -8
  %2416 = bitcast i8* %2415 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2417, label %2421

; <label>:2417                                    ; preds = %2414
  %2418 = bitcast i32* %213 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2418)
  %2419 = atomicrmw volatile add i32* %2416, i32 -1 acq_rel
  store i32 %2419, i32* %213, align 4
  %2420 = load volatile i32* %213, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2418)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i412

; <label>:2421                                    ; preds = %2414
  %2422 = load i32* %2416, align 4, !tbaa !8
  %2423 = add nsw i32 %2422, -1
  store i32 %2423, i32* %2416, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i412

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i412: ; preds = %2421, %2417
  %.0.i.i.i.i.i411 = phi i32 [ %2420, %2417 ], [ %2422, %2421 ]
  %2424 = icmp slt i32 %.0.i.i.i.i.i411, 1
  br i1 %2424, label %2425, label %2426

; <label>:2425                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i412
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2412, %"class.std::allocator.0"* %214) #1
  br label %2426

; <label>:2426                                    ; preds = %2425, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i412, %2407
  call void @llvm.lifetime.end(i64 1, i8* %2408)
  %2427 = getelementptr inbounds %"class.std::allocator.0"* %212, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2427)
  %2428 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 0, i32 0, i32 0
  %2429 = load i8** %2428, align 8, !tbaa !1
  %2430 = getelementptr inbounds i8* %2429, i64 -24
  %2431 = bitcast i8* %2430 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2432 = icmp eq i8* %2430, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2432, label %2445, label %2433, !prof !7

; <label>:2433                                    ; preds = %2426
  %2434 = getelementptr inbounds i8* %2429, i64 -8
  %2435 = bitcast i8* %2434 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2436, label %2440

; <label>:2436                                    ; preds = %2433
  %2437 = bitcast i32* %211 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2437)
  %2438 = atomicrmw volatile add i32* %2435, i32 -1 acq_rel
  store i32 %2438, i32* %211, align 4
  %2439 = load volatile i32* %211, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2437)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i414

; <label>:2440                                    ; preds = %2433
  %2441 = load i32* %2435, align 4, !tbaa !8
  %2442 = add nsw i32 %2441, -1
  store i32 %2442, i32* %2435, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i414

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i414: ; preds = %2440, %2436
  %.0.i.i.i.i1.i413 = phi i32 [ %2439, %2436 ], [ %2441, %2440 ]
  %2443 = icmp slt i32 %.0.i.i.i.i1.i413, 1
  br i1 %2443, label %2444, label %2445

; <label>:2444                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i414
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2431, %"class.std::allocator.0"* %212) #1
  br label %2445

; <label>:2445                                    ; preds = %2444, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i414, %2426
  call void @llvm.lifetime.end(i64 1, i8* %2427)
  %2446 = getelementptr inbounds %"class.std::allocator.0"* %210, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2446)
  %2447 = getelementptr inbounds %"class.std::basic_string"* %490, i64 0, i32 0, i32 0
  %2448 = load i8** %2447, align 8, !tbaa !1
  %2449 = getelementptr inbounds i8* %2448, i64 -24
  %2450 = bitcast i8* %2449 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2451 = icmp eq i8* %2449, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2451, label %2464, label %2452, !prof !7

; <label>:2452                                    ; preds = %2445
  %2453 = getelementptr inbounds i8* %2448, i64 -8
  %2454 = bitcast i8* %2453 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2455, label %2459

; <label>:2455                                    ; preds = %2452
  %2456 = bitcast i32* %209 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2456)
  %2457 = atomicrmw volatile add i32* %2454, i32 -1 acq_rel
  store i32 %2457, i32* %209, align 4
  %2458 = load volatile i32* %209, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2456)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i417

; <label>:2459                                    ; preds = %2452
  %2460 = load i32* %2454, align 4, !tbaa !8
  %2461 = add nsw i32 %2460, -1
  store i32 %2461, i32* %2454, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i417

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i417: ; preds = %2459, %2455
  %.0.i.i.i.i416 = phi i32 [ %2458, %2455 ], [ %2460, %2459 ]
  %2462 = icmp slt i32 %.0.i.i.i.i416, 1
  br i1 %2462, label %2463, label %2464

; <label>:2463                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i417
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2450, %"class.std::allocator.0"* %210) #1
  br label %2464

; <label>:2464                                    ; preds = %2463, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i417, %2445
  call void @llvm.lifetime.end(i64 1, i8* %2446)
  %2465 = getelementptr inbounds %"class.std::allocator.0"* %208, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2465)
  %2466 = getelementptr inbounds %"class.std::basic_string"* %488, i64 0, i32 0, i32 0
  %2467 = load i8** %2466, align 8, !tbaa !1
  %2468 = getelementptr inbounds i8* %2467, i64 -24
  %2469 = bitcast i8* %2468 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2470 = icmp eq i8* %2468, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2470, label %2483, label %2471, !prof !7

; <label>:2471                                    ; preds = %2464
  %2472 = getelementptr inbounds i8* %2467, i64 -8
  %2473 = bitcast i8* %2472 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2474, label %2478

; <label>:2474                                    ; preds = %2471
  %2475 = bitcast i32* %207 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2475)
  %2476 = atomicrmw volatile add i32* %2473, i32 -1 acq_rel
  store i32 %2476, i32* %207, align 4
  %2477 = load volatile i32* %207, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2475)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i420

; <label>:2478                                    ; preds = %2471
  %2479 = load i32* %2473, align 4, !tbaa !8
  %2480 = add nsw i32 %2479, -1
  store i32 %2480, i32* %2473, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i420

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i420: ; preds = %2478, %2474
  %.0.i.i.i.i419 = phi i32 [ %2477, %2474 ], [ %2479, %2478 ]
  %2481 = icmp slt i32 %.0.i.i.i.i419, 1
  br i1 %2481, label %2482, label %2483

; <label>:2482                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i420
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2469, %"class.std::allocator.0"* %208) #1
  br label %2483

; <label>:2483                                    ; preds = %2482, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i420, %2464
  call void @llvm.lifetime.end(i64 1, i8* %2465)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %493, i8* getelementptr inbounds ([9 x i8]* @.str19, i64 0, i64 0), %"class.std::allocator.0"* %494)
          to label %2484 unwind label %4506

; <label>:2484                                    ; preds = %2483
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %495, i8* getelementptr inbounds ([13 x i8]* @.str17, i64 0, i64 0), %"class.std::allocator.0"* %496)
          to label %2485 unwind label %4510

; <label>:2485                                    ; preds = %2484
  %2486 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2486, %"class.std::basic_string"* %493)
          to label %.noexc432 unwind label %4514

.noexc432:                                        ; preds = %2485
  %2487 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2487, %"class.std::basic_string"* %495)
          to label %2508 unwind label %2488

; <label>:2488                                    ; preds = %.noexc432
  %2489 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2490 = getelementptr inbounds %"class.std::allocator.0"* %206, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2490)
  %2491 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 0, i32 0, i32 0
  %2492 = load i8** %2491, align 8, !tbaa !1
  %2493 = getelementptr inbounds i8* %2492, i64 -24
  %2494 = bitcast i8* %2493 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2495 = icmp eq i8* %2493, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2495, label %.body433, label %2496, !prof !7

; <label>:2496                                    ; preds = %2488
  %2497 = getelementptr inbounds i8* %2492, i64 -8
  %2498 = bitcast i8* %2497 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2499, label %2503

; <label>:2499                                    ; preds = %2496
  %2500 = bitcast i32* %205 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2500)
  %2501 = atomicrmw volatile add i32* %2498, i32 -1 acq_rel
  store i32 %2501, i32* %205, align 4
  %2502 = load volatile i32* %205, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2500)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i431

; <label>:2503                                    ; preds = %2496
  %2504 = load i32* %2498, align 4, !tbaa !8
  %2505 = add nsw i32 %2504, -1
  store i32 %2505, i32* %2498, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i431

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i431: ; preds = %2503, %2499
  %.0.i.i.i.i.i430 = phi i32 [ %2502, %2499 ], [ %2504, %2503 ]
  %2506 = icmp slt i32 %.0.i.i.i.i.i430, 1
  br i1 %2506, label %2507, label %.body433

; <label>:2507                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i431
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2494, %"class.std::allocator.0"* %206) #1
  br label %.body433

; <label>:2508                                    ; preds = %.noexc432
  %2509 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 2
  store i32 5, i32* %2509, align 8, !tbaa !10
  %2510 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 3
  store i32 1, i32* %2510, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %492)
          to label %2511 unwind label %4518

; <label>:2511                                    ; preds = %2508
  %2512 = getelementptr inbounds %"class.std::allocator.0"* %204, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2512)
  %2513 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 1, i32 0, i32 0
  %2514 = load i8** %2513, align 8, !tbaa !1
  %2515 = getelementptr inbounds i8* %2514, i64 -24
  %2516 = bitcast i8* %2515 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2517 = icmp eq i8* %2515, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2517, label %2530, label %2518, !prof !7

; <label>:2518                                    ; preds = %2511
  %2519 = getelementptr inbounds i8* %2514, i64 -8
  %2520 = bitcast i8* %2519 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2521, label %2525

; <label>:2521                                    ; preds = %2518
  %2522 = bitcast i32* %203 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2522)
  %2523 = atomicrmw volatile add i32* %2520, i32 -1 acq_rel
  store i32 %2523, i32* %203, align 4
  %2524 = load volatile i32* %203, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2522)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i437

; <label>:2525                                    ; preds = %2518
  %2526 = load i32* %2520, align 4, !tbaa !8
  %2527 = add nsw i32 %2526, -1
  store i32 %2527, i32* %2520, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i437

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i437: ; preds = %2525, %2521
  %.0.i.i.i.i.i436 = phi i32 [ %2524, %2521 ], [ %2526, %2525 ]
  %2528 = icmp slt i32 %.0.i.i.i.i.i436, 1
  br i1 %2528, label %2529, label %2530

; <label>:2529                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i437
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2516, %"class.std::allocator.0"* %204) #1
  br label %2530

; <label>:2530                                    ; preds = %2529, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i437, %2511
  call void @llvm.lifetime.end(i64 1, i8* %2512)
  %2531 = getelementptr inbounds %"class.std::allocator.0"* %202, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2531)
  %2532 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 0, i32 0, i32 0
  %2533 = load i8** %2532, align 8, !tbaa !1
  %2534 = getelementptr inbounds i8* %2533, i64 -24
  %2535 = bitcast i8* %2534 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2536 = icmp eq i8* %2534, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2536, label %2549, label %2537, !prof !7

; <label>:2537                                    ; preds = %2530
  %2538 = getelementptr inbounds i8* %2533, i64 -8
  %2539 = bitcast i8* %2538 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2540, label %2544

; <label>:2540                                    ; preds = %2537
  %2541 = bitcast i32* %201 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2541)
  %2542 = atomicrmw volatile add i32* %2539, i32 -1 acq_rel
  store i32 %2542, i32* %201, align 4
  %2543 = load volatile i32* %201, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2541)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i439

; <label>:2544                                    ; preds = %2537
  %2545 = load i32* %2539, align 4, !tbaa !8
  %2546 = add nsw i32 %2545, -1
  store i32 %2546, i32* %2539, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i439

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i439: ; preds = %2544, %2540
  %.0.i.i.i.i1.i438 = phi i32 [ %2543, %2540 ], [ %2545, %2544 ]
  %2547 = icmp slt i32 %.0.i.i.i.i1.i438, 1
  br i1 %2547, label %2548, label %2549

; <label>:2548                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i439
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2535, %"class.std::allocator.0"* %202) #1
  br label %2549

; <label>:2549                                    ; preds = %2548, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i439, %2530
  call void @llvm.lifetime.end(i64 1, i8* %2531)
  %2550 = getelementptr inbounds %"class.std::allocator.0"* %200, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2550)
  %2551 = getelementptr inbounds %"class.std::basic_string"* %495, i64 0, i32 0, i32 0
  %2552 = load i8** %2551, align 8, !tbaa !1
  %2553 = getelementptr inbounds i8* %2552, i64 -24
  %2554 = bitcast i8* %2553 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2555 = icmp eq i8* %2553, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2555, label %2568, label %2556, !prof !7

; <label>:2556                                    ; preds = %2549
  %2557 = getelementptr inbounds i8* %2552, i64 -8
  %2558 = bitcast i8* %2557 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2559, label %2563

; <label>:2559                                    ; preds = %2556
  %2560 = bitcast i32* %199 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2560)
  %2561 = atomicrmw volatile add i32* %2558, i32 -1 acq_rel
  store i32 %2561, i32* %199, align 4
  %2562 = load volatile i32* %199, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2560)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i442

; <label>:2563                                    ; preds = %2556
  %2564 = load i32* %2558, align 4, !tbaa !8
  %2565 = add nsw i32 %2564, -1
  store i32 %2565, i32* %2558, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i442

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i442: ; preds = %2563, %2559
  %.0.i.i.i.i441 = phi i32 [ %2562, %2559 ], [ %2564, %2563 ]
  %2566 = icmp slt i32 %.0.i.i.i.i441, 1
  br i1 %2566, label %2567, label %2568

; <label>:2567                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i442
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2554, %"class.std::allocator.0"* %200) #1
  br label %2568

; <label>:2568                                    ; preds = %2567, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i442, %2549
  call void @llvm.lifetime.end(i64 1, i8* %2550)
  %2569 = getelementptr inbounds %"class.std::allocator.0"* %198, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2569)
  %2570 = getelementptr inbounds %"class.std::basic_string"* %493, i64 0, i32 0, i32 0
  %2571 = load i8** %2570, align 8, !tbaa !1
  %2572 = getelementptr inbounds i8* %2571, i64 -24
  %2573 = bitcast i8* %2572 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2574 = icmp eq i8* %2572, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2574, label %2587, label %2575, !prof !7

; <label>:2575                                    ; preds = %2568
  %2576 = getelementptr inbounds i8* %2571, i64 -8
  %2577 = bitcast i8* %2576 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2578, label %2582

; <label>:2578                                    ; preds = %2575
  %2579 = bitcast i32* %197 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2579)
  %2580 = atomicrmw volatile add i32* %2577, i32 -1 acq_rel
  store i32 %2580, i32* %197, align 4
  %2581 = load volatile i32* %197, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2579)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i445

; <label>:2582                                    ; preds = %2575
  %2583 = load i32* %2577, align 4, !tbaa !8
  %2584 = add nsw i32 %2583, -1
  store i32 %2584, i32* %2577, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i445

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i445: ; preds = %2582, %2578
  %.0.i.i.i.i444 = phi i32 [ %2581, %2578 ], [ %2583, %2582 ]
  %2585 = icmp slt i32 %.0.i.i.i.i444, 1
  br i1 %2585, label %2586, label %2587

; <label>:2586                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i445
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2573, %"class.std::allocator.0"* %198) #1
  br label %2587

; <label>:2587                                    ; preds = %2586, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i445, %2568
  call void @llvm.lifetime.end(i64 1, i8* %2569)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %498, i8* getelementptr inbounds ([11 x i8]* @.str20, i64 0, i64 0), %"class.std::allocator.0"* %499)
          to label %2588 unwind label %4595

; <label>:2588                                    ; preds = %2587
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %500, i8* getelementptr inbounds ([13 x i8]* @.str17, i64 0, i64 0), %"class.std::allocator.0"* %501)
          to label %2589 unwind label %4599

; <label>:2589                                    ; preds = %2588
  %2590 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2590, %"class.std::basic_string"* %498)
          to label %.noexc449 unwind label %4603

.noexc449:                                        ; preds = %2589
  %2591 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2591, %"class.std::basic_string"* %500)
          to label %2612 unwind label %2592

; <label>:2592                                    ; preds = %.noexc449
  %2593 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2594 = getelementptr inbounds %"class.std::allocator.0"* %196, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2594)
  %2595 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 0, i32 0, i32 0
  %2596 = load i8** %2595, align 8, !tbaa !1
  %2597 = getelementptr inbounds i8* %2596, i64 -24
  %2598 = bitcast i8* %2597 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2599 = icmp eq i8* %2597, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2599, label %.body450, label %2600, !prof !7

; <label>:2600                                    ; preds = %2592
  %2601 = getelementptr inbounds i8* %2596, i64 -8
  %2602 = bitcast i8* %2601 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2603, label %2607

; <label>:2603                                    ; preds = %2600
  %2604 = bitcast i32* %195 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2604)
  %2605 = atomicrmw volatile add i32* %2602, i32 -1 acq_rel
  store i32 %2605, i32* %195, align 4
  %2606 = load volatile i32* %195, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2604)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i448

; <label>:2607                                    ; preds = %2600
  %2608 = load i32* %2602, align 4, !tbaa !8
  %2609 = add nsw i32 %2608, -1
  store i32 %2609, i32* %2602, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i448

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i448: ; preds = %2607, %2603
  %.0.i.i.i.i.i447 = phi i32 [ %2606, %2603 ], [ %2608, %2607 ]
  %2610 = icmp slt i32 %.0.i.i.i.i.i447, 1
  br i1 %2610, label %2611, label %.body450

; <label>:2611                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i448
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2598, %"class.std::allocator.0"* %196) #1
  br label %.body450

; <label>:2612                                    ; preds = %.noexc449
  %2613 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 2
  store i32 5, i32* %2613, align 8, !tbaa !10
  %2614 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 3
  store i32 0, i32* %2614, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %497)
          to label %2615 unwind label %4607

; <label>:2615                                    ; preds = %2612
  %2616 = getelementptr inbounds %"class.std::allocator.0"* %194, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2616)
  %2617 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 1, i32 0, i32 0
  %2618 = load i8** %2617, align 8, !tbaa !1
  %2619 = getelementptr inbounds i8* %2618, i64 -24
  %2620 = bitcast i8* %2619 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2621 = icmp eq i8* %2619, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2621, label %2634, label %2622, !prof !7

; <label>:2622                                    ; preds = %2615
  %2623 = getelementptr inbounds i8* %2618, i64 -8
  %2624 = bitcast i8* %2623 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2625, label %2629

; <label>:2625                                    ; preds = %2622
  %2626 = bitcast i32* %193 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2626)
  %2627 = atomicrmw volatile add i32* %2624, i32 -1 acq_rel
  store i32 %2627, i32* %193, align 4
  %2628 = load volatile i32* %193, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2626)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i454

; <label>:2629                                    ; preds = %2622
  %2630 = load i32* %2624, align 4, !tbaa !8
  %2631 = add nsw i32 %2630, -1
  store i32 %2631, i32* %2624, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i454

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i454: ; preds = %2629, %2625
  %.0.i.i.i.i.i453 = phi i32 [ %2628, %2625 ], [ %2630, %2629 ]
  %2632 = icmp slt i32 %.0.i.i.i.i.i453, 1
  br i1 %2632, label %2633, label %2634

; <label>:2633                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i454
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2620, %"class.std::allocator.0"* %194) #1
  br label %2634

; <label>:2634                                    ; preds = %2633, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i454, %2615
  call void @llvm.lifetime.end(i64 1, i8* %2616)
  %2635 = getelementptr inbounds %"class.std::allocator.0"* %192, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2635)
  %2636 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 0, i32 0, i32 0
  %2637 = load i8** %2636, align 8, !tbaa !1
  %2638 = getelementptr inbounds i8* %2637, i64 -24
  %2639 = bitcast i8* %2638 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2640 = icmp eq i8* %2638, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2640, label %2653, label %2641, !prof !7

; <label>:2641                                    ; preds = %2634
  %2642 = getelementptr inbounds i8* %2637, i64 -8
  %2643 = bitcast i8* %2642 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2644, label %2648

; <label>:2644                                    ; preds = %2641
  %2645 = bitcast i32* %191 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2645)
  %2646 = atomicrmw volatile add i32* %2643, i32 -1 acq_rel
  store i32 %2646, i32* %191, align 4
  %2647 = load volatile i32* %191, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2645)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i456

; <label>:2648                                    ; preds = %2641
  %2649 = load i32* %2643, align 4, !tbaa !8
  %2650 = add nsw i32 %2649, -1
  store i32 %2650, i32* %2643, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i456

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i456: ; preds = %2648, %2644
  %.0.i.i.i.i1.i455 = phi i32 [ %2647, %2644 ], [ %2649, %2648 ]
  %2651 = icmp slt i32 %.0.i.i.i.i1.i455, 1
  br i1 %2651, label %2652, label %2653

; <label>:2652                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i456
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2639, %"class.std::allocator.0"* %192) #1
  br label %2653

; <label>:2653                                    ; preds = %2652, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i456, %2634
  call void @llvm.lifetime.end(i64 1, i8* %2635)
  %2654 = getelementptr inbounds %"class.std::allocator.0"* %190, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2654)
  %2655 = getelementptr inbounds %"class.std::basic_string"* %500, i64 0, i32 0, i32 0
  %2656 = load i8** %2655, align 8, !tbaa !1
  %2657 = getelementptr inbounds i8* %2656, i64 -24
  %2658 = bitcast i8* %2657 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2659 = icmp eq i8* %2657, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2659, label %2672, label %2660, !prof !7

; <label>:2660                                    ; preds = %2653
  %2661 = getelementptr inbounds i8* %2656, i64 -8
  %2662 = bitcast i8* %2661 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2663, label %2667

; <label>:2663                                    ; preds = %2660
  %2664 = bitcast i32* %189 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2664)
  %2665 = atomicrmw volatile add i32* %2662, i32 -1 acq_rel
  store i32 %2665, i32* %189, align 4
  %2666 = load volatile i32* %189, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2664)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i459

; <label>:2667                                    ; preds = %2660
  %2668 = load i32* %2662, align 4, !tbaa !8
  %2669 = add nsw i32 %2668, -1
  store i32 %2669, i32* %2662, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i459

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i459: ; preds = %2667, %2663
  %.0.i.i.i.i458 = phi i32 [ %2666, %2663 ], [ %2668, %2667 ]
  %2670 = icmp slt i32 %.0.i.i.i.i458, 1
  br i1 %2670, label %2671, label %2672

; <label>:2671                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i459
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2658, %"class.std::allocator.0"* %190) #1
  br label %2672

; <label>:2672                                    ; preds = %2671, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i459, %2653
  call void @llvm.lifetime.end(i64 1, i8* %2654)
  %2673 = getelementptr inbounds %"class.std::allocator.0"* %188, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2673)
  %2674 = getelementptr inbounds %"class.std::basic_string"* %498, i64 0, i32 0, i32 0
  %2675 = load i8** %2674, align 8, !tbaa !1
  %2676 = getelementptr inbounds i8* %2675, i64 -24
  %2677 = bitcast i8* %2676 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2678 = icmp eq i8* %2676, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2678, label %2691, label %2679, !prof !7

; <label>:2679                                    ; preds = %2672
  %2680 = getelementptr inbounds i8* %2675, i64 -8
  %2681 = bitcast i8* %2680 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2682, label %2686

; <label>:2682                                    ; preds = %2679
  %2683 = bitcast i32* %187 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2683)
  %2684 = atomicrmw volatile add i32* %2681, i32 -1 acq_rel
  store i32 %2684, i32* %187, align 4
  %2685 = load volatile i32* %187, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2683)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i462

; <label>:2686                                    ; preds = %2679
  %2687 = load i32* %2681, align 4, !tbaa !8
  %2688 = add nsw i32 %2687, -1
  store i32 %2688, i32* %2681, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i462

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i462: ; preds = %2686, %2682
  %.0.i.i.i.i461 = phi i32 [ %2685, %2682 ], [ %2687, %2686 ]
  %2689 = icmp slt i32 %.0.i.i.i.i461, 1
  br i1 %2689, label %2690, label %2691

; <label>:2690                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i462
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2677, %"class.std::allocator.0"* %188) #1
  br label %2691

; <label>:2691                                    ; preds = %2690, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i462, %2672
  call void @llvm.lifetime.end(i64 1, i8* %2673)
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %503, i8* getelementptr inbounds ([7 x i8]* @.str21, i64 0, i64 0), %"class.std::allocator.0"* %504)
          to label %2692 unwind label %4684

; <label>:2692                                    ; preds = %2691
  invoke void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"* %505, i8* getelementptr inbounds ([7 x i8]* @.str22, i64 0, i64 0), %"class.std::allocator.0"* %506)
          to label %2693 unwind label %4688

; <label>:2693                                    ; preds = %2692
  %2694 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2694, %"class.std::basic_string"* %503)
          to label %.noexc473 unwind label %4692

.noexc473:                                        ; preds = %2693
  %2695 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %2695, %"class.std::basic_string"* %505)
          to label %2716 unwind label %2696

; <label>:2696                                    ; preds = %.noexc473
  %2697 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2698 = getelementptr inbounds %"class.std::allocator.0"* %186, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2698)
  %2699 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 0, i32 0, i32 0
  %2700 = load i8** %2699, align 8, !tbaa !1
  %2701 = getelementptr inbounds i8* %2700, i64 -24
  %2702 = bitcast i8* %2701 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2703 = icmp eq i8* %2701, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2703, label %.body474, label %2704, !prof !7

; <label>:2704                                    ; preds = %2696
  %2705 = getelementptr inbounds i8* %2700, i64 -8
  %2706 = bitcast i8* %2705 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2707, label %2711

; <label>:2707                                    ; preds = %2704
  %2708 = bitcast i32* %185 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2708)
  %2709 = atomicrmw volatile add i32* %2706, i32 -1 acq_rel
  store i32 %2709, i32* %185, align 4
  %2710 = load volatile i32* %185, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2708)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i472

; <label>:2711                                    ; preds = %2704
  %2712 = load i32* %2706, align 4, !tbaa !8
  %2713 = add nsw i32 %2712, -1
  store i32 %2713, i32* %2706, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i472

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i472: ; preds = %2711, %2707
  %.0.i.i.i.i.i471 = phi i32 [ %2710, %2707 ], [ %2712, %2711 ]
  %2714 = icmp slt i32 %.0.i.i.i.i.i471, 1
  br i1 %2714, label %2715, label %.body474

; <label>:2715                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i472
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2702, %"class.std::allocator.0"* %186) #1
  br label %.body474

; <label>:2716                                    ; preds = %.noexc473
  %2717 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 2
  store i32 0, i32* %2717, align 8, !tbaa !10
  %2718 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 3
  store i32 1, i32* %2718, align 4, !tbaa !12
  invoke void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* %testCases, %class.TestCase* %502)
          to label %2719 unwind label %4696

; <label>:2719                                    ; preds = %2716
  %2720 = getelementptr inbounds %"class.std::allocator.0"* %184, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2720)
  %2721 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 1, i32 0, i32 0
  %2722 = load i8** %2721, align 8, !tbaa !1
  %2723 = getelementptr inbounds i8* %2722, i64 -24
  %2724 = bitcast i8* %2723 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2725 = icmp eq i8* %2723, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2725, label %2738, label %2726, !prof !7

; <label>:2726                                    ; preds = %2719
  %2727 = getelementptr inbounds i8* %2722, i64 -8
  %2728 = bitcast i8* %2727 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2729, label %2733

; <label>:2729                                    ; preds = %2726
  %2730 = bitcast i32* %183 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2730)
  %2731 = atomicrmw volatile add i32* %2728, i32 -1 acq_rel
  store i32 %2731, i32* %183, align 4
  %2732 = load volatile i32* %183, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2730)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i478

; <label>:2733                                    ; preds = %2726
  %2734 = load i32* %2728, align 4, !tbaa !8
  %2735 = add nsw i32 %2734, -1
  store i32 %2735, i32* %2728, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i478

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i478: ; preds = %2733, %2729
  %.0.i.i.i.i.i477 = phi i32 [ %2732, %2729 ], [ %2734, %2733 ]
  %2736 = icmp slt i32 %.0.i.i.i.i.i477, 1
  br i1 %2736, label %2737, label %2738

; <label>:2737                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i478
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2724, %"class.std::allocator.0"* %184) #1
  br label %2738

; <label>:2738                                    ; preds = %2737, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i478, %2719
  call void @llvm.lifetime.end(i64 1, i8* %2720)
  %2739 = getelementptr inbounds %"class.std::allocator.0"* %182, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2739)
  %2740 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 0, i32 0, i32 0
  %2741 = load i8** %2740, align 8, !tbaa !1
  %2742 = getelementptr inbounds i8* %2741, i64 -24
  %2743 = bitcast i8* %2742 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2744 = icmp eq i8* %2742, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2744, label %2757, label %2745, !prof !7

; <label>:2745                                    ; preds = %2738
  %2746 = getelementptr inbounds i8* %2741, i64 -8
  %2747 = bitcast i8* %2746 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2748, label %2752

; <label>:2748                                    ; preds = %2745
  %2749 = bitcast i32* %181 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2749)
  %2750 = atomicrmw volatile add i32* %2747, i32 -1 acq_rel
  store i32 %2750, i32* %181, align 4
  %2751 = load volatile i32* %181, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2749)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i480

; <label>:2752                                    ; preds = %2745
  %2753 = load i32* %2747, align 4, !tbaa !8
  %2754 = add nsw i32 %2753, -1
  store i32 %2754, i32* %2747, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i480

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i480: ; preds = %2752, %2748
  %.0.i.i.i.i1.i479 = phi i32 [ %2751, %2748 ], [ %2753, %2752 ]
  %2755 = icmp slt i32 %.0.i.i.i.i1.i479, 1
  br i1 %2755, label %2756, label %2757

; <label>:2756                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i480
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2743, %"class.std::allocator.0"* %182) #1
  br label %2757

; <label>:2757                                    ; preds = %2756, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i480, %2738
  call void @llvm.lifetime.end(i64 1, i8* %2739)
  %2758 = getelementptr inbounds %"class.std::allocator.0"* %180, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2758)
  %2759 = getelementptr inbounds %"class.std::basic_string"* %505, i64 0, i32 0, i32 0
  %2760 = load i8** %2759, align 8, !tbaa !1
  %2761 = getelementptr inbounds i8* %2760, i64 -24
  %2762 = bitcast i8* %2761 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2763 = icmp eq i8* %2761, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2763, label %2776, label %2764, !prof !7

; <label>:2764                                    ; preds = %2757
  %2765 = getelementptr inbounds i8* %2760, i64 -8
  %2766 = bitcast i8* %2765 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2767, label %2771

; <label>:2767                                    ; preds = %2764
  %2768 = bitcast i32* %179 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2768)
  %2769 = atomicrmw volatile add i32* %2766, i32 -1 acq_rel
  store i32 %2769, i32* %179, align 4
  %2770 = load volatile i32* %179, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2768)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i483

; <label>:2771                                    ; preds = %2764
  %2772 = load i32* %2766, align 4, !tbaa !8
  %2773 = add nsw i32 %2772, -1
  store i32 %2773, i32* %2766, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i483

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i483: ; preds = %2771, %2767
  %.0.i.i.i.i482 = phi i32 [ %2770, %2767 ], [ %2772, %2771 ]
  %2774 = icmp slt i32 %.0.i.i.i.i482, 1
  br i1 %2774, label %2775, label %2776

; <label>:2775                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i483
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2762, %"class.std::allocator.0"* %180) #1
  br label %2776

; <label>:2776                                    ; preds = %2775, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i483, %2757
  call void @llvm.lifetime.end(i64 1, i8* %2758)
  %2777 = getelementptr inbounds %"class.std::allocator.0"* %178, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2777)
  %2778 = getelementptr inbounds %"class.std::basic_string"* %503, i64 0, i32 0, i32 0
  %2779 = load i8** %2778, align 8, !tbaa !1
  %2780 = getelementptr inbounds i8* %2779, i64 -24
  %2781 = bitcast i8* %2780 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2782 = icmp eq i8* %2780, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2782, label %2795, label %2783, !prof !7

; <label>:2783                                    ; preds = %2776
  %2784 = getelementptr inbounds i8* %2779, i64 -8
  %2785 = bitcast i8* %2784 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2786, label %2790

; <label>:2786                                    ; preds = %2783
  %2787 = bitcast i32* %177 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2787)
  %2788 = atomicrmw volatile add i32* %2785, i32 -1 acq_rel
  store i32 %2788, i32* %177, align 4
  %2789 = load volatile i32* %177, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2787)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i486

; <label>:2790                                    ; preds = %2783
  %2791 = load i32* %2785, align 4, !tbaa !8
  %2792 = add nsw i32 %2791, -1
  store i32 %2792, i32* %2785, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i486

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i486: ; preds = %2790, %2786
  %.0.i.i.i.i485 = phi i32 [ %2789, %2786 ], [ %2791, %2790 ]
  %2793 = icmp slt i32 %.0.i.i.i.i485, 1
  br i1 %2793, label %2794, label %2795

; <label>:2794                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i486
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2781, %"class.std::allocator.0"* %178) #1
  br label %2795

; <label>:2795                                    ; preds = %2794, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i486, %2776
  call void @llvm.lifetime.end(i64 1, i8* %2777)
  %2796 = getelementptr inbounds %"class.std::vector"* %testCases, i64 0, i32 0, i32 0, i32 0
  %2797 = load %class.TestCase** %2796, align 8, !tbaa !13
  %2798 = getelementptr inbounds %"class.std::vector"* %testCases, i64 0, i32 0, i32 0, i32 1
  %2799 = load %class.TestCase** %2798, align 8, !tbaa !13
  %2800 = icmp eq %class.TestCase* %2797, %2799
  br i1 %2800, label %._crit_edge.thread, label %.lr.ph

.lr.ph:                                           ; preds = %_ZNSolsEPFRSoS_E.exit423, %2795
  %pass.0756 = phi i8 [ %pass.1, %_ZNSolsEPFRSoS_E.exit423 ], [ 1, %2795 ]
  %2801 = phi %class.TestCase* [ %4826, %_ZNSolsEPFRSoS_E.exit423 ], [ %2797, %2795 ]
  %2802 = getelementptr inbounds %class.TestCase* %2801, i64 0, i32 0, i32 0, i32 0
  %2803 = load i8** %2802, align 8, !tbaa !1
  %2804 = getelementptr inbounds %class.TestCase* %2801, i64 0, i32 1, i32 0, i32 0
  %2805 = load i8** %2804, align 8, !tbaa !1
  %2806 = getelementptr inbounds %class.TestCase* %2801, i64 0, i32 2
  %2807 = load i32* %2806, align 4, !tbaa !10
  %2808 = invoke i32 @fnmatch(i8* %2803, i8* %2805, i32 %2807)
          to label %2809 unwind label %.loopexit

; <label>:2809                                    ; preds = %.lr.ph
  %2810 = getelementptr inbounds %class.TestCase* %2801, i64 0, i32 3
  %2811 = load i32* %2810, align 4, !tbaa !12
  %2812 = icmp eq i32 %2808, %2811
  br i1 %2812, label %2813, label %4776

; <label>:2813                                    ; preds = %2809
  %2814 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([7 x i8]* @.str23, i64 0, i64 0), i64 6)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit498 unwind label %.loopexit

; <label>:2815                                    ; preds = %0
  %2816 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2817 = extractvalue { i8*, i32 } %2816, 0
  %2818 = extractvalue { i8*, i32 } %2816, 1
  br label %_ZNSsD1Ev.exit509

; <label>:2819                                    ; preds = %508
  %2820 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2821 = extractvalue { i8*, i32 } %2820, 0
  %2822 = extractvalue { i8*, i32 } %2820, 1
  br label %_ZNSsD1Ev.exit506

; <label>:2823                                    ; preds = %509
  %2824 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body76

.body76:                                          ; preds = %2823, %531, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %512
  %eh.lpad-body77 = phi { i8*, i32 } [ %2824, %2823 ], [ %513, %531 ], [ %513, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i ], [ %513, %512 ]
  %2825 = extractvalue { i8*, i32 } %eh.lpad-body77, 0
  %2826 = extractvalue { i8*, i32 } %eh.lpad-body77, 1
  br label %_ZN8TestCaseD2Ev.exit503

; <label>:2827                                    ; preds = %532
  %2828 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2829 = extractvalue { i8*, i32 } %2828, 0
  %2830 = extractvalue { i8*, i32 } %2828, 1
  %2831 = getelementptr inbounds %"class.std::allocator.0"* %176, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2831)
  %2832 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 1, i32 0, i32 0
  %2833 = load i8** %2832, align 8, !tbaa !1
  %2834 = getelementptr inbounds i8* %2833, i64 -24
  %2835 = bitcast i8* %2834 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2836 = icmp eq i8* %2834, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2836, label %2849, label %2837, !prof !7

; <label>:2837                                    ; preds = %2827
  %2838 = getelementptr inbounds i8* %2833, i64 -8
  %2839 = bitcast i8* %2838 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2840, label %2844

; <label>:2840                                    ; preds = %2837
  %2841 = bitcast i32* %175 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2841)
  %2842 = atomicrmw volatile add i32* %2839, i32 -1 acq_rel
  store i32 %2842, i32* %175, align 4
  %2843 = load volatile i32* %175, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2841)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i500

; <label>:2844                                    ; preds = %2837
  %2845 = load i32* %2839, align 4, !tbaa !8
  %2846 = add nsw i32 %2845, -1
  store i32 %2846, i32* %2839, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i500

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i500: ; preds = %2844, %2840
  %.0.i.i.i.i.i499 = phi i32 [ %2843, %2840 ], [ %2845, %2844 ]
  %2847 = icmp slt i32 %.0.i.i.i.i.i499, 1
  br i1 %2847, label %2848, label %2849

; <label>:2848                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i500
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2835, %"class.std::allocator.0"* %176) #1
  br label %2849

; <label>:2849                                    ; preds = %2848, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i500, %2827
  call void @llvm.lifetime.end(i64 1, i8* %2831)
  %2850 = getelementptr inbounds %"class.std::allocator.0"* %174, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2850)
  %2851 = getelementptr inbounds %class.TestCase* %397, i64 0, i32 0, i32 0, i32 0
  %2852 = load i8** %2851, align 8, !tbaa !1
  %2853 = getelementptr inbounds i8* %2852, i64 -24
  %2854 = bitcast i8* %2853 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2855 = icmp eq i8* %2853, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2855, label %_ZN8TestCaseD2Ev.exit503, label %2856, !prof !7

; <label>:2856                                    ; preds = %2849
  %2857 = getelementptr inbounds i8* %2852, i64 -8
  %2858 = bitcast i8* %2857 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2859, label %2863

; <label>:2859                                    ; preds = %2856
  %2860 = bitcast i32* %173 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2860)
  %2861 = atomicrmw volatile add i32* %2858, i32 -1 acq_rel
  store i32 %2861, i32* %173, align 4
  %2862 = load volatile i32* %173, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2860)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502

; <label>:2863                                    ; preds = %2856
  %2864 = load i32* %2858, align 4, !tbaa !8
  %2865 = add nsw i32 %2864, -1
  store i32 %2865, i32* %2858, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502: ; preds = %2863, %2859
  %.0.i.i.i.i1.i501 = phi i32 [ %2862, %2859 ], [ %2864, %2863 ]
  %2866 = icmp slt i32 %.0.i.i.i.i1.i501, 1
  br i1 %2866, label %2867, label %_ZN8TestCaseD2Ev.exit503

; <label>:2867                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2854, %"class.std::allocator.0"* %174) #1
  br label %_ZN8TestCaseD2Ev.exit503

_ZN8TestCaseD2Ev.exit503:                         ; preds = %2867, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502, %2849, %.body76
  %.02 = phi i8* [ %2825, %.body76 ], [ %2829, %2849 ], [ %2829, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502 ], [ %2829, %2867 ]
  %.01 = phi i32 [ %2826, %.body76 ], [ %2830, %2849 ], [ %2830, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i502 ], [ %2830, %2867 ]
  %2868 = getelementptr inbounds %"class.std::allocator.0"* %172, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2868)
  %2869 = getelementptr inbounds %"class.std::basic_string"* %400, i64 0, i32 0, i32 0
  %2870 = load i8** %2869, align 8, !tbaa !1
  %2871 = getelementptr inbounds i8* %2870, i64 -24
  %2872 = bitcast i8* %2871 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2873 = icmp eq i8* %2871, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2873, label %_ZNSsD1Ev.exit506, label %2874, !prof !7

; <label>:2874                                    ; preds = %_ZN8TestCaseD2Ev.exit503
  %2875 = getelementptr inbounds i8* %2870, i64 -8
  %2876 = bitcast i8* %2875 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2877, label %2881

; <label>:2877                                    ; preds = %2874
  %2878 = bitcast i32* %171 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2878)
  %2879 = atomicrmw volatile add i32* %2876, i32 -1 acq_rel
  store i32 %2879, i32* %171, align 4
  %2880 = load volatile i32* %171, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2878)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505

; <label>:2881                                    ; preds = %2874
  %2882 = load i32* %2876, align 4, !tbaa !8
  %2883 = add nsw i32 %2882, -1
  store i32 %2883, i32* %2876, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505: ; preds = %2881, %2877
  %.0.i.i.i.i504 = phi i32 [ %2880, %2877 ], [ %2882, %2881 ]
  %2884 = icmp slt i32 %.0.i.i.i.i504, 1
  br i1 %2884, label %2885, label %_ZNSsD1Ev.exit506

; <label>:2885                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2872, %"class.std::allocator.0"* %172) #1
  br label %_ZNSsD1Ev.exit506

_ZNSsD1Ev.exit506:                                ; preds = %2885, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505, %_ZN8TestCaseD2Ev.exit503, %2819
  %.110 = phi i8* [ %2821, %2819 ], [ %.02, %_ZN8TestCaseD2Ev.exit503 ], [ %.02, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505 ], [ %.02, %2885 ]
  %.1 = phi i32 [ %2822, %2819 ], [ %.01, %_ZN8TestCaseD2Ev.exit503 ], [ %.01, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i505 ], [ %.01, %2885 ]
  %2886 = getelementptr inbounds %"class.std::allocator.0"* %170, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2886)
  %2887 = getelementptr inbounds %"class.std::basic_string"* %398, i64 0, i32 0, i32 0
  %2888 = load i8** %2887, align 8, !tbaa !1
  %2889 = getelementptr inbounds i8* %2888, i64 -24
  %2890 = bitcast i8* %2889 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2891 = icmp eq i8* %2889, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2891, label %_ZNSsD1Ev.exit509, label %2892, !prof !7

; <label>:2892                                    ; preds = %_ZNSsD1Ev.exit506
  %2893 = getelementptr inbounds i8* %2888, i64 -8
  %2894 = bitcast i8* %2893 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2895, label %2899

; <label>:2895                                    ; preds = %2892
  %2896 = bitcast i32* %169 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2896)
  %2897 = atomicrmw volatile add i32* %2894, i32 -1 acq_rel
  store i32 %2897, i32* %169, align 4
  %2898 = load volatile i32* %169, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2896)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508

; <label>:2899                                    ; preds = %2892
  %2900 = load i32* %2894, align 4, !tbaa !8
  %2901 = add nsw i32 %2900, -1
  store i32 %2901, i32* %2894, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508: ; preds = %2899, %2895
  %.0.i.i.i.i507 = phi i32 [ %2898, %2895 ], [ %2900, %2899 ]
  %2902 = icmp slt i32 %.0.i.i.i.i507, 1
  br i1 %2902, label %2903, label %_ZNSsD1Ev.exit509

; <label>:2903                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2890, %"class.std::allocator.0"* %170) #1
  br label %_ZNSsD1Ev.exit509

; <label>:2904                                    ; preds = %611
  %2905 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2906 = extractvalue { i8*, i32 } %2905, 0
  %2907 = extractvalue { i8*, i32 } %2905, 1
  br label %_ZNSsD1Ev.exit509

; <label>:2908                                    ; preds = %612
  %2909 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2910 = extractvalue { i8*, i32 } %2909, 0
  %2911 = extractvalue { i8*, i32 } %2909, 1
  br label %_ZNSsD1Ev.exit517

; <label>:2912                                    ; preds = %613
  %2913 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body86

.body86:                                          ; preds = %2912, %635, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i84, %616
  %eh.lpad-body87 = phi { i8*, i32 } [ %2913, %2912 ], [ %617, %635 ], [ %617, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i84 ], [ %617, %616 ]
  %2914 = extractvalue { i8*, i32 } %eh.lpad-body87, 0
  %2915 = extractvalue { i8*, i32 } %eh.lpad-body87, 1
  br label %_ZN8TestCaseD2Ev.exit514

; <label>:2916                                    ; preds = %636
  %2917 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2918 = extractvalue { i8*, i32 } %2917, 0
  %2919 = extractvalue { i8*, i32 } %2917, 1
  %2920 = getelementptr inbounds %"class.std::allocator.0"* %168, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2920)
  %2921 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 1, i32 0, i32 0
  %2922 = load i8** %2921, align 8, !tbaa !1
  %2923 = getelementptr inbounds i8* %2922, i64 -24
  %2924 = bitcast i8* %2923 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2925 = icmp eq i8* %2923, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2925, label %2938, label %2926, !prof !7

; <label>:2926                                    ; preds = %2916
  %2927 = getelementptr inbounds i8* %2922, i64 -8
  %2928 = bitcast i8* %2927 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2929, label %2933

; <label>:2929                                    ; preds = %2926
  %2930 = bitcast i32* %167 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2930)
  %2931 = atomicrmw volatile add i32* %2928, i32 -1 acq_rel
  store i32 %2931, i32* %167, align 4
  %2932 = load volatile i32* %167, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2930)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i511

; <label>:2933                                    ; preds = %2926
  %2934 = load i32* %2928, align 4, !tbaa !8
  %2935 = add nsw i32 %2934, -1
  store i32 %2935, i32* %2928, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i511

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i511: ; preds = %2933, %2929
  %.0.i.i.i.i.i510 = phi i32 [ %2932, %2929 ], [ %2934, %2933 ]
  %2936 = icmp slt i32 %.0.i.i.i.i.i510, 1
  br i1 %2936, label %2937, label %2938

; <label>:2937                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i511
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2924, %"class.std::allocator.0"* %168) #1
  br label %2938

; <label>:2938                                    ; preds = %2937, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i511, %2916
  call void @llvm.lifetime.end(i64 1, i8* %2920)
  %2939 = getelementptr inbounds %"class.std::allocator.0"* %166, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2939)
  %2940 = getelementptr inbounds %class.TestCase* %402, i64 0, i32 0, i32 0, i32 0
  %2941 = load i8** %2940, align 8, !tbaa !1
  %2942 = getelementptr inbounds i8* %2941, i64 -24
  %2943 = bitcast i8* %2942 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2944 = icmp eq i8* %2942, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2944, label %_ZN8TestCaseD2Ev.exit514, label %2945, !prof !7

; <label>:2945                                    ; preds = %2938
  %2946 = getelementptr inbounds i8* %2941, i64 -8
  %2947 = bitcast i8* %2946 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2948, label %2952

; <label>:2948                                    ; preds = %2945
  %2949 = bitcast i32* %165 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2949)
  %2950 = atomicrmw volatile add i32* %2947, i32 -1 acq_rel
  store i32 %2950, i32* %165, align 4
  %2951 = load volatile i32* %165, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2949)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513

; <label>:2952                                    ; preds = %2945
  %2953 = load i32* %2947, align 4, !tbaa !8
  %2954 = add nsw i32 %2953, -1
  store i32 %2954, i32* %2947, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513: ; preds = %2952, %2948
  %.0.i.i.i.i1.i512 = phi i32 [ %2951, %2948 ], [ %2953, %2952 ]
  %2955 = icmp slt i32 %.0.i.i.i.i1.i512, 1
  br i1 %2955, label %2956, label %_ZN8TestCaseD2Ev.exit514

; <label>:2956                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2943, %"class.std::allocator.0"* %166) #1
  br label %_ZN8TestCaseD2Ev.exit514

_ZN8TestCaseD2Ev.exit514:                         ; preds = %2956, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513, %2938, %.body86
  %.312 = phi i8* [ %2914, %.body86 ], [ %2918, %2938 ], [ %2918, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513 ], [ %2918, %2956 ]
  %.3 = phi i32 [ %2915, %.body86 ], [ %2919, %2938 ], [ %2919, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i513 ], [ %2919, %2956 ]
  %2957 = getelementptr inbounds %"class.std::allocator.0"* %164, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2957)
  %2958 = getelementptr inbounds %"class.std::basic_string"* %405, i64 0, i32 0, i32 0
  %2959 = load i8** %2958, align 8, !tbaa !1
  %2960 = getelementptr inbounds i8* %2959, i64 -24
  %2961 = bitcast i8* %2960 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2962 = icmp eq i8* %2960, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2962, label %_ZNSsD1Ev.exit517, label %2963, !prof !7

; <label>:2963                                    ; preds = %_ZN8TestCaseD2Ev.exit514
  %2964 = getelementptr inbounds i8* %2959, i64 -8
  %2965 = bitcast i8* %2964 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2966, label %2970

; <label>:2966                                    ; preds = %2963
  %2967 = bitcast i32* %163 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2967)
  %2968 = atomicrmw volatile add i32* %2965, i32 -1 acq_rel
  store i32 %2968, i32* %163, align 4
  %2969 = load volatile i32* %163, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2967)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516

; <label>:2970                                    ; preds = %2963
  %2971 = load i32* %2965, align 4, !tbaa !8
  %2972 = add nsw i32 %2971, -1
  store i32 %2972, i32* %2965, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516: ; preds = %2970, %2966
  %.0.i.i.i.i515 = phi i32 [ %2969, %2966 ], [ %2971, %2970 ]
  %2973 = icmp slt i32 %.0.i.i.i.i515, 1
  br i1 %2973, label %2974, label %_ZNSsD1Ev.exit517

; <label>:2974                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2961, %"class.std::allocator.0"* %164) #1
  br label %_ZNSsD1Ev.exit517

_ZNSsD1Ev.exit517:                                ; preds = %2974, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516, %_ZN8TestCaseD2Ev.exit514, %2908
  %.413 = phi i8* [ %2910, %2908 ], [ %.312, %_ZN8TestCaseD2Ev.exit514 ], [ %.312, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516 ], [ %.312, %2974 ]
  %.4 = phi i32 [ %2911, %2908 ], [ %.3, %_ZN8TestCaseD2Ev.exit514 ], [ %.3, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i516 ], [ %.3, %2974 ]
  %2975 = getelementptr inbounds %"class.std::allocator.0"* %162, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %2975)
  %2976 = getelementptr inbounds %"class.std::basic_string"* %403, i64 0, i32 0, i32 0
  %2977 = load i8** %2976, align 8, !tbaa !1
  %2978 = getelementptr inbounds i8* %2977, i64 -24
  %2979 = bitcast i8* %2978 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %2980 = icmp eq i8* %2978, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %2980, label %_ZNSsD1Ev.exit509, label %2981, !prof !7

; <label>:2981                                    ; preds = %_ZNSsD1Ev.exit517
  %2982 = getelementptr inbounds i8* %2977, i64 -8
  %2983 = bitcast i8* %2982 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %2984, label %2988

; <label>:2984                                    ; preds = %2981
  %2985 = bitcast i32* %161 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %2985)
  %2986 = atomicrmw volatile add i32* %2983, i32 -1 acq_rel
  store i32 %2986, i32* %161, align 4
  %2987 = load volatile i32* %161, align 4
  call void @llvm.lifetime.end(i64 4, i8* %2985)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519

; <label>:2988                                    ; preds = %2981
  %2989 = load i32* %2983, align 4, !tbaa !8
  %2990 = add nsw i32 %2989, -1
  store i32 %2990, i32* %2983, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519: ; preds = %2988, %2984
  %.0.i.i.i.i518 = phi i32 [ %2987, %2984 ], [ %2989, %2988 ]
  %2991 = icmp slt i32 %.0.i.i.i.i518, 1
  br i1 %2991, label %2992, label %_ZNSsD1Ev.exit509

; <label>:2992                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %2979, %"class.std::allocator.0"* %162) #1
  br label %_ZNSsD1Ev.exit509

; <label>:2993                                    ; preds = %715
  %2994 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2995 = extractvalue { i8*, i32 } %2994, 0
  %2996 = extractvalue { i8*, i32 } %2994, 1
  br label %_ZNSsD1Ev.exit509

; <label>:2997                                    ; preds = %716
  %2998 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %2999 = extractvalue { i8*, i32 } %2998, 0
  %3000 = extractvalue { i8*, i32 } %2998, 1
  br label %_ZNSsD1Ev.exit530

; <label>:3001                                    ; preds = %717
  %3002 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body106

.body106:                                         ; preds = %3001, %739, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i104, %720
  %eh.lpad-body107 = phi { i8*, i32 } [ %3002, %3001 ], [ %721, %739 ], [ %721, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i104 ], [ %721, %720 ]
  %3003 = extractvalue { i8*, i32 } %eh.lpad-body107, 0
  %3004 = extractvalue { i8*, i32 } %eh.lpad-body107, 1
  br label %_ZN8TestCaseD2Ev.exit527

; <label>:3005                                    ; preds = %740
  %3006 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3007 = extractvalue { i8*, i32 } %3006, 0
  %3008 = extractvalue { i8*, i32 } %3006, 1
  %3009 = getelementptr inbounds %"class.std::allocator.0"* %160, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3009)
  %3010 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 1, i32 0, i32 0
  %3011 = load i8** %3010, align 8, !tbaa !1
  %3012 = getelementptr inbounds i8* %3011, i64 -24
  %3013 = bitcast i8* %3012 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3014 = icmp eq i8* %3012, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3014, label %3027, label %3015, !prof !7

; <label>:3015                                    ; preds = %3005
  %3016 = getelementptr inbounds i8* %3011, i64 -8
  %3017 = bitcast i8* %3016 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3018, label %3022

; <label>:3018                                    ; preds = %3015
  %3019 = bitcast i32* %159 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3019)
  %3020 = atomicrmw volatile add i32* %3017, i32 -1 acq_rel
  store i32 %3020, i32* %159, align 4
  %3021 = load volatile i32* %159, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3019)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i524

; <label>:3022                                    ; preds = %3015
  %3023 = load i32* %3017, align 4, !tbaa !8
  %3024 = add nsw i32 %3023, -1
  store i32 %3024, i32* %3017, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i524

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i524: ; preds = %3022, %3018
  %.0.i.i.i.i.i523 = phi i32 [ %3021, %3018 ], [ %3023, %3022 ]
  %3025 = icmp slt i32 %.0.i.i.i.i.i523, 1
  br i1 %3025, label %3026, label %3027

; <label>:3026                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i524
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3013, %"class.std::allocator.0"* %160) #1
  br label %3027

; <label>:3027                                    ; preds = %3026, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i524, %3005
  call void @llvm.lifetime.end(i64 1, i8* %3009)
  %3028 = getelementptr inbounds %"class.std::allocator.0"* %158, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3028)
  %3029 = getelementptr inbounds %class.TestCase* %407, i64 0, i32 0, i32 0, i32 0
  %3030 = load i8** %3029, align 8, !tbaa !1
  %3031 = getelementptr inbounds i8* %3030, i64 -24
  %3032 = bitcast i8* %3031 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3033 = icmp eq i8* %3031, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3033, label %_ZN8TestCaseD2Ev.exit527, label %3034, !prof !7

; <label>:3034                                    ; preds = %3027
  %3035 = getelementptr inbounds i8* %3030, i64 -8
  %3036 = bitcast i8* %3035 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3037, label %3041

; <label>:3037                                    ; preds = %3034
  %3038 = bitcast i32* %157 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3038)
  %3039 = atomicrmw volatile add i32* %3036, i32 -1 acq_rel
  store i32 %3039, i32* %157, align 4
  %3040 = load volatile i32* %157, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3038)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526

; <label>:3041                                    ; preds = %3034
  %3042 = load i32* %3036, align 4, !tbaa !8
  %3043 = add nsw i32 %3042, -1
  store i32 %3043, i32* %3036, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526: ; preds = %3041, %3037
  %.0.i.i.i.i1.i525 = phi i32 [ %3040, %3037 ], [ %3042, %3041 ]
  %3044 = icmp slt i32 %.0.i.i.i.i1.i525, 1
  br i1 %3044, label %3045, label %_ZN8TestCaseD2Ev.exit527

; <label>:3045                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3032, %"class.std::allocator.0"* %158) #1
  br label %_ZN8TestCaseD2Ev.exit527

_ZN8TestCaseD2Ev.exit527:                         ; preds = %3045, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526, %3027, %.body106
  %.615 = phi i8* [ %3003, %.body106 ], [ %3007, %3027 ], [ %3007, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526 ], [ %3007, %3045 ]
  %.6 = phi i32 [ %3004, %.body106 ], [ %3008, %3027 ], [ %3008, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i526 ], [ %3008, %3045 ]
  %3046 = getelementptr inbounds %"class.std::allocator.0"* %156, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3046)
  %3047 = getelementptr inbounds %"class.std::basic_string"* %410, i64 0, i32 0, i32 0
  %3048 = load i8** %3047, align 8, !tbaa !1
  %3049 = getelementptr inbounds i8* %3048, i64 -24
  %3050 = bitcast i8* %3049 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3051 = icmp eq i8* %3049, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3051, label %_ZNSsD1Ev.exit530, label %3052, !prof !7

; <label>:3052                                    ; preds = %_ZN8TestCaseD2Ev.exit527
  %3053 = getelementptr inbounds i8* %3048, i64 -8
  %3054 = bitcast i8* %3053 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3055, label %3059

; <label>:3055                                    ; preds = %3052
  %3056 = bitcast i32* %155 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3056)
  %3057 = atomicrmw volatile add i32* %3054, i32 -1 acq_rel
  store i32 %3057, i32* %155, align 4
  %3058 = load volatile i32* %155, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3056)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529

; <label>:3059                                    ; preds = %3052
  %3060 = load i32* %3054, align 4, !tbaa !8
  %3061 = add nsw i32 %3060, -1
  store i32 %3061, i32* %3054, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529: ; preds = %3059, %3055
  %.0.i.i.i.i528 = phi i32 [ %3058, %3055 ], [ %3060, %3059 ]
  %3062 = icmp slt i32 %.0.i.i.i.i528, 1
  br i1 %3062, label %3063, label %_ZNSsD1Ev.exit530

; <label>:3063                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3050, %"class.std::allocator.0"* %156) #1
  br label %_ZNSsD1Ev.exit530

_ZNSsD1Ev.exit530:                                ; preds = %3063, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529, %_ZN8TestCaseD2Ev.exit527, %2997
  %.716 = phi i8* [ %2999, %2997 ], [ %.615, %_ZN8TestCaseD2Ev.exit527 ], [ %.615, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529 ], [ %.615, %3063 ]
  %.7 = phi i32 [ %3000, %2997 ], [ %.6, %_ZN8TestCaseD2Ev.exit527 ], [ %.6, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i529 ], [ %.6, %3063 ]
  %3064 = getelementptr inbounds %"class.std::allocator.0"* %154, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3064)
  %3065 = getelementptr inbounds %"class.std::basic_string"* %408, i64 0, i32 0, i32 0
  %3066 = load i8** %3065, align 8, !tbaa !1
  %3067 = getelementptr inbounds i8* %3066, i64 -24
  %3068 = bitcast i8* %3067 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3069 = icmp eq i8* %3067, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3069, label %_ZNSsD1Ev.exit509, label %3070, !prof !7

; <label>:3070                                    ; preds = %_ZNSsD1Ev.exit530
  %3071 = getelementptr inbounds i8* %3066, i64 -8
  %3072 = bitcast i8* %3071 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3073, label %3077

; <label>:3073                                    ; preds = %3070
  %3074 = bitcast i32* %153 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3074)
  %3075 = atomicrmw volatile add i32* %3072, i32 -1 acq_rel
  store i32 %3075, i32* %153, align 4
  %3076 = load volatile i32* %153, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3074)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532

; <label>:3077                                    ; preds = %3070
  %3078 = load i32* %3072, align 4, !tbaa !8
  %3079 = add nsw i32 %3078, -1
  store i32 %3079, i32* %3072, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532: ; preds = %3077, %3073
  %.0.i.i.i.i531 = phi i32 [ %3076, %3073 ], [ %3078, %3077 ]
  %3080 = icmp slt i32 %.0.i.i.i.i531, 1
  br i1 %3080, label %3081, label %_ZNSsD1Ev.exit509

; <label>:3081                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3068, %"class.std::allocator.0"* %154) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3082                                    ; preds = %819
  %3083 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3084 = extractvalue { i8*, i32 } %3083, 0
  %3085 = extractvalue { i8*, i32 } %3083, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3086                                    ; preds = %820
  %3087 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3088 = extractvalue { i8*, i32 } %3087, 0
  %3089 = extractvalue { i8*, i32 } %3087, 1
  br label %_ZNSsD1Ev.exit541

; <label>:3090                                    ; preds = %821
  %3091 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body123

.body123:                                         ; preds = %3090, %843, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i121, %824
  %eh.lpad-body124 = phi { i8*, i32 } [ %3091, %3090 ], [ %825, %843 ], [ %825, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i121 ], [ %825, %824 ]
  %3092 = extractvalue { i8*, i32 } %eh.lpad-body124, 0
  %3093 = extractvalue { i8*, i32 } %eh.lpad-body124, 1
  br label %_ZN8TestCaseD2Ev.exit538

; <label>:3094                                    ; preds = %844
  %3095 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3096 = extractvalue { i8*, i32 } %3095, 0
  %3097 = extractvalue { i8*, i32 } %3095, 1
  %3098 = getelementptr inbounds %"class.std::allocator.0"* %152, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3098)
  %3099 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 1, i32 0, i32 0
  %3100 = load i8** %3099, align 8, !tbaa !1
  %3101 = getelementptr inbounds i8* %3100, i64 -24
  %3102 = bitcast i8* %3101 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3103 = icmp eq i8* %3101, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3103, label %3116, label %3104, !prof !7

; <label>:3104                                    ; preds = %3094
  %3105 = getelementptr inbounds i8* %3100, i64 -8
  %3106 = bitcast i8* %3105 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3107, label %3111

; <label>:3107                                    ; preds = %3104
  %3108 = bitcast i32* %151 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3108)
  %3109 = atomicrmw volatile add i32* %3106, i32 -1 acq_rel
  store i32 %3109, i32* %151, align 4
  %3110 = load volatile i32* %151, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3108)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i535

; <label>:3111                                    ; preds = %3104
  %3112 = load i32* %3106, align 4, !tbaa !8
  %3113 = add nsw i32 %3112, -1
  store i32 %3113, i32* %3106, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i535

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i535: ; preds = %3111, %3107
  %.0.i.i.i.i.i534 = phi i32 [ %3110, %3107 ], [ %3112, %3111 ]
  %3114 = icmp slt i32 %.0.i.i.i.i.i534, 1
  br i1 %3114, label %3115, label %3116

; <label>:3115                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i535
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3102, %"class.std::allocator.0"* %152) #1
  br label %3116

; <label>:3116                                    ; preds = %3115, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i535, %3094
  call void @llvm.lifetime.end(i64 1, i8* %3098)
  %3117 = getelementptr inbounds %"class.std::allocator.0"* %150, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3117)
  %3118 = getelementptr inbounds %class.TestCase* %412, i64 0, i32 0, i32 0, i32 0
  %3119 = load i8** %3118, align 8, !tbaa !1
  %3120 = getelementptr inbounds i8* %3119, i64 -24
  %3121 = bitcast i8* %3120 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3122 = icmp eq i8* %3120, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3122, label %_ZN8TestCaseD2Ev.exit538, label %3123, !prof !7

; <label>:3123                                    ; preds = %3116
  %3124 = getelementptr inbounds i8* %3119, i64 -8
  %3125 = bitcast i8* %3124 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3126, label %3130

; <label>:3126                                    ; preds = %3123
  %3127 = bitcast i32* %149 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3127)
  %3128 = atomicrmw volatile add i32* %3125, i32 -1 acq_rel
  store i32 %3128, i32* %149, align 4
  %3129 = load volatile i32* %149, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3127)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537

; <label>:3130                                    ; preds = %3123
  %3131 = load i32* %3125, align 4, !tbaa !8
  %3132 = add nsw i32 %3131, -1
  store i32 %3132, i32* %3125, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537: ; preds = %3130, %3126
  %.0.i.i.i.i1.i536 = phi i32 [ %3129, %3126 ], [ %3131, %3130 ]
  %3133 = icmp slt i32 %.0.i.i.i.i1.i536, 1
  br i1 %3133, label %3134, label %_ZN8TestCaseD2Ev.exit538

; <label>:3134                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3121, %"class.std::allocator.0"* %150) #1
  br label %_ZN8TestCaseD2Ev.exit538

_ZN8TestCaseD2Ev.exit538:                         ; preds = %3134, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537, %3116, %.body123
  %.918 = phi i8* [ %3092, %.body123 ], [ %3096, %3116 ], [ %3096, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537 ], [ %3096, %3134 ]
  %.9 = phi i32 [ %3093, %.body123 ], [ %3097, %3116 ], [ %3097, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i537 ], [ %3097, %3134 ]
  %3135 = getelementptr inbounds %"class.std::allocator.0"* %148, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3135)
  %3136 = getelementptr inbounds %"class.std::basic_string"* %415, i64 0, i32 0, i32 0
  %3137 = load i8** %3136, align 8, !tbaa !1
  %3138 = getelementptr inbounds i8* %3137, i64 -24
  %3139 = bitcast i8* %3138 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3140 = icmp eq i8* %3138, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3140, label %_ZNSsD1Ev.exit541, label %3141, !prof !7

; <label>:3141                                    ; preds = %_ZN8TestCaseD2Ev.exit538
  %3142 = getelementptr inbounds i8* %3137, i64 -8
  %3143 = bitcast i8* %3142 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3144, label %3148

; <label>:3144                                    ; preds = %3141
  %3145 = bitcast i32* %147 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3145)
  %3146 = atomicrmw volatile add i32* %3143, i32 -1 acq_rel
  store i32 %3146, i32* %147, align 4
  %3147 = load volatile i32* %147, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3145)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540

; <label>:3148                                    ; preds = %3141
  %3149 = load i32* %3143, align 4, !tbaa !8
  %3150 = add nsw i32 %3149, -1
  store i32 %3150, i32* %3143, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540: ; preds = %3148, %3144
  %.0.i.i.i.i539 = phi i32 [ %3147, %3144 ], [ %3149, %3148 ]
  %3151 = icmp slt i32 %.0.i.i.i.i539, 1
  br i1 %3151, label %3152, label %_ZNSsD1Ev.exit541

; <label>:3152                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3139, %"class.std::allocator.0"* %148) #1
  br label %_ZNSsD1Ev.exit541

_ZNSsD1Ev.exit541:                                ; preds = %3152, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540, %_ZN8TestCaseD2Ev.exit538, %3086
  %.1019 = phi i8* [ %3088, %3086 ], [ %.918, %_ZN8TestCaseD2Ev.exit538 ], [ %.918, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540 ], [ %.918, %3152 ]
  %.10 = phi i32 [ %3089, %3086 ], [ %.9, %_ZN8TestCaseD2Ev.exit538 ], [ %.9, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i540 ], [ %.9, %3152 ]
  %3153 = getelementptr inbounds %"class.std::allocator.0"* %146, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3153)
  %3154 = getelementptr inbounds %"class.std::basic_string"* %413, i64 0, i32 0, i32 0
  %3155 = load i8** %3154, align 8, !tbaa !1
  %3156 = getelementptr inbounds i8* %3155, i64 -24
  %3157 = bitcast i8* %3156 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3158 = icmp eq i8* %3156, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3158, label %_ZNSsD1Ev.exit509, label %3159, !prof !7

; <label>:3159                                    ; preds = %_ZNSsD1Ev.exit541
  %3160 = getelementptr inbounds i8* %3155, i64 -8
  %3161 = bitcast i8* %3160 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3162, label %3166

; <label>:3162                                    ; preds = %3159
  %3163 = bitcast i32* %145 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3163)
  %3164 = atomicrmw volatile add i32* %3161, i32 -1 acq_rel
  store i32 %3164, i32* %145, align 4
  %3165 = load volatile i32* %145, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3163)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543

; <label>:3166                                    ; preds = %3159
  %3167 = load i32* %3161, align 4, !tbaa !8
  %3168 = add nsw i32 %3167, -1
  store i32 %3168, i32* %3161, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543: ; preds = %3166, %3162
  %.0.i.i.i.i542 = phi i32 [ %3165, %3162 ], [ %3167, %3166 ]
  %3169 = icmp slt i32 %.0.i.i.i.i542, 1
  br i1 %3169, label %3170, label %_ZNSsD1Ev.exit509

; <label>:3170                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3157, %"class.std::allocator.0"* %146) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3171                                    ; preds = %923
  %3172 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3173 = extractvalue { i8*, i32 } %3172, 0
  %3174 = extractvalue { i8*, i32 } %3172, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3175                                    ; preds = %924
  %3176 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3177 = extractvalue { i8*, i32 } %3176, 0
  %3178 = extractvalue { i8*, i32 } %3176, 1
  br label %_ZNSsD1Ev.exit554

; <label>:3179                                    ; preds = %925
  %3180 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body140

.body140:                                         ; preds = %3179, %947, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i138, %928
  %eh.lpad-body141 = phi { i8*, i32 } [ %3180, %3179 ], [ %929, %947 ], [ %929, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i138 ], [ %929, %928 ]
  %3181 = extractvalue { i8*, i32 } %eh.lpad-body141, 0
  %3182 = extractvalue { i8*, i32 } %eh.lpad-body141, 1
  br label %_ZN8TestCaseD2Ev.exit551

; <label>:3183                                    ; preds = %948
  %3184 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3185 = extractvalue { i8*, i32 } %3184, 0
  %3186 = extractvalue { i8*, i32 } %3184, 1
  %3187 = getelementptr inbounds %"class.std::allocator.0"* %144, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3187)
  %3188 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 1, i32 0, i32 0
  %3189 = load i8** %3188, align 8, !tbaa !1
  %3190 = getelementptr inbounds i8* %3189, i64 -24
  %3191 = bitcast i8* %3190 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3192 = icmp eq i8* %3190, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3192, label %3205, label %3193, !prof !7

; <label>:3193                                    ; preds = %3183
  %3194 = getelementptr inbounds i8* %3189, i64 -8
  %3195 = bitcast i8* %3194 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3196, label %3200

; <label>:3196                                    ; preds = %3193
  %3197 = bitcast i32* %143 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3197)
  %3198 = atomicrmw volatile add i32* %3195, i32 -1 acq_rel
  store i32 %3198, i32* %143, align 4
  %3199 = load volatile i32* %143, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3197)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i548

; <label>:3200                                    ; preds = %3193
  %3201 = load i32* %3195, align 4, !tbaa !8
  %3202 = add nsw i32 %3201, -1
  store i32 %3202, i32* %3195, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i548

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i548: ; preds = %3200, %3196
  %.0.i.i.i.i.i547 = phi i32 [ %3199, %3196 ], [ %3201, %3200 ]
  %3203 = icmp slt i32 %.0.i.i.i.i.i547, 1
  br i1 %3203, label %3204, label %3205

; <label>:3204                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i548
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3191, %"class.std::allocator.0"* %144) #1
  br label %3205

; <label>:3205                                    ; preds = %3204, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i548, %3183
  call void @llvm.lifetime.end(i64 1, i8* %3187)
  %3206 = getelementptr inbounds %"class.std::allocator.0"* %142, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3206)
  %3207 = getelementptr inbounds %class.TestCase* %417, i64 0, i32 0, i32 0, i32 0
  %3208 = load i8** %3207, align 8, !tbaa !1
  %3209 = getelementptr inbounds i8* %3208, i64 -24
  %3210 = bitcast i8* %3209 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3211 = icmp eq i8* %3209, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3211, label %_ZN8TestCaseD2Ev.exit551, label %3212, !prof !7

; <label>:3212                                    ; preds = %3205
  %3213 = getelementptr inbounds i8* %3208, i64 -8
  %3214 = bitcast i8* %3213 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3215, label %3219

; <label>:3215                                    ; preds = %3212
  %3216 = bitcast i32* %141 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3216)
  %3217 = atomicrmw volatile add i32* %3214, i32 -1 acq_rel
  store i32 %3217, i32* %141, align 4
  %3218 = load volatile i32* %141, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3216)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550

; <label>:3219                                    ; preds = %3212
  %3220 = load i32* %3214, align 4, !tbaa !8
  %3221 = add nsw i32 %3220, -1
  store i32 %3221, i32* %3214, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550: ; preds = %3219, %3215
  %.0.i.i.i.i1.i549 = phi i32 [ %3218, %3215 ], [ %3220, %3219 ]
  %3222 = icmp slt i32 %.0.i.i.i.i1.i549, 1
  br i1 %3222, label %3223, label %_ZN8TestCaseD2Ev.exit551

; <label>:3223                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3210, %"class.std::allocator.0"* %142) #1
  br label %_ZN8TestCaseD2Ev.exit551

_ZN8TestCaseD2Ev.exit551:                         ; preds = %3223, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550, %3205, %.body140
  %.1221 = phi i8* [ %3181, %.body140 ], [ %3185, %3205 ], [ %3185, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550 ], [ %3185, %3223 ]
  %.12 = phi i32 [ %3182, %.body140 ], [ %3186, %3205 ], [ %3186, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i550 ], [ %3186, %3223 ]
  %3224 = getelementptr inbounds %"class.std::allocator.0"* %140, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3224)
  %3225 = getelementptr inbounds %"class.std::basic_string"* %420, i64 0, i32 0, i32 0
  %3226 = load i8** %3225, align 8, !tbaa !1
  %3227 = getelementptr inbounds i8* %3226, i64 -24
  %3228 = bitcast i8* %3227 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3229 = icmp eq i8* %3227, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3229, label %_ZNSsD1Ev.exit554, label %3230, !prof !7

; <label>:3230                                    ; preds = %_ZN8TestCaseD2Ev.exit551
  %3231 = getelementptr inbounds i8* %3226, i64 -8
  %3232 = bitcast i8* %3231 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3233, label %3237

; <label>:3233                                    ; preds = %3230
  %3234 = bitcast i32* %139 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3234)
  %3235 = atomicrmw volatile add i32* %3232, i32 -1 acq_rel
  store i32 %3235, i32* %139, align 4
  %3236 = load volatile i32* %139, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3234)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553

; <label>:3237                                    ; preds = %3230
  %3238 = load i32* %3232, align 4, !tbaa !8
  %3239 = add nsw i32 %3238, -1
  store i32 %3239, i32* %3232, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553: ; preds = %3237, %3233
  %.0.i.i.i.i552 = phi i32 [ %3236, %3233 ], [ %3238, %3237 ]
  %3240 = icmp slt i32 %.0.i.i.i.i552, 1
  br i1 %3240, label %3241, label %_ZNSsD1Ev.exit554

; <label>:3241                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3228, %"class.std::allocator.0"* %140) #1
  br label %_ZNSsD1Ev.exit554

_ZNSsD1Ev.exit554:                                ; preds = %3241, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553, %_ZN8TestCaseD2Ev.exit551, %3175
  %.1322 = phi i8* [ %3177, %3175 ], [ %.1221, %_ZN8TestCaseD2Ev.exit551 ], [ %.1221, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553 ], [ %.1221, %3241 ]
  %.13 = phi i32 [ %3178, %3175 ], [ %.12, %_ZN8TestCaseD2Ev.exit551 ], [ %.12, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i553 ], [ %.12, %3241 ]
  %3242 = getelementptr inbounds %"class.std::allocator.0"* %138, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3242)
  %3243 = getelementptr inbounds %"class.std::basic_string"* %418, i64 0, i32 0, i32 0
  %3244 = load i8** %3243, align 8, !tbaa !1
  %3245 = getelementptr inbounds i8* %3244, i64 -24
  %3246 = bitcast i8* %3245 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3247 = icmp eq i8* %3245, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3247, label %_ZNSsD1Ev.exit509, label %3248, !prof !7

; <label>:3248                                    ; preds = %_ZNSsD1Ev.exit554
  %3249 = getelementptr inbounds i8* %3244, i64 -8
  %3250 = bitcast i8* %3249 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3251, label %3255

; <label>:3251                                    ; preds = %3248
  %3252 = bitcast i32* %137 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3252)
  %3253 = atomicrmw volatile add i32* %3250, i32 -1 acq_rel
  store i32 %3253, i32* %137, align 4
  %3254 = load volatile i32* %137, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3252)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556

; <label>:3255                                    ; preds = %3248
  %3256 = load i32* %3250, align 4, !tbaa !8
  %3257 = add nsw i32 %3256, -1
  store i32 %3257, i32* %3250, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556: ; preds = %3255, %3251
  %.0.i.i.i.i555 = phi i32 [ %3254, %3251 ], [ %3256, %3255 ]
  %3258 = icmp slt i32 %.0.i.i.i.i555, 1
  br i1 %3258, label %3259, label %_ZNSsD1Ev.exit509

; <label>:3259                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3246, %"class.std::allocator.0"* %138) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3260                                    ; preds = %1027
  %3261 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3262 = extractvalue { i8*, i32 } %3261, 0
  %3263 = extractvalue { i8*, i32 } %3261, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3264                                    ; preds = %1028
  %3265 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3266 = extractvalue { i8*, i32 } %3265, 0
  %3267 = extractvalue { i8*, i32 } %3265, 1
  br label %_ZNSsD1Ev.exit567

; <label>:3268                                    ; preds = %1029
  %3269 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body162

.body162:                                         ; preds = %3268, %1051, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i160, %1032
  %eh.lpad-body163 = phi { i8*, i32 } [ %3269, %3268 ], [ %1033, %1051 ], [ %1033, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i160 ], [ %1033, %1032 ]
  %3270 = extractvalue { i8*, i32 } %eh.lpad-body163, 0
  %3271 = extractvalue { i8*, i32 } %eh.lpad-body163, 1
  br label %_ZN8TestCaseD2Ev.exit564

; <label>:3272                                    ; preds = %1052
  %3273 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3274 = extractvalue { i8*, i32 } %3273, 0
  %3275 = extractvalue { i8*, i32 } %3273, 1
  %3276 = getelementptr inbounds %"class.std::allocator.0"* %136, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3276)
  %3277 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 1, i32 0, i32 0
  %3278 = load i8** %3277, align 8, !tbaa !1
  %3279 = getelementptr inbounds i8* %3278, i64 -24
  %3280 = bitcast i8* %3279 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3281 = icmp eq i8* %3279, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3281, label %3294, label %3282, !prof !7

; <label>:3282                                    ; preds = %3272
  %3283 = getelementptr inbounds i8* %3278, i64 -8
  %3284 = bitcast i8* %3283 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3285, label %3289

; <label>:3285                                    ; preds = %3282
  %3286 = bitcast i32* %135 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3286)
  %3287 = atomicrmw volatile add i32* %3284, i32 -1 acq_rel
  store i32 %3287, i32* %135, align 4
  %3288 = load volatile i32* %135, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3286)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i561

; <label>:3289                                    ; preds = %3282
  %3290 = load i32* %3284, align 4, !tbaa !8
  %3291 = add nsw i32 %3290, -1
  store i32 %3291, i32* %3284, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i561

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i561: ; preds = %3289, %3285
  %.0.i.i.i.i.i560 = phi i32 [ %3288, %3285 ], [ %3290, %3289 ]
  %3292 = icmp slt i32 %.0.i.i.i.i.i560, 1
  br i1 %3292, label %3293, label %3294

; <label>:3293                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i561
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3280, %"class.std::allocator.0"* %136) #1
  br label %3294

; <label>:3294                                    ; preds = %3293, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i561, %3272
  call void @llvm.lifetime.end(i64 1, i8* %3276)
  %3295 = getelementptr inbounds %"class.std::allocator.0"* %134, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3295)
  %3296 = getelementptr inbounds %class.TestCase* %422, i64 0, i32 0, i32 0, i32 0
  %3297 = load i8** %3296, align 8, !tbaa !1
  %3298 = getelementptr inbounds i8* %3297, i64 -24
  %3299 = bitcast i8* %3298 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3300 = icmp eq i8* %3298, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3300, label %_ZN8TestCaseD2Ev.exit564, label %3301, !prof !7

; <label>:3301                                    ; preds = %3294
  %3302 = getelementptr inbounds i8* %3297, i64 -8
  %3303 = bitcast i8* %3302 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3304, label %3308

; <label>:3304                                    ; preds = %3301
  %3305 = bitcast i32* %133 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3305)
  %3306 = atomicrmw volatile add i32* %3303, i32 -1 acq_rel
  store i32 %3306, i32* %133, align 4
  %3307 = load volatile i32* %133, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3305)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563

; <label>:3308                                    ; preds = %3301
  %3309 = load i32* %3303, align 4, !tbaa !8
  %3310 = add nsw i32 %3309, -1
  store i32 %3310, i32* %3303, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563: ; preds = %3308, %3304
  %.0.i.i.i.i1.i562 = phi i32 [ %3307, %3304 ], [ %3309, %3308 ]
  %3311 = icmp slt i32 %.0.i.i.i.i1.i562, 1
  br i1 %3311, label %3312, label %_ZN8TestCaseD2Ev.exit564

; <label>:3312                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3299, %"class.std::allocator.0"* %134) #1
  br label %_ZN8TestCaseD2Ev.exit564

_ZN8TestCaseD2Ev.exit564:                         ; preds = %3312, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563, %3294, %.body162
  %.1524 = phi i8* [ %3270, %.body162 ], [ %3274, %3294 ], [ %3274, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563 ], [ %3274, %3312 ]
  %.15 = phi i32 [ %3271, %.body162 ], [ %3275, %3294 ], [ %3275, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i563 ], [ %3275, %3312 ]
  %3313 = getelementptr inbounds %"class.std::allocator.0"* %132, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3313)
  %3314 = getelementptr inbounds %"class.std::basic_string"* %425, i64 0, i32 0, i32 0
  %3315 = load i8** %3314, align 8, !tbaa !1
  %3316 = getelementptr inbounds i8* %3315, i64 -24
  %3317 = bitcast i8* %3316 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3318 = icmp eq i8* %3316, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3318, label %_ZNSsD1Ev.exit567, label %3319, !prof !7

; <label>:3319                                    ; preds = %_ZN8TestCaseD2Ev.exit564
  %3320 = getelementptr inbounds i8* %3315, i64 -8
  %3321 = bitcast i8* %3320 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3322, label %3326

; <label>:3322                                    ; preds = %3319
  %3323 = bitcast i32* %131 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3323)
  %3324 = atomicrmw volatile add i32* %3321, i32 -1 acq_rel
  store i32 %3324, i32* %131, align 4
  %3325 = load volatile i32* %131, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3323)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566

; <label>:3326                                    ; preds = %3319
  %3327 = load i32* %3321, align 4, !tbaa !8
  %3328 = add nsw i32 %3327, -1
  store i32 %3328, i32* %3321, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566: ; preds = %3326, %3322
  %.0.i.i.i.i565 = phi i32 [ %3325, %3322 ], [ %3327, %3326 ]
  %3329 = icmp slt i32 %.0.i.i.i.i565, 1
  br i1 %3329, label %3330, label %_ZNSsD1Ev.exit567

; <label>:3330                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3317, %"class.std::allocator.0"* %132) #1
  br label %_ZNSsD1Ev.exit567

_ZNSsD1Ev.exit567:                                ; preds = %3330, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566, %_ZN8TestCaseD2Ev.exit564, %3264
  %.1625 = phi i8* [ %3266, %3264 ], [ %.1524, %_ZN8TestCaseD2Ev.exit564 ], [ %.1524, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566 ], [ %.1524, %3330 ]
  %.16 = phi i32 [ %3267, %3264 ], [ %.15, %_ZN8TestCaseD2Ev.exit564 ], [ %.15, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i566 ], [ %.15, %3330 ]
  %3331 = getelementptr inbounds %"class.std::allocator.0"* %130, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3331)
  %3332 = getelementptr inbounds %"class.std::basic_string"* %423, i64 0, i32 0, i32 0
  %3333 = load i8** %3332, align 8, !tbaa !1
  %3334 = getelementptr inbounds i8* %3333, i64 -24
  %3335 = bitcast i8* %3334 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3336 = icmp eq i8* %3334, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3336, label %_ZNSsD1Ev.exit509, label %3337, !prof !7

; <label>:3337                                    ; preds = %_ZNSsD1Ev.exit567
  %3338 = getelementptr inbounds i8* %3333, i64 -8
  %3339 = bitcast i8* %3338 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3340, label %3344

; <label>:3340                                    ; preds = %3337
  %3341 = bitcast i32* %129 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3341)
  %3342 = atomicrmw volatile add i32* %3339, i32 -1 acq_rel
  store i32 %3342, i32* %129, align 4
  %3343 = load volatile i32* %129, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3341)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569

; <label>:3344                                    ; preds = %3337
  %3345 = load i32* %3339, align 4, !tbaa !8
  %3346 = add nsw i32 %3345, -1
  store i32 %3346, i32* %3339, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569: ; preds = %3344, %3340
  %.0.i.i.i.i568 = phi i32 [ %3343, %3340 ], [ %3345, %3344 ]
  %3347 = icmp slt i32 %.0.i.i.i.i568, 1
  br i1 %3347, label %3348, label %_ZNSsD1Ev.exit509

; <label>:3348                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3335, %"class.std::allocator.0"* %130) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3349                                    ; preds = %1131
  %3350 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3351 = extractvalue { i8*, i32 } %3350, 0
  %3352 = extractvalue { i8*, i32 } %3350, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3353                                    ; preds = %1132
  %3354 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3355 = extractvalue { i8*, i32 } %3354, 0
  %3356 = extractvalue { i8*, i32 } %3354, 1
  br label %_ZNSsD1Ev.exit578

; <label>:3357                                    ; preds = %1133
  %3358 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body179

.body179:                                         ; preds = %3357, %1155, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i177, %1136
  %eh.lpad-body180 = phi { i8*, i32 } [ %3358, %3357 ], [ %1137, %1155 ], [ %1137, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i177 ], [ %1137, %1136 ]
  %3359 = extractvalue { i8*, i32 } %eh.lpad-body180, 0
  %3360 = extractvalue { i8*, i32 } %eh.lpad-body180, 1
  br label %_ZN8TestCaseD2Ev.exit575

; <label>:3361                                    ; preds = %1156
  %3362 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3363 = extractvalue { i8*, i32 } %3362, 0
  %3364 = extractvalue { i8*, i32 } %3362, 1
  %3365 = getelementptr inbounds %"class.std::allocator.0"* %128, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3365)
  %3366 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 1, i32 0, i32 0
  %3367 = load i8** %3366, align 8, !tbaa !1
  %3368 = getelementptr inbounds i8* %3367, i64 -24
  %3369 = bitcast i8* %3368 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3370 = icmp eq i8* %3368, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3370, label %3383, label %3371, !prof !7

; <label>:3371                                    ; preds = %3361
  %3372 = getelementptr inbounds i8* %3367, i64 -8
  %3373 = bitcast i8* %3372 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3374, label %3378

; <label>:3374                                    ; preds = %3371
  %3375 = bitcast i32* %127 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3375)
  %3376 = atomicrmw volatile add i32* %3373, i32 -1 acq_rel
  store i32 %3376, i32* %127, align 4
  %3377 = load volatile i32* %127, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3375)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i572

; <label>:3378                                    ; preds = %3371
  %3379 = load i32* %3373, align 4, !tbaa !8
  %3380 = add nsw i32 %3379, -1
  store i32 %3380, i32* %3373, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i572

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i572: ; preds = %3378, %3374
  %.0.i.i.i.i.i571 = phi i32 [ %3377, %3374 ], [ %3379, %3378 ]
  %3381 = icmp slt i32 %.0.i.i.i.i.i571, 1
  br i1 %3381, label %3382, label %3383

; <label>:3382                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i572
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3369, %"class.std::allocator.0"* %128) #1
  br label %3383

; <label>:3383                                    ; preds = %3382, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i572, %3361
  call void @llvm.lifetime.end(i64 1, i8* %3365)
  %3384 = getelementptr inbounds %"class.std::allocator.0"* %126, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3384)
  %3385 = getelementptr inbounds %class.TestCase* %427, i64 0, i32 0, i32 0, i32 0
  %3386 = load i8** %3385, align 8, !tbaa !1
  %3387 = getelementptr inbounds i8* %3386, i64 -24
  %3388 = bitcast i8* %3387 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3389 = icmp eq i8* %3387, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3389, label %_ZN8TestCaseD2Ev.exit575, label %3390, !prof !7

; <label>:3390                                    ; preds = %3383
  %3391 = getelementptr inbounds i8* %3386, i64 -8
  %3392 = bitcast i8* %3391 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3393, label %3397

; <label>:3393                                    ; preds = %3390
  %3394 = bitcast i32* %125 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3394)
  %3395 = atomicrmw volatile add i32* %3392, i32 -1 acq_rel
  store i32 %3395, i32* %125, align 4
  %3396 = load volatile i32* %125, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3394)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574

; <label>:3397                                    ; preds = %3390
  %3398 = load i32* %3392, align 4, !tbaa !8
  %3399 = add nsw i32 %3398, -1
  store i32 %3399, i32* %3392, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574: ; preds = %3397, %3393
  %.0.i.i.i.i1.i573 = phi i32 [ %3396, %3393 ], [ %3398, %3397 ]
  %3400 = icmp slt i32 %.0.i.i.i.i1.i573, 1
  br i1 %3400, label %3401, label %_ZN8TestCaseD2Ev.exit575

; <label>:3401                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3388, %"class.std::allocator.0"* %126) #1
  br label %_ZN8TestCaseD2Ev.exit575

_ZN8TestCaseD2Ev.exit575:                         ; preds = %3401, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574, %3383, %.body179
  %.1827 = phi i8* [ %3359, %.body179 ], [ %3363, %3383 ], [ %3363, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574 ], [ %3363, %3401 ]
  %.18 = phi i32 [ %3360, %.body179 ], [ %3364, %3383 ], [ %3364, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i574 ], [ %3364, %3401 ]
  %3402 = getelementptr inbounds %"class.std::allocator.0"* %124, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3402)
  %3403 = getelementptr inbounds %"class.std::basic_string"* %430, i64 0, i32 0, i32 0
  %3404 = load i8** %3403, align 8, !tbaa !1
  %3405 = getelementptr inbounds i8* %3404, i64 -24
  %3406 = bitcast i8* %3405 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3407 = icmp eq i8* %3405, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3407, label %_ZNSsD1Ev.exit578, label %3408, !prof !7

; <label>:3408                                    ; preds = %_ZN8TestCaseD2Ev.exit575
  %3409 = getelementptr inbounds i8* %3404, i64 -8
  %3410 = bitcast i8* %3409 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3411, label %3415

; <label>:3411                                    ; preds = %3408
  %3412 = bitcast i32* %123 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3412)
  %3413 = atomicrmw volatile add i32* %3410, i32 -1 acq_rel
  store i32 %3413, i32* %123, align 4
  %3414 = load volatile i32* %123, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3412)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577

; <label>:3415                                    ; preds = %3408
  %3416 = load i32* %3410, align 4, !tbaa !8
  %3417 = add nsw i32 %3416, -1
  store i32 %3417, i32* %3410, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577: ; preds = %3415, %3411
  %.0.i.i.i.i576 = phi i32 [ %3414, %3411 ], [ %3416, %3415 ]
  %3418 = icmp slt i32 %.0.i.i.i.i576, 1
  br i1 %3418, label %3419, label %_ZNSsD1Ev.exit578

; <label>:3419                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3406, %"class.std::allocator.0"* %124) #1
  br label %_ZNSsD1Ev.exit578

_ZNSsD1Ev.exit578:                                ; preds = %3419, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577, %_ZN8TestCaseD2Ev.exit575, %3353
  %.1928 = phi i8* [ %3355, %3353 ], [ %.1827, %_ZN8TestCaseD2Ev.exit575 ], [ %.1827, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577 ], [ %.1827, %3419 ]
  %.19 = phi i32 [ %3356, %3353 ], [ %.18, %_ZN8TestCaseD2Ev.exit575 ], [ %.18, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i577 ], [ %.18, %3419 ]
  %3420 = getelementptr inbounds %"class.std::allocator.0"* %122, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3420)
  %3421 = getelementptr inbounds %"class.std::basic_string"* %428, i64 0, i32 0, i32 0
  %3422 = load i8** %3421, align 8, !tbaa !1
  %3423 = getelementptr inbounds i8* %3422, i64 -24
  %3424 = bitcast i8* %3423 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3425 = icmp eq i8* %3423, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3425, label %_ZNSsD1Ev.exit509, label %3426, !prof !7

; <label>:3426                                    ; preds = %_ZNSsD1Ev.exit578
  %3427 = getelementptr inbounds i8* %3422, i64 -8
  %3428 = bitcast i8* %3427 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3429, label %3433

; <label>:3429                                    ; preds = %3426
  %3430 = bitcast i32* %121 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3430)
  %3431 = atomicrmw volatile add i32* %3428, i32 -1 acq_rel
  store i32 %3431, i32* %121, align 4
  %3432 = load volatile i32* %121, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3430)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580

; <label>:3433                                    ; preds = %3426
  %3434 = load i32* %3428, align 4, !tbaa !8
  %3435 = add nsw i32 %3434, -1
  store i32 %3435, i32* %3428, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580: ; preds = %3433, %3429
  %.0.i.i.i.i579 = phi i32 [ %3432, %3429 ], [ %3434, %3433 ]
  %3436 = icmp slt i32 %.0.i.i.i.i579, 1
  br i1 %3436, label %3437, label %_ZNSsD1Ev.exit509

; <label>:3437                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3424, %"class.std::allocator.0"* %122) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3438                                    ; preds = %1235
  %3439 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3440 = extractvalue { i8*, i32 } %3439, 0
  %3441 = extractvalue { i8*, i32 } %3439, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3442                                    ; preds = %1236
  %3443 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3444 = extractvalue { i8*, i32 } %3443, 0
  %3445 = extractvalue { i8*, i32 } %3443, 1
  br label %_ZNSsD1Ev.exit591

; <label>:3446                                    ; preds = %1237
  %3447 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body200

.body200:                                         ; preds = %3446, %1259, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i198, %1240
  %eh.lpad-body201 = phi { i8*, i32 } [ %3447, %3446 ], [ %1241, %1259 ], [ %1241, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i198 ], [ %1241, %1240 ]
  %3448 = extractvalue { i8*, i32 } %eh.lpad-body201, 0
  %3449 = extractvalue { i8*, i32 } %eh.lpad-body201, 1
  br label %_ZN8TestCaseD2Ev.exit588

; <label>:3450                                    ; preds = %1260
  %3451 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3452 = extractvalue { i8*, i32 } %3451, 0
  %3453 = extractvalue { i8*, i32 } %3451, 1
  %3454 = getelementptr inbounds %"class.std::allocator.0"* %120, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3454)
  %3455 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 1, i32 0, i32 0
  %3456 = load i8** %3455, align 8, !tbaa !1
  %3457 = getelementptr inbounds i8* %3456, i64 -24
  %3458 = bitcast i8* %3457 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3459 = icmp eq i8* %3457, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3459, label %3472, label %3460, !prof !7

; <label>:3460                                    ; preds = %3450
  %3461 = getelementptr inbounds i8* %3456, i64 -8
  %3462 = bitcast i8* %3461 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3463, label %3467

; <label>:3463                                    ; preds = %3460
  %3464 = bitcast i32* %119 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3464)
  %3465 = atomicrmw volatile add i32* %3462, i32 -1 acq_rel
  store i32 %3465, i32* %119, align 4
  %3466 = load volatile i32* %119, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3464)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i585

; <label>:3467                                    ; preds = %3460
  %3468 = load i32* %3462, align 4, !tbaa !8
  %3469 = add nsw i32 %3468, -1
  store i32 %3469, i32* %3462, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i585

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i585: ; preds = %3467, %3463
  %.0.i.i.i.i.i584 = phi i32 [ %3466, %3463 ], [ %3468, %3467 ]
  %3470 = icmp slt i32 %.0.i.i.i.i.i584, 1
  br i1 %3470, label %3471, label %3472

; <label>:3471                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i585
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3458, %"class.std::allocator.0"* %120) #1
  br label %3472

; <label>:3472                                    ; preds = %3471, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i585, %3450
  call void @llvm.lifetime.end(i64 1, i8* %3454)
  %3473 = getelementptr inbounds %"class.std::allocator.0"* %118, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3473)
  %3474 = getelementptr inbounds %class.TestCase* %432, i64 0, i32 0, i32 0, i32 0
  %3475 = load i8** %3474, align 8, !tbaa !1
  %3476 = getelementptr inbounds i8* %3475, i64 -24
  %3477 = bitcast i8* %3476 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3478 = icmp eq i8* %3476, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3478, label %_ZN8TestCaseD2Ev.exit588, label %3479, !prof !7

; <label>:3479                                    ; preds = %3472
  %3480 = getelementptr inbounds i8* %3475, i64 -8
  %3481 = bitcast i8* %3480 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3482, label %3486

; <label>:3482                                    ; preds = %3479
  %3483 = bitcast i32* %117 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3483)
  %3484 = atomicrmw volatile add i32* %3481, i32 -1 acq_rel
  store i32 %3484, i32* %117, align 4
  %3485 = load volatile i32* %117, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3483)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587

; <label>:3486                                    ; preds = %3479
  %3487 = load i32* %3481, align 4, !tbaa !8
  %3488 = add nsw i32 %3487, -1
  store i32 %3488, i32* %3481, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587: ; preds = %3486, %3482
  %.0.i.i.i.i1.i586 = phi i32 [ %3485, %3482 ], [ %3487, %3486 ]
  %3489 = icmp slt i32 %.0.i.i.i.i1.i586, 1
  br i1 %3489, label %3490, label %_ZN8TestCaseD2Ev.exit588

; <label>:3490                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3477, %"class.std::allocator.0"* %118) #1
  br label %_ZN8TestCaseD2Ev.exit588

_ZN8TestCaseD2Ev.exit588:                         ; preds = %3490, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587, %3472, %.body200
  %.2130 = phi i8* [ %3448, %.body200 ], [ %3452, %3472 ], [ %3452, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587 ], [ %3452, %3490 ]
  %.21 = phi i32 [ %3449, %.body200 ], [ %3453, %3472 ], [ %3453, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i587 ], [ %3453, %3490 ]
  %3491 = getelementptr inbounds %"class.std::allocator.0"* %116, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3491)
  %3492 = getelementptr inbounds %"class.std::basic_string"* %435, i64 0, i32 0, i32 0
  %3493 = load i8** %3492, align 8, !tbaa !1
  %3494 = getelementptr inbounds i8* %3493, i64 -24
  %3495 = bitcast i8* %3494 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3496 = icmp eq i8* %3494, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3496, label %_ZNSsD1Ev.exit591, label %3497, !prof !7

; <label>:3497                                    ; preds = %_ZN8TestCaseD2Ev.exit588
  %3498 = getelementptr inbounds i8* %3493, i64 -8
  %3499 = bitcast i8* %3498 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3500, label %3504

; <label>:3500                                    ; preds = %3497
  %3501 = bitcast i32* %115 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3501)
  %3502 = atomicrmw volatile add i32* %3499, i32 -1 acq_rel
  store i32 %3502, i32* %115, align 4
  %3503 = load volatile i32* %115, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3501)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590

; <label>:3504                                    ; preds = %3497
  %3505 = load i32* %3499, align 4, !tbaa !8
  %3506 = add nsw i32 %3505, -1
  store i32 %3506, i32* %3499, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590: ; preds = %3504, %3500
  %.0.i.i.i.i589 = phi i32 [ %3503, %3500 ], [ %3505, %3504 ]
  %3507 = icmp slt i32 %.0.i.i.i.i589, 1
  br i1 %3507, label %3508, label %_ZNSsD1Ev.exit591

; <label>:3508                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3495, %"class.std::allocator.0"* %116) #1
  br label %_ZNSsD1Ev.exit591

_ZNSsD1Ev.exit591:                                ; preds = %3508, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590, %_ZN8TestCaseD2Ev.exit588, %3442
  %.2231 = phi i8* [ %3444, %3442 ], [ %.2130, %_ZN8TestCaseD2Ev.exit588 ], [ %.2130, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590 ], [ %.2130, %3508 ]
  %.22 = phi i32 [ %3445, %3442 ], [ %.21, %_ZN8TestCaseD2Ev.exit588 ], [ %.21, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i590 ], [ %.21, %3508 ]
  %3509 = getelementptr inbounds %"class.std::allocator.0"* %114, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3509)
  %3510 = getelementptr inbounds %"class.std::basic_string"* %433, i64 0, i32 0, i32 0
  %3511 = load i8** %3510, align 8, !tbaa !1
  %3512 = getelementptr inbounds i8* %3511, i64 -24
  %3513 = bitcast i8* %3512 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3514 = icmp eq i8* %3512, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3514, label %_ZNSsD1Ev.exit509, label %3515, !prof !7

; <label>:3515                                    ; preds = %_ZNSsD1Ev.exit591
  %3516 = getelementptr inbounds i8* %3511, i64 -8
  %3517 = bitcast i8* %3516 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3518, label %3522

; <label>:3518                                    ; preds = %3515
  %3519 = bitcast i32* %113 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3519)
  %3520 = atomicrmw volatile add i32* %3517, i32 -1 acq_rel
  store i32 %3520, i32* %113, align 4
  %3521 = load volatile i32* %113, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3519)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593

; <label>:3522                                    ; preds = %3515
  %3523 = load i32* %3517, align 4, !tbaa !8
  %3524 = add nsw i32 %3523, -1
  store i32 %3524, i32* %3517, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593: ; preds = %3522, %3518
  %.0.i.i.i.i592 = phi i32 [ %3521, %3518 ], [ %3523, %3522 ]
  %3525 = icmp slt i32 %.0.i.i.i.i592, 1
  br i1 %3525, label %3526, label %_ZNSsD1Ev.exit509

; <label>:3526                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3513, %"class.std::allocator.0"* %114) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3527                                    ; preds = %1339
  %3528 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3529 = extractvalue { i8*, i32 } %3528, 0
  %3530 = extractvalue { i8*, i32 } %3528, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3531                                    ; preds = %1340
  %3532 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3533 = extractvalue { i8*, i32 } %3532, 0
  %3534 = extractvalue { i8*, i32 } %3532, 1
  br label %_ZNSsD1Ev.exit602

; <label>:3535                                    ; preds = %1341
  %3536 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body217

.body217:                                         ; preds = %3535, %1363, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i215, %1344
  %eh.lpad-body218 = phi { i8*, i32 } [ %3536, %3535 ], [ %1345, %1363 ], [ %1345, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i215 ], [ %1345, %1344 ]
  %3537 = extractvalue { i8*, i32 } %eh.lpad-body218, 0
  %3538 = extractvalue { i8*, i32 } %eh.lpad-body218, 1
  br label %_ZN8TestCaseD2Ev.exit599

; <label>:3539                                    ; preds = %1364
  %3540 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3541 = extractvalue { i8*, i32 } %3540, 0
  %3542 = extractvalue { i8*, i32 } %3540, 1
  %3543 = getelementptr inbounds %"class.std::allocator.0"* %112, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3543)
  %3544 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 1, i32 0, i32 0
  %3545 = load i8** %3544, align 8, !tbaa !1
  %3546 = getelementptr inbounds i8* %3545, i64 -24
  %3547 = bitcast i8* %3546 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3548 = icmp eq i8* %3546, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3548, label %3561, label %3549, !prof !7

; <label>:3549                                    ; preds = %3539
  %3550 = getelementptr inbounds i8* %3545, i64 -8
  %3551 = bitcast i8* %3550 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3552, label %3556

; <label>:3552                                    ; preds = %3549
  %3553 = bitcast i32* %111 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3553)
  %3554 = atomicrmw volatile add i32* %3551, i32 -1 acq_rel
  store i32 %3554, i32* %111, align 4
  %3555 = load volatile i32* %111, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3553)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i596

; <label>:3556                                    ; preds = %3549
  %3557 = load i32* %3551, align 4, !tbaa !8
  %3558 = add nsw i32 %3557, -1
  store i32 %3558, i32* %3551, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i596

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i596: ; preds = %3556, %3552
  %.0.i.i.i.i.i595 = phi i32 [ %3555, %3552 ], [ %3557, %3556 ]
  %3559 = icmp slt i32 %.0.i.i.i.i.i595, 1
  br i1 %3559, label %3560, label %3561

; <label>:3560                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i596
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3547, %"class.std::allocator.0"* %112) #1
  br label %3561

; <label>:3561                                    ; preds = %3560, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i596, %3539
  call void @llvm.lifetime.end(i64 1, i8* %3543)
  %3562 = getelementptr inbounds %"class.std::allocator.0"* %110, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3562)
  %3563 = getelementptr inbounds %class.TestCase* %437, i64 0, i32 0, i32 0, i32 0
  %3564 = load i8** %3563, align 8, !tbaa !1
  %3565 = getelementptr inbounds i8* %3564, i64 -24
  %3566 = bitcast i8* %3565 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3567 = icmp eq i8* %3565, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3567, label %_ZN8TestCaseD2Ev.exit599, label %3568, !prof !7

; <label>:3568                                    ; preds = %3561
  %3569 = getelementptr inbounds i8* %3564, i64 -8
  %3570 = bitcast i8* %3569 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3571, label %3575

; <label>:3571                                    ; preds = %3568
  %3572 = bitcast i32* %109 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3572)
  %3573 = atomicrmw volatile add i32* %3570, i32 -1 acq_rel
  store i32 %3573, i32* %109, align 4
  %3574 = load volatile i32* %109, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3572)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598

; <label>:3575                                    ; preds = %3568
  %3576 = load i32* %3570, align 4, !tbaa !8
  %3577 = add nsw i32 %3576, -1
  store i32 %3577, i32* %3570, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598: ; preds = %3575, %3571
  %.0.i.i.i.i1.i597 = phi i32 [ %3574, %3571 ], [ %3576, %3575 ]
  %3578 = icmp slt i32 %.0.i.i.i.i1.i597, 1
  br i1 %3578, label %3579, label %_ZN8TestCaseD2Ev.exit599

; <label>:3579                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3566, %"class.std::allocator.0"* %110) #1
  br label %_ZN8TestCaseD2Ev.exit599

_ZN8TestCaseD2Ev.exit599:                         ; preds = %3579, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598, %3561, %.body217
  %.2433 = phi i8* [ %3537, %.body217 ], [ %3541, %3561 ], [ %3541, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598 ], [ %3541, %3579 ]
  %.24 = phi i32 [ %3538, %.body217 ], [ %3542, %3561 ], [ %3542, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i598 ], [ %3542, %3579 ]
  %3580 = getelementptr inbounds %"class.std::allocator.0"* %108, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3580)
  %3581 = getelementptr inbounds %"class.std::basic_string"* %440, i64 0, i32 0, i32 0
  %3582 = load i8** %3581, align 8, !tbaa !1
  %3583 = getelementptr inbounds i8* %3582, i64 -24
  %3584 = bitcast i8* %3583 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3585 = icmp eq i8* %3583, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3585, label %_ZNSsD1Ev.exit602, label %3586, !prof !7

; <label>:3586                                    ; preds = %_ZN8TestCaseD2Ev.exit599
  %3587 = getelementptr inbounds i8* %3582, i64 -8
  %3588 = bitcast i8* %3587 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3589, label %3593

; <label>:3589                                    ; preds = %3586
  %3590 = bitcast i32* %107 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3590)
  %3591 = atomicrmw volatile add i32* %3588, i32 -1 acq_rel
  store i32 %3591, i32* %107, align 4
  %3592 = load volatile i32* %107, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3590)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601

; <label>:3593                                    ; preds = %3586
  %3594 = load i32* %3588, align 4, !tbaa !8
  %3595 = add nsw i32 %3594, -1
  store i32 %3595, i32* %3588, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601: ; preds = %3593, %3589
  %.0.i.i.i.i600 = phi i32 [ %3592, %3589 ], [ %3594, %3593 ]
  %3596 = icmp slt i32 %.0.i.i.i.i600, 1
  br i1 %3596, label %3597, label %_ZNSsD1Ev.exit602

; <label>:3597                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3584, %"class.std::allocator.0"* %108) #1
  br label %_ZNSsD1Ev.exit602

_ZNSsD1Ev.exit602:                                ; preds = %3597, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601, %_ZN8TestCaseD2Ev.exit599, %3531
  %.2534 = phi i8* [ %3533, %3531 ], [ %.2433, %_ZN8TestCaseD2Ev.exit599 ], [ %.2433, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601 ], [ %.2433, %3597 ]
  %.25 = phi i32 [ %3534, %3531 ], [ %.24, %_ZN8TestCaseD2Ev.exit599 ], [ %.24, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i601 ], [ %.24, %3597 ]
  %3598 = getelementptr inbounds %"class.std::allocator.0"* %106, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3598)
  %3599 = getelementptr inbounds %"class.std::basic_string"* %438, i64 0, i32 0, i32 0
  %3600 = load i8** %3599, align 8, !tbaa !1
  %3601 = getelementptr inbounds i8* %3600, i64 -24
  %3602 = bitcast i8* %3601 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3603 = icmp eq i8* %3601, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3603, label %_ZNSsD1Ev.exit509, label %3604, !prof !7

; <label>:3604                                    ; preds = %_ZNSsD1Ev.exit602
  %3605 = getelementptr inbounds i8* %3600, i64 -8
  %3606 = bitcast i8* %3605 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3607, label %3611

; <label>:3607                                    ; preds = %3604
  %3608 = bitcast i32* %105 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3608)
  %3609 = atomicrmw volatile add i32* %3606, i32 -1 acq_rel
  store i32 %3609, i32* %105, align 4
  %3610 = load volatile i32* %105, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3608)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604

; <label>:3611                                    ; preds = %3604
  %3612 = load i32* %3606, align 4, !tbaa !8
  %3613 = add nsw i32 %3612, -1
  store i32 %3613, i32* %3606, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604: ; preds = %3611, %3607
  %.0.i.i.i.i603 = phi i32 [ %3610, %3607 ], [ %3612, %3611 ]
  %3614 = icmp slt i32 %.0.i.i.i.i603, 1
  br i1 %3614, label %3615, label %_ZNSsD1Ev.exit509

; <label>:3615                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3602, %"class.std::allocator.0"* %106) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3616                                    ; preds = %1443
  %3617 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3618 = extractvalue { i8*, i32 } %3617, 0
  %3619 = extractvalue { i8*, i32 } %3617, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3620                                    ; preds = %1444
  %3621 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3622 = extractvalue { i8*, i32 } %3621, 0
  %3623 = extractvalue { i8*, i32 } %3621, 1
  br label %_ZNSsD1Ev.exit616

; <label>:3624                                    ; preds = %1445
  %3625 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body235

.body235:                                         ; preds = %3624, %1467, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i233, %1448
  %eh.lpad-body236 = phi { i8*, i32 } [ %3625, %3624 ], [ %1449, %1467 ], [ %1449, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i233 ], [ %1449, %1448 ]
  %3626 = extractvalue { i8*, i32 } %eh.lpad-body236, 0
  %3627 = extractvalue { i8*, i32 } %eh.lpad-body236, 1
  br label %_ZN8TestCaseD2Ev.exit613

; <label>:3628                                    ; preds = %1468
  %3629 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3630 = extractvalue { i8*, i32 } %3629, 0
  %3631 = extractvalue { i8*, i32 } %3629, 1
  %3632 = getelementptr inbounds %"class.std::allocator.0"* %102, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3632)
  %3633 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 1, i32 0, i32 0
  %3634 = load i8** %3633, align 8, !tbaa !1
  %3635 = getelementptr inbounds i8* %3634, i64 -24
  %3636 = bitcast i8* %3635 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3637 = icmp eq i8* %3635, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3637, label %3650, label %3638, !prof !7

; <label>:3638                                    ; preds = %3628
  %3639 = getelementptr inbounds i8* %3634, i64 -8
  %3640 = bitcast i8* %3639 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3641, label %3645

; <label>:3641                                    ; preds = %3638
  %3642 = bitcast i32* %101 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3642)
  %3643 = atomicrmw volatile add i32* %3640, i32 -1 acq_rel
  store i32 %3643, i32* %101, align 4
  %3644 = load volatile i32* %101, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3642)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i610

; <label>:3645                                    ; preds = %3638
  %3646 = load i32* %3640, align 4, !tbaa !8
  %3647 = add nsw i32 %3646, -1
  store i32 %3647, i32* %3640, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i610

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i610: ; preds = %3645, %3641
  %.0.i.i.i.i.i609 = phi i32 [ %3644, %3641 ], [ %3646, %3645 ]
  %3648 = icmp slt i32 %.0.i.i.i.i.i609, 1
  br i1 %3648, label %3649, label %3650

; <label>:3649                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i610
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3636, %"class.std::allocator.0"* %102) #1
  br label %3650

; <label>:3650                                    ; preds = %3649, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i610, %3628
  call void @llvm.lifetime.end(i64 1, i8* %3632)
  %3651 = getelementptr inbounds %"class.std::allocator.0"* %100, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3651)
  %3652 = getelementptr inbounds %class.TestCase* %442, i64 0, i32 0, i32 0, i32 0
  %3653 = load i8** %3652, align 8, !tbaa !1
  %3654 = getelementptr inbounds i8* %3653, i64 -24
  %3655 = bitcast i8* %3654 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3656 = icmp eq i8* %3654, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3656, label %_ZN8TestCaseD2Ev.exit613, label %3657, !prof !7

; <label>:3657                                    ; preds = %3650
  %3658 = getelementptr inbounds i8* %3653, i64 -8
  %3659 = bitcast i8* %3658 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3660, label %3664

; <label>:3660                                    ; preds = %3657
  %3661 = bitcast i32* %99 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3661)
  %3662 = atomicrmw volatile add i32* %3659, i32 -1 acq_rel
  store i32 %3662, i32* %99, align 4
  %3663 = load volatile i32* %99, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3661)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612

; <label>:3664                                    ; preds = %3657
  %3665 = load i32* %3659, align 4, !tbaa !8
  %3666 = add nsw i32 %3665, -1
  store i32 %3666, i32* %3659, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612: ; preds = %3664, %3660
  %.0.i.i.i.i1.i611 = phi i32 [ %3663, %3660 ], [ %3665, %3664 ]
  %3667 = icmp slt i32 %.0.i.i.i.i1.i611, 1
  br i1 %3667, label %3668, label %_ZN8TestCaseD2Ev.exit613

; <label>:3668                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3655, %"class.std::allocator.0"* %100) #1
  br label %_ZN8TestCaseD2Ev.exit613

_ZN8TestCaseD2Ev.exit613:                         ; preds = %3668, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612, %3650, %.body235
  %.2736 = phi i8* [ %3626, %.body235 ], [ %3630, %3650 ], [ %3630, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612 ], [ %3630, %3668 ]
  %.27 = phi i32 [ %3627, %.body235 ], [ %3631, %3650 ], [ %3631, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i612 ], [ %3631, %3668 ]
  %3669 = getelementptr inbounds %"class.std::allocator.0"* %98, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3669)
  %3670 = getelementptr inbounds %"class.std::basic_string"* %445, i64 0, i32 0, i32 0
  %3671 = load i8** %3670, align 8, !tbaa !1
  %3672 = getelementptr inbounds i8* %3671, i64 -24
  %3673 = bitcast i8* %3672 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3674 = icmp eq i8* %3672, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3674, label %_ZNSsD1Ev.exit616, label %3675, !prof !7

; <label>:3675                                    ; preds = %_ZN8TestCaseD2Ev.exit613
  %3676 = getelementptr inbounds i8* %3671, i64 -8
  %3677 = bitcast i8* %3676 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3678, label %3682

; <label>:3678                                    ; preds = %3675
  %3679 = bitcast i32* %97 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3679)
  %3680 = atomicrmw volatile add i32* %3677, i32 -1 acq_rel
  store i32 %3680, i32* %97, align 4
  %3681 = load volatile i32* %97, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3679)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615

; <label>:3682                                    ; preds = %3675
  %3683 = load i32* %3677, align 4, !tbaa !8
  %3684 = add nsw i32 %3683, -1
  store i32 %3684, i32* %3677, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615: ; preds = %3682, %3678
  %.0.i.i.i.i614 = phi i32 [ %3681, %3678 ], [ %3683, %3682 ]
  %3685 = icmp slt i32 %.0.i.i.i.i614, 1
  br i1 %3685, label %3686, label %_ZNSsD1Ev.exit616

; <label>:3686                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3673, %"class.std::allocator.0"* %98) #1
  br label %_ZNSsD1Ev.exit616

_ZNSsD1Ev.exit616:                                ; preds = %3686, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615, %_ZN8TestCaseD2Ev.exit613, %3620
  %.2837 = phi i8* [ %3622, %3620 ], [ %.2736, %_ZN8TestCaseD2Ev.exit613 ], [ %.2736, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615 ], [ %.2736, %3686 ]
  %.28 = phi i32 [ %3623, %3620 ], [ %.27, %_ZN8TestCaseD2Ev.exit613 ], [ %.27, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i615 ], [ %.27, %3686 ]
  %3687 = getelementptr inbounds %"class.std::allocator.0"* %96, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3687)
  %3688 = getelementptr inbounds %"class.std::basic_string"* %443, i64 0, i32 0, i32 0
  %3689 = load i8** %3688, align 8, !tbaa !1
  %3690 = getelementptr inbounds i8* %3689, i64 -24
  %3691 = bitcast i8* %3690 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3692 = icmp eq i8* %3690, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3692, label %_ZNSsD1Ev.exit509, label %3693, !prof !7

; <label>:3693                                    ; preds = %_ZNSsD1Ev.exit616
  %3694 = getelementptr inbounds i8* %3689, i64 -8
  %3695 = bitcast i8* %3694 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3696, label %3700

; <label>:3696                                    ; preds = %3693
  %3697 = bitcast i32* %95 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3697)
  %3698 = atomicrmw volatile add i32* %3695, i32 -1 acq_rel
  store i32 %3698, i32* %95, align 4
  %3699 = load volatile i32* %95, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3697)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618

; <label>:3700                                    ; preds = %3693
  %3701 = load i32* %3695, align 4, !tbaa !8
  %3702 = add nsw i32 %3701, -1
  store i32 %3702, i32* %3695, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618: ; preds = %3700, %3696
  %.0.i.i.i.i617 = phi i32 [ %3699, %3696 ], [ %3701, %3700 ]
  %3703 = icmp slt i32 %.0.i.i.i.i617, 1
  br i1 %3703, label %3704, label %_ZNSsD1Ev.exit509

; <label>:3704                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3691, %"class.std::allocator.0"* %96) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3705                                    ; preds = %1547
  %3706 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3707 = extractvalue { i8*, i32 } %3706, 0
  %3708 = extractvalue { i8*, i32 } %3706, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3709                                    ; preds = %1548
  %3710 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3711 = extractvalue { i8*, i32 } %3710, 0
  %3712 = extractvalue { i8*, i32 } %3710, 1
  br label %_ZNSsD1Ev.exit630

; <label>:3713                                    ; preds = %1549
  %3714 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body253

.body253:                                         ; preds = %3713, %1571, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i251, %1552
  %eh.lpad-body254 = phi { i8*, i32 } [ %3714, %3713 ], [ %1553, %1571 ], [ %1553, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i251 ], [ %1553, %1552 ]
  %3715 = extractvalue { i8*, i32 } %eh.lpad-body254, 0
  %3716 = extractvalue { i8*, i32 } %eh.lpad-body254, 1
  br label %_ZN8TestCaseD2Ev.exit627

; <label>:3717                                    ; preds = %1572
  %3718 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3719 = extractvalue { i8*, i32 } %3718, 0
  %3720 = extractvalue { i8*, i32 } %3718, 1
  %3721 = getelementptr inbounds %"class.std::allocator.0"* %92, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3721)
  %3722 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 1, i32 0, i32 0
  %3723 = load i8** %3722, align 8, !tbaa !1
  %3724 = getelementptr inbounds i8* %3723, i64 -24
  %3725 = bitcast i8* %3724 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3726 = icmp eq i8* %3724, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3726, label %3739, label %3727, !prof !7

; <label>:3727                                    ; preds = %3717
  %3728 = getelementptr inbounds i8* %3723, i64 -8
  %3729 = bitcast i8* %3728 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3730, label %3734

; <label>:3730                                    ; preds = %3727
  %3731 = bitcast i32* %91 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3731)
  %3732 = atomicrmw volatile add i32* %3729, i32 -1 acq_rel
  store i32 %3732, i32* %91, align 4
  %3733 = load volatile i32* %91, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3731)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i624

; <label>:3734                                    ; preds = %3727
  %3735 = load i32* %3729, align 4, !tbaa !8
  %3736 = add nsw i32 %3735, -1
  store i32 %3736, i32* %3729, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i624

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i624: ; preds = %3734, %3730
  %.0.i.i.i.i.i623 = phi i32 [ %3733, %3730 ], [ %3735, %3734 ]
  %3737 = icmp slt i32 %.0.i.i.i.i.i623, 1
  br i1 %3737, label %3738, label %3739

; <label>:3738                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i624
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3725, %"class.std::allocator.0"* %92) #1
  br label %3739

; <label>:3739                                    ; preds = %3738, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i624, %3717
  call void @llvm.lifetime.end(i64 1, i8* %3721)
  %3740 = getelementptr inbounds %"class.std::allocator.0"* %90, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3740)
  %3741 = getelementptr inbounds %class.TestCase* %447, i64 0, i32 0, i32 0, i32 0
  %3742 = load i8** %3741, align 8, !tbaa !1
  %3743 = getelementptr inbounds i8* %3742, i64 -24
  %3744 = bitcast i8* %3743 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3745 = icmp eq i8* %3743, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3745, label %_ZN8TestCaseD2Ev.exit627, label %3746, !prof !7

; <label>:3746                                    ; preds = %3739
  %3747 = getelementptr inbounds i8* %3742, i64 -8
  %3748 = bitcast i8* %3747 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3749, label %3753

; <label>:3749                                    ; preds = %3746
  %3750 = bitcast i32* %89 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3750)
  %3751 = atomicrmw volatile add i32* %3748, i32 -1 acq_rel
  store i32 %3751, i32* %89, align 4
  %3752 = load volatile i32* %89, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3750)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626

; <label>:3753                                    ; preds = %3746
  %3754 = load i32* %3748, align 4, !tbaa !8
  %3755 = add nsw i32 %3754, -1
  store i32 %3755, i32* %3748, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626: ; preds = %3753, %3749
  %.0.i.i.i.i1.i625 = phi i32 [ %3752, %3749 ], [ %3754, %3753 ]
  %3756 = icmp slt i32 %.0.i.i.i.i1.i625, 1
  br i1 %3756, label %3757, label %_ZN8TestCaseD2Ev.exit627

; <label>:3757                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3744, %"class.std::allocator.0"* %90) #1
  br label %_ZN8TestCaseD2Ev.exit627

_ZN8TestCaseD2Ev.exit627:                         ; preds = %3757, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626, %3739, %.body253
  %.3039 = phi i8* [ %3715, %.body253 ], [ %3719, %3739 ], [ %3719, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626 ], [ %3719, %3757 ]
  %.30 = phi i32 [ %3716, %.body253 ], [ %3720, %3739 ], [ %3720, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i626 ], [ %3720, %3757 ]
  %3758 = getelementptr inbounds %"class.std::allocator.0"* %88, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3758)
  %3759 = getelementptr inbounds %"class.std::basic_string"* %450, i64 0, i32 0, i32 0
  %3760 = load i8** %3759, align 8, !tbaa !1
  %3761 = getelementptr inbounds i8* %3760, i64 -24
  %3762 = bitcast i8* %3761 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3763 = icmp eq i8* %3761, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3763, label %_ZNSsD1Ev.exit630, label %3764, !prof !7

; <label>:3764                                    ; preds = %_ZN8TestCaseD2Ev.exit627
  %3765 = getelementptr inbounds i8* %3760, i64 -8
  %3766 = bitcast i8* %3765 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3767, label %3771

; <label>:3767                                    ; preds = %3764
  %3768 = bitcast i32* %87 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3768)
  %3769 = atomicrmw volatile add i32* %3766, i32 -1 acq_rel
  store i32 %3769, i32* %87, align 4
  %3770 = load volatile i32* %87, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3768)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629

; <label>:3771                                    ; preds = %3764
  %3772 = load i32* %3766, align 4, !tbaa !8
  %3773 = add nsw i32 %3772, -1
  store i32 %3773, i32* %3766, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629: ; preds = %3771, %3767
  %.0.i.i.i.i628 = phi i32 [ %3770, %3767 ], [ %3772, %3771 ]
  %3774 = icmp slt i32 %.0.i.i.i.i628, 1
  br i1 %3774, label %3775, label %_ZNSsD1Ev.exit630

; <label>:3775                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3762, %"class.std::allocator.0"* %88) #1
  br label %_ZNSsD1Ev.exit630

_ZNSsD1Ev.exit630:                                ; preds = %3775, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629, %_ZN8TestCaseD2Ev.exit627, %3709
  %.3140 = phi i8* [ %3711, %3709 ], [ %.3039, %_ZN8TestCaseD2Ev.exit627 ], [ %.3039, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629 ], [ %.3039, %3775 ]
  %.31 = phi i32 [ %3712, %3709 ], [ %.30, %_ZN8TestCaseD2Ev.exit627 ], [ %.30, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i629 ], [ %.30, %3775 ]
  %3776 = getelementptr inbounds %"class.std::allocator.0"* %86, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3776)
  %3777 = getelementptr inbounds %"class.std::basic_string"* %448, i64 0, i32 0, i32 0
  %3778 = load i8** %3777, align 8, !tbaa !1
  %3779 = getelementptr inbounds i8* %3778, i64 -24
  %3780 = bitcast i8* %3779 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3781 = icmp eq i8* %3779, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3781, label %_ZNSsD1Ev.exit509, label %3782, !prof !7

; <label>:3782                                    ; preds = %_ZNSsD1Ev.exit630
  %3783 = getelementptr inbounds i8* %3778, i64 -8
  %3784 = bitcast i8* %3783 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3785, label %3789

; <label>:3785                                    ; preds = %3782
  %3786 = bitcast i32* %85 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3786)
  %3787 = atomicrmw volatile add i32* %3784, i32 -1 acq_rel
  store i32 %3787, i32* %85, align 4
  %3788 = load volatile i32* %85, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3786)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632

; <label>:3789                                    ; preds = %3782
  %3790 = load i32* %3784, align 4, !tbaa !8
  %3791 = add nsw i32 %3790, -1
  store i32 %3791, i32* %3784, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632: ; preds = %3789, %3785
  %.0.i.i.i.i631 = phi i32 [ %3788, %3785 ], [ %3790, %3789 ]
  %3792 = icmp slt i32 %.0.i.i.i.i631, 1
  br i1 %3792, label %3793, label %_ZNSsD1Ev.exit509

; <label>:3793                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3780, %"class.std::allocator.0"* %86) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3794                                    ; preds = %1651
  %3795 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3796 = extractvalue { i8*, i32 } %3795, 0
  %3797 = extractvalue { i8*, i32 } %3795, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3798                                    ; preds = %1652
  %3799 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3800 = extractvalue { i8*, i32 } %3799, 0
  %3801 = extractvalue { i8*, i32 } %3799, 1
  br label %_ZNSsD1Ev.exit646

; <label>:3802                                    ; preds = %1653
  %3803 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body270

.body270:                                         ; preds = %3802, %1675, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i268, %1656
  %eh.lpad-body271 = phi { i8*, i32 } [ %3803, %3802 ], [ %1657, %1675 ], [ %1657, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i268 ], [ %1657, %1656 ]
  %3804 = extractvalue { i8*, i32 } %eh.lpad-body271, 0
  %3805 = extractvalue { i8*, i32 } %eh.lpad-body271, 1
  br label %_ZN8TestCaseD2Ev.exit643

; <label>:3806                                    ; preds = %1676
  %3807 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3808 = extractvalue { i8*, i32 } %3807, 0
  %3809 = extractvalue { i8*, i32 } %3807, 1
  %3810 = getelementptr inbounds %"class.std::allocator.0"* %80, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3810)
  %3811 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 1, i32 0, i32 0
  %3812 = load i8** %3811, align 8, !tbaa !1
  %3813 = getelementptr inbounds i8* %3812, i64 -24
  %3814 = bitcast i8* %3813 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3815 = icmp eq i8* %3813, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3815, label %3828, label %3816, !prof !7

; <label>:3816                                    ; preds = %3806
  %3817 = getelementptr inbounds i8* %3812, i64 -8
  %3818 = bitcast i8* %3817 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3819, label %3823

; <label>:3819                                    ; preds = %3816
  %3820 = bitcast i32* %79 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3820)
  %3821 = atomicrmw volatile add i32* %3818, i32 -1 acq_rel
  store i32 %3821, i32* %79, align 4
  %3822 = load volatile i32* %79, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3820)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i640

; <label>:3823                                    ; preds = %3816
  %3824 = load i32* %3818, align 4, !tbaa !8
  %3825 = add nsw i32 %3824, -1
  store i32 %3825, i32* %3818, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i640

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i640: ; preds = %3823, %3819
  %.0.i.i.i.i.i639 = phi i32 [ %3822, %3819 ], [ %3824, %3823 ]
  %3826 = icmp slt i32 %.0.i.i.i.i.i639, 1
  br i1 %3826, label %3827, label %3828

; <label>:3827                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i640
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3814, %"class.std::allocator.0"* %80) #1
  br label %3828

; <label>:3828                                    ; preds = %3827, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i640, %3806
  call void @llvm.lifetime.end(i64 1, i8* %3810)
  %3829 = getelementptr inbounds %"class.std::allocator.0"* %78, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3829)
  %3830 = getelementptr inbounds %class.TestCase* %452, i64 0, i32 0, i32 0, i32 0
  %3831 = load i8** %3830, align 8, !tbaa !1
  %3832 = getelementptr inbounds i8* %3831, i64 -24
  %3833 = bitcast i8* %3832 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3834 = icmp eq i8* %3832, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3834, label %_ZN8TestCaseD2Ev.exit643, label %3835, !prof !7

; <label>:3835                                    ; preds = %3828
  %3836 = getelementptr inbounds i8* %3831, i64 -8
  %3837 = bitcast i8* %3836 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3838, label %3842

; <label>:3838                                    ; preds = %3835
  %3839 = bitcast i32* %77 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3839)
  %3840 = atomicrmw volatile add i32* %3837, i32 -1 acq_rel
  store i32 %3840, i32* %77, align 4
  %3841 = load volatile i32* %77, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3839)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642

; <label>:3842                                    ; preds = %3835
  %3843 = load i32* %3837, align 4, !tbaa !8
  %3844 = add nsw i32 %3843, -1
  store i32 %3844, i32* %3837, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642: ; preds = %3842, %3838
  %.0.i.i.i.i1.i641 = phi i32 [ %3841, %3838 ], [ %3843, %3842 ]
  %3845 = icmp slt i32 %.0.i.i.i.i1.i641, 1
  br i1 %3845, label %3846, label %_ZN8TestCaseD2Ev.exit643

; <label>:3846                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3833, %"class.std::allocator.0"* %78) #1
  br label %_ZN8TestCaseD2Ev.exit643

_ZN8TestCaseD2Ev.exit643:                         ; preds = %3846, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642, %3828, %.body270
  %.3342 = phi i8* [ %3804, %.body270 ], [ %3808, %3828 ], [ %3808, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642 ], [ %3808, %3846 ]
  %.33 = phi i32 [ %3805, %.body270 ], [ %3809, %3828 ], [ %3809, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i642 ], [ %3809, %3846 ]
  %3847 = getelementptr inbounds %"class.std::allocator.0"* %76, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3847)
  %3848 = getelementptr inbounds %"class.std::basic_string"* %455, i64 0, i32 0, i32 0
  %3849 = load i8** %3848, align 8, !tbaa !1
  %3850 = getelementptr inbounds i8* %3849, i64 -24
  %3851 = bitcast i8* %3850 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3852 = icmp eq i8* %3850, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3852, label %_ZNSsD1Ev.exit646, label %3853, !prof !7

; <label>:3853                                    ; preds = %_ZN8TestCaseD2Ev.exit643
  %3854 = getelementptr inbounds i8* %3849, i64 -8
  %3855 = bitcast i8* %3854 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3856, label %3860

; <label>:3856                                    ; preds = %3853
  %3857 = bitcast i32* %75 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3857)
  %3858 = atomicrmw volatile add i32* %3855, i32 -1 acq_rel
  store i32 %3858, i32* %75, align 4
  %3859 = load volatile i32* %75, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3857)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645

; <label>:3860                                    ; preds = %3853
  %3861 = load i32* %3855, align 4, !tbaa !8
  %3862 = add nsw i32 %3861, -1
  store i32 %3862, i32* %3855, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645: ; preds = %3860, %3856
  %.0.i.i.i.i644 = phi i32 [ %3859, %3856 ], [ %3861, %3860 ]
  %3863 = icmp slt i32 %.0.i.i.i.i644, 1
  br i1 %3863, label %3864, label %_ZNSsD1Ev.exit646

; <label>:3864                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3851, %"class.std::allocator.0"* %76) #1
  br label %_ZNSsD1Ev.exit646

_ZNSsD1Ev.exit646:                                ; preds = %3864, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645, %_ZN8TestCaseD2Ev.exit643, %3798
  %.3443 = phi i8* [ %3800, %3798 ], [ %.3342, %_ZN8TestCaseD2Ev.exit643 ], [ %.3342, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645 ], [ %.3342, %3864 ]
  %.34 = phi i32 [ %3801, %3798 ], [ %.33, %_ZN8TestCaseD2Ev.exit643 ], [ %.33, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i645 ], [ %.33, %3864 ]
  %3865 = getelementptr inbounds %"class.std::allocator.0"* %74, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3865)
  %3866 = getelementptr inbounds %"class.std::basic_string"* %453, i64 0, i32 0, i32 0
  %3867 = load i8** %3866, align 8, !tbaa !1
  %3868 = getelementptr inbounds i8* %3867, i64 -24
  %3869 = bitcast i8* %3868 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3870 = icmp eq i8* %3868, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3870, label %_ZNSsD1Ev.exit509, label %3871, !prof !7

; <label>:3871                                    ; preds = %_ZNSsD1Ev.exit646
  %3872 = getelementptr inbounds i8* %3867, i64 -8
  %3873 = bitcast i8* %3872 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3874, label %3878

; <label>:3874                                    ; preds = %3871
  %3875 = bitcast i32* %73 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3875)
  %3876 = atomicrmw volatile add i32* %3873, i32 -1 acq_rel
  store i32 %3876, i32* %73, align 4
  %3877 = load volatile i32* %73, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3875)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648

; <label>:3878                                    ; preds = %3871
  %3879 = load i32* %3873, align 4, !tbaa !8
  %3880 = add nsw i32 %3879, -1
  store i32 %3880, i32* %3873, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648: ; preds = %3878, %3874
  %.0.i.i.i.i647 = phi i32 [ %3877, %3874 ], [ %3879, %3878 ]
  %3881 = icmp slt i32 %.0.i.i.i.i647, 1
  br i1 %3881, label %3882, label %_ZNSsD1Ev.exit509

; <label>:3882                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3869, %"class.std::allocator.0"* %74) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3883                                    ; preds = %1755
  %3884 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3885 = extractvalue { i8*, i32 } %3884, 0
  %3886 = extractvalue { i8*, i32 } %3884, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3887                                    ; preds = %1756
  %3888 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3889 = extractvalue { i8*, i32 } %3888, 0
  %3890 = extractvalue { i8*, i32 } %3888, 1
  br label %_ZNSsD1Ev.exit657

; <label>:3891                                    ; preds = %1757
  %3892 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body295

.body295:                                         ; preds = %3891, %1779, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i293, %1760
  %eh.lpad-body296 = phi { i8*, i32 } [ %3892, %3891 ], [ %1761, %1779 ], [ %1761, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i293 ], [ %1761, %1760 ]
  %3893 = extractvalue { i8*, i32 } %eh.lpad-body296, 0
  %3894 = extractvalue { i8*, i32 } %eh.lpad-body296, 1
  br label %_ZN8TestCaseD2Ev.exit654

; <label>:3895                                    ; preds = %1780
  %3896 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3897 = extractvalue { i8*, i32 } %3896, 0
  %3898 = extractvalue { i8*, i32 } %3896, 1
  %3899 = getelementptr inbounds %"class.std::allocator.0"* %72, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3899)
  %3900 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 1, i32 0, i32 0
  %3901 = load i8** %3900, align 8, !tbaa !1
  %3902 = getelementptr inbounds i8* %3901, i64 -24
  %3903 = bitcast i8* %3902 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3904 = icmp eq i8* %3902, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3904, label %3917, label %3905, !prof !7

; <label>:3905                                    ; preds = %3895
  %3906 = getelementptr inbounds i8* %3901, i64 -8
  %3907 = bitcast i8* %3906 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3908, label %3912

; <label>:3908                                    ; preds = %3905
  %3909 = bitcast i32* %71 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3909)
  %3910 = atomicrmw volatile add i32* %3907, i32 -1 acq_rel
  store i32 %3910, i32* %71, align 4
  %3911 = load volatile i32* %71, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3909)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i651

; <label>:3912                                    ; preds = %3905
  %3913 = load i32* %3907, align 4, !tbaa !8
  %3914 = add nsw i32 %3913, -1
  store i32 %3914, i32* %3907, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i651

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i651: ; preds = %3912, %3908
  %.0.i.i.i.i.i650 = phi i32 [ %3911, %3908 ], [ %3913, %3912 ]
  %3915 = icmp slt i32 %.0.i.i.i.i.i650, 1
  br i1 %3915, label %3916, label %3917

; <label>:3916                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i651
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3903, %"class.std::allocator.0"* %72) #1
  br label %3917

; <label>:3917                                    ; preds = %3916, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i651, %3895
  call void @llvm.lifetime.end(i64 1, i8* %3899)
  %3918 = getelementptr inbounds %"class.std::allocator.0"* %70, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3918)
  %3919 = getelementptr inbounds %class.TestCase* %457, i64 0, i32 0, i32 0, i32 0
  %3920 = load i8** %3919, align 8, !tbaa !1
  %3921 = getelementptr inbounds i8* %3920, i64 -24
  %3922 = bitcast i8* %3921 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3923 = icmp eq i8* %3921, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3923, label %_ZN8TestCaseD2Ev.exit654, label %3924, !prof !7

; <label>:3924                                    ; preds = %3917
  %3925 = getelementptr inbounds i8* %3920, i64 -8
  %3926 = bitcast i8* %3925 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3927, label %3931

; <label>:3927                                    ; preds = %3924
  %3928 = bitcast i32* %69 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3928)
  %3929 = atomicrmw volatile add i32* %3926, i32 -1 acq_rel
  store i32 %3929, i32* %69, align 4
  %3930 = load volatile i32* %69, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3928)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653

; <label>:3931                                    ; preds = %3924
  %3932 = load i32* %3926, align 4, !tbaa !8
  %3933 = add nsw i32 %3932, -1
  store i32 %3933, i32* %3926, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653: ; preds = %3931, %3927
  %.0.i.i.i.i1.i652 = phi i32 [ %3930, %3927 ], [ %3932, %3931 ]
  %3934 = icmp slt i32 %.0.i.i.i.i1.i652, 1
  br i1 %3934, label %3935, label %_ZN8TestCaseD2Ev.exit654

; <label>:3935                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3922, %"class.std::allocator.0"* %70) #1
  br label %_ZN8TestCaseD2Ev.exit654

_ZN8TestCaseD2Ev.exit654:                         ; preds = %3935, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653, %3917, %.body295
  %.3645 = phi i8* [ %3893, %.body295 ], [ %3897, %3917 ], [ %3897, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653 ], [ %3897, %3935 ]
  %.36 = phi i32 [ %3894, %.body295 ], [ %3898, %3917 ], [ %3898, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i653 ], [ %3898, %3935 ]
  %3936 = getelementptr inbounds %"class.std::allocator.0"* %68, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3936)
  %3937 = getelementptr inbounds %"class.std::basic_string"* %460, i64 0, i32 0, i32 0
  %3938 = load i8** %3937, align 8, !tbaa !1
  %3939 = getelementptr inbounds i8* %3938, i64 -24
  %3940 = bitcast i8* %3939 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3941 = icmp eq i8* %3939, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3941, label %_ZNSsD1Ev.exit657, label %3942, !prof !7

; <label>:3942                                    ; preds = %_ZN8TestCaseD2Ev.exit654
  %3943 = getelementptr inbounds i8* %3938, i64 -8
  %3944 = bitcast i8* %3943 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3945, label %3949

; <label>:3945                                    ; preds = %3942
  %3946 = bitcast i32* %67 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3946)
  %3947 = atomicrmw volatile add i32* %3944, i32 -1 acq_rel
  store i32 %3947, i32* %67, align 4
  %3948 = load volatile i32* %67, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3946)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656

; <label>:3949                                    ; preds = %3942
  %3950 = load i32* %3944, align 4, !tbaa !8
  %3951 = add nsw i32 %3950, -1
  store i32 %3951, i32* %3944, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656: ; preds = %3949, %3945
  %.0.i.i.i.i655 = phi i32 [ %3948, %3945 ], [ %3950, %3949 ]
  %3952 = icmp slt i32 %.0.i.i.i.i655, 1
  br i1 %3952, label %3953, label %_ZNSsD1Ev.exit657

; <label>:3953                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3940, %"class.std::allocator.0"* %68) #1
  br label %_ZNSsD1Ev.exit657

_ZNSsD1Ev.exit657:                                ; preds = %3953, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656, %_ZN8TestCaseD2Ev.exit654, %3887
  %.3746 = phi i8* [ %3889, %3887 ], [ %.3645, %_ZN8TestCaseD2Ev.exit654 ], [ %.3645, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656 ], [ %.3645, %3953 ]
  %.37 = phi i32 [ %3890, %3887 ], [ %.36, %_ZN8TestCaseD2Ev.exit654 ], [ %.36, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i656 ], [ %.36, %3953 ]
  %3954 = getelementptr inbounds %"class.std::allocator.0"* %66, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3954)
  %3955 = getelementptr inbounds %"class.std::basic_string"* %458, i64 0, i32 0, i32 0
  %3956 = load i8** %3955, align 8, !tbaa !1
  %3957 = getelementptr inbounds i8* %3956, i64 -24
  %3958 = bitcast i8* %3957 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3959 = icmp eq i8* %3957, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3959, label %_ZNSsD1Ev.exit509, label %3960, !prof !7

; <label>:3960                                    ; preds = %_ZNSsD1Ev.exit657
  %3961 = getelementptr inbounds i8* %3956, i64 -8
  %3962 = bitcast i8* %3961 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3963, label %3967

; <label>:3963                                    ; preds = %3960
  %3964 = bitcast i32* %65 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3964)
  %3965 = atomicrmw volatile add i32* %3962, i32 -1 acq_rel
  store i32 %3965, i32* %65, align 4
  %3966 = load volatile i32* %65, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3964)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659

; <label>:3967                                    ; preds = %3960
  %3968 = load i32* %3962, align 4, !tbaa !8
  %3969 = add nsw i32 %3968, -1
  store i32 %3969, i32* %3962, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659: ; preds = %3967, %3963
  %.0.i.i.i.i658 = phi i32 [ %3966, %3963 ], [ %3968, %3967 ]
  %3970 = icmp slt i32 %.0.i.i.i.i658, 1
  br i1 %3970, label %3971, label %_ZNSsD1Ev.exit509

; <label>:3971                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3958, %"class.std::allocator.0"* %66) #1
  br label %_ZNSsD1Ev.exit509

; <label>:3972                                    ; preds = %1859
  %3973 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3974 = extractvalue { i8*, i32 } %3973, 0
  %3975 = extractvalue { i8*, i32 } %3973, 1
  br label %_ZNSsD1Ev.exit509

; <label>:3976                                    ; preds = %1860
  %3977 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3978 = extractvalue { i8*, i32 } %3977, 0
  %3979 = extractvalue { i8*, i32 } %3977, 1
  br label %_ZNSsD1Ev.exit671

; <label>:3980                                    ; preds = %1861
  %3981 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body312

.body312:                                         ; preds = %3980, %1883, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i310, %1864
  %eh.lpad-body313 = phi { i8*, i32 } [ %3981, %3980 ], [ %1865, %1883 ], [ %1865, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i310 ], [ %1865, %1864 ]
  %3982 = extractvalue { i8*, i32 } %eh.lpad-body313, 0
  %3983 = extractvalue { i8*, i32 } %eh.lpad-body313, 1
  br label %_ZN8TestCaseD2Ev.exit668

; <label>:3984                                    ; preds = %1884
  %3985 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %3986 = extractvalue { i8*, i32 } %3985, 0
  %3987 = extractvalue { i8*, i32 } %3985, 1
  %3988 = getelementptr inbounds %"class.std::allocator.0"* %62, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %3988)
  %3989 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 1, i32 0, i32 0
  %3990 = load i8** %3989, align 8, !tbaa !1
  %3991 = getelementptr inbounds i8* %3990, i64 -24
  %3992 = bitcast i8* %3991 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %3993 = icmp eq i8* %3991, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %3993, label %4006, label %3994, !prof !7

; <label>:3994                                    ; preds = %3984
  %3995 = getelementptr inbounds i8* %3990, i64 -8
  %3996 = bitcast i8* %3995 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %3997, label %4001

; <label>:3997                                    ; preds = %3994
  %3998 = bitcast i32* %61 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %3998)
  %3999 = atomicrmw volatile add i32* %3996, i32 -1 acq_rel
  store i32 %3999, i32* %61, align 4
  %4000 = load volatile i32* %61, align 4
  call void @llvm.lifetime.end(i64 4, i8* %3998)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i665

; <label>:4001                                    ; preds = %3994
  %4002 = load i32* %3996, align 4, !tbaa !8
  %4003 = add nsw i32 %4002, -1
  store i32 %4003, i32* %3996, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i665

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i665: ; preds = %4001, %3997
  %.0.i.i.i.i.i664 = phi i32 [ %4000, %3997 ], [ %4002, %4001 ]
  %4004 = icmp slt i32 %.0.i.i.i.i.i664, 1
  br i1 %4004, label %4005, label %4006

; <label>:4005                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i665
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %3992, %"class.std::allocator.0"* %62) #1
  br label %4006

; <label>:4006                                    ; preds = %4005, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i665, %3984
  call void @llvm.lifetime.end(i64 1, i8* %3988)
  %4007 = getelementptr inbounds %"class.std::allocator.0"* %60, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4007)
  %4008 = getelementptr inbounds %class.TestCase* %462, i64 0, i32 0, i32 0, i32 0
  %4009 = load i8** %4008, align 8, !tbaa !1
  %4010 = getelementptr inbounds i8* %4009, i64 -24
  %4011 = bitcast i8* %4010 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4012 = icmp eq i8* %4010, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4012, label %_ZN8TestCaseD2Ev.exit668, label %4013, !prof !7

; <label>:4013                                    ; preds = %4006
  %4014 = getelementptr inbounds i8* %4009, i64 -8
  %4015 = bitcast i8* %4014 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4016, label %4020

; <label>:4016                                    ; preds = %4013
  %4017 = bitcast i32* %59 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4017)
  %4018 = atomicrmw volatile add i32* %4015, i32 -1 acq_rel
  store i32 %4018, i32* %59, align 4
  %4019 = load volatile i32* %59, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4017)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667

; <label>:4020                                    ; preds = %4013
  %4021 = load i32* %4015, align 4, !tbaa !8
  %4022 = add nsw i32 %4021, -1
  store i32 %4022, i32* %4015, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667: ; preds = %4020, %4016
  %.0.i.i.i.i1.i666 = phi i32 [ %4019, %4016 ], [ %4021, %4020 ]
  %4023 = icmp slt i32 %.0.i.i.i.i1.i666, 1
  br i1 %4023, label %4024, label %_ZN8TestCaseD2Ev.exit668

; <label>:4024                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4011, %"class.std::allocator.0"* %60) #1
  br label %_ZN8TestCaseD2Ev.exit668

_ZN8TestCaseD2Ev.exit668:                         ; preds = %4024, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667, %4006, %.body312
  %.3948 = phi i8* [ %3982, %.body312 ], [ %3986, %4006 ], [ %3986, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667 ], [ %3986, %4024 ]
  %.39 = phi i32 [ %3983, %.body312 ], [ %3987, %4006 ], [ %3987, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i667 ], [ %3987, %4024 ]
  %4025 = getelementptr inbounds %"class.std::allocator.0"* %58, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4025)
  %4026 = getelementptr inbounds %"class.std::basic_string"* %465, i64 0, i32 0, i32 0
  %4027 = load i8** %4026, align 8, !tbaa !1
  %4028 = getelementptr inbounds i8* %4027, i64 -24
  %4029 = bitcast i8* %4028 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4030 = icmp eq i8* %4028, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4030, label %_ZNSsD1Ev.exit671, label %4031, !prof !7

; <label>:4031                                    ; preds = %_ZN8TestCaseD2Ev.exit668
  %4032 = getelementptr inbounds i8* %4027, i64 -8
  %4033 = bitcast i8* %4032 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4034, label %4038

; <label>:4034                                    ; preds = %4031
  %4035 = bitcast i32* %57 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4035)
  %4036 = atomicrmw volatile add i32* %4033, i32 -1 acq_rel
  store i32 %4036, i32* %57, align 4
  %4037 = load volatile i32* %57, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4035)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670

; <label>:4038                                    ; preds = %4031
  %4039 = load i32* %4033, align 4, !tbaa !8
  %4040 = add nsw i32 %4039, -1
  store i32 %4040, i32* %4033, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670: ; preds = %4038, %4034
  %.0.i.i.i.i669 = phi i32 [ %4037, %4034 ], [ %4039, %4038 ]
  %4041 = icmp slt i32 %.0.i.i.i.i669, 1
  br i1 %4041, label %4042, label %_ZNSsD1Ev.exit671

; <label>:4042                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4029, %"class.std::allocator.0"* %58) #1
  br label %_ZNSsD1Ev.exit671

_ZNSsD1Ev.exit671:                                ; preds = %4042, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670, %_ZN8TestCaseD2Ev.exit668, %3976
  %.4049 = phi i8* [ %3978, %3976 ], [ %.3948, %_ZN8TestCaseD2Ev.exit668 ], [ %.3948, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670 ], [ %.3948, %4042 ]
  %.40 = phi i32 [ %3979, %3976 ], [ %.39, %_ZN8TestCaseD2Ev.exit668 ], [ %.39, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i670 ], [ %.39, %4042 ]
  %4043 = getelementptr inbounds %"class.std::allocator.0"* %56, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4043)
  %4044 = getelementptr inbounds %"class.std::basic_string"* %463, i64 0, i32 0, i32 0
  %4045 = load i8** %4044, align 8, !tbaa !1
  %4046 = getelementptr inbounds i8* %4045, i64 -24
  %4047 = bitcast i8* %4046 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4048 = icmp eq i8* %4046, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4048, label %_ZNSsD1Ev.exit509, label %4049, !prof !7

; <label>:4049                                    ; preds = %_ZNSsD1Ev.exit671
  %4050 = getelementptr inbounds i8* %4045, i64 -8
  %4051 = bitcast i8* %4050 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4052, label %4056

; <label>:4052                                    ; preds = %4049
  %4053 = bitcast i32* %55 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4053)
  %4054 = atomicrmw volatile add i32* %4051, i32 -1 acq_rel
  store i32 %4054, i32* %55, align 4
  %4055 = load volatile i32* %55, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4053)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673

; <label>:4056                                    ; preds = %4049
  %4057 = load i32* %4051, align 4, !tbaa !8
  %4058 = add nsw i32 %4057, -1
  store i32 %4058, i32* %4051, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673: ; preds = %4056, %4052
  %.0.i.i.i.i672 = phi i32 [ %4055, %4052 ], [ %4057, %4056 ]
  %4059 = icmp slt i32 %.0.i.i.i.i672, 1
  br i1 %4059, label %4060, label %_ZNSsD1Ev.exit509

; <label>:4060                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4047, %"class.std::allocator.0"* %56) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4061                                    ; preds = %1963
  %4062 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4063 = extractvalue { i8*, i32 } %4062, 0
  %4064 = extractvalue { i8*, i32 } %4062, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4065                                    ; preds = %1964
  %4066 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4067 = extractvalue { i8*, i32 } %4066, 0
  %4068 = extractvalue { i8*, i32 } %4066, 1
  br label %_ZNSsD1Ev.exit685

; <label>:4069                                    ; preds = %1965
  %4070 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body336

.body336:                                         ; preds = %4069, %1987, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i334, %1968
  %eh.lpad-body337 = phi { i8*, i32 } [ %4070, %4069 ], [ %1969, %1987 ], [ %1969, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i334 ], [ %1969, %1968 ]
  %4071 = extractvalue { i8*, i32 } %eh.lpad-body337, 0
  %4072 = extractvalue { i8*, i32 } %eh.lpad-body337, 1
  br label %_ZN8TestCaseD2Ev.exit682

; <label>:4073                                    ; preds = %1988
  %4074 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4075 = extractvalue { i8*, i32 } %4074, 0
  %4076 = extractvalue { i8*, i32 } %4074, 1
  %4077 = getelementptr inbounds %"class.std::allocator.0"* %52, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4077)
  %4078 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 1, i32 0, i32 0
  %4079 = load i8** %4078, align 8, !tbaa !1
  %4080 = getelementptr inbounds i8* %4079, i64 -24
  %4081 = bitcast i8* %4080 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4082 = icmp eq i8* %4080, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4082, label %4095, label %4083, !prof !7

; <label>:4083                                    ; preds = %4073
  %4084 = getelementptr inbounds i8* %4079, i64 -8
  %4085 = bitcast i8* %4084 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4086, label %4090

; <label>:4086                                    ; preds = %4083
  %4087 = bitcast i32* %51 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4087)
  %4088 = atomicrmw volatile add i32* %4085, i32 -1 acq_rel
  store i32 %4088, i32* %51, align 4
  %4089 = load volatile i32* %51, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4087)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i679

; <label>:4090                                    ; preds = %4083
  %4091 = load i32* %4085, align 4, !tbaa !8
  %4092 = add nsw i32 %4091, -1
  store i32 %4092, i32* %4085, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i679

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i679: ; preds = %4090, %4086
  %.0.i.i.i.i.i678 = phi i32 [ %4089, %4086 ], [ %4091, %4090 ]
  %4093 = icmp slt i32 %.0.i.i.i.i.i678, 1
  br i1 %4093, label %4094, label %4095

; <label>:4094                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i679
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4081, %"class.std::allocator.0"* %52) #1
  br label %4095

; <label>:4095                                    ; preds = %4094, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i679, %4073
  call void @llvm.lifetime.end(i64 1, i8* %4077)
  %4096 = getelementptr inbounds %"class.std::allocator.0"* %50, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4096)
  %4097 = getelementptr inbounds %class.TestCase* %467, i64 0, i32 0, i32 0, i32 0
  %4098 = load i8** %4097, align 8, !tbaa !1
  %4099 = getelementptr inbounds i8* %4098, i64 -24
  %4100 = bitcast i8* %4099 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4101 = icmp eq i8* %4099, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4101, label %_ZN8TestCaseD2Ev.exit682, label %4102, !prof !7

; <label>:4102                                    ; preds = %4095
  %4103 = getelementptr inbounds i8* %4098, i64 -8
  %4104 = bitcast i8* %4103 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4105, label %4109

; <label>:4105                                    ; preds = %4102
  %4106 = bitcast i32* %49 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4106)
  %4107 = atomicrmw volatile add i32* %4104, i32 -1 acq_rel
  store i32 %4107, i32* %49, align 4
  %4108 = load volatile i32* %49, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4106)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681

; <label>:4109                                    ; preds = %4102
  %4110 = load i32* %4104, align 4, !tbaa !8
  %4111 = add nsw i32 %4110, -1
  store i32 %4111, i32* %4104, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681: ; preds = %4109, %4105
  %.0.i.i.i.i1.i680 = phi i32 [ %4108, %4105 ], [ %4110, %4109 ]
  %4112 = icmp slt i32 %.0.i.i.i.i1.i680, 1
  br i1 %4112, label %4113, label %_ZN8TestCaseD2Ev.exit682

; <label>:4113                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4100, %"class.std::allocator.0"* %50) #1
  br label %_ZN8TestCaseD2Ev.exit682

_ZN8TestCaseD2Ev.exit682:                         ; preds = %4113, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681, %4095, %.body336
  %.4251 = phi i8* [ %4071, %.body336 ], [ %4075, %4095 ], [ %4075, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681 ], [ %4075, %4113 ]
  %.42 = phi i32 [ %4072, %.body336 ], [ %4076, %4095 ], [ %4076, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i681 ], [ %4076, %4113 ]
  %4114 = getelementptr inbounds %"class.std::allocator.0"* %48, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4114)
  %4115 = getelementptr inbounds %"class.std::basic_string"* %470, i64 0, i32 0, i32 0
  %4116 = load i8** %4115, align 8, !tbaa !1
  %4117 = getelementptr inbounds i8* %4116, i64 -24
  %4118 = bitcast i8* %4117 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4119 = icmp eq i8* %4117, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4119, label %_ZNSsD1Ev.exit685, label %4120, !prof !7

; <label>:4120                                    ; preds = %_ZN8TestCaseD2Ev.exit682
  %4121 = getelementptr inbounds i8* %4116, i64 -8
  %4122 = bitcast i8* %4121 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4123, label %4127

; <label>:4123                                    ; preds = %4120
  %4124 = bitcast i32* %47 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4124)
  %4125 = atomicrmw volatile add i32* %4122, i32 -1 acq_rel
  store i32 %4125, i32* %47, align 4
  %4126 = load volatile i32* %47, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4124)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684

; <label>:4127                                    ; preds = %4120
  %4128 = load i32* %4122, align 4, !tbaa !8
  %4129 = add nsw i32 %4128, -1
  store i32 %4129, i32* %4122, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684: ; preds = %4127, %4123
  %.0.i.i.i.i683 = phi i32 [ %4126, %4123 ], [ %4128, %4127 ]
  %4130 = icmp slt i32 %.0.i.i.i.i683, 1
  br i1 %4130, label %4131, label %_ZNSsD1Ev.exit685

; <label>:4131                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4118, %"class.std::allocator.0"* %48) #1
  br label %_ZNSsD1Ev.exit685

_ZNSsD1Ev.exit685:                                ; preds = %4131, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684, %_ZN8TestCaseD2Ev.exit682, %4065
  %.4352 = phi i8* [ %4067, %4065 ], [ %.4251, %_ZN8TestCaseD2Ev.exit682 ], [ %.4251, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684 ], [ %.4251, %4131 ]
  %.43 = phi i32 [ %4068, %4065 ], [ %.42, %_ZN8TestCaseD2Ev.exit682 ], [ %.42, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i684 ], [ %.42, %4131 ]
  %4132 = getelementptr inbounds %"class.std::allocator.0"* %46, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4132)
  %4133 = getelementptr inbounds %"class.std::basic_string"* %468, i64 0, i32 0, i32 0
  %4134 = load i8** %4133, align 8, !tbaa !1
  %4135 = getelementptr inbounds i8* %4134, i64 -24
  %4136 = bitcast i8* %4135 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4137 = icmp eq i8* %4135, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4137, label %_ZNSsD1Ev.exit509, label %4138, !prof !7

; <label>:4138                                    ; preds = %_ZNSsD1Ev.exit685
  %4139 = getelementptr inbounds i8* %4134, i64 -8
  %4140 = bitcast i8* %4139 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4141, label %4145

; <label>:4141                                    ; preds = %4138
  %4142 = bitcast i32* %45 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4142)
  %4143 = atomicrmw volatile add i32* %4140, i32 -1 acq_rel
  store i32 %4143, i32* %45, align 4
  %4144 = load volatile i32* %45, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4142)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687

; <label>:4145                                    ; preds = %4138
  %4146 = load i32* %4140, align 4, !tbaa !8
  %4147 = add nsw i32 %4146, -1
  store i32 %4147, i32* %4140, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687: ; preds = %4145, %4141
  %.0.i.i.i.i686 = phi i32 [ %4144, %4141 ], [ %4146, %4145 ]
  %4148 = icmp slt i32 %.0.i.i.i.i686, 1
  br i1 %4148, label %4149, label %_ZNSsD1Ev.exit509

; <label>:4149                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4136, %"class.std::allocator.0"* %46) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4150                                    ; preds = %2067
  %4151 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4152 = extractvalue { i8*, i32 } %4151, 0
  %4153 = extractvalue { i8*, i32 } %4151, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4154                                    ; preds = %2068
  %4155 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4156 = extractvalue { i8*, i32 } %4155, 0
  %4157 = extractvalue { i8*, i32 } %4155, 1
  br label %_ZNSsD1Ev.exit701

; <label>:4158                                    ; preds = %2069
  %4159 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body353

.body353:                                         ; preds = %4158, %2091, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i351, %2072
  %eh.lpad-body354 = phi { i8*, i32 } [ %4159, %4158 ], [ %2073, %2091 ], [ %2073, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i351 ], [ %2073, %2072 ]
  %4160 = extractvalue { i8*, i32 } %eh.lpad-body354, 0
  %4161 = extractvalue { i8*, i32 } %eh.lpad-body354, 1
  br label %_ZN8TestCaseD2Ev.exit698

; <label>:4162                                    ; preds = %2092
  %4163 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4164 = extractvalue { i8*, i32 } %4163, 0
  %4165 = extractvalue { i8*, i32 } %4163, 1
  %4166 = getelementptr inbounds %"class.std::allocator.0"* %40, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4166)
  %4167 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 1, i32 0, i32 0
  %4168 = load i8** %4167, align 8, !tbaa !1
  %4169 = getelementptr inbounds i8* %4168, i64 -24
  %4170 = bitcast i8* %4169 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4171 = icmp eq i8* %4169, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4171, label %4184, label %4172, !prof !7

; <label>:4172                                    ; preds = %4162
  %4173 = getelementptr inbounds i8* %4168, i64 -8
  %4174 = bitcast i8* %4173 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4175, label %4179

; <label>:4175                                    ; preds = %4172
  %4176 = bitcast i32* %39 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4176)
  %4177 = atomicrmw volatile add i32* %4174, i32 -1 acq_rel
  store i32 %4177, i32* %39, align 4
  %4178 = load volatile i32* %39, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4176)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i695

; <label>:4179                                    ; preds = %4172
  %4180 = load i32* %4174, align 4, !tbaa !8
  %4181 = add nsw i32 %4180, -1
  store i32 %4181, i32* %4174, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i695

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i695: ; preds = %4179, %4175
  %.0.i.i.i.i.i694 = phi i32 [ %4178, %4175 ], [ %4180, %4179 ]
  %4182 = icmp slt i32 %.0.i.i.i.i.i694, 1
  br i1 %4182, label %4183, label %4184

; <label>:4183                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i695
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4170, %"class.std::allocator.0"* %40) #1
  br label %4184

; <label>:4184                                    ; preds = %4183, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i695, %4162
  call void @llvm.lifetime.end(i64 1, i8* %4166)
  %4185 = getelementptr inbounds %"class.std::allocator.0"* %38, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4185)
  %4186 = getelementptr inbounds %class.TestCase* %472, i64 0, i32 0, i32 0, i32 0
  %4187 = load i8** %4186, align 8, !tbaa !1
  %4188 = getelementptr inbounds i8* %4187, i64 -24
  %4189 = bitcast i8* %4188 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4190 = icmp eq i8* %4188, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4190, label %_ZN8TestCaseD2Ev.exit698, label %4191, !prof !7

; <label>:4191                                    ; preds = %4184
  %4192 = getelementptr inbounds i8* %4187, i64 -8
  %4193 = bitcast i8* %4192 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4194, label %4198

; <label>:4194                                    ; preds = %4191
  %4195 = bitcast i32* %37 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4195)
  %4196 = atomicrmw volatile add i32* %4193, i32 -1 acq_rel
  store i32 %4196, i32* %37, align 4
  %4197 = load volatile i32* %37, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4195)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697

; <label>:4198                                    ; preds = %4191
  %4199 = load i32* %4193, align 4, !tbaa !8
  %4200 = add nsw i32 %4199, -1
  store i32 %4200, i32* %4193, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697: ; preds = %4198, %4194
  %.0.i.i.i.i1.i696 = phi i32 [ %4197, %4194 ], [ %4199, %4198 ]
  %4201 = icmp slt i32 %.0.i.i.i.i1.i696, 1
  br i1 %4201, label %4202, label %_ZN8TestCaseD2Ev.exit698

; <label>:4202                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4189, %"class.std::allocator.0"* %38) #1
  br label %_ZN8TestCaseD2Ev.exit698

_ZN8TestCaseD2Ev.exit698:                         ; preds = %4202, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697, %4184, %.body353
  %.4554 = phi i8* [ %4160, %.body353 ], [ %4164, %4184 ], [ %4164, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697 ], [ %4164, %4202 ]
  %.45 = phi i32 [ %4161, %.body353 ], [ %4165, %4184 ], [ %4165, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i697 ], [ %4165, %4202 ]
  %4203 = getelementptr inbounds %"class.std::allocator.0"* %36, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4203)
  %4204 = getelementptr inbounds %"class.std::basic_string"* %475, i64 0, i32 0, i32 0
  %4205 = load i8** %4204, align 8, !tbaa !1
  %4206 = getelementptr inbounds i8* %4205, i64 -24
  %4207 = bitcast i8* %4206 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4208 = icmp eq i8* %4206, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4208, label %_ZNSsD1Ev.exit701, label %4209, !prof !7

; <label>:4209                                    ; preds = %_ZN8TestCaseD2Ev.exit698
  %4210 = getelementptr inbounds i8* %4205, i64 -8
  %4211 = bitcast i8* %4210 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4212, label %4216

; <label>:4212                                    ; preds = %4209
  %4213 = bitcast i32* %35 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4213)
  %4214 = atomicrmw volatile add i32* %4211, i32 -1 acq_rel
  store i32 %4214, i32* %35, align 4
  %4215 = load volatile i32* %35, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4213)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700

; <label>:4216                                    ; preds = %4209
  %4217 = load i32* %4211, align 4, !tbaa !8
  %4218 = add nsw i32 %4217, -1
  store i32 %4218, i32* %4211, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700: ; preds = %4216, %4212
  %.0.i.i.i.i699 = phi i32 [ %4215, %4212 ], [ %4217, %4216 ]
  %4219 = icmp slt i32 %.0.i.i.i.i699, 1
  br i1 %4219, label %4220, label %_ZNSsD1Ev.exit701

; <label>:4220                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4207, %"class.std::allocator.0"* %36) #1
  br label %_ZNSsD1Ev.exit701

_ZNSsD1Ev.exit701:                                ; preds = %4220, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700, %_ZN8TestCaseD2Ev.exit698, %4154
  %.4655 = phi i8* [ %4156, %4154 ], [ %.4554, %_ZN8TestCaseD2Ev.exit698 ], [ %.4554, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700 ], [ %.4554, %4220 ]
  %.46 = phi i32 [ %4157, %4154 ], [ %.45, %_ZN8TestCaseD2Ev.exit698 ], [ %.45, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i700 ], [ %.45, %4220 ]
  %4221 = getelementptr inbounds %"class.std::allocator.0"* %34, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4221)
  %4222 = getelementptr inbounds %"class.std::basic_string"* %473, i64 0, i32 0, i32 0
  %4223 = load i8** %4222, align 8, !tbaa !1
  %4224 = getelementptr inbounds i8* %4223, i64 -24
  %4225 = bitcast i8* %4224 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4226 = icmp eq i8* %4224, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4226, label %_ZNSsD1Ev.exit509, label %4227, !prof !7

; <label>:4227                                    ; preds = %_ZNSsD1Ev.exit701
  %4228 = getelementptr inbounds i8* %4223, i64 -8
  %4229 = bitcast i8* %4228 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4230, label %4234

; <label>:4230                                    ; preds = %4227
  %4231 = bitcast i32* %33 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4231)
  %4232 = atomicrmw volatile add i32* %4229, i32 -1 acq_rel
  store i32 %4232, i32* %33, align 4
  %4233 = load volatile i32* %33, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4231)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703

; <label>:4234                                    ; preds = %4227
  %4235 = load i32* %4229, align 4, !tbaa !8
  %4236 = add nsw i32 %4235, -1
  store i32 %4236, i32* %4229, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703: ; preds = %4234, %4230
  %.0.i.i.i.i702 = phi i32 [ %4233, %4230 ], [ %4235, %4234 ]
  %4237 = icmp slt i32 %.0.i.i.i.i702, 1
  br i1 %4237, label %4238, label %_ZNSsD1Ev.exit509

; <label>:4238                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4225, %"class.std::allocator.0"* %34) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4239                                    ; preds = %2171
  %4240 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4241 = extractvalue { i8*, i32 } %4240, 0
  %4242 = extractvalue { i8*, i32 } %4240, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4243                                    ; preds = %2172
  %4244 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4245 = extractvalue { i8*, i32 } %4244, 0
  %4246 = extractvalue { i8*, i32 } %4244, 1
  br label %_ZNSsD1Ev.exit712

; <label>:4247                                    ; preds = %2173
  %4248 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body372

.body372:                                         ; preds = %4247, %2195, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i370, %2176
  %eh.lpad-body373 = phi { i8*, i32 } [ %4248, %4247 ], [ %2177, %2195 ], [ %2177, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i370 ], [ %2177, %2176 ]
  %4249 = extractvalue { i8*, i32 } %eh.lpad-body373, 0
  %4250 = extractvalue { i8*, i32 } %eh.lpad-body373, 1
  br label %_ZN8TestCaseD2Ev.exit709

; <label>:4251                                    ; preds = %2196
  %4252 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4253 = extractvalue { i8*, i32 } %4252, 0
  %4254 = extractvalue { i8*, i32 } %4252, 1
  %4255 = getelementptr inbounds %"class.std::allocator.0"* %32, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4255)
  %4256 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 1, i32 0, i32 0
  %4257 = load i8** %4256, align 8, !tbaa !1
  %4258 = getelementptr inbounds i8* %4257, i64 -24
  %4259 = bitcast i8* %4258 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4260 = icmp eq i8* %4258, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4260, label %4273, label %4261, !prof !7

; <label>:4261                                    ; preds = %4251
  %4262 = getelementptr inbounds i8* %4257, i64 -8
  %4263 = bitcast i8* %4262 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4264, label %4268

; <label>:4264                                    ; preds = %4261
  %4265 = bitcast i32* %31 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4265)
  %4266 = atomicrmw volatile add i32* %4263, i32 -1 acq_rel
  store i32 %4266, i32* %31, align 4
  %4267 = load volatile i32* %31, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4265)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i706

; <label>:4268                                    ; preds = %4261
  %4269 = load i32* %4263, align 4, !tbaa !8
  %4270 = add nsw i32 %4269, -1
  store i32 %4270, i32* %4263, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i706

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i706: ; preds = %4268, %4264
  %.0.i.i.i.i.i705 = phi i32 [ %4267, %4264 ], [ %4269, %4268 ]
  %4271 = icmp slt i32 %.0.i.i.i.i.i705, 1
  br i1 %4271, label %4272, label %4273

; <label>:4272                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i706
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4259, %"class.std::allocator.0"* %32) #1
  br label %4273

; <label>:4273                                    ; preds = %4272, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i706, %4251
  call void @llvm.lifetime.end(i64 1, i8* %4255)
  %4274 = getelementptr inbounds %"class.std::allocator.0"* %30, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4274)
  %4275 = getelementptr inbounds %class.TestCase* %477, i64 0, i32 0, i32 0, i32 0
  %4276 = load i8** %4275, align 8, !tbaa !1
  %4277 = getelementptr inbounds i8* %4276, i64 -24
  %4278 = bitcast i8* %4277 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4279 = icmp eq i8* %4277, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4279, label %_ZN8TestCaseD2Ev.exit709, label %4280, !prof !7

; <label>:4280                                    ; preds = %4273
  %4281 = getelementptr inbounds i8* %4276, i64 -8
  %4282 = bitcast i8* %4281 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4283, label %4287

; <label>:4283                                    ; preds = %4280
  %4284 = bitcast i32* %29 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4284)
  %4285 = atomicrmw volatile add i32* %4282, i32 -1 acq_rel
  store i32 %4285, i32* %29, align 4
  %4286 = load volatile i32* %29, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4284)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708

; <label>:4287                                    ; preds = %4280
  %4288 = load i32* %4282, align 4, !tbaa !8
  %4289 = add nsw i32 %4288, -1
  store i32 %4289, i32* %4282, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708: ; preds = %4287, %4283
  %.0.i.i.i.i1.i707 = phi i32 [ %4286, %4283 ], [ %4288, %4287 ]
  %4290 = icmp slt i32 %.0.i.i.i.i1.i707, 1
  br i1 %4290, label %4291, label %_ZN8TestCaseD2Ev.exit709

; <label>:4291                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4278, %"class.std::allocator.0"* %30) #1
  br label %_ZN8TestCaseD2Ev.exit709

_ZN8TestCaseD2Ev.exit709:                         ; preds = %4291, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708, %4273, %.body372
  %.4857 = phi i8* [ %4249, %.body372 ], [ %4253, %4273 ], [ %4253, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708 ], [ %4253, %4291 ]
  %.48 = phi i32 [ %4250, %.body372 ], [ %4254, %4273 ], [ %4254, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i708 ], [ %4254, %4291 ]
  %4292 = getelementptr inbounds %"class.std::allocator.0"* %28, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4292)
  %4293 = getelementptr inbounds %"class.std::basic_string"* %480, i64 0, i32 0, i32 0
  %4294 = load i8** %4293, align 8, !tbaa !1
  %4295 = getelementptr inbounds i8* %4294, i64 -24
  %4296 = bitcast i8* %4295 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4297 = icmp eq i8* %4295, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4297, label %_ZNSsD1Ev.exit712, label %4298, !prof !7

; <label>:4298                                    ; preds = %_ZN8TestCaseD2Ev.exit709
  %4299 = getelementptr inbounds i8* %4294, i64 -8
  %4300 = bitcast i8* %4299 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4301, label %4305

; <label>:4301                                    ; preds = %4298
  %4302 = bitcast i32* %27 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4302)
  %4303 = atomicrmw volatile add i32* %4300, i32 -1 acq_rel
  store i32 %4303, i32* %27, align 4
  %4304 = load volatile i32* %27, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4302)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711

; <label>:4305                                    ; preds = %4298
  %4306 = load i32* %4300, align 4, !tbaa !8
  %4307 = add nsw i32 %4306, -1
  store i32 %4307, i32* %4300, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711: ; preds = %4305, %4301
  %.0.i.i.i.i710 = phi i32 [ %4304, %4301 ], [ %4306, %4305 ]
  %4308 = icmp slt i32 %.0.i.i.i.i710, 1
  br i1 %4308, label %4309, label %_ZNSsD1Ev.exit712

; <label>:4309                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4296, %"class.std::allocator.0"* %28) #1
  br label %_ZNSsD1Ev.exit712

_ZNSsD1Ev.exit712:                                ; preds = %4309, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711, %_ZN8TestCaseD2Ev.exit709, %4243
  %.4958 = phi i8* [ %4245, %4243 ], [ %.4857, %_ZN8TestCaseD2Ev.exit709 ], [ %.4857, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711 ], [ %.4857, %4309 ]
  %.49 = phi i32 [ %4246, %4243 ], [ %.48, %_ZN8TestCaseD2Ev.exit709 ], [ %.48, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i711 ], [ %.48, %4309 ]
  %4310 = getelementptr inbounds %"class.std::allocator.0"* %26, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4310)
  %4311 = getelementptr inbounds %"class.std::basic_string"* %478, i64 0, i32 0, i32 0
  %4312 = load i8** %4311, align 8, !tbaa !1
  %4313 = getelementptr inbounds i8* %4312, i64 -24
  %4314 = bitcast i8* %4313 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4315 = icmp eq i8* %4313, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4315, label %_ZNSsD1Ev.exit509, label %4316, !prof !7

; <label>:4316                                    ; preds = %_ZNSsD1Ev.exit712
  %4317 = getelementptr inbounds i8* %4312, i64 -8
  %4318 = bitcast i8* %4317 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4319, label %4323

; <label>:4319                                    ; preds = %4316
  %4320 = bitcast i32* %25 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4320)
  %4321 = atomicrmw volatile add i32* %4318, i32 -1 acq_rel
  store i32 %4321, i32* %25, align 4
  %4322 = load volatile i32* %25, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4320)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714

; <label>:4323                                    ; preds = %4316
  %4324 = load i32* %4318, align 4, !tbaa !8
  %4325 = add nsw i32 %4324, -1
  store i32 %4325, i32* %4318, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714: ; preds = %4323, %4319
  %.0.i.i.i.i713 = phi i32 [ %4322, %4319 ], [ %4324, %4323 ]
  %4326 = icmp slt i32 %.0.i.i.i.i713, 1
  br i1 %4326, label %4327, label %_ZNSsD1Ev.exit509

; <label>:4327                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4314, %"class.std::allocator.0"* %26) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4328                                    ; preds = %2275
  %4329 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4330 = extractvalue { i8*, i32 } %4329, 0
  %4331 = extractvalue { i8*, i32 } %4329, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4332                                    ; preds = %2276
  %4333 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4334 = extractvalue { i8*, i32 } %4333, 0
  %4335 = extractvalue { i8*, i32 } %4333, 1
  br label %_ZNSsD1Ev.exit726

; <label>:4336                                    ; preds = %2277
  %4337 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body391

.body391:                                         ; preds = %4336, %2299, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i389, %2280
  %eh.lpad-body392 = phi { i8*, i32 } [ %4337, %4336 ], [ %2281, %2299 ], [ %2281, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i389 ], [ %2281, %2280 ]
  %4338 = extractvalue { i8*, i32 } %eh.lpad-body392, 0
  %4339 = extractvalue { i8*, i32 } %eh.lpad-body392, 1
  br label %_ZN8TestCaseD2Ev.exit723

; <label>:4340                                    ; preds = %2300
  %4341 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4342 = extractvalue { i8*, i32 } %4341, 0
  %4343 = extractvalue { i8*, i32 } %4341, 1
  %4344 = getelementptr inbounds %"class.std::allocator.0"* %22, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4344)
  %4345 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 1, i32 0, i32 0
  %4346 = load i8** %4345, align 8, !tbaa !1
  %4347 = getelementptr inbounds i8* %4346, i64 -24
  %4348 = bitcast i8* %4347 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4349 = icmp eq i8* %4347, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4349, label %4362, label %4350, !prof !7

; <label>:4350                                    ; preds = %4340
  %4351 = getelementptr inbounds i8* %4346, i64 -8
  %4352 = bitcast i8* %4351 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4353, label %4357

; <label>:4353                                    ; preds = %4350
  %4354 = bitcast i32* %21 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4354)
  %4355 = atomicrmw volatile add i32* %4352, i32 -1 acq_rel
  store i32 %4355, i32* %21, align 4
  %4356 = load volatile i32* %21, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4354)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i720

; <label>:4357                                    ; preds = %4350
  %4358 = load i32* %4352, align 4, !tbaa !8
  %4359 = add nsw i32 %4358, -1
  store i32 %4359, i32* %4352, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i720

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i720: ; preds = %4357, %4353
  %.0.i.i.i.i.i719 = phi i32 [ %4356, %4353 ], [ %4358, %4357 ]
  %4360 = icmp slt i32 %.0.i.i.i.i.i719, 1
  br i1 %4360, label %4361, label %4362

; <label>:4361                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i720
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4348, %"class.std::allocator.0"* %22) #1
  br label %4362

; <label>:4362                                    ; preds = %4361, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i720, %4340
  call void @llvm.lifetime.end(i64 1, i8* %4344)
  %4363 = getelementptr inbounds %"class.std::allocator.0"* %20, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4363)
  %4364 = getelementptr inbounds %class.TestCase* %482, i64 0, i32 0, i32 0, i32 0
  %4365 = load i8** %4364, align 8, !tbaa !1
  %4366 = getelementptr inbounds i8* %4365, i64 -24
  %4367 = bitcast i8* %4366 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4368 = icmp eq i8* %4366, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4368, label %_ZN8TestCaseD2Ev.exit723, label %4369, !prof !7

; <label>:4369                                    ; preds = %4362
  %4370 = getelementptr inbounds i8* %4365, i64 -8
  %4371 = bitcast i8* %4370 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4372, label %4376

; <label>:4372                                    ; preds = %4369
  %4373 = bitcast i32* %19 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4373)
  %4374 = atomicrmw volatile add i32* %4371, i32 -1 acq_rel
  store i32 %4374, i32* %19, align 4
  %4375 = load volatile i32* %19, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4373)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722

; <label>:4376                                    ; preds = %4369
  %4377 = load i32* %4371, align 4, !tbaa !8
  %4378 = add nsw i32 %4377, -1
  store i32 %4378, i32* %4371, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722: ; preds = %4376, %4372
  %.0.i.i.i.i1.i721 = phi i32 [ %4375, %4372 ], [ %4377, %4376 ]
  %4379 = icmp slt i32 %.0.i.i.i.i1.i721, 1
  br i1 %4379, label %4380, label %_ZN8TestCaseD2Ev.exit723

; <label>:4380                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4367, %"class.std::allocator.0"* %20) #1
  br label %_ZN8TestCaseD2Ev.exit723

_ZN8TestCaseD2Ev.exit723:                         ; preds = %4380, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722, %4362, %.body391
  %.5160 = phi i8* [ %4338, %.body391 ], [ %4342, %4362 ], [ %4342, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722 ], [ %4342, %4380 ]
  %.51 = phi i32 [ %4339, %.body391 ], [ %4343, %4362 ], [ %4343, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i722 ], [ %4343, %4380 ]
  %4381 = getelementptr inbounds %"class.std::allocator.0"* %18, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4381)
  %4382 = getelementptr inbounds %"class.std::basic_string"* %485, i64 0, i32 0, i32 0
  %4383 = load i8** %4382, align 8, !tbaa !1
  %4384 = getelementptr inbounds i8* %4383, i64 -24
  %4385 = bitcast i8* %4384 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4386 = icmp eq i8* %4384, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4386, label %_ZNSsD1Ev.exit726, label %4387, !prof !7

; <label>:4387                                    ; preds = %_ZN8TestCaseD2Ev.exit723
  %4388 = getelementptr inbounds i8* %4383, i64 -8
  %4389 = bitcast i8* %4388 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4390, label %4394

; <label>:4390                                    ; preds = %4387
  %4391 = bitcast i32* %17 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4391)
  %4392 = atomicrmw volatile add i32* %4389, i32 -1 acq_rel
  store i32 %4392, i32* %17, align 4
  %4393 = load volatile i32* %17, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4391)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725

; <label>:4394                                    ; preds = %4387
  %4395 = load i32* %4389, align 4, !tbaa !8
  %4396 = add nsw i32 %4395, -1
  store i32 %4396, i32* %4389, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725: ; preds = %4394, %4390
  %.0.i.i.i.i724 = phi i32 [ %4393, %4390 ], [ %4395, %4394 ]
  %4397 = icmp slt i32 %.0.i.i.i.i724, 1
  br i1 %4397, label %4398, label %_ZNSsD1Ev.exit726

; <label>:4398                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4385, %"class.std::allocator.0"* %18) #1
  br label %_ZNSsD1Ev.exit726

_ZNSsD1Ev.exit726:                                ; preds = %4398, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725, %_ZN8TestCaseD2Ev.exit723, %4332
  %.5261 = phi i8* [ %4334, %4332 ], [ %.5160, %_ZN8TestCaseD2Ev.exit723 ], [ %.5160, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725 ], [ %.5160, %4398 ]
  %.52 = phi i32 [ %4335, %4332 ], [ %.51, %_ZN8TestCaseD2Ev.exit723 ], [ %.51, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i725 ], [ %.51, %4398 ]
  %4399 = getelementptr inbounds %"class.std::allocator.0"* %16, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4399)
  %4400 = getelementptr inbounds %"class.std::basic_string"* %483, i64 0, i32 0, i32 0
  %4401 = load i8** %4400, align 8, !tbaa !1
  %4402 = getelementptr inbounds i8* %4401, i64 -24
  %4403 = bitcast i8* %4402 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4404 = icmp eq i8* %4402, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4404, label %_ZNSsD1Ev.exit509, label %4405, !prof !7

; <label>:4405                                    ; preds = %_ZNSsD1Ev.exit726
  %4406 = getelementptr inbounds i8* %4401, i64 -8
  %4407 = bitcast i8* %4406 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4408, label %4412

; <label>:4408                                    ; preds = %4405
  %4409 = bitcast i32* %15 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4409)
  %4410 = atomicrmw volatile add i32* %4407, i32 -1 acq_rel
  store i32 %4410, i32* %15, align 4
  %4411 = load volatile i32* %15, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4409)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728

; <label>:4412                                    ; preds = %4405
  %4413 = load i32* %4407, align 4, !tbaa !8
  %4414 = add nsw i32 %4413, -1
  store i32 %4414, i32* %4407, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728: ; preds = %4412, %4408
  %.0.i.i.i.i727 = phi i32 [ %4411, %4408 ], [ %4413, %4412 ]
  %4415 = icmp slt i32 %.0.i.i.i.i727, 1
  br i1 %4415, label %4416, label %_ZNSsD1Ev.exit509

; <label>:4416                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4403, %"class.std::allocator.0"* %16) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4417                                    ; preds = %2379
  %4418 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4419 = extractvalue { i8*, i32 } %4418, 0
  %4420 = extractvalue { i8*, i32 } %4418, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4421                                    ; preds = %2380
  %4422 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4423 = extractvalue { i8*, i32 } %4422, 0
  %4424 = extractvalue { i8*, i32 } %4422, 1
  br label %_ZNSsD1Ev.exit740

; <label>:4425                                    ; preds = %2381
  %4426 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body408

.body408:                                         ; preds = %4425, %2403, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i406, %2384
  %eh.lpad-body409 = phi { i8*, i32 } [ %4426, %4425 ], [ %2385, %2403 ], [ %2385, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i406 ], [ %2385, %2384 ]
  %4427 = extractvalue { i8*, i32 } %eh.lpad-body409, 0
  %4428 = extractvalue { i8*, i32 } %eh.lpad-body409, 1
  br label %_ZN8TestCaseD2Ev.exit737

; <label>:4429                                    ; preds = %2404
  %4430 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4431 = extractvalue { i8*, i32 } %4430, 0
  %4432 = extractvalue { i8*, i32 } %4430, 1
  %4433 = getelementptr inbounds %"class.std::allocator.0"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4433)
  %4434 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 1, i32 0, i32 0
  %4435 = load i8** %4434, align 8, !tbaa !1
  %4436 = getelementptr inbounds i8* %4435, i64 -24
  %4437 = bitcast i8* %4436 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4438 = icmp eq i8* %4436, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4438, label %4451, label %4439, !prof !7

; <label>:4439                                    ; preds = %4429
  %4440 = getelementptr inbounds i8* %4435, i64 -8
  %4441 = bitcast i8* %4440 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4442, label %4446

; <label>:4442                                    ; preds = %4439
  %4443 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4443)
  %4444 = atomicrmw volatile add i32* %4441, i32 -1 acq_rel
  store i32 %4444, i32* %11, align 4
  %4445 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4443)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i734

; <label>:4446                                    ; preds = %4439
  %4447 = load i32* %4441, align 4, !tbaa !8
  %4448 = add nsw i32 %4447, -1
  store i32 %4448, i32* %4441, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i734

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i734: ; preds = %4446, %4442
  %.0.i.i.i.i.i733 = phi i32 [ %4445, %4442 ], [ %4447, %4446 ]
  %4449 = icmp slt i32 %.0.i.i.i.i.i733, 1
  br i1 %4449, label %4450, label %4451

; <label>:4450                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i734
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4437, %"class.std::allocator.0"* %12) #1
  br label %4451

; <label>:4451                                    ; preds = %4450, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i734, %4429
  call void @llvm.lifetime.end(i64 1, i8* %4433)
  %4452 = getelementptr inbounds %"class.std::allocator.0"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4452)
  %4453 = getelementptr inbounds %class.TestCase* %487, i64 0, i32 0, i32 0, i32 0
  %4454 = load i8** %4453, align 8, !tbaa !1
  %4455 = getelementptr inbounds i8* %4454, i64 -24
  %4456 = bitcast i8* %4455 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4457 = icmp eq i8* %4455, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4457, label %_ZN8TestCaseD2Ev.exit737, label %4458, !prof !7

; <label>:4458                                    ; preds = %4451
  %4459 = getelementptr inbounds i8* %4454, i64 -8
  %4460 = bitcast i8* %4459 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4461, label %4465

; <label>:4461                                    ; preds = %4458
  %4462 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4462)
  %4463 = atomicrmw volatile add i32* %4460, i32 -1 acq_rel
  store i32 %4463, i32* %9, align 4
  %4464 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4462)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736

; <label>:4465                                    ; preds = %4458
  %4466 = load i32* %4460, align 4, !tbaa !8
  %4467 = add nsw i32 %4466, -1
  store i32 %4467, i32* %4460, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736: ; preds = %4465, %4461
  %.0.i.i.i.i1.i735 = phi i32 [ %4464, %4461 ], [ %4466, %4465 ]
  %4468 = icmp slt i32 %.0.i.i.i.i1.i735, 1
  br i1 %4468, label %4469, label %_ZN8TestCaseD2Ev.exit737

; <label>:4469                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4456, %"class.std::allocator.0"* %10) #1
  br label %_ZN8TestCaseD2Ev.exit737

_ZN8TestCaseD2Ev.exit737:                         ; preds = %4469, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736, %4451, %.body408
  %.5463 = phi i8* [ %4427, %.body408 ], [ %4431, %4451 ], [ %4431, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736 ], [ %4431, %4469 ]
  %.54 = phi i32 [ %4428, %.body408 ], [ %4432, %4451 ], [ %4432, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i736 ], [ %4432, %4469 ]
  %4470 = getelementptr inbounds %"class.std::allocator.0"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4470)
  %4471 = getelementptr inbounds %"class.std::basic_string"* %490, i64 0, i32 0, i32 0
  %4472 = load i8** %4471, align 8, !tbaa !1
  %4473 = getelementptr inbounds i8* %4472, i64 -24
  %4474 = bitcast i8* %4473 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4475 = icmp eq i8* %4473, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4475, label %_ZNSsD1Ev.exit740, label %4476, !prof !7

; <label>:4476                                    ; preds = %_ZN8TestCaseD2Ev.exit737
  %4477 = getelementptr inbounds i8* %4472, i64 -8
  %4478 = bitcast i8* %4477 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4479, label %4483

; <label>:4479                                    ; preds = %4476
  %4480 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4480)
  %4481 = atomicrmw volatile add i32* %4478, i32 -1 acq_rel
  store i32 %4481, i32* %7, align 4
  %4482 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4480)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739

; <label>:4483                                    ; preds = %4476
  %4484 = load i32* %4478, align 4, !tbaa !8
  %4485 = add nsw i32 %4484, -1
  store i32 %4485, i32* %4478, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739: ; preds = %4483, %4479
  %.0.i.i.i.i738 = phi i32 [ %4482, %4479 ], [ %4484, %4483 ]
  %4486 = icmp slt i32 %.0.i.i.i.i738, 1
  br i1 %4486, label %4487, label %_ZNSsD1Ev.exit740

; <label>:4487                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4474, %"class.std::allocator.0"* %8) #1
  br label %_ZNSsD1Ev.exit740

_ZNSsD1Ev.exit740:                                ; preds = %4487, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739, %_ZN8TestCaseD2Ev.exit737, %4421
  %.5564 = phi i8* [ %4423, %4421 ], [ %.5463, %_ZN8TestCaseD2Ev.exit737 ], [ %.5463, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739 ], [ %.5463, %4487 ]
  %.55 = phi i32 [ %4424, %4421 ], [ %.54, %_ZN8TestCaseD2Ev.exit737 ], [ %.54, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i739 ], [ %.54, %4487 ]
  %4488 = getelementptr inbounds %"class.std::allocator.0"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4488)
  %4489 = getelementptr inbounds %"class.std::basic_string"* %488, i64 0, i32 0, i32 0
  %4490 = load i8** %4489, align 8, !tbaa !1
  %4491 = getelementptr inbounds i8* %4490, i64 -24
  %4492 = bitcast i8* %4491 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4493 = icmp eq i8* %4491, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4493, label %_ZNSsD1Ev.exit509, label %4494, !prof !7

; <label>:4494                                    ; preds = %_ZNSsD1Ev.exit740
  %4495 = getelementptr inbounds i8* %4490, i64 -8
  %4496 = bitcast i8* %4495 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4497, label %4501

; <label>:4497                                    ; preds = %4494
  %4498 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4498)
  %4499 = atomicrmw volatile add i32* %4496, i32 -1 acq_rel
  store i32 %4499, i32* %5, align 4
  %4500 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4498)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742

; <label>:4501                                    ; preds = %4494
  %4502 = load i32* %4496, align 4, !tbaa !8
  %4503 = add nsw i32 %4502, -1
  store i32 %4503, i32* %4496, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742: ; preds = %4501, %4497
  %.0.i.i.i.i741 = phi i32 [ %4500, %4497 ], [ %4502, %4501 ]
  %4504 = icmp slt i32 %.0.i.i.i.i741, 1
  br i1 %4504, label %4505, label %_ZNSsD1Ev.exit509

; <label>:4505                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4492, %"class.std::allocator.0"* %6) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4506                                    ; preds = %2483
  %4507 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4508 = extractvalue { i8*, i32 } %4507, 0
  %4509 = extractvalue { i8*, i32 } %4507, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4510                                    ; preds = %2484
  %4511 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4512 = extractvalue { i8*, i32 } %4511, 0
  %4513 = extractvalue { i8*, i32 } %4511, 1
  br label %_ZNSsD1Ev.exit732

; <label>:4514                                    ; preds = %2485
  %4515 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body433

.body433:                                         ; preds = %4514, %2507, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i431, %2488
  %eh.lpad-body434 = phi { i8*, i32 } [ %4515, %4514 ], [ %2489, %2507 ], [ %2489, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i431 ], [ %2489, %2488 ]
  %4516 = extractvalue { i8*, i32 } %eh.lpad-body434, 0
  %4517 = extractvalue { i8*, i32 } %eh.lpad-body434, 1
  br label %_ZN8TestCaseD2Ev.exit748

; <label>:4518                                    ; preds = %2508
  %4519 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4520 = extractvalue { i8*, i32 } %4519, 0
  %4521 = extractvalue { i8*, i32 } %4519, 1
  %4522 = getelementptr inbounds %"class.std::allocator.0"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4522)
  %4523 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 1, i32 0, i32 0
  %4524 = load i8** %4523, align 8, !tbaa !1
  %4525 = getelementptr inbounds i8* %4524, i64 -24
  %4526 = bitcast i8* %4525 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4527 = icmp eq i8* %4525, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4527, label %4540, label %4528, !prof !7

; <label>:4528                                    ; preds = %4518
  %4529 = getelementptr inbounds i8* %4524, i64 -8
  %4530 = bitcast i8* %4529 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4531, label %4535

; <label>:4531                                    ; preds = %4528
  %4532 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4532)
  %4533 = atomicrmw volatile add i32* %4530, i32 -1 acq_rel
  store i32 %4533, i32* %3, align 4
  %4534 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4532)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i745

; <label>:4535                                    ; preds = %4528
  %4536 = load i32* %4530, align 4, !tbaa !8
  %4537 = add nsw i32 %4536, -1
  store i32 %4537, i32* %4530, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i745

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i745: ; preds = %4535, %4531
  %.0.i.i.i.i.i744 = phi i32 [ %4534, %4531 ], [ %4536, %4535 ]
  %4538 = icmp slt i32 %.0.i.i.i.i.i744, 1
  br i1 %4538, label %4539, label %4540

; <label>:4539                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i745
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4526, %"class.std::allocator.0"* %4) #1
  br label %4540

; <label>:4540                                    ; preds = %4539, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i745, %4518
  call void @llvm.lifetime.end(i64 1, i8* %4522)
  %4541 = getelementptr inbounds %"class.std::allocator.0"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4541)
  %4542 = getelementptr inbounds %class.TestCase* %492, i64 0, i32 0, i32 0, i32 0
  %4543 = load i8** %4542, align 8, !tbaa !1
  %4544 = getelementptr inbounds i8* %4543, i64 -24
  %4545 = bitcast i8* %4544 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4546 = icmp eq i8* %4544, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4546, label %_ZN8TestCaseD2Ev.exit748, label %4547, !prof !7

; <label>:4547                                    ; preds = %4540
  %4548 = getelementptr inbounds i8* %4543, i64 -8
  %4549 = bitcast i8* %4548 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4550, label %4554

; <label>:4550                                    ; preds = %4547
  %4551 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4551)
  %4552 = atomicrmw volatile add i32* %4549, i32 -1 acq_rel
  store i32 %4552, i32* %1, align 4
  %4553 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4551)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747

; <label>:4554                                    ; preds = %4547
  %4555 = load i32* %4549, align 4, !tbaa !8
  %4556 = add nsw i32 %4555, -1
  store i32 %4556, i32* %4549, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747: ; preds = %4554, %4550
  %.0.i.i.i.i1.i746 = phi i32 [ %4553, %4550 ], [ %4555, %4554 ]
  %4557 = icmp slt i32 %.0.i.i.i.i1.i746, 1
  br i1 %4557, label %4558, label %_ZN8TestCaseD2Ev.exit748

; <label>:4558                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4545, %"class.std::allocator.0"* %2) #1
  br label %_ZN8TestCaseD2Ev.exit748

_ZN8TestCaseD2Ev.exit748:                         ; preds = %4558, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747, %4540, %.body433
  %.5766 = phi i8* [ %4516, %.body433 ], [ %4520, %4540 ], [ %4520, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747 ], [ %4520, %4558 ]
  %.57 = phi i32 [ %4517, %.body433 ], [ %4521, %4540 ], [ %4521, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i747 ], [ %4521, %4558 ]
  %4559 = getelementptr inbounds %"class.std::allocator.0"* %14, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4559)
  %4560 = getelementptr inbounds %"class.std::basic_string"* %495, i64 0, i32 0, i32 0
  %4561 = load i8** %4560, align 8, !tbaa !1
  %4562 = getelementptr inbounds i8* %4561, i64 -24
  %4563 = bitcast i8* %4562 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4564 = icmp eq i8* %4562, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4564, label %_ZNSsD1Ev.exit732, label %4565, !prof !7

; <label>:4565                                    ; preds = %_ZN8TestCaseD2Ev.exit748
  %4566 = getelementptr inbounds i8* %4561, i64 -8
  %4567 = bitcast i8* %4566 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4568, label %4572

; <label>:4568                                    ; preds = %4565
  %4569 = bitcast i32* %13 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4569)
  %4570 = atomicrmw volatile add i32* %4567, i32 -1 acq_rel
  store i32 %4570, i32* %13, align 4
  %4571 = load volatile i32* %13, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4569)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731

; <label>:4572                                    ; preds = %4565
  %4573 = load i32* %4567, align 4, !tbaa !8
  %4574 = add nsw i32 %4573, -1
  store i32 %4574, i32* %4567, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731: ; preds = %4572, %4568
  %.0.i.i.i.i730 = phi i32 [ %4571, %4568 ], [ %4573, %4572 ]
  %4575 = icmp slt i32 %.0.i.i.i.i730, 1
  br i1 %4575, label %4576, label %_ZNSsD1Ev.exit732

; <label>:4576                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4563, %"class.std::allocator.0"* %14) #1
  br label %_ZNSsD1Ev.exit732

_ZNSsD1Ev.exit732:                                ; preds = %4576, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731, %_ZN8TestCaseD2Ev.exit748, %4510
  %.5867 = phi i8* [ %4512, %4510 ], [ %.5766, %_ZN8TestCaseD2Ev.exit748 ], [ %.5766, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731 ], [ %.5766, %4576 ]
  %.58 = phi i32 [ %4513, %4510 ], [ %.57, %_ZN8TestCaseD2Ev.exit748 ], [ %.57, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i731 ], [ %.57, %4576 ]
  %4577 = getelementptr inbounds %"class.std::allocator.0"* %24, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4577)
  %4578 = getelementptr inbounds %"class.std::basic_string"* %493, i64 0, i32 0, i32 0
  %4579 = load i8** %4578, align 8, !tbaa !1
  %4580 = getelementptr inbounds i8* %4579, i64 -24
  %4581 = bitcast i8* %4580 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4582 = icmp eq i8* %4580, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4582, label %_ZNSsD1Ev.exit509, label %4583, !prof !7

; <label>:4583                                    ; preds = %_ZNSsD1Ev.exit732
  %4584 = getelementptr inbounds i8* %4579, i64 -8
  %4585 = bitcast i8* %4584 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4586, label %4590

; <label>:4586                                    ; preds = %4583
  %4587 = bitcast i32* %23 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4587)
  %4588 = atomicrmw volatile add i32* %4585, i32 -1 acq_rel
  store i32 %4588, i32* %23, align 4
  %4589 = load volatile i32* %23, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4587)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717

; <label>:4590                                    ; preds = %4583
  %4591 = load i32* %4585, align 4, !tbaa !8
  %4592 = add nsw i32 %4591, -1
  store i32 %4592, i32* %4585, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717: ; preds = %4590, %4586
  %.0.i.i.i.i716 = phi i32 [ %4589, %4586 ], [ %4591, %4590 ]
  %4593 = icmp slt i32 %.0.i.i.i.i716, 1
  br i1 %4593, label %4594, label %_ZNSsD1Ev.exit509

; <label>:4594                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4581, %"class.std::allocator.0"* %24) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4595                                    ; preds = %2587
  %4596 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4597 = extractvalue { i8*, i32 } %4596, 0
  %4598 = extractvalue { i8*, i32 } %4596, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4599                                    ; preds = %2588
  %4600 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4601 = extractvalue { i8*, i32 } %4600, 0
  %4602 = extractvalue { i8*, i32 } %4600, 1
  br label %_ZNSsD1Ev.exit677

; <label>:4603                                    ; preds = %2589
  %4604 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body450

.body450:                                         ; preds = %4603, %2611, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i448, %2592
  %eh.lpad-body451 = phi { i8*, i32 } [ %4604, %4603 ], [ %2593, %2611 ], [ %2593, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i448 ], [ %2593, %2592 ]
  %4605 = extractvalue { i8*, i32 } %eh.lpad-body451, 0
  %4606 = extractvalue { i8*, i32 } %eh.lpad-body451, 1
  br label %_ZN8TestCaseD2Ev.exit693

; <label>:4607                                    ; preds = %2612
  %4608 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4609 = extractvalue { i8*, i32 } %4608, 0
  %4610 = extractvalue { i8*, i32 } %4608, 1
  %4611 = getelementptr inbounds %"class.std::allocator.0"* %44, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4611)
  %4612 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 1, i32 0, i32 0
  %4613 = load i8** %4612, align 8, !tbaa !1
  %4614 = getelementptr inbounds i8* %4613, i64 -24
  %4615 = bitcast i8* %4614 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4616 = icmp eq i8* %4614, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4616, label %4629, label %4617, !prof !7

; <label>:4617                                    ; preds = %4607
  %4618 = getelementptr inbounds i8* %4613, i64 -8
  %4619 = bitcast i8* %4618 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4620, label %4624

; <label>:4620                                    ; preds = %4617
  %4621 = bitcast i32* %43 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4621)
  %4622 = atomicrmw volatile add i32* %4619, i32 -1 acq_rel
  store i32 %4622, i32* %43, align 4
  %4623 = load volatile i32* %43, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4621)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i690

; <label>:4624                                    ; preds = %4617
  %4625 = load i32* %4619, align 4, !tbaa !8
  %4626 = add nsw i32 %4625, -1
  store i32 %4626, i32* %4619, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i690

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i690: ; preds = %4624, %4620
  %.0.i.i.i.i.i689 = phi i32 [ %4623, %4620 ], [ %4625, %4624 ]
  %4627 = icmp slt i32 %.0.i.i.i.i.i689, 1
  br i1 %4627, label %4628, label %4629

; <label>:4628                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i690
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4615, %"class.std::allocator.0"* %44) #1
  br label %4629

; <label>:4629                                    ; preds = %4628, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i690, %4607
  call void @llvm.lifetime.end(i64 1, i8* %4611)
  %4630 = getelementptr inbounds %"class.std::allocator.0"* %42, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4630)
  %4631 = getelementptr inbounds %class.TestCase* %497, i64 0, i32 0, i32 0, i32 0
  %4632 = load i8** %4631, align 8, !tbaa !1
  %4633 = getelementptr inbounds i8* %4632, i64 -24
  %4634 = bitcast i8* %4633 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4635 = icmp eq i8* %4633, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4635, label %_ZN8TestCaseD2Ev.exit693, label %4636, !prof !7

; <label>:4636                                    ; preds = %4629
  %4637 = getelementptr inbounds i8* %4632, i64 -8
  %4638 = bitcast i8* %4637 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4639, label %4643

; <label>:4639                                    ; preds = %4636
  %4640 = bitcast i32* %41 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4640)
  %4641 = atomicrmw volatile add i32* %4638, i32 -1 acq_rel
  store i32 %4641, i32* %41, align 4
  %4642 = load volatile i32* %41, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4640)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692

; <label>:4643                                    ; preds = %4636
  %4644 = load i32* %4638, align 4, !tbaa !8
  %4645 = add nsw i32 %4644, -1
  store i32 %4645, i32* %4638, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692: ; preds = %4643, %4639
  %.0.i.i.i.i1.i691 = phi i32 [ %4642, %4639 ], [ %4644, %4643 ]
  %4646 = icmp slt i32 %.0.i.i.i.i1.i691, 1
  br i1 %4646, label %4647, label %_ZN8TestCaseD2Ev.exit693

; <label>:4647                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4634, %"class.std::allocator.0"* %42) #1
  br label %_ZN8TestCaseD2Ev.exit693

_ZN8TestCaseD2Ev.exit693:                         ; preds = %4647, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692, %4629, %.body450
  %.6069 = phi i8* [ %4605, %.body450 ], [ %4609, %4629 ], [ %4609, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692 ], [ %4609, %4647 ]
  %.60 = phi i32 [ %4606, %.body450 ], [ %4610, %4629 ], [ %4610, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i692 ], [ %4610, %4647 ]
  %4648 = getelementptr inbounds %"class.std::allocator.0"* %54, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4648)
  %4649 = getelementptr inbounds %"class.std::basic_string"* %500, i64 0, i32 0, i32 0
  %4650 = load i8** %4649, align 8, !tbaa !1
  %4651 = getelementptr inbounds i8* %4650, i64 -24
  %4652 = bitcast i8* %4651 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4653 = icmp eq i8* %4651, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4653, label %_ZNSsD1Ev.exit677, label %4654, !prof !7

; <label>:4654                                    ; preds = %_ZN8TestCaseD2Ev.exit693
  %4655 = getelementptr inbounds i8* %4650, i64 -8
  %4656 = bitcast i8* %4655 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4657, label %4661

; <label>:4657                                    ; preds = %4654
  %4658 = bitcast i32* %53 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4658)
  %4659 = atomicrmw volatile add i32* %4656, i32 -1 acq_rel
  store i32 %4659, i32* %53, align 4
  %4660 = load volatile i32* %53, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4658)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676

; <label>:4661                                    ; preds = %4654
  %4662 = load i32* %4656, align 4, !tbaa !8
  %4663 = add nsw i32 %4662, -1
  store i32 %4663, i32* %4656, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676: ; preds = %4661, %4657
  %.0.i.i.i.i675 = phi i32 [ %4660, %4657 ], [ %4662, %4661 ]
  %4664 = icmp slt i32 %.0.i.i.i.i675, 1
  br i1 %4664, label %4665, label %_ZNSsD1Ev.exit677

; <label>:4665                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4652, %"class.std::allocator.0"* %54) #1
  br label %_ZNSsD1Ev.exit677

_ZNSsD1Ev.exit677:                                ; preds = %4665, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676, %_ZN8TestCaseD2Ev.exit693, %4599
  %.6170 = phi i8* [ %4601, %4599 ], [ %.6069, %_ZN8TestCaseD2Ev.exit693 ], [ %.6069, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676 ], [ %.6069, %4665 ]
  %.61 = phi i32 [ %4602, %4599 ], [ %.60, %_ZN8TestCaseD2Ev.exit693 ], [ %.60, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i676 ], [ %.60, %4665 ]
  %4666 = getelementptr inbounds %"class.std::allocator.0"* %64, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4666)
  %4667 = getelementptr inbounds %"class.std::basic_string"* %498, i64 0, i32 0, i32 0
  %4668 = load i8** %4667, align 8, !tbaa !1
  %4669 = getelementptr inbounds i8* %4668, i64 -24
  %4670 = bitcast i8* %4669 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4671 = icmp eq i8* %4669, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4671, label %_ZNSsD1Ev.exit509, label %4672, !prof !7

; <label>:4672                                    ; preds = %_ZNSsD1Ev.exit677
  %4673 = getelementptr inbounds i8* %4668, i64 -8
  %4674 = bitcast i8* %4673 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4675, label %4679

; <label>:4675                                    ; preds = %4672
  %4676 = bitcast i32* %63 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4676)
  %4677 = atomicrmw volatile add i32* %4674, i32 -1 acq_rel
  store i32 %4677, i32* %63, align 4
  %4678 = load volatile i32* %63, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4676)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662

; <label>:4679                                    ; preds = %4672
  %4680 = load i32* %4674, align 4, !tbaa !8
  %4681 = add nsw i32 %4680, -1
  store i32 %4681, i32* %4674, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662: ; preds = %4679, %4675
  %.0.i.i.i.i661 = phi i32 [ %4678, %4675 ], [ %4680, %4679 ]
  %4682 = icmp slt i32 %.0.i.i.i.i661, 1
  br i1 %4682, label %4683, label %_ZNSsD1Ev.exit509

; <label>:4683                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4670, %"class.std::allocator.0"* %64) #1
  br label %_ZNSsD1Ev.exit509

; <label>:4684                                    ; preds = %2691
  %4685 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4686 = extractvalue { i8*, i32 } %4685, 0
  %4687 = extractvalue { i8*, i32 } %4685, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4688                                    ; preds = %2692
  %4689 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4690 = extractvalue { i8*, i32 } %4689, 0
  %4691 = extractvalue { i8*, i32 } %4689, 1
  br label %_ZNSsD1Ev.exit622

; <label>:4692                                    ; preds = %2693
  %4693 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %.body474

.body474:                                         ; preds = %4692, %2715, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i472, %2696
  %eh.lpad-body475 = phi { i8*, i32 } [ %4693, %4692 ], [ %2697, %2715 ], [ %2697, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i472 ], [ %2697, %2696 ]
  %4694 = extractvalue { i8*, i32 } %eh.lpad-body475, 0
  %4695 = extractvalue { i8*, i32 } %eh.lpad-body475, 1
  br label %_ZN8TestCaseD2Ev.exit638

; <label>:4696                                    ; preds = %2716
  %4697 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4698 = extractvalue { i8*, i32 } %4697, 0
  %4699 = extractvalue { i8*, i32 } %4697, 1
  %4700 = getelementptr inbounds %"class.std::allocator.0"* %84, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4700)
  %4701 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 1, i32 0, i32 0
  %4702 = load i8** %4701, align 8, !tbaa !1
  %4703 = getelementptr inbounds i8* %4702, i64 -24
  %4704 = bitcast i8* %4703 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4705 = icmp eq i8* %4703, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4705, label %4718, label %4706, !prof !7

; <label>:4706                                    ; preds = %4696
  %4707 = getelementptr inbounds i8* %4702, i64 -8
  %4708 = bitcast i8* %4707 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4709, label %4713

; <label>:4709                                    ; preds = %4706
  %4710 = bitcast i32* %83 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4710)
  %4711 = atomicrmw volatile add i32* %4708, i32 -1 acq_rel
  store i32 %4711, i32* %83, align 4
  %4712 = load volatile i32* %83, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4710)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i635

; <label>:4713                                    ; preds = %4706
  %4714 = load i32* %4708, align 4, !tbaa !8
  %4715 = add nsw i32 %4714, -1
  store i32 %4715, i32* %4708, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i635

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i635: ; preds = %4713, %4709
  %.0.i.i.i.i.i634 = phi i32 [ %4712, %4709 ], [ %4714, %4713 ]
  %4716 = icmp slt i32 %.0.i.i.i.i.i634, 1
  br i1 %4716, label %4717, label %4718

; <label>:4717                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i635
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4704, %"class.std::allocator.0"* %84) #1
  br label %4718

; <label>:4718                                    ; preds = %4717, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i635, %4696
  call void @llvm.lifetime.end(i64 1, i8* %4700)
  %4719 = getelementptr inbounds %"class.std::allocator.0"* %82, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4719)
  %4720 = getelementptr inbounds %class.TestCase* %502, i64 0, i32 0, i32 0, i32 0
  %4721 = load i8** %4720, align 8, !tbaa !1
  %4722 = getelementptr inbounds i8* %4721, i64 -24
  %4723 = bitcast i8* %4722 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4724 = icmp eq i8* %4722, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4724, label %_ZN8TestCaseD2Ev.exit638, label %4725, !prof !7

; <label>:4725                                    ; preds = %4718
  %4726 = getelementptr inbounds i8* %4721, i64 -8
  %4727 = bitcast i8* %4726 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4728, label %4732

; <label>:4728                                    ; preds = %4725
  %4729 = bitcast i32* %81 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4729)
  %4730 = atomicrmw volatile add i32* %4727, i32 -1 acq_rel
  store i32 %4730, i32* %81, align 4
  %4731 = load volatile i32* %81, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4729)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637

; <label>:4732                                    ; preds = %4725
  %4733 = load i32* %4727, align 4, !tbaa !8
  %4734 = add nsw i32 %4733, -1
  store i32 %4734, i32* %4727, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637: ; preds = %4732, %4728
  %.0.i.i.i.i1.i636 = phi i32 [ %4731, %4728 ], [ %4733, %4732 ]
  %4735 = icmp slt i32 %.0.i.i.i.i1.i636, 1
  br i1 %4735, label %4736, label %_ZN8TestCaseD2Ev.exit638

; <label>:4736                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4723, %"class.std::allocator.0"* %82) #1
  br label %_ZN8TestCaseD2Ev.exit638

_ZN8TestCaseD2Ev.exit638:                         ; preds = %4736, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637, %4718, %.body474
  %.6372 = phi i8* [ %4694, %.body474 ], [ %4698, %4718 ], [ %4698, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637 ], [ %4698, %4736 ]
  %.63 = phi i32 [ %4695, %.body474 ], [ %4699, %4718 ], [ %4699, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i637 ], [ %4699, %4736 ]
  %4737 = getelementptr inbounds %"class.std::allocator.0"* %94, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4737)
  %4738 = getelementptr inbounds %"class.std::basic_string"* %505, i64 0, i32 0, i32 0
  %4739 = load i8** %4738, align 8, !tbaa !1
  %4740 = getelementptr inbounds i8* %4739, i64 -24
  %4741 = bitcast i8* %4740 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4742 = icmp eq i8* %4740, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4742, label %_ZNSsD1Ev.exit622, label %4743, !prof !7

; <label>:4743                                    ; preds = %_ZN8TestCaseD2Ev.exit638
  %4744 = getelementptr inbounds i8* %4739, i64 -8
  %4745 = bitcast i8* %4744 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4746, label %4750

; <label>:4746                                    ; preds = %4743
  %4747 = bitcast i32* %93 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4747)
  %4748 = atomicrmw volatile add i32* %4745, i32 -1 acq_rel
  store i32 %4748, i32* %93, align 4
  %4749 = load volatile i32* %93, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4747)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621

; <label>:4750                                    ; preds = %4743
  %4751 = load i32* %4745, align 4, !tbaa !8
  %4752 = add nsw i32 %4751, -1
  store i32 %4752, i32* %4745, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621: ; preds = %4750, %4746
  %.0.i.i.i.i620 = phi i32 [ %4749, %4746 ], [ %4751, %4750 ]
  %4753 = icmp slt i32 %.0.i.i.i.i620, 1
  br i1 %4753, label %4754, label %_ZNSsD1Ev.exit622

; <label>:4754                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4741, %"class.std::allocator.0"* %94) #1
  br label %_ZNSsD1Ev.exit622

_ZNSsD1Ev.exit622:                                ; preds = %4754, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621, %_ZN8TestCaseD2Ev.exit638, %4688
  %.6473 = phi i8* [ %4690, %4688 ], [ %.6372, %_ZN8TestCaseD2Ev.exit638 ], [ %.6372, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621 ], [ %.6372, %4754 ]
  %.64 = phi i32 [ %4691, %4688 ], [ %.63, %_ZN8TestCaseD2Ev.exit638 ], [ %.63, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i621 ], [ %.63, %4754 ]
  %4755 = getelementptr inbounds %"class.std::allocator.0"* %104, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %4755)
  %4756 = getelementptr inbounds %"class.std::basic_string"* %503, i64 0, i32 0, i32 0
  %4757 = load i8** %4756, align 8, !tbaa !1
  %4758 = getelementptr inbounds i8* %4757, i64 -24
  %4759 = bitcast i8* %4758 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %4760 = icmp eq i8* %4758, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %4760, label %_ZNSsD1Ev.exit509, label %4761, !prof !7

; <label>:4761                                    ; preds = %_ZNSsD1Ev.exit622
  %4762 = getelementptr inbounds i8* %4757, i64 -8
  %4763 = bitcast i8* %4762 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %4764, label %4768

; <label>:4764                                    ; preds = %4761
  %4765 = bitcast i32* %103 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %4765)
  %4766 = atomicrmw volatile add i32* %4763, i32 -1 acq_rel
  store i32 %4766, i32* %103, align 4
  %4767 = load volatile i32* %103, align 4
  call void @llvm.lifetime.end(i64 4, i8* %4765)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607

; <label>:4768                                    ; preds = %4761
  %4769 = load i32* %4763, align 4, !tbaa !8
  %4770 = add nsw i32 %4769, -1
  store i32 %4770, i32* %4763, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607: ; preds = %4768, %4764
  %.0.i.i.i.i606 = phi i32 [ %4767, %4764 ], [ %4769, %4768 ]
  %4771 = icmp slt i32 %.0.i.i.i.i606, 1
  br i1 %4771, label %4772, label %_ZNSsD1Ev.exit509

; <label>:4772                                    ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %4759, %"class.std::allocator.0"* %104) #1
  br label %_ZNSsD1Ev.exit509

.loopexit:                                        ; preds = %.noexc425, %.noexc424, %.noexc468, %4818, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit491, %4796, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit493, %4793, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit495, %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit522, %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit546, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit559, %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit498, %4776, %2813, %.lr.ph
  %lpad.loopexit = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %4773

.nonloopexit:                                     ; preds = %.noexc156, %.noexc155, %.noexc195, %4872, %4865, %4855, %.noexc287, %.noexc286, %.noexc330, %4847, %4840, %._crit_edge.thread, %4811
  %lpad.nonloopexit = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %4773

; <label>:4773                                    ; preds = %.nonloopexit, %.loopexit
  %lpad.phi = phi { i8*, i32 } [ %lpad.loopexit, %.loopexit ], [ %lpad.nonloopexit, %.nonloopexit ]
  %4774 = extractvalue { i8*, i32 } %lpad.phi, 0
  %4775 = extractvalue { i8*, i32 } %lpad.phi, 1
  br label %_ZNSsD1Ev.exit509

; <label>:4776                                    ; preds = %2809
  %4777 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([7 x i8]* @.str24, i64 0, i64 0), i64 6)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit498 unwind label %.loopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit498: ; preds = %4776, %2813
  %pass.1 = phi i8 [ %pass.0756, %2813 ], [ 0, %4776 ]
  %4778 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([9 x i8]* @.str25, i64 0, i64 0), i64 8)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit559 unwind label %.loopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit559: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit498
  %4779 = load i8** %2802, align 8, !tbaa !1
  %4780 = getelementptr inbounds i8* %4779, i64 -24
  %4781 = bitcast i8* %4780 to i64*
  %4782 = load i64* %4781, align 8, !tbaa !14
  %4783 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* %4779, i64 %4782)
          to label %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit546 unwind label %.loopexit

_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit546: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit559
  %4784 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %4783, i8* getelementptr inbounds ([3 x i8]* @.str26, i64 0, i64 0), i64 2)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit522 unwind label %.loopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit522: ; preds = %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit546
  %4785 = load i8** %2804, align 8, !tbaa !1
  %4786 = getelementptr inbounds i8* %4785, i64 -24
  %4787 = bitcast i8* %4786 to i64*
  %4788 = load i64* %4787, align 8, !tbaa !14
  %4789 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %4783, i8* %4785, i64 %4788)
          to label %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit unwind label %.loopexit

_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit: ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit522
  %4790 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %4789, i8* getelementptr inbounds ([3 x i8]* @.str26, i64 0, i64 0), i64 2)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit495 unwind label %.loopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit495: ; preds = %_ZStlsIcSt11char_traitsIcESaIcEERSt13basic_ostreamIT_T0_ES7_RKSbIS4_S5_T1_E.exit
  %4791 = load i32* %2806, align 4, !tbaa !10
  %4792 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* %4789, i32 %4791)
          to label %4793 unwind label %.loopexit

; <label>:4793                                    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit495
  %4794 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %4792, i8* getelementptr inbounds ([12 x i8]* @.str27, i64 0, i64 0), i64 11)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit493 unwind label %.loopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit493: ; preds = %4793
  %4795 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* %4792, i32 %2808)
          to label %4796 unwind label %.loopexit

; <label>:4796                                    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit493
  %4797 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* %4795, i8* getelementptr inbounds ([12 x i8]* @.str28, i64 0, i64 0), i64 11)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit491 unwind label %.loopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit491: ; preds = %4796
  %4798 = load i32* %2810, align 4, !tbaa !12
  %4799 = invoke %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"* %4795, i32 %4798)
          to label %4800 unwind label %.loopexit

; <label>:4800                                    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit491
  %4801 = bitcast %"class.std::basic_ostream"* %4799 to i8**
  %4802 = load i8** %4801, align 8, !tbaa !17
  %4803 = getelementptr i8* %4802, i64 -24
  %4804 = bitcast i8* %4803 to i64*
  %4805 = load i64* %4804, align 8
  %4806 = bitcast %"class.std::basic_ostream"* %4799 to i8*
  %.sum751 = add i64 %4805, 240
  %4807 = getelementptr inbounds i8* %4806, i64 %.sum751
  %4808 = bitcast i8* %4807 to %"class.std::ctype"**
  %4809 = load %"class.std::ctype"** %4808, align 8, !tbaa !19
  %4810 = icmp eq %"class.std::ctype"* %4809, null
  br i1 %4810, label %4811, label %.noexc464

; <label>:4811                                    ; preds = %4800
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc488 unwind label %.nonloopexit

.noexc488:                                        ; preds = %4811
  unreachable

.noexc464:                                        ; preds = %4800
  %4812 = getelementptr inbounds %"class.std::ctype"* %4809, i64 0, i32 6
  %4813 = load i8* %4812, align 1, !tbaa !22
  %4814 = icmp eq i8 %4813, 0
  br i1 %4814, label %4818, label %4815

; <label>:4815                                    ; preds = %.noexc464
  %4816 = getelementptr inbounds %"class.std::ctype"* %4809, i64 0, i32 7, i64 10
  %4817 = load i8* %4816, align 1, !tbaa !24
  br label %.noexc424

; <label>:4818                                    ; preds = %.noexc464
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %4809)
          to label %.noexc468 unwind label %.loopexit

.noexc468:                                        ; preds = %4818
  %4819 = bitcast %"class.std::ctype"* %4809 to i8 (%"class.std::ctype"*, i8)***
  %4820 = load i8 (%"class.std::ctype"*, i8)*** %4819, align 8, !tbaa !17
  %4821 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %4820, i64 6
  %4822 = load i8 (%"class.std::ctype"*, i8)** %4821, align 8
  %4823 = invoke signext i8 %4822(%"class.std::ctype"* %4809, i8 signext 10)
          to label %.noexc424 unwind label %.loopexit

.noexc424:                                        ; preds = %.noexc468, %4815
  %.0.i467 = phi i8 [ %4817, %4815 ], [ %4823, %.noexc468 ]
  %4824 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* %4799, i8 signext %.0.i467)
          to label %.noexc425 unwind label %.loopexit

.noexc425:                                        ; preds = %.noexc424
  %4825 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %4824)
          to label %_ZNSolsEPFRSoS_E.exit423 unwind label %.loopexit

_ZNSolsEPFRSoS_E.exit423:                         ; preds = %.noexc425
  %4826 = getelementptr inbounds %class.TestCase* %2801, i64 1
  %4827 = load %class.TestCase** %2798, align 8, !tbaa !13
  %4828 = icmp eq %class.TestCase* %4826, %4827
  br i1 %4828, label %._crit_edge, label %.lr.ph

._crit_edge:                                      ; preds = %_ZNSolsEPFRSoS_E.exit423
  %4829 = and i8 %pass.1, 1
  %4830 = icmp eq i8 %4829, 0
  br i1 %4830, label %4855, label %._crit_edge.thread

._crit_edge.thread:                               ; preds = %._crit_edge, %2795
  %4831 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([18 x i8]* @.str29, i64 0, i64 0), i64 17)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit387 unwind label %.nonloopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit387: ; preds = %._crit_edge.thread
  %4832 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !17
  %4833 = getelementptr i8* %4832, i64 -24
  %4834 = bitcast i8* %4833 to i64*
  %4835 = load i64* %4834, align 8
  %.sum = add i64 %4835, 240
  %4836 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum
  %4837 = bitcast i8* %4836 to %"class.std::ctype"**
  %4838 = load %"class.std::ctype"** %4837, align 8, !tbaa !19
  %4839 = icmp eq %"class.std::ctype"* %4838, null
  br i1 %4839, label %4840, label %.noexc326

; <label>:4840                                    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit387
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc367 unwind label %.nonloopexit

.noexc367:                                        ; preds = %4840
  unreachable

.noexc326:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit387
  %4841 = getelementptr inbounds %"class.std::ctype"* %4838, i64 0, i32 6
  %4842 = load i8* %4841, align 1, !tbaa !22
  %4843 = icmp eq i8 %4842, 0
  br i1 %4843, label %4847, label %4844

; <label>:4844                                    ; preds = %.noexc326
  %4845 = getelementptr inbounds %"class.std::ctype"* %4838, i64 0, i32 7, i64 10
  %4846 = load i8* %4845, align 1, !tbaa !24
  br label %.noexc286

; <label>:4847                                    ; preds = %.noexc326
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %4838)
          to label %.noexc330 unwind label %.nonloopexit

.noexc330:                                        ; preds = %4847
  %4848 = bitcast %"class.std::ctype"* %4838 to i8 (%"class.std::ctype"*, i8)***
  %4849 = load i8 (%"class.std::ctype"*, i8)*** %4848, align 8, !tbaa !17
  %4850 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %4849, i64 6
  %4851 = load i8 (%"class.std::ctype"*, i8)** %4850, align 8
  %4852 = invoke signext i8 %4851(%"class.std::ctype"* %4838, i8 signext 10)
          to label %.noexc286 unwind label %.nonloopexit

.noexc286:                                        ; preds = %.noexc330, %4844
  %.0.i329 = phi i8 [ %4846, %4844 ], [ %4852, %.noexc330 ]
  %4853 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i329)
          to label %.noexc287 unwind label %.nonloopexit

.noexc287:                                        ; preds = %.noexc286
  %4854 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %4853)
          to label %_ZNSolsEPFRSoS_E.exit285 unwind label %.nonloopexit

; <label>:4855                                    ; preds = %._crit_edge
  %4856 = invoke %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"* @_ZSt4cout, i8* getelementptr inbounds ([19 x i8]* @.str30, i64 0, i64 0), i64 18)
          to label %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit unwind label %.nonloopexit

_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit: ; preds = %4855
  %4857 = load i8** bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8**), align 8, !tbaa !17
  %4858 = getelementptr i8* %4857, i64 -24
  %4859 = bitcast i8* %4858 to i64*
  %4860 = load i64* %4859, align 8
  %.sum750 = add i64 %4860, 240
  %4861 = getelementptr inbounds i8* bitcast (%"class.std::basic_ostream"* @_ZSt4cout to i8*), i64 %.sum750
  %4862 = bitcast i8* %4861 to %"class.std::ctype"**
  %4863 = load %"class.std::ctype"** %4862, align 8, !tbaa !19
  %4864 = icmp eq %"class.std::ctype"* %4863, null
  br i1 %4864, label %4865, label %.noexc193

; <label>:4865                                    ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  invoke void @_ZSt16__throw_bad_castv() #9
          to label %.noexc231 unwind label %.nonloopexit

.noexc231:                                        ; preds = %4865
  unreachable

.noexc193:                                        ; preds = %_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc.exit
  %4866 = getelementptr inbounds %"class.std::ctype"* %4863, i64 0, i32 6
  %4867 = load i8* %4866, align 1, !tbaa !22
  %4868 = icmp eq i8 %4867, 0
  br i1 %4868, label %4872, label %4869

; <label>:4869                                    ; preds = %.noexc193
  %4870 = getelementptr inbounds %"class.std::ctype"* %4863, i64 0, i32 7, i64 10
  %4871 = load i8* %4870, align 1, !tbaa !24
  br label %.noexc155

; <label>:4872                                    ; preds = %.noexc193
  invoke void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"* %4863)
          to label %.noexc195 unwind label %.nonloopexit

.noexc195:                                        ; preds = %4872
  %4873 = bitcast %"class.std::ctype"* %4863 to i8 (%"class.std::ctype"*, i8)***
  %4874 = load i8 (%"class.std::ctype"*, i8)*** %4873, align 8, !tbaa !17
  %4875 = getelementptr inbounds i8 (%"class.std::ctype"*, i8)** %4874, i64 6
  %4876 = load i8 (%"class.std::ctype"*, i8)** %4875, align 8
  %4877 = invoke signext i8 %4876(%"class.std::ctype"* %4863, i8 signext 10)
          to label %.noexc155 unwind label %.nonloopexit

.noexc155:                                        ; preds = %.noexc195, %4869
  %.0.i = phi i8 [ %4871, %4869 ], [ %4877, %.noexc195 ]
  %4878 = invoke %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"* @_ZSt4cout, i8 signext %.0.i)
          to label %.noexc156 unwind label %.nonloopexit

.noexc156:                                        ; preds = %.noexc155
  %4879 = invoke %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"* %4878)
          to label %_ZNSolsEPFRSoS_E.exit285 unwind label %.nonloopexit

_ZNSolsEPFRSoS_E.exit285:                         ; preds = %.noexc156, %.noexc287
  %.0 = phi i32 [ 0, %.noexc287 ], [ 1, %.noexc156 ]
  %4880 = load %class.TestCase** %2796, align 8, !tbaa !25
  %4881 = load %class.TestCase** %2798, align 8, !tbaa !28
  invoke void @_ZNSt12_Destroy_auxILb0EE9__destroyIP8TestCaseEEvT_S4_(%class.TestCase* %4880, %class.TestCase* %4881)
          to label %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i100 unwind label %4886

_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i100: ; preds = %_ZNSolsEPFRSoS_E.exit285
  %4882 = load %class.TestCase** %2796, align 8, !tbaa !25
  %4883 = icmp eq %class.TestCase* %4882, null
  br i1 %4883, label %_ZNSt6vectorI8TestCaseSaIS0_EED2Ev.exit102, label %4884

; <label>:4884                                    ; preds = %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i100
  %4885 = bitcast %class.TestCase* %4882 to i8*
  call void @_ZdlPv(i8* %4885) #1
  br label %_ZNSt6vectorI8TestCaseSaIS0_EED2Ev.exit102

; <label>:4886                                    ; preds = %_ZNSolsEPFRSoS_E.exit285
  %4887 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %4888 = load %class.TestCase** %2796, align 8, !tbaa !25
  %4889 = icmp eq %class.TestCase* %4888, null
  br i1 %4889, label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EED2Ev.exit.i101, label %4890

; <label>:4890                                    ; preds = %4886
  %4891 = bitcast %class.TestCase* %4888 to i8*
  call void @_ZdlPv(i8* %4891) #1
  br label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EED2Ev.exit.i101

_ZNSt12_Vector_baseI8TestCaseSaIS0_EED2Ev.exit.i101: ; preds = %4890, %4886
  resume { i8*, i32 } %4887

_ZNSt6vectorI8TestCaseSaIS0_EED2Ev.exit102:       ; preds = %4884, %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i100
  ret i32 %.0

_ZNSsD1Ev.exit509:                                ; preds = %4773, %4772, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607, %_ZNSsD1Ev.exit622, %4684, %4683, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662, %_ZNSsD1Ev.exit677, %4595, %4594, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717, %_ZNSsD1Ev.exit732, %4506, %4505, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742, %_ZNSsD1Ev.exit740, %4417, %4416, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728, %_ZNSsD1Ev.exit726, %4328, %4327, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714, %_ZNSsD1Ev.exit712, %4239, %4238, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703, %_ZNSsD1Ev.exit701, %4150, %4149, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687, %_ZNSsD1Ev.exit685, %4061, %4060, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673, %_ZNSsD1Ev.exit671, %3972, %3971, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659, %_ZNSsD1Ev.exit657, %3883, %3882, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648, %_ZNSsD1Ev.exit646, %3794, %3793, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632, %_ZNSsD1Ev.exit630, %3705, %3704, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618, %_ZNSsD1Ev.exit616, %3616, %3615, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604, %_ZNSsD1Ev.exit602, %3527, %3526, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593, %_ZNSsD1Ev.exit591, %3438, %3437, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580, %_ZNSsD1Ev.exit578, %3349, %3348, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569, %_ZNSsD1Ev.exit567, %3260, %3259, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556, %_ZNSsD1Ev.exit554, %3171, %3170, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543, %_ZNSsD1Ev.exit541, %3082, %3081, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532, %_ZNSsD1Ev.exit530, %2993, %2992, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519, %_ZNSsD1Ev.exit517, %2904, %2903, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508, %_ZNSsD1Ev.exit506, %2815
  %.6675 = phi i8* [ %4774, %4773 ], [ %2817, %2815 ], [ %2906, %2904 ], [ %2995, %2993 ], [ %3084, %3082 ], [ %3173, %3171 ], [ %3262, %3260 ], [ %3351, %3349 ], [ %3440, %3438 ], [ %3529, %3527 ], [ %3618, %3616 ], [ %3707, %3705 ], [ %3796, %3794 ], [ %3885, %3883 ], [ %3974, %3972 ], [ %4063, %4061 ], [ %4152, %4150 ], [ %4241, %4239 ], [ %4330, %4328 ], [ %4419, %4417 ], [ %4508, %4506 ], [ %4597, %4595 ], [ %4686, %4684 ], [ %.110, %_ZNSsD1Ev.exit506 ], [ %.110, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508 ], [ %.110, %2903 ], [ %.413, %_ZNSsD1Ev.exit517 ], [ %.413, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519 ], [ %.413, %2992 ], [ %.716, %_ZNSsD1Ev.exit530 ], [ %.716, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532 ], [ %.716, %3081 ], [ %.1019, %_ZNSsD1Ev.exit541 ], [ %.1019, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543 ], [ %.1019, %3170 ], [ %.1322, %_ZNSsD1Ev.exit554 ], [ %.1322, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556 ], [ %.1322, %3259 ], [ %.1625, %_ZNSsD1Ev.exit567 ], [ %.1625, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569 ], [ %.1625, %3348 ], [ %.1928, %_ZNSsD1Ev.exit578 ], [ %.1928, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580 ], [ %.1928, %3437 ], [ %.2231, %_ZNSsD1Ev.exit591 ], [ %.2231, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593 ], [ %.2231, %3526 ], [ %.2534, %_ZNSsD1Ev.exit602 ], [ %.2534, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604 ], [ %.2534, %3615 ], [ %.2837, %_ZNSsD1Ev.exit616 ], [ %.2837, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618 ], [ %.2837, %3704 ], [ %.3140, %_ZNSsD1Ev.exit630 ], [ %.3140, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632 ], [ %.3140, %3793 ], [ %.3443, %_ZNSsD1Ev.exit646 ], [ %.3443, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648 ], [ %.3443, %3882 ], [ %.3746, %_ZNSsD1Ev.exit657 ], [ %.3746, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659 ], [ %.3746, %3971 ], [ %.4049, %_ZNSsD1Ev.exit671 ], [ %.4049, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673 ], [ %.4049, %4060 ], [ %.4352, %_ZNSsD1Ev.exit685 ], [ %.4352, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687 ], [ %.4352, %4149 ], [ %.4655, %_ZNSsD1Ev.exit701 ], [ %.4655, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703 ], [ %.4655, %4238 ], [ %.4958, %_ZNSsD1Ev.exit712 ], [ %.4958, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714 ], [ %.4958, %4327 ], [ %.5261, %_ZNSsD1Ev.exit726 ], [ %.5261, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728 ], [ %.5261, %4416 ], [ %.5564, %_ZNSsD1Ev.exit740 ], [ %.5564, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742 ], [ %.5564, %4505 ], [ %.5867, %_ZNSsD1Ev.exit732 ], [ %.5867, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717 ], [ %.5867, %4594 ], [ %.6170, %_ZNSsD1Ev.exit677 ], [ %.6170, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662 ], [ %.6170, %4683 ], [ %.6473, %_ZNSsD1Ev.exit622 ], [ %.6473, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607 ], [ %.6473, %4772 ]
  %.66 = phi i32 [ %4775, %4773 ], [ %2818, %2815 ], [ %2907, %2904 ], [ %2996, %2993 ], [ %3085, %3082 ], [ %3174, %3171 ], [ %3263, %3260 ], [ %3352, %3349 ], [ %3441, %3438 ], [ %3530, %3527 ], [ %3619, %3616 ], [ %3708, %3705 ], [ %3797, %3794 ], [ %3886, %3883 ], [ %3975, %3972 ], [ %4064, %4061 ], [ %4153, %4150 ], [ %4242, %4239 ], [ %4331, %4328 ], [ %4420, %4417 ], [ %4509, %4506 ], [ %4598, %4595 ], [ %4687, %4684 ], [ %.1, %_ZNSsD1Ev.exit506 ], [ %.1, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i508 ], [ %.1, %2903 ], [ %.4, %_ZNSsD1Ev.exit517 ], [ %.4, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i519 ], [ %.4, %2992 ], [ %.7, %_ZNSsD1Ev.exit530 ], [ %.7, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i532 ], [ %.7, %3081 ], [ %.10, %_ZNSsD1Ev.exit541 ], [ %.10, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i543 ], [ %.10, %3170 ], [ %.13, %_ZNSsD1Ev.exit554 ], [ %.13, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i556 ], [ %.13, %3259 ], [ %.16, %_ZNSsD1Ev.exit567 ], [ %.16, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i569 ], [ %.16, %3348 ], [ %.19, %_ZNSsD1Ev.exit578 ], [ %.19, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i580 ], [ %.19, %3437 ], [ %.22, %_ZNSsD1Ev.exit591 ], [ %.22, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i593 ], [ %.22, %3526 ], [ %.25, %_ZNSsD1Ev.exit602 ], [ %.25, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i604 ], [ %.25, %3615 ], [ %.28, %_ZNSsD1Ev.exit616 ], [ %.28, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i618 ], [ %.28, %3704 ], [ %.31, %_ZNSsD1Ev.exit630 ], [ %.31, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i632 ], [ %.31, %3793 ], [ %.34, %_ZNSsD1Ev.exit646 ], [ %.34, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i648 ], [ %.34, %3882 ], [ %.37, %_ZNSsD1Ev.exit657 ], [ %.37, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i659 ], [ %.37, %3971 ], [ %.40, %_ZNSsD1Ev.exit671 ], [ %.40, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i673 ], [ %.40, %4060 ], [ %.43, %_ZNSsD1Ev.exit685 ], [ %.43, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i687 ], [ %.43, %4149 ], [ %.46, %_ZNSsD1Ev.exit701 ], [ %.46, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i703 ], [ %.46, %4238 ], [ %.49, %_ZNSsD1Ev.exit712 ], [ %.49, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i714 ], [ %.49, %4327 ], [ %.52, %_ZNSsD1Ev.exit726 ], [ %.52, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i728 ], [ %.52, %4416 ], [ %.55, %_ZNSsD1Ev.exit740 ], [ %.55, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i742 ], [ %.55, %4505 ], [ %.58, %_ZNSsD1Ev.exit732 ], [ %.58, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i717 ], [ %.58, %4594 ], [ %.61, %_ZNSsD1Ev.exit677 ], [ %.61, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i662 ], [ %.61, %4683 ], [ %.64, %_ZNSsD1Ev.exit622 ], [ %.64, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i607 ], [ %.64, %4772 ]
  %4892 = getelementptr inbounds %"class.std::vector"* %testCases, i64 0, i32 0, i32 0, i32 0
  %4893 = load %class.TestCase** %4892, align 8, !tbaa !25
  %4894 = getelementptr inbounds %"class.std::vector"* %testCases, i64 0, i32 0, i32 0, i32 1
  %4895 = load %class.TestCase** %4894, align 8, !tbaa !28
  invoke void @_ZNSt12_Destroy_auxILb0EE9__destroyIP8TestCaseEEvT_S4_(%class.TestCase* %4893, %class.TestCase* %4895)
          to label %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i unwind label %4900

_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i: ; preds = %_ZNSsD1Ev.exit509
  %4896 = load %class.TestCase** %4892, align 8, !tbaa !25
  %4897 = icmp eq %class.TestCase* %4896, null
  br i1 %4897, label %_ZNSt6vectorI8TestCaseSaIS0_EED2Ev.exit, label %4898

; <label>:4898                                    ; preds = %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i
  %4899 = bitcast %class.TestCase* %4896 to i8*
  call void @_ZdlPv(i8* %4899) #1
  br label %_ZNSt6vectorI8TestCaseSaIS0_EED2Ev.exit

; <label>:4900                                    ; preds = %_ZNSsD1Ev.exit509
  %4901 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %4902 = load %class.TestCase** %4892, align 8, !tbaa !25
  %4903 = icmp eq %class.TestCase* %4902, null
  br i1 %4903, label %.body, label %4904

; <label>:4904                                    ; preds = %4900
  %4905 = bitcast %class.TestCase* %4902 to i8*
  call void @_ZdlPv(i8* %4905) #1
  br label %.body

_ZNSt6vectorI8TestCaseSaIS0_EED2Ev.exit:          ; preds = %4898, %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit.i
  %4906 = insertvalue { i8*, i32 } undef, i8* %.6675, 0
  %4907 = insertvalue { i8*, i32 } %4906, i32 %.66, 1
  resume { i8*, i32 } %4907

.body:                                            ; preds = %4904, %4900
  %4908 = extractvalue { i8*, i32 } %4901, 0
  call void @__clang_call_terminate(i8* %4908) #10
  unreachable
}

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt6vectorI8TestCaseSaIS0_EE9push_backERKS0_(%"class.std::vector"* nocapture %this, %class.TestCase* %__x) #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator.0", align 1
  %3 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  %4 = load %class.TestCase** %3, align 8, !tbaa !28
  %5 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 2
  %6 = load %class.TestCase** %5, align 8, !tbaa !29
  %7 = icmp eq %class.TestCase* %4, %6
  br i1 %7, label %43, label %8

; <label>:8                                       ; preds = %0
  %9 = icmp eq %class.TestCase* %4, null
  br i1 %9, label %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit, label %10

; <label>:10                                      ; preds = %8
  %11 = getelementptr inbounds %class.TestCase* %4, i64 0, i32 0
  %12 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 0
  call void @_ZNSsC1ERKSs(%"class.std::basic_string"* %11, %"class.std::basic_string"* %12)
  %13 = getelementptr inbounds %class.TestCase* %4, i64 0, i32 1
  %14 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %13, %"class.std::basic_string"* %14)
          to label %_ZN8TestCaseC2ERKS_.exit.i.i unwind label %15

; <label>:15                                      ; preds = %10
  %16 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %17 = getelementptr inbounds %"class.std::allocator.0"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %17)
  %18 = getelementptr inbounds %class.TestCase* %4, i64 0, i32 0, i32 0, i32 0
  %19 = load i8** %18, align 8, !tbaa !1
  %20 = getelementptr inbounds i8* %19, i64 -24
  %21 = bitcast i8* %20 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %22 = icmp eq i8* %20, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %22, label %35, label %23, !prof !7

; <label>:23                                      ; preds = %15
  %24 = getelementptr inbounds i8* %19, i64 -8
  %25 = bitcast i8* %24 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %26, label %30

; <label>:26                                      ; preds = %23
  %27 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %27)
  %28 = atomicrmw volatile add i32* %25, i32 -1 acq_rel
  store i32 %28, i32* %1, align 4
  %29 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %27)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i

; <label>:30                                      ; preds = %23
  %31 = load i32* %25, align 4, !tbaa !8
  %32 = add nsw i32 %31, -1
  store i32 %32, i32* %25, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i: ; preds = %30, %26
  %.0.i.i.i.i.i.i.i = phi i32 [ %29, %26 ], [ %31, %30 ]
  %33 = icmp slt i32 %.0.i.i.i.i.i.i.i, 1
  br i1 %33, label %34, label %35

; <label>:34                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %21, %"class.std::allocator.0"* %2) #1
  br label %35

; <label>:35                                      ; preds = %34, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i, %15
  call void @llvm.lifetime.end(i64 1, i8* %17)
  resume { i8*, i32 } %16

_ZN8TestCaseC2ERKS_.exit.i.i:                     ; preds = %10
  %36 = getelementptr inbounds %class.TestCase* %4, i64 0, i32 2
  %37 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 2
  %38 = bitcast i32* %37 to i64*
  %39 = bitcast i32* %36 to i64*
  %40 = load i64* %38, align 4
  store i64 %40, i64* %39, align 4
  %.pre = load %class.TestCase** %3, align 8, !tbaa !28
  br label %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit

_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit: ; preds = %_ZN8TestCaseC2ERKS_.exit.i.i, %8
  %41 = phi %class.TestCase* [ null, %8 ], [ %.pre, %_ZN8TestCaseC2ERKS_.exit.i.i ]
  %42 = getelementptr inbounds %class.TestCase* %41, i64 1
  store %class.TestCase* %42, %class.TestCase** %3, align 8, !tbaa !28
  br label %44

; <label>:43                                      ; preds = %0
  call void @_ZNSt6vectorI8TestCaseSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_(%"class.std::vector"* %this, %class.TestCase* %4, %class.TestCase* %__x)
  br label %44

; <label>:44                                      ; preds = %43, %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit
  ret void
}

declare void @_ZNSsC1EPKcRKSaIcE(%"class.std::basic_string"*, i8*, %"class.std::allocator.0"*) #0

declare i32 @__gxx_personality_v0(...)

; Function Attrs: noinline noreturn nounwind
define linkonce_odr hidden void @__clang_call_terminate(i8*) #3 {
  %2 = tail call i8* @__cxa_begin_catch(i8* %0) #1
  tail call void @_ZSt9terminatev() #10
  unreachable
}

declare i8* @__cxa_begin_catch(i8*)

declare void @_ZSt9terminatev()

declare i32 @fnmatch(i8*, i8*, i32) #0

declare %"class.std::basic_ostream"* @_ZNSolsEi(%"class.std::basic_ostream"*, i32) #0

declare %"class.std::basic_ostream"* @_ZNSo3putEc(%"class.std::basic_ostream"*, i8 signext) #0

declare void @_ZNKSt5ctypeIcE13_M_widen_initEv(%"class.std::ctype"*) #0

; Function Attrs: noreturn
declare void @_ZSt16__throw_bad_castv() #4

declare %"class.std::basic_ostream"* @_ZNSo5flushEv(%"class.std::basic_ostream"*) #0

declare %"class.std::basic_ostream"* @_ZSt16__ostream_insertIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_PKS3_l(%"class.std::basic_ostream"*, i8*, i64) #0

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt6vectorI8TestCaseSaIS0_EE13_M_insert_auxEN9__gnu_cxx17__normal_iteratorIPS0_S2_EERKS0_(%"class.std::vector"* nocapture %this, %class.TestCase* %__position.coerce, %class.TestCase* %__x) #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator.0", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator.0", align 1
  %5 = alloca i32, align 4
  %6 = alloca %"class.std::allocator.0", align 1
  %7 = alloca i32, align 4
  %8 = alloca %"class.std::allocator.0", align 1
  %9 = alloca i32, align 4
  %10 = alloca %"class.std::allocator.0", align 1
  %11 = alloca i32, align 4
  %12 = alloca %"class.std::allocator.0", align 1
  %13 = alloca i32, align 4
  %14 = alloca %"class.std::allocator.0", align 1
  %15 = alloca i32, align 4
  %16 = alloca %"class.std::allocator.0", align 1
  %17 = alloca i32, align 4
  %18 = alloca %"class.std::allocator.0", align 1
  %__x_copy = alloca %class.TestCase, align 8
  %19 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 1
  %20 = load %class.TestCase** %19, align 8, !tbaa !28
  %21 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 2
  %22 = load %class.TestCase** %21, align 8, !tbaa !29
  %23 = icmp eq %class.TestCase* %20, %22
  br i1 %23, label %_ZNKSt6vectorI8TestCaseSaIS0_EE12_M_check_lenEmPKc.exit, label %24

; <label>:24                                      ; preds = %0
  %25 = icmp eq %class.TestCase* %20, null
  br i1 %25, label %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit, label %26

; <label>:26                                      ; preds = %24
  %27 = getelementptr inbounds %class.TestCase* %20, i64 0, i32 0
  %28 = getelementptr inbounds %class.TestCase* %20, i64 -1, i32 0
  call void @_ZNSsC1ERKSs(%"class.std::basic_string"* %27, %"class.std::basic_string"* %28)
  %29 = getelementptr inbounds %class.TestCase* %20, i64 0, i32 1
  %30 = getelementptr inbounds %class.TestCase* %20, i64 -1, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %29, %"class.std::basic_string"* %30)
          to label %_ZN8TestCaseC2ERKS_.exit.i.i unwind label %31

; <label>:31                                      ; preds = %26
  %32 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %33 = getelementptr inbounds %"class.std::allocator.0"* %18, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %33)
  %34 = getelementptr inbounds %class.TestCase* %20, i64 0, i32 0, i32 0, i32 0
  %35 = load i8** %34, align 8, !tbaa !1
  %36 = getelementptr inbounds i8* %35, i64 -24
  %37 = bitcast i8* %36 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %38 = icmp eq i8* %36, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %38, label %51, label %39, !prof !7

; <label>:39                                      ; preds = %31
  %40 = getelementptr inbounds i8* %35, i64 -8
  %41 = bitcast i8* %40 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %42, label %46

; <label>:42                                      ; preds = %39
  %43 = bitcast i32* %17 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %43)
  %44 = atomicrmw volatile add i32* %41, i32 -1 acq_rel
  store i32 %44, i32* %17, align 4
  %45 = load volatile i32* %17, align 4
  call void @llvm.lifetime.end(i64 4, i8* %43)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i

; <label>:46                                      ; preds = %39
  %47 = load i32* %41, align 4, !tbaa !8
  %48 = add nsw i32 %47, -1
  store i32 %48, i32* %41, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i: ; preds = %46, %42
  %.0.i.i.i.i.i.i.i = phi i32 [ %45, %42 ], [ %47, %46 ]
  %49 = icmp slt i32 %.0.i.i.i.i.i.i.i, 1
  br i1 %49, label %50, label %51

; <label>:50                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %37, %"class.std::allocator.0"* %18) #1
  br label %51

; <label>:51                                      ; preds = %50, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i, %31
  call void @llvm.lifetime.end(i64 1, i8* %33)
  resume { i8*, i32 } %32

_ZN8TestCaseC2ERKS_.exit.i.i:                     ; preds = %26
  %52 = getelementptr inbounds %class.TestCase* %20, i64 0, i32 2
  %53 = getelementptr inbounds %class.TestCase* %20, i64 -1, i32 2
  %54 = bitcast i32* %53 to i64*
  %55 = bitcast i32* %52 to i64*
  %56 = load i64* %54, align 4
  store i64 %56, i64* %55, align 4
  %.pre = load %class.TestCase** %19, align 8, !tbaa !28
  br label %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit

_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit: ; preds = %_ZN8TestCaseC2ERKS_.exit.i.i, %24
  %57 = phi %class.TestCase* [ null, %24 ], [ %.pre, %_ZN8TestCaseC2ERKS_.exit.i.i ]
  %58 = getelementptr inbounds %class.TestCase* %57, i64 1
  store %class.TestCase* %58, %class.TestCase** %19, align 8, !tbaa !28
  %59 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 0
  %60 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 0
  call void @_ZNSsC1ERKSs(%"class.std::basic_string"* %59, %"class.std::basic_string"* %60)
  %61 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 1
  %62 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %61, %"class.std::basic_string"* %62)
          to label %_ZN8TestCaseC2ERKS_.exit unwind label %63

; <label>:63                                      ; preds = %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit
  %64 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %65 = getelementptr inbounds %"class.std::allocator.0"* %16, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %65)
  %66 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 0, i32 0, i32 0
  %67 = load i8** %66, align 8, !tbaa !1
  %68 = getelementptr inbounds i8* %67, i64 -24
  %69 = bitcast i8* %68 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %70 = icmp eq i8* %68, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %70, label %83, label %71, !prof !7

; <label>:71                                      ; preds = %63
  %72 = getelementptr inbounds i8* %67, i64 -8
  %73 = bitcast i8* %72 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %74, label %78

; <label>:74                                      ; preds = %71
  %75 = bitcast i32* %15 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %75)
  %76 = atomicrmw volatile add i32* %73, i32 -1 acq_rel
  store i32 %76, i32* %15, align 4
  %77 = load volatile i32* %15, align 4
  call void @llvm.lifetime.end(i64 4, i8* %75)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

; <label>:78                                      ; preds = %71
  %79 = load i32* %73, align 4, !tbaa !8
  %80 = add nsw i32 %79, -1
  store i32 %80, i32* %73, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i: ; preds = %78, %74
  %.0.i.i.i.i.i = phi i32 [ %77, %74 ], [ %79, %78 ]
  %81 = icmp slt i32 %.0.i.i.i.i.i, 1
  br i1 %81, label %82, label %83

; <label>:82                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %69, %"class.std::allocator.0"* %16) #1
  br label %83

; <label>:83                                      ; preds = %82, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i, %63
  call void @llvm.lifetime.end(i64 1, i8* %65)
  resume { i8*, i32 } %64

_ZN8TestCaseC2ERKS_.exit:                         ; preds = %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit
  %84 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 2
  %85 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 2
  %86 = bitcast i32* %85 to i64*
  %87 = bitcast i32* %84 to i64*
  %88 = load i64* %86, align 4
  store i64 %88, i64* %87, align 8
  %89 = load %class.TestCase** %19, align 8, !tbaa !28
  %90 = getelementptr inbounds %class.TestCase* %89, i64 -2
  %91 = ptrtoint %class.TestCase* %90 to i64
  %92 = ptrtoint %class.TestCase* %__position.coerce to i64
  %93 = sub i64 %91, %92
  %94 = icmp sgt i64 %93, 0
  br i1 %94, label %.lr.ph.i.i.i.i, label %_ZSt13copy_backwardIP8TestCaseS1_ET0_T_S3_S2_.exit

.lr.ph.i.i.i.i:                                   ; preds = %_ZN8TestCaseC2ERKS_.exit
  %95 = getelementptr inbounds %class.TestCase* %89, i64 -1
  %96 = sdiv exact i64 %93, 24
  br label %97

; <label>:97                                      ; preds = %.noexc2, %.lr.ph.i.i.i.i
  %__n.04.i.i.i.i = phi i64 [ %96, %.lr.ph.i.i.i.i ], [ %111, %.noexc2 ]
  %.03.i.i.i.i = phi %class.TestCase* [ %95, %.lr.ph.i.i.i.i ], [ %98, %.noexc2 ]
  %.012.i.i.i.i = phi %class.TestCase* [ %90, %.lr.ph.i.i.i.i ], [ %99, %.noexc2 ]
  %98 = getelementptr inbounds %class.TestCase* %.03.i.i.i.i, i64 -1
  %99 = getelementptr inbounds %class.TestCase* %.012.i.i.i.i, i64 -1
  %100 = getelementptr inbounds %class.TestCase* %98, i64 0, i32 0
  %101 = getelementptr inbounds %class.TestCase* %99, i64 0, i32 0
  %102 = invoke %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %100, %"class.std::basic_string"* %101)
          to label %.noexc unwind label %.loopexit

.noexc:                                           ; preds = %97
  %103 = getelementptr inbounds %class.TestCase* %.03.i.i.i.i, i64 -1, i32 1
  %104 = getelementptr inbounds %class.TestCase* %.012.i.i.i.i, i64 -1, i32 1
  %105 = invoke %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %103, %"class.std::basic_string"* %104)
          to label %.noexc2 unwind label %.loopexit

.noexc2:                                          ; preds = %.noexc
  %106 = getelementptr inbounds %class.TestCase* %.03.i.i.i.i, i64 -1, i32 2
  %107 = getelementptr inbounds %class.TestCase* %.012.i.i.i.i, i64 -1, i32 2
  %108 = bitcast i32* %107 to i64*
  %109 = bitcast i32* %106 to i64*
  %110 = load i64* %108, align 4
  store i64 %110, i64* %109, align 4
  %111 = add nsw i64 %__n.04.i.i.i.i, -1
  %112 = icmp sgt i64 %111, 0
  br i1 %112, label %97, label %_ZSt13copy_backwardIP8TestCaseS1_ET0_T_S3_S2_.exit

_ZSt13copy_backwardIP8TestCaseS1_ET0_T_S3_S2_.exit: ; preds = %.noexc2, %_ZN8TestCaseC2ERKS_.exit
  %113 = getelementptr inbounds %class.TestCase* %__position.coerce, i64 0, i32 0
  %114 = invoke %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %113, %"class.std::basic_string"* %59)
          to label %.noexc3 unwind label %.nonloopexit

.noexc3:                                          ; preds = %_ZSt13copy_backwardIP8TestCaseS1_ET0_T_S3_S2_.exit
  %115 = getelementptr inbounds %class.TestCase* %__position.coerce, i64 0, i32 1
  %116 = invoke %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"* %115, %"class.std::basic_string"* %61)
          to label %117 unwind label %.nonloopexit

; <label>:117                                     ; preds = %.noexc3
  %118 = getelementptr inbounds %class.TestCase* %__position.coerce, i64 0, i32 2
  %119 = bitcast i32* %118 to i64*
  %120 = load i64* %87, align 8
  store i64 %120, i64* %119, align 4
  %121 = getelementptr inbounds %"class.std::allocator.0"* %14, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %121)
  %122 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 1, i32 0, i32 0
  %123 = load i8** %122, align 8, !tbaa !1
  %124 = getelementptr inbounds i8* %123, i64 -24
  %125 = bitcast i8* %124 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %126 = icmp eq i8* %124, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %126, label %139, label %127, !prof !7

; <label>:127                                     ; preds = %117
  %128 = getelementptr inbounds i8* %123, i64 -8
  %129 = bitcast i8* %128 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %130, label %134

; <label>:130                                     ; preds = %127
  %131 = bitcast i32* %13 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %131)
  %132 = atomicrmw volatile add i32* %129, i32 -1 acq_rel
  store i32 %132, i32* %13, align 4
  %133 = load volatile i32* %13, align 4
  call void @llvm.lifetime.end(i64 4, i8* %131)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i6

; <label>:134                                     ; preds = %127
  %135 = load i32* %129, align 4, !tbaa !8
  %136 = add nsw i32 %135, -1
  store i32 %136, i32* %129, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i6

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i6: ; preds = %134, %130
  %.0.i.i.i.i.i5 = phi i32 [ %133, %130 ], [ %135, %134 ]
  %137 = icmp slt i32 %.0.i.i.i.i.i5, 1
  br i1 %137, label %138, label %139

; <label>:138                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i6
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %125, %"class.std::allocator.0"* %14) #1
  br label %139

; <label>:139                                     ; preds = %138, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i6, %117
  call void @llvm.lifetime.end(i64 1, i8* %121)
  %140 = getelementptr inbounds %"class.std::allocator.0"* %12, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %140)
  %141 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 0, i32 0, i32 0
  %142 = load i8** %141, align 8, !tbaa !1
  %143 = getelementptr inbounds i8* %142, i64 -24
  %144 = bitcast i8* %143 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %145 = icmp eq i8* %143, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %145, label %_ZN8TestCaseD2Ev.exit, label %146, !prof !7

; <label>:146                                     ; preds = %139
  %147 = getelementptr inbounds i8* %142, i64 -8
  %148 = bitcast i8* %147 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %149, label %153

; <label>:149                                     ; preds = %146
  %150 = bitcast i32* %11 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %150)
  %151 = atomicrmw volatile add i32* %148, i32 -1 acq_rel
  store i32 %151, i32* %11, align 4
  %152 = load volatile i32* %11, align 4
  call void @llvm.lifetime.end(i64 4, i8* %150)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i

; <label>:153                                     ; preds = %146
  %154 = load i32* %148, align 4, !tbaa !8
  %155 = add nsw i32 %154, -1
  store i32 %155, i32* %148, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i: ; preds = %153, %149
  %.0.i.i.i.i1.i = phi i32 [ %152, %149 ], [ %154, %153 ]
  %156 = icmp slt i32 %.0.i.i.i.i1.i, 1
  br i1 %156, label %157, label %_ZN8TestCaseD2Ev.exit

; <label>:157                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %144, %"class.std::allocator.0"* %12) #1
  br label %_ZN8TestCaseD2Ev.exit

.loopexit:                                        ; preds = %.noexc, %97
  %lpad.loopexit = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %158

.nonloopexit:                                     ; preds = %.noexc3, %_ZSt13copy_backwardIP8TestCaseS1_ET0_T_S3_S2_.exit
  %lpad.nonloopexit = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  br label %158

; <label>:158                                     ; preds = %.nonloopexit, %.loopexit
  %lpad.phi = phi { i8*, i32 } [ %lpad.loopexit, %.loopexit ], [ %lpad.nonloopexit, %.nonloopexit ]
  %159 = extractvalue { i8*, i32 } %lpad.phi, 0
  %160 = extractvalue { i8*, i32 } %lpad.phi, 1
  %161 = getelementptr inbounds %"class.std::allocator.0"* %10, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %161)
  %162 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 1, i32 0, i32 0
  %163 = load i8** %162, align 8, !tbaa !1
  %164 = getelementptr inbounds i8* %163, i64 -24
  %165 = bitcast i8* %164 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %166 = icmp eq i8* %164, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %166, label %179, label %167, !prof !7

; <label>:167                                     ; preds = %158
  %168 = getelementptr inbounds i8* %163, i64 -8
  %169 = bitcast i8* %168 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %170, label %174

; <label>:170                                     ; preds = %167
  %171 = bitcast i32* %9 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %171)
  %172 = atomicrmw volatile add i32* %169, i32 -1 acq_rel
  store i32 %172, i32* %9, align 4
  %173 = load volatile i32* %9, align 4
  call void @llvm.lifetime.end(i64 4, i8* %171)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i8

; <label>:174                                     ; preds = %167
  %175 = load i32* %169, align 4, !tbaa !8
  %176 = add nsw i32 %175, -1
  store i32 %176, i32* %169, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i8

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i8: ; preds = %174, %170
  %.0.i.i.i.i.i7 = phi i32 [ %173, %170 ], [ %175, %174 ]
  %177 = icmp slt i32 %.0.i.i.i.i.i7, 1
  br i1 %177, label %178, label %179

; <label>:178                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i8
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %165, %"class.std::allocator.0"* %10) #1
  br label %179

; <label>:179                                     ; preds = %178, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i8, %158
  call void @llvm.lifetime.end(i64 1, i8* %161)
  %180 = getelementptr inbounds %"class.std::allocator.0"* %8, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %180)
  %181 = getelementptr inbounds %class.TestCase* %__x_copy, i64 0, i32 0, i32 0, i32 0
  %182 = load i8** %181, align 8, !tbaa !1
  %183 = getelementptr inbounds i8* %182, i64 -24
  %184 = bitcast i8* %183 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %185 = icmp eq i8* %183, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %185, label %_ZN8TestCaseD2Ev.exit11, label %186, !prof !7

; <label>:186                                     ; preds = %179
  %187 = getelementptr inbounds i8* %182, i64 -8
  %188 = bitcast i8* %187 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %189, label %193

; <label>:189                                     ; preds = %186
  %190 = bitcast i32* %7 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %190)
  %191 = atomicrmw volatile add i32* %188, i32 -1 acq_rel
  store i32 %191, i32* %7, align 4
  %192 = load volatile i32* %7, align 4
  call void @llvm.lifetime.end(i64 4, i8* %190)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10

; <label>:193                                     ; preds = %186
  %194 = load i32* %188, align 4, !tbaa !8
  %195 = add nsw i32 %194, -1
  store i32 %195, i32* %188, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10: ; preds = %193, %189
  %.0.i.i.i.i1.i9 = phi i32 [ %192, %189 ], [ %194, %193 ]
  %196 = icmp slt i32 %.0.i.i.i.i1.i9, 1
  br i1 %196, label %197, label %_ZN8TestCaseD2Ev.exit11

; <label>:197                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %184, %"class.std::allocator.0"* %8) #1
  br label %_ZN8TestCaseD2Ev.exit11

_ZNKSt6vectorI8TestCaseSaIS0_EE12_M_check_lenEmPKc.exit: ; preds = %0
  %198 = getelementptr inbounds %"class.std::vector"* %this, i64 0, i32 0, i32 0, i32 0
  %199 = load %class.TestCase** %198, align 8, !tbaa !25
  %200 = ptrtoint %class.TestCase* %20 to i64
  %201 = ptrtoint %class.TestCase* %199 to i64
  %202 = sub i64 %200, %201
  %203 = sdiv exact i64 %202, 24
  %204 = icmp eq %class.TestCase* %20, %199
  %205 = select i1 %204, i64 1, i64 %203
  %uadd.i = call { i64, i1 } @llvm.uadd.with.overflow.i64(i64 %203, i64 %205)
  %206 = extractvalue { i64, i1 } %uadd.i, 0
  %207 = extractvalue { i64, i1 } %uadd.i, 1
  %208 = icmp ugt i64 %206, 768614336404564650
  %or.cond.i = or i1 %207, %208
  %209 = select i1 %or.cond.i, i64 768614336404564650, i64 %206
  %210 = ptrtoint %class.TestCase* %__position.coerce to i64
  %211 = sub i64 %210, %201
  %212 = sdiv exact i64 %211, 24
  %213 = icmp eq i64 %209, 0
  br i1 %213, label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE11_M_allocateEm.exit, label %214

; <label>:214                                     ; preds = %_ZNKSt6vectorI8TestCaseSaIS0_EE12_M_check_lenEmPKc.exit
  %215 = icmp ugt i64 %209, 768614336404564650
  br i1 %215, label %216, label %_ZN9__gnu_cxx13new_allocatorI8TestCaseE8allocateEmPKv.exit.i

; <label>:216                                     ; preds = %214
  call void @_ZSt17__throw_bad_allocv() #9
  unreachable

_ZN9__gnu_cxx13new_allocatorI8TestCaseE8allocateEmPKv.exit.i: ; preds = %214
  %217 = mul i64 %209, 24
  %218 = call noalias i8* @_Znwm(i64 %217)
  %219 = bitcast i8* %218 to %class.TestCase*
  br label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE11_M_allocateEm.exit

_ZNSt12_Vector_baseI8TestCaseSaIS0_EE11_M_allocateEm.exit: ; preds = %_ZN9__gnu_cxx13new_allocatorI8TestCaseE8allocateEmPKv.exit.i, %_ZNKSt6vectorI8TestCaseSaIS0_EE12_M_check_lenEmPKc.exit
  %220 = phi %class.TestCase* [ %219, %_ZN9__gnu_cxx13new_allocatorI8TestCaseE8allocateEmPKv.exit.i ], [ null, %_ZNKSt6vectorI8TestCaseSaIS0_EE12_M_check_lenEmPKc.exit ]
  %221 = getelementptr inbounds %class.TestCase* %220, i64 %212
  %222 = icmp eq %class.TestCase* %221, null
  br i1 %222, label %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit16, label %223

; <label>:223                                     ; preds = %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE11_M_allocateEm.exit
  %224 = getelementptr inbounds %class.TestCase* %221, i64 0, i32 0
  %225 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %224, %"class.std::basic_string"* %225)
          to label %.noexc15 unwind label %265

.noexc15:                                         ; preds = %223
  %226 = getelementptr inbounds %class.TestCase* %220, i64 %212, i32 1
  %227 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %226, %"class.std::basic_string"* %227)
          to label %_ZN8TestCaseC2ERKS_.exit.i.i14 unwind label %228

; <label>:228                                     ; preds = %.noexc15
  %229 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %230 = getelementptr inbounds %"class.std::allocator.0"* %6, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %230)
  %231 = getelementptr inbounds %class.TestCase* %221, i64 0, i32 0, i32 0, i32 0
  %232 = load i8** %231, align 8, !tbaa !1
  %233 = getelementptr inbounds i8* %232, i64 -24
  %234 = bitcast i8* %233 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %235 = icmp eq i8* %233, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %235, label %.body, label %236, !prof !7

; <label>:236                                     ; preds = %228
  %237 = getelementptr inbounds i8* %232, i64 -8
  %238 = bitcast i8* %237 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %239, label %243

; <label>:239                                     ; preds = %236
  %240 = bitcast i32* %5 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %240)
  %241 = atomicrmw volatile add i32* %238, i32 -1 acq_rel
  store i32 %241, i32* %5, align 4
  %242 = load volatile i32* %5, align 4
  call void @llvm.lifetime.end(i64 4, i8* %240)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13

; <label>:243                                     ; preds = %236
  %244 = load i32* %238, align 4, !tbaa !8
  %245 = add nsw i32 %244, -1
  store i32 %245, i32* %238, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13: ; preds = %243, %239
  %.0.i.i.i.i.i.i.i12 = phi i32 [ %242, %239 ], [ %244, %243 ]
  %246 = icmp slt i32 %.0.i.i.i.i.i.i.i12, 1
  br i1 %246, label %247, label %.body

; <label>:247                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %234, %"class.std::allocator.0"* %6) #1
  br label %.body

_ZN8TestCaseC2ERKS_.exit.i.i14:                   ; preds = %.noexc15
  %248 = getelementptr inbounds %class.TestCase* %220, i64 %212, i32 2
  %249 = getelementptr inbounds %class.TestCase* %__x, i64 0, i32 2
  %250 = bitcast i32* %249 to i64*
  %251 = bitcast i32* %248 to i64*
  %252 = load i64* %250, align 4
  store i64 %252, i64* %251, align 4
  br label %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit16

_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit16: ; preds = %_ZN8TestCaseC2ERKS_.exit.i.i14, %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE11_M_allocateEm.exit
  %253 = load %class.TestCase** %198, align 8, !tbaa !25
  %254 = invoke %class.TestCase* @_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIP8TestCaseS3_EET0_T_S5_S4_(%class.TestCase* %253, %class.TestCase* %__position.coerce, %class.TestCase* %220)
          to label %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit unwind label %265

_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit: ; preds = %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit16
  %255 = getelementptr inbounds %class.TestCase* %254, i64 1
  %256 = load %class.TestCase** %19, align 8, !tbaa !28
  %257 = invoke %class.TestCase* @_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIP8TestCaseS3_EET0_T_S5_S4_(%class.TestCase* %__position.coerce, %class.TestCase* %256, %class.TestCase* %255)
          to label %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit19 unwind label %265

_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit19: ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit
  %258 = load %class.TestCase** %198, align 8, !tbaa !25
  %259 = load %class.TestCase** %19, align 8, !tbaa !28
  call void @_ZNSt12_Destroy_auxILb0EE9__destroyIP8TestCaseEEvT_S4_(%class.TestCase* %258, %class.TestCase* %259)
  %260 = load %class.TestCase** %198, align 8, !tbaa !25
  %261 = icmp eq %class.TestCase* %260, null
  br i1 %261, label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit, label %262

; <label>:262                                     ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit19
  %263 = bitcast %class.TestCase* %260 to i8*
  call void @_ZdlPv(i8* %263) #1
  br label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit

_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit: ; preds = %262, %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit19
  store %class.TestCase* %220, %class.TestCase** %198, align 8, !tbaa !25
  store %class.TestCase* %257, %class.TestCase** %19, align 8, !tbaa !28
  %264 = getelementptr inbounds %class.TestCase* %220, i64 %209
  store %class.TestCase* %264, %class.TestCase** %21, align 8, !tbaa !29
  br label %_ZN8TestCaseD2Ev.exit

; <label>:265                                     ; preds = %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit, %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit16, %223
  %__new_finish.0 = phi %class.TestCase* [ %220, %223 ], [ null, %_ZN9__gnu_cxx14__alloc_traitsISaI8TestCaseEE9constructIS1_EEvRS2_PS1_RKT_.exit16 ], [ %255, %_ZSt34__uninitialized_move_if_noexcept_aIP8TestCaseS1_SaIS0_EET0_T_S4_S3_RT1_.exit ]
  %266 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  br label %.body

.body:                                            ; preds = %265, %247, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13, %228
  %__new_finish.0.lpad-body = phi %class.TestCase* [ %__new_finish.0, %265 ], [ %220, %247 ], [ %220, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13 ], [ %220, %228 ]
  %eh.lpad-body = phi { i8*, i32 } [ %266, %265 ], [ %229, %247 ], [ %229, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i13 ], [ %229, %228 ]
  %267 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  %268 = call i8* @__cxa_begin_catch(i8* %267) #1
  %269 = icmp eq %class.TestCase* %__new_finish.0.lpad-body, null
  br i1 %269, label %270, label %312

; <label>:270                                     ; preds = %.body
  %271 = getelementptr inbounds %"class.std::allocator.0"* %4, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %271)
  %272 = getelementptr inbounds %class.TestCase* %220, i64 %212, i32 1, i32 0, i32 0
  %273 = load i8** %272, align 8, !tbaa !1
  %274 = getelementptr inbounds i8* %273, i64 -24
  %275 = bitcast i8* %274 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %276 = icmp eq i8* %274, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %276, label %289, label %277, !prof !7

; <label>:277                                     ; preds = %270
  %278 = getelementptr inbounds i8* %273, i64 -8
  %279 = bitcast i8* %278 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %280, label %284

; <label>:280                                     ; preds = %277
  %281 = bitcast i32* %3 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %281)
  %282 = atomicrmw volatile add i32* %279, i32 -1 acq_rel
  store i32 %282, i32* %3, align 4
  %283 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %281)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i21

; <label>:284                                     ; preds = %277
  %285 = load i32* %279, align 4, !tbaa !8
  %286 = add nsw i32 %285, -1
  store i32 %286, i32* %279, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i21

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i21: ; preds = %284, %280
  %.0.i.i.i.i.i.i.i20 = phi i32 [ %283, %280 ], [ %285, %284 ]
  %287 = icmp slt i32 %.0.i.i.i.i.i.i.i20, 1
  br i1 %287, label %288, label %289

; <label>:288                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i21
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %275, %"class.std::allocator.0"* %4) #1
  br label %289

; <label>:289                                     ; preds = %288, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i.i21, %270
  call void @llvm.lifetime.end(i64 1, i8* %271)
  %290 = getelementptr inbounds %"class.std::allocator.0"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %290)
  %291 = getelementptr inbounds %class.TestCase* %221, i64 0, i32 0, i32 0, i32 0
  %292 = load i8** %291, align 8, !tbaa !1
  %293 = getelementptr inbounds i8* %292, i64 -24
  %294 = bitcast i8* %293 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %295 = icmp eq i8* %293, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %295, label %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit, label %296, !prof !7

; <label>:296                                     ; preds = %289
  %297 = getelementptr inbounds i8* %292, i64 -8
  %298 = bitcast i8* %297 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %299, label %303

; <label>:299                                     ; preds = %296
  %300 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %300)
  %301 = atomicrmw volatile add i32* %298, i32 -1 acq_rel
  store i32 %301, i32* %1, align 4
  %302 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %300)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i.i

; <label>:303                                     ; preds = %296
  %304 = load i32* %298, align 4, !tbaa !8
  %305 = add nsw i32 %304, -1
  store i32 %305, i32* %298, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i.i: ; preds = %303, %299
  %.0.i.i.i.i1.i.i.i = phi i32 [ %302, %299 ], [ %304, %303 ]
  %306 = icmp slt i32 %.0.i.i.i.i1.i.i.i, 1
  br i1 %306, label %307, label %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit

; <label>:307                                     ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %294, %"class.std::allocator.0"* %2) #1
  br label %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit

; <label>:308                                     ; preds = %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit23, %312
  %309 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  %310 = extractvalue { i8*, i32 } %309, 0
  %311 = extractvalue { i8*, i32 } %309, 1
  invoke void @__cxa_end_catch()
          to label %_ZN8TestCaseD2Ev.exit11 unwind label %318

; <label>:312                                     ; preds = %.body
  invoke void @_ZNSt12_Destroy_auxILb0EE9__destroyIP8TestCaseEEvT_S4_(%class.TestCase* %220, %class.TestCase* %__new_finish.0.lpad-body)
          to label %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit unwind label %308

_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit:  ; preds = %312, %307, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i.i, %289
  %313 = icmp eq %class.TestCase* %220, null
  br i1 %313, label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit23, label %314

; <label>:314                                     ; preds = %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit
  %315 = bitcast %class.TestCase* %220 to i8*
  call void @_ZdlPv(i8* %315) #1
  br label %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit23

_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit23: ; preds = %314, %_ZSt8_DestroyIP8TestCaseS0_EvT_S2_RSaIT0_E.exit
  invoke void @__cxa_rethrow() #9
          to label %321 unwind label %308

_ZN8TestCaseD2Ev.exit:                            ; preds = %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit, %157, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i, %139
  ret void

_ZN8TestCaseD2Ev.exit11:                          ; preds = %308, %197, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10, %179
  %.01 = phi i32 [ %311, %308 ], [ %160, %179 ], [ %160, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10 ], [ %160, %197 ]
  %.0 = phi i8* [ %310, %308 ], [ %159, %179 ], [ %159, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i10 ], [ %159, %197 ]
  %316 = insertvalue { i8*, i32 } undef, i8* %.0, 0
  %317 = insertvalue { i8*, i32 } %316, i32 %.01, 1
  resume { i8*, i32 } %317

; <label>:318                                     ; preds = %308
  %319 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %320 = extractvalue { i8*, i32 } %319, 0
  call void @__clang_call_terminate(i8* %320) #10
  unreachable

; <label>:321                                     ; preds = %_ZNSt12_Vector_baseI8TestCaseSaIS0_EE13_M_deallocateEPS0_m.exit23
  unreachable
}

declare void @__cxa_rethrow()

declare void @__cxa_end_catch()

; Function Attrs: nobuiltin nounwind
declare void @_ZdlPv(i8*) #5

; Function Attrs: uwtable
define linkonce_odr void @_ZNSt12_Destroy_auxILb0EE9__destroyIP8TestCaseEEvT_S4_(%class.TestCase* readonly %__first, %class.TestCase* readnone %__last) #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator.0", align 1
  %3 = alloca i32, align 4
  %4 = alloca %"class.std::allocator.0", align 1
  %5 = icmp eq %class.TestCase* %__first, %__last
  br i1 %5, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %0
  %6 = getelementptr inbounds %"class.std::allocator.0"* %4, i64 0, i32 0
  %7 = getelementptr inbounds %"class.std::allocator.0"* %2, i64 0, i32 0
  %8 = bitcast i32* %1 to i8*
  %9 = bitcast i32* %3 to i8*
  br label %10

; <label>:10                                      ; preds = %_ZSt8_DestroyI8TestCaseEvPT_.exit, %.lr.ph
  %.01 = phi %class.TestCase* [ %__first, %.lr.ph ], [ %44, %_ZSt8_DestroyI8TestCaseEvPT_.exit ]
  call void @llvm.lifetime.start(i64 1, i8* %6)
  %11 = getelementptr inbounds %class.TestCase* %.01, i64 0, i32 1, i32 0, i32 0
  %12 = load i8** %11, align 8, !tbaa !1
  %13 = getelementptr inbounds i8* %12, i64 -24
  %14 = bitcast i8* %13 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %15 = icmp eq i8* %13, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %15, label %27, label %16, !prof !7

; <label>:16                                      ; preds = %10
  %17 = getelementptr inbounds i8* %12, i64 -8
  %18 = bitcast i8* %17 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %19, label %22

; <label>:19                                      ; preds = %16
  call void @llvm.lifetime.start(i64 4, i8* %9)
  %20 = atomicrmw volatile add i32* %18, i32 -1 acq_rel
  store i32 %20, i32* %3, align 4
  %21 = load volatile i32* %3, align 4
  call void @llvm.lifetime.end(i64 4, i8* %9)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

; <label>:22                                      ; preds = %16
  %23 = load i32* %18, align 4, !tbaa !8
  %24 = add nsw i32 %23, -1
  store i32 %24, i32* %18, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i: ; preds = %22, %19
  %.0.i.i.i.i.i.i = phi i32 [ %21, %19 ], [ %23, %22 ]
  %25 = icmp slt i32 %.0.i.i.i.i.i.i, 1
  br i1 %25, label %26, label %27

; <label>:26                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %14, %"class.std::allocator.0"* %4) #1
  br label %27

; <label>:27                                      ; preds = %26, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %10
  call void @llvm.lifetime.end(i64 1, i8* %6)
  call void @llvm.lifetime.start(i64 1, i8* %7)
  %28 = getelementptr inbounds %class.TestCase* %.01, i64 0, i32 0, i32 0, i32 0
  %29 = load i8** %28, align 8, !tbaa !1
  %30 = getelementptr inbounds i8* %29, i64 -24
  %31 = bitcast i8* %30 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %32 = icmp eq i8* %30, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %32, label %_ZSt8_DestroyI8TestCaseEvPT_.exit, label %33, !prof !7

; <label>:33                                      ; preds = %27
  %34 = getelementptr inbounds i8* %29, i64 -8
  %35 = bitcast i8* %34 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %36, label %39

; <label>:36                                      ; preds = %33
  call void @llvm.lifetime.start(i64 4, i8* %8)
  %37 = atomicrmw volatile add i32* %35, i32 -1 acq_rel
  store i32 %37, i32* %1, align 4
  %38 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %8)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i

; <label>:39                                      ; preds = %33
  %40 = load i32* %35, align 4, !tbaa !8
  %41 = add nsw i32 %40, -1
  store i32 %41, i32* %35, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i: ; preds = %39, %36
  %.0.i.i.i.i1.i.i = phi i32 [ %38, %36 ], [ %40, %39 ]
  %42 = icmp slt i32 %.0.i.i.i.i1.i.i, 1
  br i1 %42, label %43, label %_ZSt8_DestroyI8TestCaseEvPT_.exit

; <label>:43                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %31, %"class.std::allocator.0"* %2) #1
  br label %_ZSt8_DestroyI8TestCaseEvPT_.exit

_ZSt8_DestroyI8TestCaseEvPT_.exit:                ; preds = %43, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i2.i.i, %27
  call void @llvm.lifetime.end(i64 1, i8* %7)
  %44 = getelementptr inbounds %class.TestCase* %.01, i64 1
  %45 = icmp eq %class.TestCase* %44, %__last
  br i1 %45, label %._crit_edge, label %10

._crit_edge:                                      ; preds = %_ZSt8_DestroyI8TestCaseEvPT_.exit, %0
  ret void
}

; Function Attrs: uwtable
define linkonce_odr %class.TestCase* @_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIP8TestCaseS3_EET0_T_S5_S4_(%class.TestCase* %__first, %class.TestCase* readnone %__last, %class.TestCase* %__result) #2 align 2 {
  %1 = alloca i32, align 4
  %2 = alloca %"class.std::allocator.0", align 1
  %3 = icmp eq %class.TestCase* %__first, %__last
  br i1 %3, label %._crit_edge, label %.lr.ph

.lr.ph:                                           ; preds = %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit, %0
  %__cur.06 = phi %class.TestCase* [ %36, %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit ], [ %__result, %0 ]
  %.05 = phi %class.TestCase* [ %35, %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit ], [ %__first, %0 ]
  %4 = icmp eq %class.TestCase* %__cur.06, null
  br i1 %4, label %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit, label %5

; <label>:5                                       ; preds = %.lr.ph
  %6 = getelementptr inbounds %class.TestCase* %__cur.06, i64 0, i32 0
  %7 = getelementptr inbounds %class.TestCase* %.05, i64 0, i32 0
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %6, %"class.std::basic_string"* %7)
          to label %.noexc unwind label %38

.noexc:                                           ; preds = %5
  %8 = getelementptr inbounds %class.TestCase* %__cur.06, i64 0, i32 1
  %9 = getelementptr inbounds %class.TestCase* %.05, i64 0, i32 1
  invoke void @_ZNSsC1ERKSs(%"class.std::basic_string"* %8, %"class.std::basic_string"* %9)
          to label %_ZN8TestCaseC2ERKS_.exit.i unwind label %10

; <label>:10                                      ; preds = %.noexc
  %11 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %12 = getelementptr inbounds %"class.std::allocator.0"* %2, i64 0, i32 0
  call void @llvm.lifetime.start(i64 1, i8* %12)
  %13 = getelementptr inbounds %class.TestCase* %__cur.06, i64 0, i32 0, i32 0, i32 0
  %14 = load i8** %13, align 8, !tbaa !1
  %15 = getelementptr inbounds i8* %14, i64 -24
  %16 = bitcast i8* %15 to %"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*
  %17 = icmp eq i8* %15, bitcast ([0 x i64]* @_ZNSs4_Rep20_S_empty_rep_storageE to i8*)
  br i1 %17, label %.body, label %18, !prof !7

; <label>:18                                      ; preds = %10
  %19 = getelementptr inbounds i8* %14, i64 -8
  %20 = bitcast i8* %19 to i32*
  br i1 icmp ne (i8* bitcast (i32 (i32*, void (i8*)*)* @__pthread_key_create to i8*), i8* null), label %21, label %25

; <label>:21                                      ; preds = %18
  %22 = bitcast i32* %1 to i8*
  call void @llvm.lifetime.start(i64 4, i8* %22)
  %23 = atomicrmw volatile add i32* %20, i32 -1 acq_rel
  store i32 %23, i32* %1, align 4
  %24 = load volatile i32* %1, align 4
  call void @llvm.lifetime.end(i64 4, i8* %22)
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

; <label>:25                                      ; preds = %18
  %26 = load i32* %20, align 4, !tbaa !8
  %27 = add nsw i32 %26, -1
  store i32 %27, i32* %20, align 4, !tbaa !8
  br label %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i

_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i: ; preds = %25, %21
  %.0.i.i.i.i.i.i = phi i32 [ %24, %21 ], [ %26, %25 ]
  %28 = icmp slt i32 %.0.i.i.i.i.i.i, 1
  br i1 %28, label %29, label %.body

; <label>:29                                      ; preds = %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i
  call void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"* %16, %"class.std::allocator.0"* %2) #1
  br label %.body

_ZN8TestCaseC2ERKS_.exit.i:                       ; preds = %.noexc
  %30 = getelementptr inbounds %class.TestCase* %__cur.06, i64 0, i32 2
  %31 = getelementptr inbounds %class.TestCase* %.05, i64 0, i32 2
  %32 = bitcast i32* %31 to i64*
  %33 = bitcast i32* %30 to i64*
  %34 = load i64* %32, align 4
  store i64 %34, i64* %33, align 4
  br label %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit

_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit:     ; preds = %_ZN8TestCaseC2ERKS_.exit.i, %.lr.ph
  %35 = getelementptr inbounds %class.TestCase* %.05, i64 1
  %36 = getelementptr inbounds %class.TestCase* %__cur.06, i64 1
  %37 = icmp eq %class.TestCase* %35, %__last
  br i1 %37, label %._crit_edge, label %.lr.ph

; <label>:38                                      ; preds = %5
  %39 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  br label %.body

.body:                                            ; preds = %38, %29, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i, %10
  %eh.lpad-body = phi { i8*, i32 } [ %39, %38 ], [ %11, %29 ], [ %11, %_ZN9__gnu_cxxL27__exchange_and_add_dispatchEPii.exit.i.i.i.i.i ], [ %11, %10 ]
  %40 = extractvalue { i8*, i32 } %eh.lpad-body, 0
  %41 = call i8* @__cxa_begin_catch(i8* %40) #1
  invoke void @_ZNSt12_Destroy_auxILb0EE9__destroyIP8TestCaseEEvT_S4_(%class.TestCase* %__result, %class.TestCase* %__cur.06)
          to label %_ZSt8_DestroyIP8TestCaseEvT_S2_.exit unwind label %42

_ZSt8_DestroyIP8TestCaseEvT_S2_.exit:             ; preds = %.body
  invoke void @__cxa_rethrow() #9
          to label %48 unwind label %42

._crit_edge:                                      ; preds = %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit, %0
  %__cur.0.lcssa = phi %class.TestCase* [ %__result, %0 ], [ %36, %_ZSt10_ConstructI8TestCaseS0_EvPT_RKT0_.exit ]
  ret %class.TestCase* %__cur.0.lcssa

; <label>:42                                      ; preds = %_ZSt8_DestroyIP8TestCaseEvT_S2_.exit, %.body
  %43 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          cleanup
  invoke void @__cxa_end_catch()
          to label %44 unwind label %45

; <label>:44                                      ; preds = %42
  resume { i8*, i32 } %43

; <label>:45                                      ; preds = %42
  %46 = landingpad { i8*, i32 } personality i8* bitcast (i32 (...)* @__gxx_personality_v0 to i8*)
          catch i8* null
  %47 = extractvalue { i8*, i32 } %46, 0
  call void @__clang_call_terminate(i8* %47) #10
  unreachable

; <label>:48                                      ; preds = %_ZSt8_DestroyIP8TestCaseEvT_S2_.exit
  unreachable
}

; Function Attrs: noreturn
declare void @_ZSt17__throw_bad_allocv() #4

; Function Attrs: nobuiltin
declare noalias i8* @_Znwm(i64) #6

declare %"class.std::basic_string"* @_ZNSs6assignERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

declare void @_ZNSsC1ERKSs(%"class.std::basic_string"*, %"class.std::basic_string"*) #0

; Function Attrs: nounwind
declare void @_ZNSs4_Rep10_M_destroyERKSaIcE(%"struct.std::basic_string<char, std::char_traits<char>, std::allocator<char> >::_Rep"*, %"class.std::allocator.0"*) #7

; Function Attrs: nounwind
declare extern_weak i32 @__pthread_key_create(i32*, void (i8*)*) #7

define internal void @_GLOBAL__I_a() section ".text.startup" {
  tail call void @_ZNSt8ios_base4InitC1Ev(%"class.std::ios_base::Init"* @_ZStL8__ioinit)
  %1 = tail call i32 @__cxa_atexit(void (i8*)* bitcast (void (%"class.std::ios_base::Init"*)* @_ZNSt8ios_base4InitD1Ev to void (i8*)*), i8* getelementptr inbounds (%"class.std::ios_base::Init"* @_ZStL8__ioinit, i64 0, i32 0), i8* @__dso_handle) #1
  ret void
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #1

; Function Attrs: nounwind readnone
declare { i64, i1 } @llvm.uadd.with.overflow.i64(i64, i64) #8

attributes #0 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind }
attributes #2 = { uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { noinline noreturn nounwind }
attributes #4 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nobuiltin nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { nobuiltin "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { nounwind readnone }
attributes #9 = { noreturn }
attributes #10 = { noreturn nounwind }

!llvm.ident = !{!0}

!0 = metadata !{metadata !"Ubuntu clang version 3.4-1ubuntu3 (tags/RELEASE_34/final) (based on LLVM 3.4)"}
!1 = metadata !{metadata !2, metadata !4, i64 0}
!2 = metadata !{metadata !"_ZTSSs", metadata !3, i64 0}
!3 = metadata !{metadata !"_ZTSNSs12_Alloc_hiderE", metadata !4, i64 0}
!4 = metadata !{metadata !"any pointer", metadata !5, i64 0}
!5 = metadata !{metadata !"omnipotent char", metadata !6, i64 0}
!6 = metadata !{metadata !"Simple C/C++ TBAA"}
!7 = metadata !{metadata !"branch_weights", i32 64, i32 4}
!8 = metadata !{metadata !9, metadata !9, i64 0}
!9 = metadata !{metadata !"int", metadata !5, i64 0}
!10 = metadata !{metadata !11, metadata !9, i64 16}
!11 = metadata !{metadata !"_ZTS8TestCase", metadata !2, i64 0, metadata !2, i64 8, metadata !9, i64 16, metadata !9, i64 20}
!12 = metadata !{metadata !11, metadata !9, i64 20}
!13 = metadata !{metadata !4, metadata !4, i64 0}
!14 = metadata !{metadata !15, metadata !16, i64 0}
!15 = metadata !{metadata !"_ZTSNSs9_Rep_baseE", metadata !16, i64 0, metadata !16, i64 8, metadata !9, i64 16}
!16 = metadata !{metadata !"long", metadata !5, i64 0}
!17 = metadata !{metadata !18, metadata !18, i64 0}
!18 = metadata !{metadata !"vtable pointer", metadata !6, i64 0}
!19 = metadata !{metadata !20, metadata !4, i64 240}
!20 = metadata !{metadata !"_ZTSSt9basic_iosIcSt11char_traitsIcEE", metadata !4, i64 216, metadata !5, i64 224, metadata !21, i64 225, metadata !4, i64 232, metadata !4, i64 240, metadata !4, i64 248, metadata !4, i64 256}
!21 = metadata !{metadata !"bool", metadata !5, i64 0}
!22 = metadata !{metadata !23, metadata !5, i64 56}
!23 = metadata !{metadata !"_ZTSSt5ctypeIcE", metadata !4, i64 16, metadata !21, i64 24, metadata !4, i64 32, metadata !4, i64 40, metadata !4, i64 48, metadata !5, i64 56, metadata !5, i64 57, metadata !5, i64 313, metadata !5, i64 569}
!24 = metadata !{metadata !5, metadata !5, i64 0}
!25 = metadata !{metadata !26, metadata !4, i64 0}
!26 = metadata !{metadata !"_ZTSSt12_Vector_baseI8TestCaseSaIS0_EE", metadata !27, i64 0}
!27 = metadata !{metadata !"_ZTSNSt12_Vector_baseI8TestCaseSaIS0_EE12_Vector_implE", metadata !4, i64 0, metadata !4, i64 8, metadata !4, i64 16}
!28 = metadata !{metadata !26, metadata !4, i64 8}
!29 = metadata !{metadata !26, metadata !4, i64 16}
