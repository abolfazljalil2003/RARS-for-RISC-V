# مراحل پایپلاین (Pipeline Stages) در RISC-V

<div dir="rtl">

## 📑 فهرست مطالب

- [مقدمه](#مقدمه)
- [مرحله IF - Instruction Fetch](#مرحله-if---instruction-fetch)
- [مرحله ID - Instruction Decode](#مرحله-id---instruction-decode)
- [مرحله EX - Execute](#مرحله-ex---execute)
- [مرحله MEM - Memory Access](#مرحله-mem---memory-access)
- [مرحله WB - Write Back](#مرحله-wb---write-back)
- [Hazards و راه‌حل‌ها](#hazards-و-راه‌حل‌ها)
- [بهینه‌سازی‌ها](#بهینه‌سازی‌ها)
- [مثال‌های عملی](#مثال‌های-عملی)

---

## مقدمه

### 🎯 پایپلاین (Pipeline) چیست؟

**پایپلاین** تکنیکی است که در آن اجرای چندین دستور به‌طور همزمان در مراحل مختلف انجام می‌شود.

### 📊 مزایای پایپلاین

<div dir="ltr">

```
بدون پایپلاین:
Cycle: 1    2    3    4    5    6    7    8
Inst1: IF - ID - EX - MEM - WB
Inst2:                         IF - ID - EX - MEM - WB

با پایپلاین:
Cycle: 1    2    3    4    5    6    7    8
Inst1: IF - ID - EX - MEM - WB
Inst2:      IF - ID - EX - MEM - WB
Inst3:           IF - ID - EX - MEM - WB
Inst4:                IF - ID - EX - MEM - WB
Inst5:                     IF - ID - EX - MEM - WB

بهبود: ~5x سریع‌تر! 🚀
```

</div>

### 🔄 پنج مرحله کلاسیک

<div dir="ltr">

```
┌────┬────┬────┬─────┬────┐
│ IF │ ID │ EX │ MEM │ WB │
└────┴────┴────┴─────┴────┘
```

</div>

<div dir="ltr">

| مرحله | نام کامل | وظیفه اصلی |
|-------|----------|-----------|
| **IF** | Instruction Fetch | واکشی دستور از حافظه |
| **ID** | Instruction Decode | رمزگشایی دستور |
| **EX** | Execute | اجرای عملیات |
| **MEM** | Memory Access | دسترسی به حافظه |
| **WB** | Write Back | نوشتن نتیجه |

</div>

---

## مرحله IF - Instruction Fetch

### 📖 توضیحات

**IF** اولین مرحله پایپلاین است که دستور را از حافظه می‌خواند.

### 🔧 اجزای IF

**1. Program Counter (PC)**
- نگهداری آدرس دستور فعلی
- به‌روزرسانی برای دستور بعدی

**2. Instruction Memory**
- حافظه فقط‌خواندنی دستورات
- بازگشت دستور بر اساس PC

**3. Adder**
- محاسبه آدرس دستور بعدی
- معمولاً: <span dir="ltr">`PC + 4`</span>

**4. IF/ID Register**
- ذخیره دستور برای مرحله بعد
- رجیستر پایپلاین

### 🔄 عملیات مرحله IF

<div dir="ltr">

```
1. خواندن PC
2. دسترسی به Instruction Memory
3. بازیابی دستور
4. محاسبه: PC_next = PC + 4
5. ذخیره دستور در IF/ID
```

</div>

### 📊 نمودار جریان داده

<div dir="ltr">

```
     ┌────────┐
     │   PC   │
     └───┬────┘
         │
         ▼
  ┌─────────────┐
  │ Instruction │
  │   Memory    │
  └──────┬──────┘
         │
         ▼
   ┌──────────┐      ┌────────┐
   │  Adder   │◄────►│ PC + 4 │
   └──────────┘      └────────┘
         │
         ▼
    ┌────────┐
    │ IF/ID  │
    └────────┘
```

</div>

### ⚠️ چالش‌ها

**1. Branch Hazard**
- عدم مشخص بودن آدرس مقصد انشعاب
- نیاز به Stall یا Prediction

**2. Cache Miss**
- عدم وجود دستور در I-Cache
- تأخیر در بازیابی از حافظه اصلی

**3. Instruction Alignment**
- مشکل تراز نبودن دستورات

### 💡 بهینه‌سازی‌ها

<div dir="ltr">

```assembly
# Instruction Cache (I-Cache)
- ذخیره دستورات پرتکرار
- کاهش تأخیر دسترسی

# Branch Prediction
- پیش‌بینی مسیر انشعاب
- کاهش Stall

# Prefetching
- پیش‌خوانی دستورات
- آماده‌سازی قبل از نیاز
```

</div>

### 📝 مثال کد

<div dir="ltr">

```assembly
# دستورات در حافظه
0x1000: add  t0, t1, t2
0x1004: sub  t3, t4, t5
0x1008: lw   t6, 0(sp)
0x100C: beq  t0, t1, label

# اجرا در IF:
Cycle 1: PC = 0x1000 → Fetch: add t0, t1, t2
Cycle 2: PC = 0x1004 → Fetch: sub t3, t4, t5
Cycle 3: PC = 0x1008 → Fetch: lw t6, 0(sp)
Cycle 4: PC = 0x100C → Fetch: beq t0, t1, label
```

</div>

---

## مرحله ID - Instruction Decode

### 📖 توضیحات

**ID** دستور را تحلیل کرده و آماده اجرا می‌کند.

### 🔧 اجزای ID

**1. Control Unit**
- تفسیر Opcode
- تولید سیگنال‌های کنترلی

**2. Register File**
- خواندن رجیسترهای منبع
- آماده‌سازی داده‌ها

**3. Sign Extender**
- گسترش مقادیر Immediate
- تبدیل 12/20 بیت به 32 بیت

**4. ID/EX Register**
- انتقال به مرحله بعد

### 🔄 عملیات مرحله ID

<div dir="ltr">

```
1. دریافت دستور از IF/ID
2. تجزیه به Opcode و Operands
3. خواندن Register File
4. گسترش Immediate (اگر نیاز باشد)
5. تولید سیگنال‌های کنترل
6. ذخیره در ID/EX
```

</div>

### 📊 تحلیل دستور

<div dir="ltr">

```
دستور: ADD R1, R2, R3

┌────────────────────────────┐
│  Instruction: 0x003100B3   │
└───────────┬────────────────┘
            │
            ▼
     ┌──────────────┐
     │ Opcode: ADD  │
     │ rd:     R1   │
     │ rs1:    R2   │
     │ rs2:    R3   │
     └──────────────┘
```

</div>

### 🎯 سیگنال‌های کنترلی

<div dir="ltr">

| سیگنال | کاربرد |
|--------|--------|
| **ALUOp** | نوع عملیات ALU |
| **RegWrite** | نوشتن در رجیستر |
| **MemRead** | خواندن از حافظه |
| **MemWrite** | نوشتن در حافظه |
| **Branch** | دستور انشعاب |
| **ALUSrc** | انتخاب منبع ALU |
| **MemtoReg** | انتخاب منبع Write Back |

</div>

### ⚠️ چالش‌ها

**1. Data Hazards**

<div dir="ltr">

```assembly
add t0, t1, t2    # t0 = t1 + t2
sub t3, t0, t4    # نیاز به t0 (هنوز آماده نیست!)
```

</div>

**2. Control Hazards**

<div dir="ltr">

```assembly
beq t0, t1, label # مقصد مشخص نیست
add t2, t3, t4    # ممکن است اجرا نشود
```

</div>

**3. Structural Hazards**
- تداخل در دسترسی به Register File

### 💡 راه‌حل‌ها

<div dir="ltr">

```
✅ Forwarding: انتقال مستقیم داده
✅ Stalling: توقف موقت
✅ Hazard Detection Unit: تشخیص خطرات
```

</div>

### 📝 مثال کامل

<div dir="ltr">

```assembly
# دستور: addi t0, t1, 100

# مرحله Decode:
1. Opcode = ADDI (I-type)
2. rd = t0 (x5)
3. rs1 = t1 (x6)
4. Immediate = 100

5. خواندن Register File:
   rs1_data = RF[t1] = 20

6. گسترش Immediate:
   imm_ext = sign_extend(100) = 0x00000064

7. سیگنال‌های کنترل:
   ALUOp = ADD
   ALUSrc = 1 (استفاده از Immediate)
   RegWrite = 1

8. ذخیره در ID/EX:
   - rs1_data = 20
   - imm_ext = 100
   - control signals
```

</div>

---

## مرحله EX - Execute

### 📖 توضیحات

**EX** عملیات اصلی را انجام می‌دهد (محاسبه، مقایسه، آدرس).

### 🔧 اجزای EX

**1. ALU (Arithmetic Logic Unit)**
- اجرای عملیات حسابی و منطقی
- محاسبه آدرس
- مقایسه برای Branch

**2. Forwarding Unit**
- انتقال مستقیم داده‌ها
- رفع Data Hazard

**3. Branch Unit**
- ارزیابی شرط انشعاب
- محاسبه آدرس مقصد

**4. EX/MEM Register**
- انتقال به مرحله بعد

### 🔄 عملیات بر اساس نوع دستور

#### دستورات حسابی

<div dir="ltr">

```assembly
add t0, t1, t2

# EX:
ALU_input1 = RF[t1] = 10
ALU_input2 = RF[t2] = 5
ALU_op = ADD
Result = 10 + 5 = 15
```

</div>

#### دستورات حافظه

<div dir="ltr">

```assembly
lw t0, 8(sp)

# EX:
ALU_input1 = RF[sp] = 0x1000
ALU_input2 = 8 (offset)
ALU_op = ADD
Address = 0x1000 + 8 = 0x1008
```

</div>

#### دستورات انشعاب

<div dir="ltr">

```assembly
beq t0, t1, label

# EX:
ALU_input1 = RF[t0]
ALU_input2 = RF[t1]
ALU_op = SUB
Zero = (t0 - t1 == 0) ?
Branch_target = PC + offset
```

</div>

### 📊 نمودار ALU

<div dir="ltr">

```
    Input A ────┐
                ├──► ┌─────┐
    Input B ────┤    │ ALU │──► Result
                │    └─────┘
    ALU Op  ────┘         │
                          └──► Zero Flag
```

</div>

### ⚠️ چالش‌ها

**1. Data Hazards**

<div dir="ltr">

```assembly
add t0, t1, t2    # EX: محاسبه t0
sub t3, t0, t4    # EX: نیاز به t0 (Forwarding!)
```

</div>

**راه‌حل: Forwarding**

<div dir="ltr">

```
EX/MEM.Result ───► ALU Input
MEM/WB.Result ───► ALU Input
```

</div>

**2. Control Hazards**

<div dir="ltr">

```assembly
beq t0, t1, label # تصمیم در EX
add t2, t3, t4    # ممکن است Flush شود
```

</div>

### 💡 بهینه‌سازی‌ها

<div dir="ltr">

```
✅ Forwarding Paths
✅ Branch Prediction
✅ Early Branch Resolution
✅ ALU Result Bypassing
```

</div>

### 📝 مثال کامل

<div dir="ltr">

```assembly
# سناریو: محاسبه (a + b) × c

# دستور 1: add t0, t1, t2  (t0 = a + b)
EX:
  Input_A = RF[t1] = 10  # a
  Input_B = RF[t2] = 5   # b
  Operation = ADD
  Result = 15
  → EX/MEM.Result = 15

# دستور 2: mul t3, t0, t4  (t3 = t0 × c)
EX:
  Input_A = Forwarded(EX/MEM.Result) = 15  # از دستور قبل!
  Input_B = RF[t4] = 3   # c
  Operation = MUL
  Result = 45
  → EX/MEM.Result = 45
```

</div>

---

## مرحله MEM - Memory Access

### 📖 توضیحات

**MEM** دسترسی به حافظه داده را مدیریت می‌کند.

### 🔧 اجزای MEM

**1. Data Memory**
- حافظه داده‌ها
- قابل خواندن و نوشتن

**2. Address Calculator**
- آدرس محاسبه شده از EX

**3. MEM/WB Register**
- انتقال به مرحله نهایی

### 🔄 عملیات بر اساس نوع

#### دستورات LOAD

<div dir="ltr">

```assembly
lw t0, 8(sp)

# MEM:
Address = EX/MEM.ALU_Result = 0x1008
Data = Memory[0x1008]
→ MEM/WB.Data = Data
```

</div>

#### دستورات STORE

<div dir="ltr">

```assembly
sw t0, 8(sp)

# MEM:
Address = EX/MEM.ALU_Result = 0x1008
Data = EX/MEM.RegisterData
Memory[0x1008] = Data
```

</div>

#### دستورات محاسباتی

<div dir="ltr">

```assembly
add t0, t1, t2

# MEM:
# هیچ عملیات حافظه‌ای انجام نمی‌شود
# فقط انتقال Result از EX/MEM به MEM/WB
```

</div>

### 📊 نمودار حافظه

<div dir="ltr">

```
    ┌─────────────┐
    │   Address   │
    └──────┬──────┘
           │
           ▼
    ┌─────────────┐
    │    Data     │──┬──► Read Data
    │   Memory    │  │
    └─────────────┘  │
           ▲         │
           │         │
    Write Data◄──────┘
```

</div>

### ⚠️ چالش‌ها

**1. Cache Miss**

<div dir="ltr">

```
I-Cache Hit:  ~1 cycle
I-Cache Miss: ~100 cycles
D-Cache Hit:  ~1 cycle  
D-Cache Miss: ~100 cycles

تأثیر: کاهش شدید عملکرد!
```

</div>

**2. Alignment Errors**

<div dir="ltr">

```assembly
# ❌ اشتباه - آدرس تراز نیست
lw t0, 1(sp)    # آدرس فرد!

# ✅ صحیح - آدرس تراز است
lw t0, 0(sp)    # آدرس مضرب 4
lw t0, 4(sp)
```

</div>

**3. Memory Conflicts**

<div dir="ltr">

```assembly
# تداخل در دسترسی همزمان
lw t0, 0(sp)    # MEM: Read
sw t1, 4(sp)    # MEM: Write
```

</div>

### 💡 بهینه‌سازی‌ها

**1. Data Cache (D-Cache)**

<div dir="ltr">

```
┌──────────────────────┐
│   Fast D-Cache       │ ~1 cycle
├──────────────────────┤
│   L2 Cache           │ ~10 cycles
├──────────────────────┤
│   Main Memory        │ ~100 cycles
└──────────────────────┘
```

</div>

**2. Write Buffer**

<div dir="ltr">

```
Store → Write Buffer → Memory (background)
        ↓
    Continue Pipeline
```

</div>

**3. Prefetching**

<div dir="ltr">

```assembly
# پیش‌بینی الگوی دسترسی
lw t0, 0(a0)
lw t1, 4(a0)
# Prefetch: 8(a0), 12(a0), ...
```

</div>

### 📝 مثال کامل

<div dir="ltr">

```assembly
# کپی آرایه: dest[i] = src[i]

loop:
    # Load
    lw   t0, 0(a0)      # MEM: Read src[i]
    # تأخیر 1 cycle (Cache Hit)
    
    # Store  
    sw   t0, 0(a1)      # MEM: Write dest[i]
    # تأخیر 1 cycle (Cache Hit)
    
    addi a0, a0, 4
    addi a1, a1, 4
    bne  a0, a2, loop

# با Cache Misses:
# Load:  ~100 cycles
# Store: ~100 cycles
# جمع:  ~200 cycles تأخیر!
```

</div>

---

## مرحله WB - Write Back

### 📖 توضیحات

**WB** آخرین مرحله است که نتیجه را در رجیستر می‌نویسد.

### 🔧 اجزای WB

**1. Multiplexer**
- انتخاب بین ALU Result یا Memory Data

**2. Register File**
- نوشتن در رجیستر مقصد

### 🔄 عملیات بر اساس نوع

#### دستورات محاسباتی

<div dir="ltr">

```assembly
add t0, t1, t2

# WB:
Source = MEM/WB.ALU_Result = 15
Destination = t0
RF[t0] = 15
```

</div>

#### دستورات LOAD

<div dir="ltr">

```assembly
lw t0, 8(sp)

# WB:
Source = MEM/WB.Memory_Data
Destination = t0
RF[t0] = Memory_Data
```

</div>

#### دستورات STORE

<div dir="ltr">

```assembly
sw t0, 8(sp)

# WB:
# هیچ عملیات Write Back انجام نمی‌شود
RegWrite = 0
```

</div>

### 📊 نمودار WB

<div dir="ltr">

```
ALU Result ───┐
              ├──► MUX ───► Register File
Memory Data ──┘         │
                        │
MemtoReg ───────────────┘
                        │
Destination Register ───┘
```

</div>

### 🎯 سیگنال‌های کنترلی

<div dir="ltr">

| سیگنال | مقدار | عملیات |
|--------|-------|--------|
| **RegWrite** | 1 | نوشتن در رجیستر |
| **RegWrite** | 0 | بدون نوشتن |
| **MemtoReg** | 0 | از ALU |
| **MemtoReg** | 1 | از Memory |

</div>

### ⚠️ چالش‌ها

**1. Write-After-Write (WAW)**

<div dir="ltr">

```assembly
add t0, t1, t2    # WB: نوشتن در t0
sub t0, t3, t4    # WB: نوشتن در t0
# ترتیب مهم است!
```

</div>

**2. Write-After-Read (WAR)**

<div dir="ltr">

```assembly
add t1, t0, t2    # خواندن t0
sub t0, t3, t4    # نوشتن در t0
# در پایپلاین معمولاً مشکل نیست
```

</div>

### 📝 مثال ترکیبی

<div dir="ltr">

```assembly
# محاسبه: result = (a + b) + mem[addr]

# Cycle 1: add t0, t1, t2
IF | ID | EX | MEM | WB(t0=15)

# Cycle 2: lw t3, 0(a0)  
   | IF | ID | EX | MEM(read) | WB(t3=10)

# Cycle 3: add t4, t0, t3
      | IF | ID(need t0,t3) | EX | MEM | WB(t4=25)

# Forwarding:
# t0: از Cycle 1 WB
# t3: از Cycle 2 WB
```

</div>

---

## Hazards و راه‌حل‌ها

### 🚨 انواع Hazards

#### 1. Data Hazards

**Read After Write (RAW)**

<div dir="ltr">

```assembly
add t0, t1, t2    # Write t0
sub t3, t0, t4    # Read t0 (خطر!)
```

</div>

**راه‌حل: Forwarding**

<div dir="ltr">

```
EX/MEM ───► ALU
MEM/WB ───► ALU
```

</div>

#### 2. Control Hazards

<div dir="ltr">

```assembly
beq t0, t1, label
add t2, t3, t4    # ممکن است اجرا نشود
```

</div>

**راه‌حل‌ها:**
- Branch Prediction
- Branch Delay Slot
- Early Branch Resolution

#### 3. Structural Hazards

<div dir="ltr">

```
دو دستور نیاز به یک منبع دارند:
- Register File (Read/Write همزمان)
- Memory (IF و MEM همزمان)
```

</div>

**راه‌حل:**
- Dual-Port Register File
- Split I/D Cache

### 📊 جدول مقایسه

<div dir="ltr">

| Hazard | علت | راه‌حل | هزینه |
|--------|-----|--------|-------|
| **RAW** | وابستگی داده | Forwarding | کم |
| **WAW** | نوشتن همزمان | In-order | صفر |
| **WAR** | خواندن دیر | معمولاً نیست | صفر |
| **Branch** | عدم قطعیت | Prediction | متوسط |
| **Structural** | تداخل منابع | منابع بیشتر | زیاد |

</div>

---

## بهینه‌سازی‌ها

### ⚡ 1. Forwarding (Bypassing)

<div dir="ltr">

```
     EX/MEM ───┐
               ├──► ALU Input
     MEM/WB ───┘

کاهش Stall از 2 به 0 cycle
```

</div>

### 🎯 2. Branch Prediction

**Static Prediction:**

<div dir="ltr">

```assembly
# همیشه فرض: Not Taken
beq t0, t1, label
# ادامه به دستور بعد
```

</div>

**Dynamic Prediction:**

<div dir="ltr">

```
Branch History Table (BHT):
┌─────────┬──────────┐
│ Address │ Predict  │
├─────────┼──────────┤
│ 0x1000  │ Taken    │
│ 0x1004  │ NotTaken │
└─────────┴──────────┘
```

</div>

### 🚀 3. Superscalar Execution

**اجرای چند دستور همزمان:**

<div dir="ltr">

```
Cycle:  1    2    3    4    5
        ┌────┬────┬────┬────┬────┐
Pipe 1: │IF1 │ID1 │EX1 │ME1 │WB1 │
        ├────┼────┼────┼────┼────┤
Pipe 2: │IF2 │ID2 │EX2 │ME2 │WB2 │
        └────┴────┴────┴────┴────┘

2x سریع‌تر!
```

</div>

### 💾 4. Cache Optimization

<div dir="ltr">

```
L1 Cache: 32KB, 1 cycle
L2 Cache: 256KB, 10 cycles  
L3 Cache: 8MB, 30 cycles
RAM: 100+ cycles

Hit Rate بالا = عملکرد بهتر
```

</div>

---

## مثال‌های عملی

### 1️⃣ مثال کامل: حلقه ساده

<div dir="ltr">

```assembly
# محاسبه مجموع آرایه
# for (i=0; i<n; i++) sum += arr[i]

loop:
    lw   t0, 0(a0)      # Load arr[i]
    add  a2, a2, t0     # sum += arr[i]
    addi a0, a0, 4      # i++
    addi a1, a1, -1     # n--
    bnez a1, loop       # if (n != 0) goto loop
```

</div>

**تحلیل Pipeline:**

<div dir="ltr">

```
Cycle: 1    2    3    4    5    6    7    8    9    10
Inst1: IF - ID - EX - ME - WB
Inst2:      IF - ID - EX - ME - WB
Inst3:           IF - ID - EX - ME - WB
Inst4:                IF - ID - EX - ME - WB
Inst5:                     IF - ID(stall) - EX - ME - WB
       ↑                        ↑
   Branch taken           Wait for branch
```

</div>

### 2️⃣ Data Hazard با Forwarding

<div dir="ltr">

```assembly
add t0, t1, t2    # t0 = t1 + t2
sub t3, t0, t4    # t3 = t0 - t4 (نیاز به t0!)
```

**بدون Forwarding:**

<div dir="ltr">

```
Cycle: 1    2    3    4    5    6    7    8
add:   IF - ID - EX - ME - WB
sub:        IF - ID - XX - XX - EX - ME - WB
                    ↑    ↑
                  Stall Stall

تأخیر: 2 cycles
```

</div>

**با Forwarding:**

<div dir="ltr">

```
Cycle: 1    2    3    4    5    6    7
add:   IF - ID - EX - ME - WB
sub:        IF - ID - EX(FWD) - ME - WB
                    ↑
               Forward from EX/MEM

تأخیر: 0 cycles ✅
```

</div>

### 3️⃣ Load-Use Hazard

<div dir="ltr">

```assembly
lw   t0, 0(a0)    # Load
add  t1, t0, t2   # استفاده فوری (خطر!)
```

**حتی با Forwarding:**

<div dir="ltr">

```
Cycle: 1    2    3    4    5    6    7
lw:    IF - ID - EX - ME - WB
add:        IF - ID - XX - EX(FWD) - ME - WB
                      ↑
                    Stall

تأخیر: 1 cycle (اجتناب‌ناپذیر)
```

</div>

**راه‌حل: Code Reordering**

<div dir="ltr">

```assembly
# ❌ بد
lw   t0, 0(a0)
add  t1, t0, t2   # Stall!

# ✅ خوب
lw   t0, 0(a0)
addi a0, a0, 4    # دستور مستقل
add  t1, t0, t2   # حالا t0 آماده است
```

</div>

### 4️⃣ Branch Prediction

<div dir="ltr">

```assembly
loop:
    # ... کد حلقه ...
    addi t0, t0, 1
    blt  t0, t1, loop    # معمولاً Taken

# با Prediction:
# - پیش‌بینی: Taken
# - اگر درست: 0 cycle تأخیر
# - اگر غلط: 3 cycle تأخیر
```

</div>

---

## 🎓 تمرین‌های پیشنهادی

### تمرین 1: تحلیل Pipeline

برای کد زیر نمودار Pipeline بکشید:

<div dir="ltr">

```assembly
add t0, t1, t2
lw  t3, 0(a0)
sub t4, t0, t3
sw  t4, 0(a1)
```

</div>

<details>
<summary>💡 راهنمایی</summary>

- Data Hazard بین <span dir="ltr">`add`</span> و <span dir="ltr">`sub`</span> → Forwarding
- Load-Use Hazard بین <span dir="ltr">`lw`</span> و <span dir="ltr">`sub`</span> → Stall 1 cycle

</details>

### تمرین 2: بهینه‌سازی کد

کد زیر را برای کاهش Stall بهینه کنید:

<div dir="ltr">

```assembly
lw  t0, 0(a0)
add t1, t0, t2
lw  t3, 4(a0)
add t4, t3, t5
```

</div>

### تمرین 3: محاسبه CPI

برای یک حلقه 100 تکراری با 5 دستور محاسبه کنید:
- بدون Pipeline
- با Pipeline بدون Hazard
- با Pipeline با Branch Misprediction 10%

---

## 🐛 اشکالات رایج

### ❌ خطای 1: فراموشی Forwarding Path

<div dir="ltr">

```assembly
# خطر!
add t0, t1, t2
sub t3, t0, t4    # اگر Forwarding نباشد: Stall

# راه‌حل: اطمینان از وجود Forwarding
```

</div>

### ❌ خطای 2: Load-Use بدون Stall

<div dir="ltr">

```assembly
# خطر! نمی‌توان جلوگیری کرد
lw  t0, 0(a0)
add t1, t0, t2    # حتماً 1 cycle Stall

# راه‌حل: درج دستور مستقل
lw  t0, 0(a0)
nop               # یا دستور مفید دیگر
add t1, t0, t2
```

</div>

### ❌ خطای 3: Branch Delay نادیده گرفته شده

<div dir="ltr">

```assembly
beq t0, t1, label
add t2, t3, t4    # ممکن است Flush شود!

# راه‌حل: استفاده از Branch Delay Slot
beq t0, t1, label
nop               # یا دستور بی‌اثر از Branch
label:
```

</div>

---

## 📊 مقایسه عملکرد

### زمان اجرا

<div dir="ltr">

| معماری | CPI | Frequency | عملکرد نسبی |
|---------|-----|-----------|-------------|
| **بدون Pipeline** | 5.0 | 1 GHz | 1x |
| **Pipeline ایده‌آل** | 1.0 | 1 GHz | 5x |
| **Pipeline واقعی** | 1.3 | 1 GHz | 3.8x |
| **Superscalar** | 0.5 | 1 GHz | 10x |

</div>

### تأثیر Hazards

<div dir="ltr">

| Hazard | تکرار | تأخیر | تأثیر کلی |
|--------|-------|-------|-----------|
| **Data** | 30% | 0-1 cycle | 0.3 CPI |
| **Control** | 20% | 2-3 cycles | 0.5 CPI |
| **Structural** | 5% | 1 cycle | 0.05 CPI |
| **جمع** | - | - | **0.85 CPI** |

</div>

---

## 💡 نکات کلیدی

### ✅ برای طراحی

<div dir="ltr">

```
1. Pipeline Depth: تعادل بین سرعت و پیچیدگی
2. Forwarding: ضروری برای عملکرد خوب
3. Branch Prediction: مهم برای کد با حلقه
4. Cache: بزرگترین تأثیر بر عملکرد
```

</div>

### ⚡ برای برنامه‌نویسی

<div dir="ltr">

```assembly
# ✅ خوب: جداسازی Load-Use
lw   t0, 0(a0)
addi a0, a0, 4      # دستور مستقل
add  t1, t0, t2     # حالا آماده است

# ✅ خوب: Loop Unrolling
loop:
    lw t0, 0(a0)
    lw t1, 4(a0)    # بارگذاری موازی
    add a2, a2, t0
    add a2, a2, t1
    addi a0, a0, 8
    bnez a1, loop
```

</div>

---

## 📚 منابع و مراجع

### 📖 مستندات

- [RISC-V Microarchitecture Guide](https://riscv.org/)
- [Computer Organization and Design: RISC-V Edition](https://www.elsevier.com/)

### 🛠️ ابزارها

- **RARS**: شبیه‌ساز با نمایش Pipeline
- **Spike**: شبیه‌ساز رسمی با تحلیل عملکرد

### 📚 مقالات

1. "The RISC-V Instruction Set Manual"
2. "Pipeline Hazards and Forwarding"
3. "Branch Prediction Techniques"

---

## ❓ سوالات متداول

### Q1: CPI در Pipeline چقدر است؟

**A:** در حالت ایده‌آل 1، اما در عمل:

<div dir="ltr">

```
CPI = 1 + Stall_cycles
    = 1 + Data_hazards + Control_hazards + Structural_hazards
    ≈ 1.3 - 1.5 (معمولی)
```

</div>

### Q2: چرا Forwarding همیشه کافی نیست؟

**A:** در Load-Use Hazard، داده از حافظه در MEM آماده می‌شود:

<div dir="ltr">

```assembly
lw  t0, 0(a0)    # ME: داده آماده
add t1, t0, t2    # EX: نیاز به داده
# 1 cycle تأخیر اجتناب‌ناپذیر است!
```

</div>

### Q3: Branch Prediction چقدر دقیق است؟

**A:** بستگی به الگوریتم دارد:

<div dir="ltr">

```
Static: 50-70%
1-bit: 70-80%
2-bit: 80-90%
Advanced: 95%+
```

</div>

---

## 🏆 خلاصه جامع

<div dir="ltr">

| مرحله | وظیفه | تأخیر معمولی | نکته کلیدی |
|--------|-------|-------------|-------------|
| **IF** | واکشی دستور | 1 cycle | I-Cache مهم است |
| **ID** | رمزگشایی | 1 cycle | Hazard Detection |
| **EX** | اجرا | 1 cycle | Forwarding |
| **MEM** | حافظه | 1 cycle | D-Cache مهم است |
| **WB** | نوشتن | 1 cycle | تداخل نباید باشد |

### Hazards:
- **Data**: Forwarding (0-1 cycle)
- **Control**: Prediction (0-3 cycles)
- **Structural**: منابع بیشتر (0-1 cycle)

### بهینه‌سازی:
1. Forwarding Paths ✅
2. Branch Prediction ✅
3. Cache Optimization ✅
4. Code Reordering ✅

</div>

---

<div align="center">


[⬆ بازگشت به بالا](#مراحل-پایپلاین-pipeline-stages-در-risc-v)

---



📧 سوال دارید? Issue باز کنید!

</div>

</div>