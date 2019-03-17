; ModuleID = 'test12.c'
source_filename = "test12.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@array1_size = external dso_local global i64, align 8
@array2 = external dso_local global [0 x i8], align 1
@array1 = external dso_local global [0 x i8], align 1
@temp = external dso_local global i8, align 1
@.str = private unnamed_addr constant [9 x i8] c"%zu, %zu\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @victim_function_v12(i64 %x, i64 %y) #0 {
entry:
  %x.addr = alloca i64, align 8
  %y.addr = alloca i64, align 8
  store i64 %x, i64* %x.addr, align 8
  store i64 %y, i64* %y.addr, align 8
  %0 = load i64, i64* %x.addr, align 8
  %1 = load i64, i64* %y.addr, align 8
  %add = add i64 %0, %1
  %2 = load i64, i64* @array1_size, align 8
  %cmp = icmp ult i64 %add, %2
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %3 = load i64, i64* %x.addr, align 8
  %4 = load i64, i64* %y.addr, align 8
  %add1 = add i64 %3, %4
  %arrayidx = getelementptr inbounds [0 x i8], [0 x i8]* @array1, i64 0, i64 %add1
  %5 = load i8, i8* %arrayidx, align 1
  %conv = zext i8 %5 to i32
  %mul = mul nsw i32 %conv, 512
  %idxprom = sext i32 %mul to i64
  %arrayidx2 = getelementptr inbounds [0 x i8], [0 x i8]* @array2, i64 0, i64 %idxprom
  %6 = load i8, i8* %arrayidx2, align 1
  %conv3 = zext i8 %6 to i32
  %7 = load i8, i8* @temp, align 1
  %conv4 = zext i8 %7 to i32
  %and = and i32 %conv4, %conv3
  %conv5 = trunc i32 %and to i8
  store i8 %conv5, i8* @temp, align 1
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 {
entry:
  %x = alloca i64, align 8
  %y = alloca i64, align 8
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str, i32 0, i32 0), i64* %x, i64* %y)
  %0 = load i64, i64* %x, align 8
  %1 = load i64, i64* %y, align 8
  call void @victim_function_v12(i64 %0, i64 %1)
  ret i32 0
}

declare dso_local i32 @__isoc99_scanf(i8*, ...) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0}
!llvm.ident = !{!1}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{!"clang version 8.0.0 (trunk 342348)"}
